package com.hotel.asia.controller;

import javax.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value="/review")
public class ReviewController {
	private static final Logger logger = LoggerFactory.getLogger(ReviewController.class);
	
	
	// 리뷰 게시판 이동
	@GetMapping(value="/reviewList")
	public String reviewList() {
		logger.info("리뷰게시판 이동");
		return "review/reviewList";
	}
	
	// 리뷰 게시글 작성 폼
	@GetMapping(value="/reviewWriteForm")
	public ModelAndView  reviewWriteForm(ModelAndView mv, HttpSession session) {
		logger.info("리뷰게시글 작성 폼 이동");
		mv.addObject("id", session.getAttribute("id"));
		mv.setViewName("review/reviewWriteForm");
		return mv;
	}
	
	
   
}
