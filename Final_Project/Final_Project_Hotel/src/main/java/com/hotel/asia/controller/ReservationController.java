package com.hotel.asia.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

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
											  ModelAndView mv, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws ParseException {
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
			logger.info("[객실 예약 번호] REZ_ID=" + rez.getREZ_ID());
			logger.info("[예약된 객실 상태 변경 여부] " + roomService.updateRezState(rez.getROOM_ID()));
			
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
		
		
		int optRezListCount = optionRezService.getOptRezListCount(rez.getREZ_ID()); // 옵션 예약 리스트 갯수
		List<OptionReservation> optRezList = optionRezService.getOptRezList(rez.getREZ_ID()); // 옵션 예약 리스트
		logger.info("=====[optRezList]=====");
		for(OptionReservation test : optRezList) {
			logger.info("getOPTION_RESERVATION_ID: " + test.getOPTION_RESERVATION_ID());
			logger.info("getREZ_ID: " + test.getREZ_ID());
			logger.info("getOPTION_ID: " + test.getOPTION_ID());
			logger.info("getOPTION_RESERVATION_DATE: " + test.getOPTION_RESERVATION_DATE());
			logger.info("getADULT: " + test.getADULT());
			logger.info("getCHILD: " + test.getCHILD());
			logger.info("==========");
		}
		
		// 숙박일수 계산
		String date1 = rez.getREZ_CHECKOUT(); // 체크아웃 날짜
		String date2 = rez.getREZ_CHECKIN(); // 체크인 날짜
		Date format1 = new SimpleDateFormat("yyyy-MM-dd").parse(date1);
        Date format2 = new SimpleDateFormat("yyyy-MM-dd").parse(date2);
        long diffSec = (format1.getTime() - format2.getTime()) / 1000; // 초 차이
        long nights = diffSec / (24*60*60); // 일자 수 차이
		logger.info("*** 숙박일수 : " + nights);
		// 체크인 날짜 ~ 체크아웃 날짜
		List<String> dateList3 = new ArrayList<String>();
		for(int i = 0; i < dateList2.length; i++) {
			logger.info("***[체크인 날짜 ~ 체크아웃 날짜] " + dateList2[i].replaceAll("[\\[\\] ]", ""));
			dateList3.add(dateList2[i].replaceAll("[\\[\\] ]", ""));
		}
		
		mv.addObject("optRezListCount", optRezListCount); // 옵션 예약 리스트 갯수
		mv.addObject("optRezList", optRezList); // 옵션 예약 리스트
		mv.addObject("rez", rez); // 객실 예약 정보
		mv.addObject("nights", nights); // 숙박일수
		mv.addObject("dateList", dateList3); // 체크인 날짜 ~ 체크아웃 날짜 (list)
		mv.setViewName("reservation/reservationComplete");
		return mv;
		
		/*
		// 옵션 예약 인원
		mv.addObject("bfAdult", bfAdult); // 조식 성인
		mv.addObject("bfChild", bfChild); // 조식 아동
		mv.addObject("dnAdult", dnAdult); // 디너 성인
		mv.addObject("dnChild", dnChild); // 디너 아동
		mv.addObject("spAdult", spAdult); // 수영장 성인
		mv.addObject("spChild", spChild); // 수영장 아동
		*/
	}
}
