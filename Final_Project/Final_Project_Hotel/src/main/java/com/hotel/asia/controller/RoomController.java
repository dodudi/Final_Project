package com.hotel.asia.controller;



import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.hotel.asia.dto.Rez;
import com.hotel.asia.dto.Room;
import com.hotel.asia.service.RezService;
import com.hotel.asia.service.RoomService;

@Controller
@RequestMapping(value="/room")
public class RoomController {
	private static final Logger logger = LoggerFactory.getLogger(RoomController.class);
	
	private RoomService roomService;
	private RezService rezService;
	

	@Autowired
	public RoomController(RoomService roomService, RezService rezService) {
		this.roomService = roomService;
		this.rezService = rezService;
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
 
	

	
	// =====[현능]=====
	@RequestMapping(value="/roomList", method = RequestMethod.GET)
	public ModelAndView roomList(ModelAndView mv) {
		List<Room> roomList = roomService.getRoomList(); // 전체 객실 리스트
		int roomListCount = roomService.getRoomListCount(); // 전체 객실 리스트 수
		mv.addObject("roomList", roomList);
		mv.addObject("roomListCount", roomListCount);
		mv.setViewName("room/roomList");
		return mv;
	}
	@ResponseBody
	@RequestMapping(value="/roomList_select")
	public Map<String, Object> roomList_v2_select(@RequestParam(value="people", defaultValue="0", required=false) int people,
												  @RequestParam(value="roomTypes", defaultValue="0", required=false) String roomTypes) throws ParseException{
		logger.info("==========[roomList_select]==========");
		logger.info("넘어온 객실타입: " + roomTypes);
		List<Room> roomList = roomService.getRoomList(roomTypes); // 객실 리스트 (선택된 객실 유형만)
		int roomListCount = roomList.size(); // 객실 리스트 수 (선택된 객실 유형만)
		List<Rez> rezList = rezService.getRezList(); // 객실 예약 리스트
		
		// 숙박 불가능 날짜 계산
		Map<Integer, List<String>> alreadyRez= new HashMap<Integer, List<String>>(); // 키:객실아이디, 값:숙박날짜
		Calendar checkInCal = Calendar.getInstance();
		DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); // 날짜 형식 지정
		Date checkOutFormat; // 체크아웃 날짜
		Date checkInFormat;// 체크인 날짜
        long diffSec; // 초 차이
        long nights;  // 일자 수 차이
		logger.info("=====예약 불가능 날짜 계산=====");
		for(Rez rez : rezList) {
			logger.info("[객실예약번호 " + rez.getREZ_ID() + " / 객실번호 " + rez.getROOM_ID() +"] " + rez.getREZ_CHECKIN() + " ~ " + rez.getREZ_CHECKOUT());
			checkOutFormat = new SimpleDateFormat("yyyy-MM-dd").parse(rez.getREZ_CHECKOUT());
			checkInFormat = new SimpleDateFormat("yyyy-MM-dd").parse(rez.getREZ_CHECKIN());
			checkInCal.setTime(checkInFormat);
			diffSec = (checkOutFormat.getTime() - checkInFormat.getTime()) / 1000;
	        nights = diffSec / (24*60*60);
			logger.info("숙박일수 : " + nights);
			
			List<String> disableDate = new ArrayList<String>();
			for(int i = 0; i < nights; i++) {
				checkInCal.add(Calendar.DATE, i);
				logger.info("숙박날짜 => " + sdf.format(checkInCal.getTime()));
				disableDate.add(sdf.format(checkInCal.getTime()));
			}
			alreadyRez.put(rez.getREZ_ID(), disableDate);
		}
		
		logger.info("=====map 확인=====");
		for(Entry<Integer, List<String>> entrySet : alreadyRez.entrySet()){
			logger.info("[객실번호 " + entrySet.getKey() + "] 숙박 날짜 : ");
			for(String value : entrySet.getValue()) {
				logger.info(value);
			}
		}
		
		
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("roomList", roomList);
		map.put("roomListCount", roomListCount);
		map.put("rezList", rezList);
		map.put("people", people);
		return map;
	}
	
	

}
