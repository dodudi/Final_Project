package com.hotel.asia.controller;

import java.net.http.HttpRequest;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.hotel.asia.dto.Member;
import com.hotel.asia.dto.Option;
import com.hotel.asia.dto.OptionId;
import com.hotel.asia.dto.OptionReservation;
import com.hotel.asia.dto.Payment;
import com.hotel.asia.dto.Rez;
import com.hotel.asia.dto.Room;
import com.hotel.asia.module.PageCalc;
import com.hotel.asia.module.PageData;
import com.hotel.asia.service.MemberService;
import com.hotel.asia.service.MyPageServiceImpl;
import com.hotel.asia.service.OptionRezService;
import com.hotel.asia.service.OptionService;
import com.hotel.asia.service.PaymentService;
import com.hotel.asia.service.RezService;
import com.hotel.asia.service.RoomService;

/*
 * MyPage에 관한 Controller입니다.
 * */
@Controller
public class MyPageController {
	private static final Logger log = LoggerFactory.getLogger(MyPageController.class);
	@Autowired
	private OptionRezService optionRezService;
	@Autowired
	private MyPageServiceImpl myPageService;
	@Autowired
	private OptionService optionService;
	@Autowired
	private RoomService roomService;
	@Autowired
	private MemberService memberService;
	@Autowired
	private RezService rezService;
	@Autowired
	private PaymentService paymentService;

	// 객실예약확인 페이지
	@GetMapping("/mypage/reserve")
	public String reserve(Model model, HttpSession session) {

		String mem_id = "user01";
		session.setAttribute("id", mem_id);
		
		Rez rez = myPageService.getRezData(mem_id);
		long day = myPageService.getDateSub(rez.getREZ_CHECKOUT(), rez.getREZ_CHECKIN());
		log.info(day + "");
		// Option Data -> 조식, 디너, 수영
		List<OptionReservation> breakFast = myPageService.getOptRezData(mem_id, OptionId.BREAKFAST);
		List<OptionReservation> dinner = myPageService.getOptRezData(mem_id, OptionId.DINNER);
		List<OptionReservation> swimming = myPageService.getOptRezData(mem_id, OptionId.SWIMMING);
		Payment payment = myPageService.getPayment(mem_id);

		List<String> allDates = myPageService.calcBreakFastDate(rez.getREZ_CHECKIN(), day + 1);

		// 옵션 리스트 - 옵션별 가격 구하기
		List<Option> optionInfo = optionService.getOptionList();
		for (Option oi : optionInfo) {
			log.info("* " + oi.getOPTION_NAME());
			log.info("성인가격 : " + oi.getOPTION_DEFAULT_PRICE());
			log.info("아동가격 : " + oi.getOPTION_CHILD_PRICE());
		}

		Map<String, Map<String, Integer>> ori_break_prices = myPageService.getOptPrice(breakFast, optionInfo,
				OptionId.BREAKFAST);
		Map<String, Map<String, Integer>> ori_dinner_prices = myPageService.getOptPrice(dinner, optionInfo,
				OptionId.DINNER);
		Map<String, Map<String, Integer>> ori_swim_prices = myPageService.getOptPrice(swimming, optionInfo,
				OptionId.SWIMMING);

		model.addAttribute("rezData", rez);
		model.addAttribute("optBreakFast", breakFast);
		model.addAttribute("optDinner", dinner);
		model.addAttribute("optSwimming", swimming);
		model.addAttribute("payMentData", payment);
		model.addAttribute("subDate", day);
		model.addAttribute("allDates", allDates);
		model.addAttribute("break_price", ori_break_prices);
		model.addAttribute("dinner_price", ori_dinner_prices);
		model.addAttribute("swim_price", ori_swim_prices);
		// 객실정보 가져오기~
		return "mypage/mypage_reserve_check";
	}

	// 날짜 별로 객실정보 가져오기 Ajax
	@ResponseBody
	@PostMapping(value = "/mypage/dateCheck")
	public HashMap<String, OptionReservation> rezCheckDate(Model model, @RequestBody HashMap<String, Object> date) {

		String mem_id = "user01";
		String getDate = date.get("date").toString();

		OptionReservation breakFast = null;
		OptionReservation dinner = null;
		OptionReservation swimming = null;

		// 아침
		if (myPageService.getOptRezData(mem_id, getDate, OptionId.BREAKFAST) != null)
			breakFast = myPageService.getOptRezData(mem_id, getDate, OptionId.BREAKFAST).get(0);
		// 저녁
		if (myPageService.getOptRezData(mem_id, getDate, OptionId.DINNER) != null)
			dinner = myPageService.getOptRezData(mem_id, getDate, OptionId.DINNER).get(0);
		// 수영
		if (myPageService.getOptRezData(mem_id, getDate, OptionId.SWIMMING) != null)
			swimming = myPageService.getOptRezData(mem_id, getDate, OptionId.SWIMMING).get(0);

		HashMap<String, OptionReservation> resultData = new HashMap<String, OptionReservation>();

		resultData.put("optBreakFast", breakFast);
		resultData.put("optDinner", dinner);
		resultData.put("optSwimming", swimming);
		return resultData;
	}

	// 테스트 날짜 입력 폼으로 이동 /reservation/testRezModify.jsp
	@PostMapping(value = "/mypage/testRezModify")
	public String testRezModify(Model model, HttpSession session) {
		// String mem_id = session.getAttribute("id").toString();
		session.setAttribute("id", "user01");
		log.info("------------------------------------------------------ 수정");

		String mem_id = session.getAttribute("id").toString();

		Rez rez = myPageService.getRezData(mem_id);
		Room room = roomService.getRoomDetail(rez.getROOM_ID());
		model.addAttribute("rezData", rez);
		model.addAttribute("room_id", room.getROOM_ID());
		return "reservation/testRezModify";
	}

	// 객실예약 수정 페이지로 이동 /option/optionModifyForm.jsp
	@PostMapping(value = "/mypage/optionModifyForm")
	public String rezModifyForm(Model model, HttpSession session, Rez rezData) {
		log.info(rezData.getROOM_ID() + "");
		long nights = myPageService.getDateSub(rezData.getREZ_CHECKOUT(), rezData.getREZ_CHECKIN());

		// 옵션 리스트 - 옵션 가격 구하기
		List<Option> optionList = optionService.getOptionList();
		for (Option opt : optionList) {
			log.info("* " + opt.getOPTION_NAME());
			log.info("성인가격 : " + opt.getOPTION_DEFAULT_PRICE());
			log.info("아동가격 : " + opt.getOPTION_CHILD_PRICE());
		}

		model.addAttribute("nights", nights);
		model.addAttribute("rez", rezData);
		model.addAttribute("optionList", optionList);
		return "option/optionModifyForm";
	}

	// 객실 수정 체크 /option/mypage_optCheck.jsp
	@PostMapping(value = "/mypage/optCheck")
	public ModelAndView rezCheck(Rez rez, int nights, ModelAndView mv, HttpServletRequest request,
			HttpSession session) {

		// 체크인 날짜 ~ 체크아웃 날짜
		List<String> dateList = new ArrayList<String>();
		for (int i = 1; i <= nights + 1; i++) {
			dateList.add(request.getParameter("spDate" + i));
		}

		// 옵션 리스트 - 옵션별 가격 구하기
		List<Option> optionInfo = optionService.getOptionList();
		for (Option oi : optionInfo) {
			log.info("* " + oi.getOPTION_NAME());
			log.info("성인가격 : " + oi.getOPTION_DEFAULT_PRICE());
			log.info("아동가격 : " + oi.getOPTION_CHILD_PRICE());
		}

		// 옵션별 총금액
		Map<String, Integer> optionPrice = new HashMap<String, Integer>();
		optionPrice.put("bfTotal", Integer.parseInt(request.getParameter("bfTotal").replaceAll(",", "")));
		optionPrice.put("dnTotal", Integer.parseInt(request.getParameter("dnTotal").replaceAll(",", "")));
		optionPrice.put("spTotal", Integer.parseInt(request.getParameter("spTotal").replaceAll(",", "")));

		log.info("객실정보");
		// 객실 정보
		Room room = roomService.getRoomDetail(rez.getROOM_ID()); // 선택한 객실 정보 구하기 (조회되는 행은 1개)
		log.info("** 선택된 객실 가격 =>" + room.getROOM_PRICE());

		log.info("조식");
		// 조식
		List<Map<String, Map<String, Integer>>> optList = new ArrayList<Map<String, Map<String, Integer>>>();
		for (int i = 1; i <= nights; i++) {
			Map<String, Integer> bfPeople = new HashMap<String, Integer>();
			Map<String, Map<String, Integer>> bfDate = new HashMap<String, Map<String, Integer>>();
			bfPeople.put("bfAdult", Integer.parseInt(request.getParameter("bfAdult" + i)));
			bfPeople.put("bfChild", Integer.parseInt(request.getParameter("bfChild" + i)));
			bfDate.put(request.getParameter("bfDate" + i), bfPeople);
			optList.add(bfDate);
		}

		log.info("디너");
		// 디너
		for (int i = 1; i <= nights; i++) {
			Map<String, Integer> dnPeople = new HashMap<String, Integer>();
			Map<String, Map<String, Integer>> dnDate = new HashMap<String, Map<String, Integer>>();
			dnPeople.put("dnAdult", Integer.parseInt(request.getParameter("dnAdult" + i)));
			dnPeople.put("dnChild", Integer.parseInt(request.getParameter("dnChild" + i)));
			dnDate.put(request.getParameter("dnDate" + i), dnPeople);
			optList.add(dnDate);
		}

		log.info("수영장");
		// 수영장
		for (int i = 1; i <= nights + 1; i++) {
			Map<String, Integer> spPeople = new HashMap<String, Integer>();
			Map<String, Map<String, Integer>> spDate = new HashMap<String, Map<String, Integer>>();
			spPeople.put("spAdult", Integer.parseInt(request.getParameter("spAdult" + i)));
			spPeople.put("spChild", Integer.parseInt(request.getParameter("spChild" + i)));
			spDate.put(request.getParameter("spDate" + i), spPeople);
			optList.add(spDate);
		}

		log.info("정보확인");
		// 담긴 정보 확인하기
		for (Map<String, Map<String, Integer>> a : optList) {
			for (String b : a.keySet()) {
				// Map<String, Integer> c = a.get(b);
				log.info(b + "->" + a.get(b));
			}
		}

		// 옵션아이디
		// 날짜
		// 성인
		// 아동

		// session.setAttribute("new_rez", rez);
		// session.setAttribute("", optList)

		mv.addObject("rez", rez); // 객실 예약 정보
		mv.addObject("nights", nights); // 숙박일수
		mv.addObject("dateList", dateList); // 날짜 리스트 (체크인 날짜 ~ 체크아웃 날짜)
		mv.addObject("optList", optList); // 옵션 예약 정보
		mv.addObject("optionInfo", optionInfo); // 옵션 정보 (이름, 가격 ....)
		mv.addObject("optionPrice", optionPrice); // 옵션별 총금액
		mv.addObject("room", room); // 객실 정보
		mv.setViewName("option/mypage_optCheck");

		// 이미 저장되어있는 데이터
		String mem_id = session.getAttribute("id").toString();
		// 기본 저장된 객실예약정보
		Rez ori_rez = myPageService.getRezData(mem_id);
		// 기존 저장된 체크인~체크아웃 날짜 일수
		long totalDate = myPageService.getDateSub(ori_rez.getREZ_CHECKOUT(), ori_rez.getREZ_CHECKIN());
		// 체크인 부터 체쿠아웃까지의 모든 날짜
		List<String> ori_dates = myPageService.calcBreakFastDate(ori_rez.getREZ_CHECKIN(), totalDate + 1);

		// 모든 옵션의 데이터를 가져옵니다.
		List<OptionReservation> ori_break = myPageService.getOptRezData(mem_id, OptionId.BREAKFAST);
		List<OptionReservation> ori_dinner = myPageService.getOptRezData(mem_id, OptionId.DINNER);
		List<OptionReservation> ori_swim = myPageService.getOptRezData(mem_id, OptionId.SWIMMING);

		Map<String, Map<String, Integer>> ori_break_prices = myPageService.getOptPrice(ori_break, optionInfo,
				OptionId.BREAKFAST);
		Map<String, Map<String, Integer>> ori_dinner_prices = myPageService.getOptPrice(ori_dinner, optionInfo,
				OptionId.DINNER);
		Map<String, Map<String, Integer>> ori_swim_prices = myPageService.getOptPrice(ori_swim, optionInfo,
				OptionId.SWIMMING);

		mv.addObject("ori_rez", ori_rez);
		mv.addObject("ori_break", ori_break);
		mv.addObject("ori_dinner", ori_dinner);
		mv.addObject("ori_swim", ori_swim);

		mv.addObject("ori_break_prices", ori_break_prices);
		mv.addObject("ori_dinner_prices", ori_dinner_prices);
		mv.addObject("ori_swim_prices", ori_swim_prices);
		mv.addObject("ori_dates", ori_dates);
		return mv;

	}

	// 객실 수정 처리! mypage/rezModify.jsp
	@PostMapping(value = "/mypage/rezModify")
	public ModelAndView rezModify(Rez rez, int nights, ModelAndView mv, HttpServletRequest request,
			HttpSession session) {
		String mem_id = session.getAttribute("id").toString();
		// 기존예약정보들 삭제
		Rez ori_rez = myPageService.getRezData(mem_id);
		myPageService.delRezData(ori_rez.getREZ_ID(), mem_id);

		// 넘어온 옵션 예약 인원수
		String[] dateList = request.getParameterValues("dateList"); // 체크인 날짜 ~ 체크아웃 날짜
		String[] bfAdult = request.getParameterValues("bfAdult"); // 조식 성인
		String[] bfChild = request.getParameterValues("bfChild"); // 조식 아동
		String[] dnAdult = request.getParameterValues("dnAdult"); // 디너 성인
		String[] dnChild = request.getParameterValues("dnChild"); // 디너 아동
		String[] spAdult = request.getParameterValues("spAdult"); // 수영장 성인
		String[] spChild = request.getParameterValues("spChild"); // 수영장 아동

		// 조식
		List<Map<String, Map<String, Integer>>> optList = new ArrayList<Map<String, Map<String, Integer>>>();
		for (int i = 1; i <= nights; i++) {
			Map<String, Integer> bfPeople = new HashMap<String, Integer>();
			Map<String, Map<String, Integer>> bfDate = new HashMap<String, Map<String, Integer>>();
			bfPeople.put("bfAdult", Integer.parseInt(bfAdult[i - 1]));
			bfPeople.put("bfChild", Integer.parseInt(bfChild[i - 1]));
			bfDate.put(dateList[i], bfPeople);
			optList.add(bfDate);
		}

		// 디너
		for (int i = 1; i <= nights; i++) {
			Map<String, Integer> dnPeople = new HashMap<String, Integer>();
			Map<String, Map<String, Integer>> dnDate = new HashMap<String, Map<String, Integer>>();
			dnPeople.put("dnAdult", Integer.parseInt(dnAdult[i - 1]));
			dnPeople.put("dnChild", Integer.parseInt(dnChild[i - 1]));
			dnDate.put(dateList[i - 1], dnPeople);
			optList.add(dnDate);
		}

		// 수영장
		for (int i = 1; i <= nights + 1; i++) {
			Map<String, Integer> spPeople = new HashMap<String, Integer>();
			Map<String, Map<String, Integer>> spDate = new HashMap<String, Map<String, Integer>>();
			spPeople.put("spAdult", Integer.parseInt(spAdult[i - 1]));
			spPeople.put("spChild", Integer.parseInt(spChild[i - 1]));
			spDate.put(dateList[i - 1], spPeople);
			optList.add(spDate);
		}

		// 객실 정보
		Room room = roomService.getRoomDetail(rez.getROOM_ID()); // 선택한 객실 정보 구하기 (조회되는 행은 1개)

		// 회원정보
		Member member = memberService.getMemberInfo((String) session.getAttribute("id")); // 회원 정보 구하기

		// 옵션별 총금액
		Map<String, Integer> optionPrice = new HashMap<String, Integer>();
		optionPrice.put("bfTotal", Integer.parseInt(request.getParameter("bfTotal")));
		optionPrice.put("dnTotal", Integer.parseInt(request.getParameter("dnTotal")));
		optionPrice.put("spTotal", Integer.parseInt(request.getParameter("spTotal")));

		// 총금액 (객실 + 옵션)
		int totalPrice = Integer.parseInt(request.getParameter("total").replaceAll(",", ""));

		mv.addObject("rez", rez); // 객실 예약 정보
		mv.addObject("nights", nights); // 숙박일수
		mv.addObject("optionPrice", optionPrice); // 옵션별 총금액
		mv.addObject("room", room); // 객실 정보
		mv.addObject("member", member); // 회원 정보
		mv.addObject("totalPrice", totalPrice); // 총금액 (객실 + 옵션)

		// 옵션 예약 인원
		mv.addObject("dateList", Arrays.toString(dateList)); // 체크인 날짜 ~ 체크아웃 날짜
		mv.addObject("bfAdult", Arrays.toString(bfAdult)); // 조식 성인
		mv.addObject("bfChild", Arrays.toString(bfChild)); // 조식 아동
		mv.addObject("dnAdult", Arrays.toString(dnAdult)); // 디너 성인
		mv.addObject("dnChild", Arrays.toString(dnChild)); // 디너 아동
		mv.addObject("spAdult", Arrays.toString(spAdult)); // 수영장 성인
		mv.addObject("spChild", Arrays.toString(spChild)); // 수영장 아동
		mv.setViewName("option/memberCheckForm");
		return mv;

	}

	// 객실 예약, 추가옵션 예약, 결제
	@RequestMapping("/reservationRoomOption")
	public ModelAndView reservationRoomOption(Rez rez, Payment pm, ModelAndView mv, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) throws ParseException {

		// 넘어온 옵션 예약 인원수
		String dateList = request.getParameter("dateList"); // 체크인 날짜 ~ 체크아웃 날짜
		String[] dateList2 = dateList.split(",");
		String bfAdult = request.getParameter("bfAdult"); // 조식 성인
		String[] bfAdult2 = bfAdult.split(",");
		String bfChild = request.getParameter("bfChild"); // 조식 아동
		String[] bfChild2 = bfChild.split(",");
		String dnAdult = request.getParameter("dnAdult"); // 디너 성인
		String[] dnAdult2 = dnAdult.split(",");
		String dnChild = request.getParameter("dnChild"); // 디너 아동
		String[] dnChild2 = dnChild.split(",");
		String spAdult = request.getParameter("spAdult"); // 수영장 성인
		String[] spAdult2 = spAdult.split(",");
		String spChild = request.getParameter("spChild"); // 수영장 아동
		String[] spChild2 = spChild.split(",");

		// 1. 객실 예약
		rez.setMEM_ID((String) session.getAttribute("id")); // 세션에 있는 아이디를 예약자 이름으로 설정
		int result = rezService.reservation(rez); // 객실 예약 추가

		// 객실 예약 실패
		if (result == 0) {
			mv.setViewName("에러페이지 설정하기~~");
			return mv;
		} else { // 객실 예약 성공
			// 2. 옵션 예약
			// 조식
			for (int i = 0; i < bfAdult2.length; i++) {
				if (!(bfAdult2[i].replaceAll("[^0-9]", "").equals("0")
						&& bfChild2[i].replaceAll("[^0-9]", "").equals("0"))) {
					OptionReservation orz = new OptionReservation();
					orz.setOPTION_ID(1);
					orz.setOPTION_RESERVATION_DATE(dateList2[i + 1].replaceAll("[\\[\\] ]", ""));
					orz.setADULT(Integer.parseInt(bfAdult2[i].replaceAll("[^0-9]", "")));
					orz.setCHILD(Integer.parseInt(bfChild2[i].replaceAll("[^0-9]", "")));
					orz.setROOM_ID(rez.getROOM_ID());
					orz.setMEM_ID((String) session.getAttribute("id"));
					int res = optionRezService.optReservation(orz);
					if (res == 0) { // 옵션 예약 실패
						mv.setViewName("에러페이지 설정하기~~");
						return mv;
					}
				}
			}
			// 디너
			for (int i = 0; i < dnAdult2.length; i++) {
				if (!(dnAdult2[i].replaceAll("[^0-9]", "").equals("0")
						&& dnChild2[i].replaceAll("[^0-9]", "").equals("0"))) {
					OptionReservation orz = new OptionReservation();
					orz.setOPTION_ID(2);
					orz.setOPTION_RESERVATION_DATE(dateList2[i].replaceAll("[\\[\\] ]", ""));
					orz.setADULT(Integer.parseInt(dnAdult2[i].replaceAll("[^0-9]", "")));
					orz.setCHILD(Integer.parseInt(dnChild2[i].replaceAll("[^0-9]", "")));
					orz.setROOM_ID(rez.getROOM_ID());
					orz.setMEM_ID((String) session.getAttribute("id"));
					int res = optionRezService.optReservation(orz);
					if (res == 0) { // 옵션 예약 실패
						mv.setViewName("에러페이지 설정하기~~");
						return mv;
					}
				}
			}
			// 수영장
			for (int i = 0; i < spAdult2.length; i++) {
				if (!(spAdult2[i].replaceAll("[^0-9]", "").equals("0")
						&& spChild2[i].replaceAll("[^0-9]", "").equals("0"))) {
					OptionReservation orz = new OptionReservation();
					orz.setOPTION_ID(3);
					orz.setOPTION_RESERVATION_DATE(dateList2[i].replaceAll("[\\[\\] ]", ""));
					orz.setADULT(Integer.parseInt(spAdult2[i].replaceAll("[^0-9]", "")));
					orz.setCHILD(Integer.parseInt(spChild2[i].replaceAll("[^0-9]", "")));
					orz.setROOM_ID(rez.getROOM_ID());
					orz.setMEM_ID((String) session.getAttribute("id"));
					int res = optionRezService.optReservation(orz);
					if (res == 0) { // 옵션 예약 실패
						mv.setViewName("에러페이지 설정하기~~");
						return mv;
					}
				}
			}
		} // 객실, 옵션 예약 end

		// 3. 결제정보 DB저장
		// pm.setROOM_ID(rez.getROOM_ID());
		// pm.setMEM_ID((String) session.getAttribute("id"));
		pm.setREZ_ID(rez.getREZ_ID());
		int paymentResult = paymentService.payment(pm);

		// 숙박일수 계산
		String date1 = rez.getREZ_CHECKOUT(); // 체크아웃 날짜
		String date2 = rez.getREZ_CHECKIN(); // 체크인 날짜
		Date format1 = new SimpleDateFormat("yyyy-MM-dd").parse(date1);
		Date format2 = new SimpleDateFormat("yyyy-MM-dd").parse(date2);
		long diffSec = (format1.getTime() - format2.getTime()) / 1000; // 초 차이
		long nights = diffSec / (24 * 60 * 60); // 일자 수 차이
		// 체크인 날짜 ~ 체크아웃 날짜
		List<String> dateList3 = new ArrayList<String>();
		for (int i = 0; i < dateList2.length; i++) {
			dateList3.add(dateList2[i].replaceAll("[\\[\\] ]", ""));
		}

		int optRezListCount = optionRezService.getOptRezListCount(rez.getREZ_ID()); // 옵션 예약 리스트 갯수
		List<OptionReservation> optRezList = optionRezService.getOptRezList(rez.getREZ_ID()); // 옵션 예약 리스트
		Room room = roomService.getRoomDetail(rez.getROOM_ID()); // 객실 정보
		// Member member = memberService. // 예약자 정보 - 나중에 회원쪽 끝나면 예약자 정보 구해서 예약 확인페이지에
		// 예약자명 이름으로 출력하기~~

		mv.addObject("optRezListCount", optRezListCount); // 옵션 예약 리스트 갯수
		mv.addObject("optRezList", optRezList); // 옵션 예약 리스트
		mv.addObject("rez", rez); // 객실 예약 정보
		mv.addObject("room", room); // 객실 정보
		mv.addObject("paymentInfo", pm); // 결제 정보
		mv.addObject("nights", nights); // 숙박일수
		mv.addObject("dateList", dateList3); // 체크인 날짜 ~ 체크아웃 날짜 (list)
		mv.setViewName("reservation/reservationComplete");
		return mv;
	}

	// 질문게시판 페이지
	@GetMapping("/mypage/question")
	public String question(Model model, PageData pageData, HttpSession session) {
		String mem_id =  session.getAttribute("id").toString();
		
		int total = myPageService.getQuestionBoardCount(mem_id);
		
		PageCalc pageCalc = new PageCalc(total, pageData.getItemLimit(), pageData);
		model.addAttribute("pageCalc",pageCalc);
		
		// 질문정보 가져오기~
		return "mypage/mypage_question_check";
	}

	// 회원정보 페이지
	@GetMapping("/mypage/member")
	public String member() {
		return "mypage/mypage_member_check";
	}

	// 쿠폰|마일리지 페이지
	@GetMapping("/mypage/coupon")
	public String coupon() {
		return "mypage/mypage_coupon";
	}

	// 즐겨찾기 게시판 페이지
	@GetMapping("/mypage/wishBoard")
	public String wishBoard() {
		return "mypage/mypage_wishboard";
	}
}
