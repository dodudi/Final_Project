package com.hotel.asia.controller;

import java.security.Principal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hotel.asia.dto.Member;
import com.hotel.asia.dto.Option;
import com.hotel.asia.dto.Rez;
import com.hotel.asia.dto.Room;
import com.hotel.asia.service.MemberService;
import com.hotel.asia.service.OptionService;
import com.hotel.asia.service.RoomService;

@Controller
@RequestMapping(value="/option")
public class OptionController {
	private static final Logger logger = LoggerFactory.getLogger(OptionController.class);
	
	@Autowired
	private OptionService optionService;
	@Autowired
	private RoomService roomService;
	@Autowired
	private MemberService memberService;
	
	// 옵션 선택 폼
	@PostMapping("/optionForm")
	public ModelAndView optionForm(Rez rez, ModelAndView mv, Principal userPrincipal) throws ParseException {
		String loginId = userPrincipal.getName();
		logger.info("***** [optionForm] 넘어온 정보 *****");
		logger.info("* 객실아이디 : " + rez.getROOM_ID());
		logger.info("* 회원아이디 : " + loginId);
		logger.info("* 체크인 날짜 : " + rez.getREZ_CHECKIN());
		logger.info("* 체크아웃 날짜 : " + rez.getREZ_CHECKOUT());
		logger.info("* 성인 수 : " + rez.getREZ_ADULT());
		logger.info("* 아동 수 : " + rez.getREZ_CHILD());
		
		// 숙박일수 계산
		String date1 = rez.getREZ_CHECKOUT(); // 체크아웃 날짜
		String date2 = rez.getREZ_CHECKIN(); // 체크인 날짜
		Date format1 = new SimpleDateFormat("yyyy-MM-dd").parse(date1);
        Date format2 = new SimpleDateFormat("yyyy-MM-dd").parse(date2);
        long diffSec = (format1.getTime() - format2.getTime()) / 1000; // 초 차이
        long nights = diffSec / (24*60*60); // 일자 수 차이
		logger.info("***** 숙박일수 : " + nights);
		
		// 옵션 리스트 - 옵션 가격 구하기
		List<Option> optionList = optionService.getOptionList();
		for(Option opt : optionList) {
			logger.info("* " + opt.getOPTION_NAME());
			logger.info("성인가격 : " + opt.getOPTION_DEFAULT_PRICE());
			logger.info("아동가격 : " + opt.getOPTION_CHILD_PRICE());
		}
		
		mv.addObject("rez", rez);
		mv.addObject("nights", nights);
		mv.addObject("optionList", optionList);
		mv.setViewName("option/optionForm");
		return mv;
	}
	
	// 옵션 선택 후 예약정보 확인 폼
	@PostMapping("/optionCheck")
	public ModelAndView optionCheck(Rez rez, int nights, ModelAndView mv, HttpServletRequest request, Principal userPrincipal) {
		String loginId = userPrincipal.getName();
		logger.info("***** [optionCheck] 넘어온 정보 *****");
		logger.info("* 객실아이디 : " + rez.getROOM_ID());
		logger.info("* 회원아이디 : " + loginId);
		logger.info("* 체크인 날짜 : " + rez.getREZ_CHECKIN());
		logger.info("* 체크아웃 날짜 : " + rez.getREZ_CHECKOUT());
		logger.info("* 성인 수 : " + rez.getREZ_ADULT());
		logger.info("* 아동 수 : " + rez.getREZ_CHILD());
		logger.info("* 숙박일수 : " + nights);
		logger.info("==========================================");
		
		// 체크인 날짜 ~ 체크아웃 날짜
		List<String> dateList = new ArrayList<String>();
		for(int i = 1; i<= nights+1 ; i++) {
			dateList.add(request.getParameter("spDate" + i));
		}
		
		// 옵션 리스트 - 옵션별 가격 구하기
		List<Option> optionInfo = optionService.getOptionList();
		for(Option oi : optionInfo) {
			logger.info("* " + oi.getOPTION_NAME());
			logger.info("성인가격 : " + oi.getOPTION_DEFAULT_PRICE());
			logger.info("아동가격 : " + oi.getOPTION_CHILD_PRICE());
		}
		
		// 옵션별 총금액
		Map<String, Integer> optionPrice = new HashMap<String, Integer>();
		optionPrice.put("bfTotal", Integer.parseInt(request.getParameter("bfTotal").replaceAll(",", "")));
		optionPrice.put("dnTotal", Integer.parseInt(request.getParameter("dnTotal").replaceAll(",", "")));
		optionPrice.put("spTotal", Integer.parseInt(request.getParameter("spTotal").replaceAll(",", "")));
		
		logger.info("객실정보");
		// 객실 정보
		Room room = roomService.getRoomDetail(rez.getROOM_ID()); // 선택한 객실 정보 구하기 (조회되는 행은 1개)
		logger.info("** 선택된 객실 가격 =>" + room.getROOM_PRICE());
		
		
		logger.info("조식");
		// 조식
		List<Map<String, Map<String, Integer>>> optList = new ArrayList<Map<String, Map<String, Integer>>>(); 
		for(int i = 1; i<= nights; i++) {
			Map<String, Integer> bfPeople = new HashMap<String, Integer>();
			Map<String, Map<String, Integer>> bfDate = new HashMap<String, Map<String, Integer>>();
			bfPeople.put("bfAdult", Integer.parseInt( request.getParameter("bfAdult" + i)));
			bfPeople.put("bfChild", Integer.parseInt( request.getParameter("bfChild" + i)));
			bfDate.put(request.getParameter("bfDate" + i), bfPeople);
			optList.add(bfDate);
		}

		logger.info("디너");
		// 디너
		for(int i = 1; i<= nights; i++) {
			Map<String, Integer> dnPeople = new HashMap<String, Integer>();
			Map<String, Map<String, Integer>> dnDate = new HashMap<String, Map<String, Integer>>();
			dnPeople.put("dnAdult", Integer.parseInt( request.getParameter("dnAdult" + i)));
			dnPeople.put("dnChild", Integer.parseInt( request.getParameter("dnChild" + i)));
			dnDate.put(request.getParameter("dnDate" + i), dnPeople);
			optList.add(dnDate);
		}
		
		logger.info("수영장");
		// 수영장
		for(int i = 1; i<= nights+1 ; i++) {
			Map<String, Integer> spPeople = new HashMap<String, Integer>();
			Map<String, Map<String, Integer>> spDate = new HashMap<String, Map<String, Integer>>();
			spPeople.put("spAdult", Integer.parseInt( request.getParameter("spAdult" + i)));
			spPeople.put("spChild", Integer.parseInt( request.getParameter("spChild" + i)));
			spDate.put(request.getParameter("spDate" + i), spPeople);
			optList.add(spDate);
		}
		
		logger.info("정보확인");
		// 담긴 정보 확인하기
		for(Map<String, Map<String, Integer>> a : optList) {
			for(String b : a.keySet()) {
				//Map<String, Integer> c = a.get(b);
				logger.info(b + "->" + a.get(b));
			}
		}
		
		mv.addObject("rez", rez); // 객실 예약 정보
		mv.addObject("nights", nights); // 숙박일수
		mv.addObject("dateList", dateList); // 날짜 리스트 (체크인 날짜 ~ 체크아웃 날짜)
		mv.addObject("optList", optList); // 옵션 예약 정보
		mv.addObject("optionInfo", optionInfo); // 옵션 정보 (이름, 가격 ....)
		mv.addObject("optionPrice", optionPrice); // 옵션별 총금액
		mv.addObject("room", room); // 객실 정보
		mv.setViewName("option/optionCheckForm");
		return mv;
	}
	
	
	// 예약정보 확인 후 회원 정보 확인 폼
	@PostMapping("/memberCheck")
	public ModelAndView memberCheck(Rez rez, int nights,
									ModelAndView mv, HttpServletRequest request, Principal userPrincipal) {
		String loginId = userPrincipal.getName();
		logger.info("***** [memberCheck] 넘어온 정보 *****");
		logger.info("* 객실아이디 : " + rez.getROOM_ID());
		logger.info("* 회원아이디 : " + loginId);
		logger.info("* 체크인 날짜 : " + rez.getREZ_CHECKIN());
		logger.info("* 체크아웃 날짜 : " + rez.getREZ_CHECKOUT());
		logger.info("* 성인 수 : " + rez.getREZ_ADULT());
		logger.info("* 아동 수 : " + rez.getREZ_CHILD());
		logger.info("* 숙박일수 : " + nights);
		logger.info("==========================================");
		
		// 넘어온 옵션 예약 인원수
		String [] dateList = request.getParameterValues("dateList"); // 체크인 날짜 ~ 체크아웃 날짜
		String [] bfAdult = request.getParameterValues("bfAdult"); // 조식 성인
		String [] bfChild = request.getParameterValues("bfChild"); // 조식 아동
		String [] dnAdult = request.getParameterValues("dnAdult"); // 디너 성인
		String [] dnChild = request.getParameterValues("dnChild"); // 디너 아동
		String [] spAdult = request.getParameterValues("spAdult"); // 수영장 성인
		String [] spChild = request.getParameterValues("spChild"); // 수영장 아동
		
		// 조식
		List<Map<String, Map<String, Integer>>> optList = new ArrayList<Map<String, Map<String, Integer>>>(); 
		for(int i = 1; i<= nights; i++) {
			Map<String, Integer> bfPeople = new HashMap<String, Integer>();
			Map<String, Map<String, Integer>> bfDate = new HashMap<String, Map<String, Integer>>();
			bfPeople.put("bfAdult", Integer.parseInt(bfAdult[i-1]));
			bfPeople.put("bfChild", Integer.parseInt(bfChild[i-1]));
			bfDate.put(dateList[i], bfPeople);
			optList.add(bfDate);
		}

		// 디너
		for(int i = 1; i<= nights; i++) {
			Map<String, Integer> dnPeople = new HashMap<String, Integer>();
			Map<String, Map<String, Integer>> dnDate = new HashMap<String, Map<String, Integer>>();
			dnPeople.put("dnAdult", Integer.parseInt(dnAdult[i-1]));
			dnPeople.put("dnChild", Integer.parseInt(dnChild[i-1]));
			dnDate.put(dateList[i-1], dnPeople);
			optList.add(dnDate);
		}
		
		// 수영장
		for(int i = 1; i<= nights+1 ; i++) {
			Map<String, Integer> spPeople = new HashMap<String, Integer>();
			Map<String, Map<String, Integer>> spDate = new HashMap<String, Map<String, Integer>>();
			spPeople.put("spAdult", Integer.parseInt(spAdult[i-1]));
			spPeople.put("spChild", Integer.parseInt(spChild[i-1]));
			spDate.put(dateList[i-1], spPeople);
			optList.add(spDate);
		}
		
		// 담긴 정보 확인하기
		for(Map<String, Map<String, Integer>> a : optList) {
			for(String b : a.keySet()) {
				//Map<String, Integer> c = a.get(b);
				logger.info(b + "->" + a.get(b));
			}
		}
		
		// 객실 정보
		Room room = roomService.getRoomDetail(rez.getROOM_ID()); // 선택한 객실 정보 구하기 (조회되는 행은 1개)
		logger.info("** 선택된 객실 가격 =>" + room.getROOM_PRICE());
		
		// 회원정보
		Member member = memberService.getMemberInfo(loginId); // 회원 정보 구하기
		
		// 옵션별 총금액
		Map<String, Integer> optionPrice = new HashMap<String, Integer>();
		optionPrice.put("bfTotal", Integer.parseInt(request.getParameter("bfTotal")));
		optionPrice.put("dnTotal", Integer.parseInt(request.getParameter("dnTotal")));
		optionPrice.put("spTotal", Integer.parseInt(request.getParameter("spTotal")));
		
		// 총금액 (객실 + 옵션)
		int totalPrice = Integer.parseInt(request.getParameter("total").replaceAll(",", ""));
		
		
		mv.addObject("rez", rez); // 객실 예약 정보
		mv.addObject("nights", nights); // 숙박일수
		mv.addObject("optionPrice", optionPrice); // 옵션별 총금액
		mv.addObject("room", room); // 객실 정보
		mv.addObject("member", member); // 회원 정보
		mv.addObject("totalPrice", totalPrice); // 총금액 (객실 + 옵션)
		
		// 옵션 예약 인원
		mv.addObject("dateList", Arrays.toString(dateList)); // 체크인 날짜 ~ 체크아웃 날짜
		mv.addObject("bfAdult", Arrays.toString(bfAdult)); // 조식 성인
		mv.addObject("bfChild", Arrays.toString(bfChild)); // 조식 아동
		mv.addObject("dnAdult", Arrays.toString(dnAdult)); // 디너 성인
		mv.addObject("dnChild", Arrays.toString(dnChild)); // 디너 아동
		mv.addObject("spAdult", Arrays.toString(spAdult)); // 수영장 성인
		mv.addObject("spChild", Arrays.toString(spChild)); // 수영장 아동
		mv.setViewName("option/memberCheckForm");
		return mv;
	}
}	

