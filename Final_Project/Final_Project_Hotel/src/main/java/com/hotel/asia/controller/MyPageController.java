package com.hotel.asia.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
/*
 * MyPage에 관한 Controller입니다.
 * */
@Controller
public class MyPageController {
	private static final Logger log = LoggerFactory.getLogger(MyPageController.class);
	
	//객실예약확인 페이지
	@GetMapping("/mypage/reserve")
	public String reserve() {
		//객실정보 가져오기~
		return "mypage/mypage_reserve_check";
	}
	//질문게시판 페이지
	@GetMapping("/mypage/question")
	public String question() {
		//질문정보 가져오기~
		return "mypage/mypage_question_check";
	}

	//회원정보 페이지
	@GetMapping("/mypage/member")
	public String member() {
		return "mypage/mypage_member_check";
	}

	//쿠폰|마일리지 페이지
	@GetMapping("/mypage/coupon")
	public String coupon() {
		return "mypage/mypage_coupon";
	}

	//즐겨찾기 게시판 페이지
	@GetMapping("/mypage/wishBoard")
	public String wishBoard() {
		return "mypage/mypage_wishboard";
	}
}
