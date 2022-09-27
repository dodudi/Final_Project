package com.hotel.asia.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MyPageController {
	private static final Logger log = LoggerFactory.getLogger(MyPageController.class);

	@GetMapping("/mypage/reserve")
	public String reserve() {
		return "mypage/mypage_reserve_check";
	}

	@GetMapping("/mypage/question")
	public String question() {
		return "mypage/mypage_question_check";
	}

	@GetMapping("/mypage/member")
	public String member() {
		return "mypage/mypage_member_check";
	}

	@GetMapping("/mypage/coupon")
	public String coupon() {
		return "mypage/mypage_coupon";
	}

	@GetMapping("/mypage/wishBoard")
	public String wishBoard() {
		return "mypage/mypage_wishboard";
	}
}
