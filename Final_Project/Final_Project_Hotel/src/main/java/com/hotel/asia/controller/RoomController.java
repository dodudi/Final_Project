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
import java.util.Set;
import java.util.TreeSet;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
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
@RequestMapping(value = "/room")
public class RoomController {
	private static final Logger logger = LoggerFactory.getLogger(RoomController.class);

	private RoomService roomService;
	private RezService rezService;

	@Autowired
	public RoomController(RoomService roomService, RezService rezService) {
		this.roomService = roomService;
		this.rezService = rezService;
	}

	// =====[현능]=====
	@RequestMapping(value = "/roomList", method = RequestMethod.GET)
	public ModelAndView roomList(ModelAndView mv) {
		List<Room> roomList = roomService.getRoomList(); // 전체 객실 리스트
		int roomListCount = roomService.getRoomListCount(); // 전체 객실 리스트 수
		mv.addObject("roomList", roomList);
		mv.addObject("roomListCount", roomListCount);
		mv.setViewName("room/roomList");
		return mv;
	}
	@ResponseBody
	@RequestMapping(value = "/roomList_select")
	public Map<String, Object> roomList_v2_select(@RequestParam(value="people", defaultValue="0", required = false) int people,
			                                      @RequestParam(value="roomTypes", defaultValue="", required = false) String roomTypes,
			                                      @RequestParam(value="checkIn", defaultValue="", required = false) String checkIn,
			                                      @RequestParam(value="checkOut", defaultValue="", required = false) String checkOut) throws ParseException {
		logger.info("==========[roomList_select]==========");
		logger.info("객실타입: " + roomTypes);
		logger.info("체크인 날짜: " + checkIn.replace(".", "-"));
		logger.info("체크아웃 날짜: " + checkOut.replace(".", "-"));
		List<Room> roomList = roomService.getRoomList(roomTypes); // 객실 리스트 (선택된 객실 유형만)
		int roomListCount = roomList.size(); // 객실 리스트 수 (선택된 객실 유형만)
		List<Rez> rezList = rezService.getRezList(); // 객실 예약 리스트
		
		// 숙박 날짜 계산 (체크인 날짜 ~ 체크아웃 날짜)
		Calendar checkInCal = Calendar.getInstance();
		DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); // 날짜 형식 지정
		Date checkInFormat = new SimpleDateFormat("yyyy-MM-dd").parse(checkIn.replace(".", "-"));// 체크인 날짜
		Date checkOutFormat = new SimpleDateFormat("yyyy-MM-dd").parse(checkOut.replace(".", "-")); // 체크아웃 날짜
		long diffSec; // 초 차이
		long nights; // 일자 수 차이
		diffSec = (checkOutFormat.getTime() - checkInFormat.getTime()) / 1000;
		nights = diffSec / (24 * 60 * 60);
		logger.info("숙박일수 : " + nights + "일");
		String dateList[] = new String[(int) nights];
		checkInCal.setTime(checkInFormat);
		int temp = 0;
		for(int i = 0; i < nights; i++) {
			checkInCal.add(Calendar.DATE, temp);
			dateList[i] = sdf.format(checkInCal.getTime());
			logger.info("숙박날짜 => " + dateList[i]);
			temp = 1;
		}
		

		
		Set<Integer> rezRoomList2 = new TreeSet<Integer>();
		// 숙박 불가능 날짜 계산
		Map<String, List<Integer>> alreadyRez = new HashMap<String, List<Integer>>(); // 키:객실아이디, 값:숙박날짜
		for(int j = 0; j < dateList.length; j++) {
			logger.info("*** 숙박 날짜 : " +  dateList[j] + " ***");
			List<Integer> rezRoomList = new ArrayList<Integer>();
			
			for(Rez rez : rezList) {
				logger.info("===[객실번호 " + rez.getROOM_ID() + "] " + rez.getREZ_CHECKIN() + " ~ " + rez.getREZ_CHECKOUT() + " ===");
				checkOutFormat = new SimpleDateFormat("yyyy-MM-dd").parse(rez.getREZ_CHECKOUT());
				checkInFormat = new SimpleDateFormat("yyyy-MM-dd").parse(rez.getREZ_CHECKIN());
				checkInCal.setTime(checkInFormat);
				diffSec = (checkOutFormat.getTime() - checkInFormat.getTime()) / 1000;
				nights = diffSec / (24 * 60 * 60);
				logger.info("기예약건 숙박일수 : " + nights);
				
				temp = 0;
				for(int i = 0; i < nights; i++) {
					checkInCal.add(Calendar.DATE, temp);
					logger.info("기예약건 숙박날짜 => " + sdf.format(checkInCal.getTime()));
					
					// 숙박 날짜에 예약된 객실 있으면 해당 객실ID 저장
					if(dateList[j].equals( sdf.format(checkInCal.getTime()) )) {
						rezRoomList.add(rez.getROOM_ID());
						rezRoomList2.add(rez.getROOM_ID());
					}
					temp = 1;
				}
			}
			alreadyRez.put(dateList[j] , rezRoomList);
		}
		
		logger.info("=====map 확인=====");
		for (Entry<String, List<Integer>> entrySet : alreadyRez.entrySet()) {
			logger.info("[숙박날짜 " + entrySet.getKey() + "] 기예약객실 : ");
			for (Integer value : entrySet.getValue()) {
				logger.info(""+value);
			}
		}
		logger.info("=====list 확인=====");
		for(int rezRoomId : rezRoomList2) {
			logger.info(""+rezRoomId);
		}
		

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("roomList", roomList);
		map.put("roomListCount", roomListCount);
		map.put("rezRoomList2", rezRoomList2);
		map.put("people", people);
		return map;
	}

	
	
	@GetMapping("/roomDetail")
	public ModelAndView Detail(@RequestParam(value = "num", defaultValue = "0") int num, ModelAndView mv,
			HttpServletRequest request) {

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
