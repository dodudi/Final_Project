package com.hotel.asia.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "/intro")
public class IntroController {
	private static final Logger logger = LoggerFactory.getLogger(IntroController.class);
	
	@GetMapping(value="/intro")
	public String intro() {
		logger.info("intro/intro");
		return "intro/intro";
	}
	
}
