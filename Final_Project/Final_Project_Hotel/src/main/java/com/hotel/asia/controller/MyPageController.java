package com.hotel.asia.controller;

import java.util.HashMap;
import java.util.List;

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

import com.hotel.asia.dto.OptionId;
import com.hotel.asia.dto.OptionReservation;
import com.hotel.asia.dto.Payment;
import com.hotel.asia.dto.Rez;
import com.hotel.asia.service.MyPageServiceImpl;

import oracle.jdbc.proxy.annotation.GetProxy;

/*
 * MyPage에 관한 Controller입니다.
 * */
@Controller
public class MyPageController {
	private static final Logger log = LoggerFactory.getLogger(MyPageController.class);

	@Autowired
	private MyPageServiceImpl myPageService;

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

	// 날짜 별로 객실정보 가져오기
	@ResponseBody
	@PostMapping(value = "/mypage/dateCheck")
	public HashMap<String, OptionReservation> rezCheckDate(Model model, @RequestBody HashMap<String, Object> date) {

		String mem_id = "user01";
		String getDate = date.get("date").toString();

		OptionReservation breakFast = null;
		OptionReservation dinner = null;
		OptionReservation swimming = null;

		//아침
		if (myPageService.getOptRezData(mem_id, getDate, OptionId.BREAKFAST) != null)
			breakFast = myPageService.getOptRezData(mem_id, getDate, OptionId.BREAKFAST).get(0);
		//저녁
		if (myPageService.getOptRezData(mem_id, getDate, OptionId.DINNER) != null)
			dinner = myPageService.getOptRezData(mem_id, getDate, OptionId.DINNER).get(0);
		//수영
		if (myPageService.getOptRezData(mem_id, getDate, OptionId.SWIMMING) != null)
			swimming = myPageService.getOptRezData(mem_id, getDate, OptionId.SWIMMING).get(0);

		HashMap<String, OptionReservation> resultData = new HashMap<String, OptionReservation>();

		resultData.put("optBreakFast", breakFast);
		resultData.put("optDinner", dinner);
		resultData.put("optSwimming", swimming);
		return resultData;
	}

	//객실예약 수정 페이지로 이동
	@PostMapping(value="/mypage/optionModifyForm")
	public String rezModifyForm() {
		
		return "option/optionModifyForm";
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
