package com.hotel.asia.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

//url을 받아 응답처리를 하는 클래스입니다.

@Controller
public class TestController {
	
	private static final Logger log = LoggerFactory.getLogger(TestController.class);
	@GetMapping("/")
	public String main() {
		log.info("ggggggggggggggggggg");
		return "home";
	}
	
}
