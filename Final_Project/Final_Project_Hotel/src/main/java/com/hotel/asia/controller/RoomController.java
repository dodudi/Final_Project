package com.hotel.asia.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.hotel.asia.service.ReservationService;
import com.hotel.asia.service.RoomService;

@Controller
@RequestMapping(value="/room")
public class RoomController {
	private static final Logger logger = LoggerFactory.getLogger(ReservationController.class);
	
	
	private RoomService roomService;
	private ReservationService reservationService;
	

	@Autowired
	public RoomController(RoomService roomService,
			              ReservationService reservationService 
			              ) {
		this.roomService = roomService;
		this.reservationService = reservationService;
	}
	
	
	@RequestMapping(value = "/roomlist", method = RequestMethod.GET)
	public String room() {
		return "/room/roomlist";
	}

}
