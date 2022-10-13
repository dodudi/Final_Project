package com.hotel.asia.controller;



import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.hotel.asia.dto.Room;

import com.hotel.asia.service.RezService;
import com.hotel.asia.service.RoomService;

@Controller
@RequestMapping(value="/room")
public class RoomController {
	private static final Logger logger = LoggerFactory.getLogger(ReservationController.class);
	
	private RoomService roomService;
	private RezService reservationService;
	

@Autowired

	public RoomController(RoomService roomService, RezService reservationService) {
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
	
	
//	@RequestMapping(value = "/roomList", method = RequestMethod.GET)
//	public ModelAndView room(Room room, ModelAndView mv ){
//		
//		
//		List<Room> roomlist = roomService.getRoomList(room);
//		mv.setViewName("room/roomList");
//		mv.addObject("roomlist", roomlist);
//		logger.info("ROOM="+room);
//		logger.info("roomlist="+roomlist);
//		
//		
//		return mv;
//	}


	

	
	// 객실 리스트
	@RequestMapping(value="/roomList", method = RequestMethod.GET)
	public ModelAndView roomList(ModelAndView mv) {
		List<Room> roomList = roomService.getRoomList(); // 전체 객실 리스트
		int roomListCount = roomService.getRoomListCount(); // 전체 객실 리스트 수
		mv.addObject("roomList", roomList);
		mv.addObject("roomListCount", roomListCount);
		mv.setViewName("room/roomList");
		return mv;
	}
	
	//ajax 객실리스트 조회
	@ResponseBody
	@RequestMapping(value="/roomList_select")
	public Map<String, Object> roomList_select(@RequestParam(value="people", defaultValue="0", required=false) int people) {
		List<Room> roomList = roomService.getRoomList(); // 전체 객실 리스트
		int roomListCount = roomService.getRoomListCount(); // 전체 객실 리스트 수
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("roomList", roomList);
		map.put("roomListCount", roomListCount);
		map.put("people", people);
		return map;
	}
	
	
	
	@GetMapping("/roomDetail")
	public ModelAndView Detail(@RequestParam(value="num", defaultValue="0") int num,
							   ModelAndView mv, 
							   HttpServletRequest request){
		
		Room room = roomService.getRoomDetail(num);
		if (room == null) {
			logger.info("객실 상세보기 실패");
			mv.setViewName("error/error");
			mv.addObject("url", request.getRequestURL());
			mv.addObject("message", "상세보기 실패입니다.");
		} else {
			logger.info("객실 상세보기 성공");
			mv.setViewName("room/roomDetail");
			mv.addObject("room", room);
		}
		return mv;
	}
	

}
