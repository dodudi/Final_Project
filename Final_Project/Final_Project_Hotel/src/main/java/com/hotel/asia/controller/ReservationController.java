package com.hotel.asia.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value="/reservation")
public class ReservationController {
	private static final Logger logger = LoggerFactory.getLogger(ReservationController.class);
	
	@RequestMapping("/testRez")
	public String testRoomList() {
		return "reservation/testRez";
	}
}
