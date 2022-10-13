package com.hotel.asia.controller;



import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import com.hotel.asia.dto.Room;

import com.hotel.asia.dto.Room;
import com.hotel.asia.service.ReservationService;
import com.hotel.asia.service.RoomService;

@Controller
@RequestMapping(value="/room")
public class RoomController {
	private static final Logger logger = LoggerFactory.getLogger(ReservationController.class);
	
	private RoomService roomService;
	private ReservationService reservationService;
	

	@Autowired
	public RoomController(
						  RoomService roomService,
			              ReservationService reservationService 
			              ) {
		this.roomService = roomService;
		this.reservationService = reservationService;
	}
	
	
//	@RequestMapping(value = "/roomList", method = RequestMethod.GET)
//	public String room(HttpServletRequest request,
//					   HttpServletResponse response,
//					   Model mv) throws Exception{
//		
//		
//		
//		int room_id = Integer.parseInt(request.getParameter("ROOM_ID").trim());
//		String room_type = request.getParameter("ROOM_TYPE").trim();
//		int room_price = Integer.parseInt(request.getParameter("ROOM_PRICE").trim());
//		String room_img = request.getParameter("ROOM_IMG").trim();
//		int room_max = Integer.parseInt(request.getParameter("ROOM_MAX").trim());
//		String room_detail = request.getParameter("ROOM_DETAIL").trim();
//		String room_state = request.getParameter("ROOM_STATE").trim();
//		
//		Room room = new Room();
//		room.setROOM_ID(room_id);
//		room.setROOM_TYPE(room_type);
//		room.setROOM_PRICE(room_price);
//		room.setROOM_IMG(room_img);
//		room.setROOM_MAX(room_max);
//		room.setROOM_DETAIL(room_detail);
//		room.setROOM_STATE(room_state);
//		
//		mv.addAttribute("roomlist", room);
//		
//		
//		return "/room/roomList";
//	}
	
	
	@RequestMapping(value = "/roomList", method = RequestMethod.GET)
	public ModelAndView room(Room room, ModelAndView mv ){
		
		
		List<Room> roomlist = roomService.getRoomList(room);
		mv.setViewName("room/roomList");
		mv.addObject("roomlist", roomlist);
		logger.info("ROOM="+room);
		logger.info("roomlist="+roomlist);
		
		
		return mv;
	}
	
//	@RequestMapping(value="/roomList", method=RequestMethod.GET)
//	public String room(@RequestParam(value="ROOM_ID", required=false) Integer room_id,
//					   @RequestParam(value="ROOM_TYPE", required=false) String room_type,
//					   @RequestParam(value="ROOM_PRICE", required=false) Integer room_price,
//					   @RequestParam(value="ROOM_IMG", required=false) String room_img,
//					   @RequestParam(value="ROOM_MAX", required=false) Integer room_max,
//					   @RequestParam(value="ROOM_DETAIL", required=false) String room_detail,
//					   @RequestParam(value="ROOM_STATE", required=false) String room_state) {
//		logger.info("ROOM_ID =" + room_id );
//		logger.info("ROOM_TYPE=" + room_type);
//		return "room/roomList";
//	}
	
	
//	@RequestMapping(value="/roomList", method=RequestMethod.GET)
//		public String room(Room room) {
//			logger.info("ROOM=" + room);
//			
//			return "room/roomList";
//		}
	

}
