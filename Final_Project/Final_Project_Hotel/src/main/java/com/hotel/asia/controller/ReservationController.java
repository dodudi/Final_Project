package com.hotel.asia.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hotel.asia.dto.OptionReservation;
import com.hotel.asia.dto.Rez;
import com.hotel.asia.service.OptionRezService;
import com.hotel.asia.service.RezService;
import com.hotel.asia.service.RoomService;

@Controller
@RequestMapping(value="/reservation")
public class ReservationController {
	private static final Logger logger = LoggerFactory.getLogger(ReservationController.class);
	
	@Autowired
	private RezService rezService;
	@Autowired
	private OptionRezService optionRezService;
	@Autowired
	private RoomService roomService;
	
	@RequestMapping("/testRez")
	public String testRoomList() {
		return "reservation/testRez";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	//========== [현능] ==========
	// 객실 + 추가옵션 예약
	@RequestMapping("/reservationRoomOption")
	public ModelAndView reservationRoomOption(Rez rez,
											  ModelAndView mv, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		logger.info("***** [reservationRoomOption] 넘어온 정보 *****");
		logger.info("* 객실아이디 : " + rez.getROOM_ID());
		logger.info("* 회원아이디 : " + session.getAttribute("id"));
		logger.info("* 체크인 날짜 : " + rez.getREZ_CHECKIN());
		logger.info("* 체크아웃 날짜 : " + rez.getREZ_CHECKOUT());
		logger.info("* 성인 수 : " + rez.getREZ_ADULT());
		logger.info("* 아동 수 : " + rez.getREZ_CHILD());
		logger.info("==========================================");
		
		// 넘어온 옵션 예약 인원수
		String dateList = request.getParameter("dateList"); // 체크인 날짜 ~ 체크아웃 날짜
		String[] dateList2 = dateList.split(",");
		String bfAdult = request.getParameter("bfAdult"); // 조식 성인
		String[] bfAdult2 = bfAdult.split(",");
		String bfChild = request.getParameter("bfChild"); // 조식 아동
		String[] bfChild2 = bfChild.split(",");
		String dnAdult = request.getParameter("dnAdult"); // 디너 성인
		String[] dnAdult2 = dnAdult.split(",");
		String dnChild = request.getParameter("dnChild"); // 디너 아동
		String[] dnChild2 = dnChild.split(",");
		String spAdult = request.getParameter("spAdult"); // 수영장 성인
		String[] spAdult2 = spAdult.split(",");
		String spChild = request.getParameter("spChild"); // 수영장 아동
		String[] spChild2 = spChild.split(",");
		logger.info("* 체크인 날짜 ~ 체크아웃 날짜 : " + dateList);
		logger.info("* 조식 성인 : " + bfAdult);
		logger.info("* 조식 아동 : " + bfChild);
		logger.info("* 디너 성인 : " + dnAdult);
		logger.info("* 디너 아동 : " + dnChild);
		logger.info("* 수영장 성인 : " + spAdult);
		logger.info("* 수영장 아동 : " + spChild);
		
		// 1. 객실 예약
		rez.setMEM_ID((String) session.getAttribute("id")); // 세션에 있는 아이디를 예약자 이름으로 설정
		int result = rezService.reservation(rez); // 객실 예약 추가
		
		// 객실 예약 실패
		if(result == 0) {
			logger.info("[객실 예약 실패] result=" + result);
			mv.setViewName("에러페이지 설정하기~~");
			return mv;
		} else { // 객실 예약 성공
			logger.info("[객실 예약 성공] result=" + result + " / 추가옵션 예약 시작");
			roomService.updateRezState(rez.getROOM_ID()); // 해당 객실 상태 Y로 바꾸기
			
			// 2. 옵션 예약
			// 조식
			for(int i = 0; i < bfAdult2.length; i++) {
				if( !(bfAdult2[i].replaceAll("[^0-9]", "").equals("0") && bfChild2[i].replaceAll("[^0-9]", "").equals("0")) ) {
					OptionReservation orz = new OptionReservation();
					orz.setOPTION_ID(1);
					orz.setOPTION_RESERVATION_DATE(dateList2[i+1].replaceAll("[\\[\\] ]", ""));
					orz.setADULT(Integer.parseInt(bfAdult2[i].replaceAll("[^0-9]", "")));
					orz.setCHILD(Integer.parseInt(bfChild2[i].replaceAll("[^0-9]", "")));
					orz.setROOM_ID(rez.getROOM_ID());
					orz.setMEM_ID((String) session.getAttribute("id"));
					int res = optionRezService.optReservation(orz);
					if(res == 0) { // 옵션 예약 실패
						logger.info("[" + dateList2[i+1] + " | 조식 옵션 예약 실패] res=" + res);
						mv.setViewName("에러페이지 설정하기~~");
						return mv;
					}
					logger.info("[" + dateList2[i+1] + " | 조식 옵션 예약 성공] res=" + res);
				}
			}
			
			// 디너
			for(int i = 0; i < dnAdult2.length; i++) {
				if( !(dnAdult2[i].replaceAll("[^0-9]", "").equals("0") && dnChild2[i].replaceAll("[^0-9]", "").equals("0")) ) {
					OptionReservation orz = new OptionReservation();
					orz.setOPTION_ID(2);
					orz.setOPTION_RESERVATION_DATE(dateList2[i].replaceAll("[\\[\\] ]", ""));
					orz.setADULT(Integer.parseInt(dnAdult2[i].replaceAll("[^0-9]", "")));
					orz.setCHILD(Integer.parseInt(dnChild2[i].replaceAll("[^0-9]", "")));
					orz.setROOM_ID(rez.getROOM_ID());
					orz.setMEM_ID((String) session.getAttribute("id"));
					int res = optionRezService.optReservation(orz);
					if(res == 0) { // 옵션 예약 실패
						logger.info("[" + dateList2[i] + " | 디너 옵션 예약 실패] res=" + res);
						mv.setViewName("에러페이지 설정하기~~");
						return mv;
					}
					logger.info("[" + dateList2[i] + " | 디너 옵션 예약 성공] res=" + res);
				}
			}
			
			// 수영장
			for(int i = 0; i < spAdult2.length; i++) {
				if( !(spAdult2[i].replaceAll("[^0-9]", "").equals("0") && spChild2[i].replaceAll("[^0-9]", "").equals("0")) ) {
					OptionReservation orz = new OptionReservation();
					orz.setOPTION_ID(3);
					orz.setOPTION_RESERVATION_DATE(dateList2[i].replaceAll("[\\[\\] ]", ""));
					orz.setADULT(Integer.parseInt(spAdult2[i].replaceAll("[^0-9]", "")));
					orz.setCHILD(Integer.parseInt(spChild2[i].replaceAll("[^0-9]", "")));
					orz.setROOM_ID(rez.getROOM_ID());
					orz.setMEM_ID((String) session.getAttribute("id"));
					int res = optionRezService.optReservation(orz);
					if(res == 0) { // 옵션 예약 실패
						logger.info("[" + dateList2[i] + " | 수영장 옵션 예약 실패] res=" + res);
						mv.setViewName("에러페이지 설정하기~~");
						return mv;
					}
					logger.info("[" + dateList2[i] + " | 수영장 옵션 예약 성공] res=" + res);
				}
			} 
		} // 객실, 옵션 예약 end
		
		// 옵션 예약 인원
		mv.addObject("bfAdult", bfAdult); // 조식 성인
		mv.addObject("bfChild", bfChild); // 조식 아동
		mv.addObject("dnAdult", dnAdult); // 디너 성인
		mv.addObject("dnChild", dnChild); // 디너 아동
		mv.addObject("spAdult", spAdult); // 수영장 성인
		mv.addObject("spChild", spChild); // 수영장 아동
		mv.setViewName("reservation/reservationComplete");
		return mv;
	}
}
