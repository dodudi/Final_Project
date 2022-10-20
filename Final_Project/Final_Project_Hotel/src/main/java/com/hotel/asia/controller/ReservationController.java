package com.hotel.asia.controller;

import java.security.Principal;
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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.hotel.asia.dto.CouponVO;
import com.hotel.asia.dto.Member;
import com.hotel.asia.dto.OptionReservation;
import com.hotel.asia.dto.Payment;
import com.hotel.asia.dto.Rez;
import com.hotel.asia.dto.Room;
import com.hotel.asia.service.CouponService;
import com.hotel.asia.service.MemberService;
import com.hotel.asia.service.OptionRezService;
import com.hotel.asia.service.PaymentService;
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
	@Autowired
	private PaymentService paymentService;
	@Autowired
	private MemberService memberService;
	@Autowired
	private CouponService couponService;
	
	
	@RequestMapping("/testRez")
	public String testRoomList(HttpSession session) {
		
		return "reservation/testRez";
	}
	
	
	@RequestMapping(value="/reservationCheck", method = RequestMethod.POST)
	public ModelAndView reservationCheck(int room_id, 
										 ModelAndView mv,
										 Rez rez,
										 HttpSession session,
										 Principal userPrincipal
										) throws ParseException {
		
		if(userPrincipal == null) {
			logger.info("로그인 아이디 없음");
			mv.addObject("state", "emptyId");
			mv.setViewName("member/login");
			return mv;
		}
	logger.info("넘어온 방번호=" + room_id);
	logger.info("넘어온 체크인 날짜=" + rez.getREZ_CHECKIN());
	logger.info("넘어온 체크아웃 날짜=" + rez.getREZ_CHECKOUT());
	logger.info("넘어온 인원수(성인)=" + rez.getREZ_ADULT());
	logger.info("넘어온 인원수(소아)=" + rez.getREZ_CHILD());
	Room room = roomService.getRoomDetail(room_id);
	
	// 숙박일수 계산
	String date1 = rez.getREZ_CHECKOUT(); // 체크아웃 날짜
	String date2 = rez.getREZ_CHECKIN(); // 체크인 날짜
	Date format1 = new SimpleDateFormat("yyyy-MM-dd").parse(date1);
	Date format2 = new SimpleDateFormat("yyyy-MM-dd").parse(date2);
	long diffSec = (format1.getTime() - format2.getTime()) / 1000; // 초 차이
	long nights = diffSec / (24*60*60); // 일자 수 차이
	logger.info("***** 숙박일수 : " + nights);
	
	mv.addObject("room", room);
	mv.addObject("rez", rez);
	mv.addObject("nights", nights);
	mv.setViewName("reservation/reservationCheck");
	return mv;
	
	


}
	
	
	// 예약정보 확인 후 회원 정보 확인 폼
		@PostMapping("/memberCheck0")
		public ModelAndView memberCheck(Rez rez, int nights,
										ModelAndView mv, HttpServletRequest request, Principal userPrincipal) {
			// 로그인하지 않거나 만료된 경우 서비스 이용 불가
			if(userPrincipal == null) {
				logger.info("로그인 아이디 없음");
				mv.addObject("state", "emptyId");
				mv.setViewName("member/login");
				return mv;
			}
			
			String loginId = userPrincipal.getName();
			logger.info("***** [memberCheck] 넘어온 정보 *****");
			logger.info("* 객실번호 : " + rez.getROOM_ID());
			logger.info("* 회원아이디 : " + loginId);
			logger.info("* 체크인 날짜 : " + rez.getREZ_CHECKIN());
			logger.info("* 체크아웃 날짜 : " + rez.getREZ_CHECKOUT());
			logger.info("* 성인 수 : " + rez.getREZ_ADULT());
			logger.info("* 아동 수 : " + rez.getREZ_CHILD());
			logger.info("* 숙박일수 : " + nights);
			logger.info("==========================================");
			

			
			// 객실 정보
			Room room = roomService.getRoomDetail(rez.getROOM_ID()); // 선택한 객실 정보 구하기 (조회되는 행은 1개)
			logger.info("** 선택된 객실 가격 =>" + room.getROOM_PRICE());
			
			// 회원정보
			Member member = memberService.member_info(loginId); // 회원 정보 구하기
			
			// 총금액 (객실 + 옵션)
			int totalPrice = Integer.parseInt(request.getParameter("total").replaceAll(",", ""));
			
			// 회원 쿠폰 정보
		      List<CouponVO> couponList = new ArrayList<CouponVO>();
		      couponList = couponService.getCouponList(loginId);
			
			
			mv.addObject("rez", rez); // 객실 예약 정보
			mv.addObject("nights", nights); // 숙박일수
			mv.addObject("room", room); // 객실 정보
			mv.addObject("member", member); // 회원 정보
			mv.addObject("totalPrice", totalPrice); // 총금액 (객실 + 옵션(옵션은 체크x)) 
			
			mv.addObject("couponList", couponList); // 회원 쿠폰 정보
			mv.setViewName("option/memberCheckForm");
			return mv;
		}
	
		
		
		// 객실 예약,결제
		@RequestMapping("/reservationroomOption0")
		public ModelAndView reservationRoomOption0(Rez rez, Payment pm,
												  ModelAndView mv, Principal userPrincipal, HttpServletRequest request, HttpServletResponse response) throws ParseException {
			String loginId = userPrincipal.getName();
			logger.info("***** [reservationRoomOption] 넘어온 정보 *****");
			logger.info("* 객실아이디 : " + rez.getROOM_ID());
			logger.info("* 회원아이디 : " + loginId);
			logger.info("* 체크인 날짜 : " + rez.getREZ_CHECKIN());
			logger.info("* 체크아웃 날짜 : " + rez.getREZ_CHECKOUT());
			logger.info("* 성인 수 : " + rez.getREZ_ADULT());
			logger.info("* 아동 수 : " + rez.getREZ_CHILD());
			logger.info("==========================================");
			
			// 넘어온 옵션 예약 인원수
			String dateList = request.getParameter("dateList"); // 체크인 날짜 ~ 체크아웃 날짜
			String[] dateList2 = dateList.split(",");
			
			logger.info("* 체크인 날짜 ~ 체크아웃 날짜 : " + dateList);
			
			
			// 1. 객실 예약
			rez.setMEM_ID(loginId); // 세션에 있는 아이디를 예약자 이름으로 설정
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
				
				
			} // 객실, 옵션 예약 end
			
			// 3. 결제정보 DB저장
		      logger.info("***** [payment] 넘어온 정보 *****");
		      logger.info("*결제번호 : " + pm.getPAYMENT_ID());
		      logger.info("*결제금액 : " + pm.getPAYMENT_PRICE());
		      logger.info("*할인금액 (사용포인트) : " + pm.getPOINT_DISCOUNT());
		      pm.setREZ_ID(rez.getREZ_ID());
		      int paymentResult = paymentService.payment(pm);
		      logger.info("[결제 성공 여부] paymentResult=" + paymentResult);
		      
		      // 4. 쿠폰 사용
		      int useCouponNum = Integer.parseInt(request.getParameter("COUPON_NUMBER")); // 사용 쿠폰번호
		      logger.info("쿠폰발급번호: " + useCouponNum);
		      if(useCouponNum != 0) {
		         int useCouponResult = couponService.useCoupon(useCouponNum); // 사용된 쿠폰 삭제
		         logger.info("[쿠폰 사용 여부] " + useCouponResult);
		      }
		      
		      // 5. 기존포인트에서 사용포인트 차감
		      int usePoint = Integer.parseInt(request.getParameter("POINT_DISCOUNT")); // 사용 포인트
		      if(usePoint != 0) {
		         int usePointResult = memberService.usePoint(loginId, usePoint);
		         logger.info("[포인트 사용 여부] " + usePointResult + " (" + usePoint + "point 사용)");
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
			
			
			Room room = roomService.getRoomDetail(rez.getROOM_ID()); // 객실 정보
			Member member = memberService.member_info(rez.getMEM_ID()); // 예약자 정보
			
			mv.addObject("member", member); // 예약자 정보
			mv.addObject("rez", rez); // 객실 예약 정보
			mv.addObject("room", room); // 객실 정보
			mv.addObject("paymentInfo", pm); // 결제 정보
			mv.addObject("nights", nights); // 숙박일수
			mv.addObject("dateList", dateList3); // 체크인 날짜 ~ 체크아웃 날짜 (list)
			mv.setViewName("reservation/reservationComplete");
			return mv;
		}
	
	
	
	
	
	//========== [현능] ==========
	// 객실 예약, 추가옵션 예약, 결제
	@RequestMapping("/reservationRoomOption")
	public ModelAndView reservationRoomOption(Rez rez, Payment pm,
											  ModelAndView mv, Principal userPrincipal, HttpServletRequest request, HttpServletResponse response) throws ParseException {
		String loginId = userPrincipal.getName();
		logger.info("***** [reservationRoomOption] 넘어온 정보 *****");
		logger.info("* 객실아이디 : " + rez.getROOM_ID());
		logger.info("* 회원아이디 : " + loginId);
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
		rez.setMEM_ID(loginId); // 세션에 있는 아이디를 예약자 이름으로 설정
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
					orz.setREZ_ID(rez.getREZ_ID());
					//orz.setROOM_ID(rez.getROOM_ID());
					//orz.setMEM_ID(loginId);
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
					orz.setREZ_ID(rez.getREZ_ID());
					//orz.setROOM_ID(rez.getROOM_ID());
					//orz.setMEM_ID(loginId);
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
					orz.setREZ_ID(rez.getREZ_ID());
					//orz.setROOM_ID(rez.getROOM_ID());
					//orz.setMEM_ID(loginId);
					int res = optionRezService.optReservation(orz);
					if(res == 0) { // 옵션 예약 실패
						logger.info("[" + dateList2[i] + " | 수영장 옵션 예약 실패] res=" + res);
						mv.setViewName("에러페이지 설정하기~~");
						return mv;
					}
					logger.info("[" + dateList2[i] + " | 수영장 옵션 예약 성공] res=" + res);
				}
			}
			logger.info("=====[옵션 예약 끝]=====");
		} // 객실, 옵션 예약 end
		
		// 3. 결제정보 DB저장
		logger.info("***** [payment] 넘어온 정보 *****");
		logger.info("*결제번호 : " + pm.getPAYMENT_ID());
		logger.info("*결제금액 : " + pm.getPAYMENT_PRICE());
		logger.info("*할인금액 (사용포인트) : " + pm.getPOINT_DISCOUNT());
		pm.setREZ_ID(rez.getREZ_ID());
		int paymentResult = paymentService.payment(pm);
		logger.info("[결제 성공 여부] paymentResult=" + paymentResult);
		
		// 4. 쿠폰 사용
		int useCouponNum = Integer.parseInt(request.getParameter("COUPON_NUMBER")); // 사용 쿠폰번호
		logger.info("쿠폰발급번호: " + useCouponNum);
		if(useCouponNum != 0) {
			int useCouponResult = couponService.useCoupon(useCouponNum); // 사용된 쿠폰 삭제
			logger.info("[쿠폰 사용 여부] " + useCouponResult);
		}
		
		// 5. 기존포인트에서 사용포인트 차감
		int usePoint = Integer.parseInt(request.getParameter("POINT_DISCOUNT")); // 사용 포인트
		if(usePoint != 0) {
			int usePointResult = memberService.usePoint(loginId, usePoint);
			logger.info("[포인트 사용 여부] " + usePointResult + " (" + usePoint + "point 사용)");
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
		
		int optRezListCount = optionRezService.getOptRezListCount(rez.getREZ_ID()); // 옵션 예약 리스트 갯수
		List<OptionReservation> optRezList = optionRezService.getOptRezList(rez.getREZ_ID()); // 옵션 예약 리스트
		Room room = roomService.getRoomDetail(rez.getROOM_ID()); // 객실 정보
		Member member = memberService.member_info(rez.getMEM_ID()); // 예약자 정보
		
		mv.addObject("member", member); // 예약자 정보
		mv.addObject("optRezListCount", optRezListCount); // 옵션 예약 리스트 갯수
		mv.addObject("optRezList", optRezList); // 옵션 예약 리스트
		mv.addObject("rez", rez); // 객실 예약 정보
		mv.addObject("room", room); // 객실 정보
		mv.addObject("paymentInfo", pm); // 결제 정보
		mv.addObject("nights", nights); // 숙박일수
		mv.addObject("dateList", dateList3); // 체크인 날짜 ~ 체크아웃 날짜 (list)
		mv.setViewName("reservation/reservationComplete");
		return mv;
	}
	
	
}