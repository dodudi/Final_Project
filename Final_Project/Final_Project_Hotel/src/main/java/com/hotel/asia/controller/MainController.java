package com.hotel.asia.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hotel.asia.dto.Room;
import com.hotel.asia.service.RezService;
import com.hotel.asia.service.RoomService;

@Controller
@RequestMapping(value = "/main")
public class MainController {
   
   private static final Logger logger = LoggerFactory.getLogger(MainController.class);
   
   private RoomService roomService;
   
   @Autowired
	public MainController(RoomService roomService) {
		this.roomService = roomService;
	}
   
   @GetMapping(value = "/main") 
   public ModelAndView home( ModelAndView mv) {
	   List<Room> roomList = roomService.getRoomList(); // 전체 객실 리스트
		int roomListCount = roomService.getRoomListCount(); // 전체 객실 리스트 수
		mv.addObject("roomList", roomList);
		mv.addObject("roomListCount", roomListCount);
		mv.setViewName("main/main");
		logger.info("main/main");
		return mv;
   }
   
}