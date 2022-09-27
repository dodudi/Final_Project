package com.hotel.asia.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MyPageController {
	private static final Logger log = LoggerFactory.getLogger(MyPageController.class);
	@GetMapping("/mypage/reserve")
	public String Reserve () {
		return "mypage/mypage_reserve_check";
	}
	
	@GetMapping("/mypage/question")
	public String Question() {
		return "mypage/mypage_question_check";
	}
	
	@GetMapping("/member")
	public String Member() {
		return "mypage/mypage_member_check";
	}
}
