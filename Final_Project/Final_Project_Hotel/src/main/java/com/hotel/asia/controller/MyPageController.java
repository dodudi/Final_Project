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

	// 질문게시판 페이지
	@GetMapping("/mypage/question")
	public String question(Model model, PageData pageData, HttpSession session) {
		String mem_id =  session.getAttribute("id").toString();
		Object itemLimitObject = session.getAttribute("itemLimit");
		int itemLimit;
		if(itemLimitObject == null)
			itemLimit = 10;
		else
			itemLimit = Integer.parseInt(itemLimitObject.toString());

		pageData.setItemLimit(itemLimit);
		
		int total = myPageService.getQuestionBoardCount(mem_id);
		
		PageCalc pageCalc = new PageCalc(total, 10, pageData);
		model.addAttribute("pageCalc",pageCalc);
		model.addAttribute("itemLimit", pageData.getItemLimit());
		// 질문정보 가져오기~
		return "mypage/mypage_question_check";
	}
	
	@ResponseBody
	@PostMapping(value = "/mypage/listCountSet")
	public PageCalc listCountSet(HttpSession session, @RequestBody PageData pageData) {
		String mem_id =  session.getAttribute("id").toString();
		
		int total = myPageService.getQuestionBoardCount(mem_id);
		PageCalc pageCalc = new PageCalc(total, 10, pageData);
		
		session.setAttribute("itemLimit", pageData.getItemLimit());
		return pageCalc;
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
