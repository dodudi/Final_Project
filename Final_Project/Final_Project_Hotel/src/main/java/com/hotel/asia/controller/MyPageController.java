package com.hotel.asia.controller;

import java.net.http.HttpRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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

import com.hotel.asia.dto.Option;
import com.hotel.asia.dto.OptionId;
import com.hotel.asia.dto.OptionReservation;
import com.hotel.asia.dto.Payment;
import com.hotel.asia.dto.Rez;
import com.hotel.asia.dto.Room;
import com.hotel.asia.service.MyPageServiceImpl;
import com.hotel.asia.service.OptionService;
import com.hotel.asia.service.RoomService;

import oracle.jdbc.proxy.annotation.GetProxy;
import oracle.jdbc.proxy.annotation.Post;

/*
 * MyPage에 관한 Controller입니다.
 * */
@Controller
public class MyPageController {
	private static final Logger log = LoggerFactory.getLogger(MyPageController.class);

	@Autowired
	private MyPageServiceImpl myPageService;
	@Autowired
	private OptionService optionService;
	@Autowired
	private RoomService roomService;

	// 객실예약확인 페이지
	@GetMapping("/mypage/reserve")
	public String reserve(Model model, HttpSession session) {

		String mem_id = "user01";

		mem_id = "user01";
		Rez rez = myPageService.getRezData(mem_id);
		long day = myPageService.getDateSub(rez.getREZ_CHECKOUT(), rez.getREZ_CHECKIN());
		log.info(day + "");
		// Option Data -> 조식, 디너, 수영
		List<OptionReservation> breakFast = myPageService.getOptRezData(mem_id, OptionId.BREAKFAST);
		List<OptionReservation> dinner = myPageService.getOptRezData(mem_id, OptionId.DINNER);
		List<OptionReservation> swimming = myPageService.getOptRezData(mem_id, OptionId.SWIMMING);
		Payment payment = myPageService.getPayment(mem_id);

		model.addAttribute("rezData", rez);
		model.addAttribute("optBreakFast", breakFast);
		model.addAttribute("optDinner", dinner);
		model.addAttribute("optSwimming", swimming);
		model.addAttribute("payMentData", payment);
		model.addAttribute("subDate", day);

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
		session.setAttribute("original_rez", rez);
		model.addAttribute("rezData", rez);

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
	public String rezModify(Model model, HttpSession session) {
		String mem_id = session.getAttribute("id").toString();
		Rez ori_rez = myPageService.getRezData(mem_id);
		//기존예약정보들 삭제
		//새로운예약정보 추가
		myPageService.delRezData(ori_rez.getREZ_ID(), mem_id);
		return "reservation/rezModify";
	}

	// 질문게시판 페이지
	@GetMapping("/mypage/question")
	public String question() {
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
