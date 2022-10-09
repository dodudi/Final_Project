package com.hotel.asia.service;

import java.util.Date;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hotel.asia.dto.OptionReservation;
import com.hotel.asia.dto.Payment;
import com.hotel.asia.dto.Rez;
import com.hotel.asia.mybatis.mapper.MyPageMapper;

@Service
public class MyPageServiceImpl implements MyPageService {
	@Autowired
	private MyPageMapper myPageMapper;

	//옵션 아이디
	public static final int BREAKFAST = 1;
	public static final int DINNER= 2;
	public static final int SWIMMING= 3;
	
	
	// 객실정보 가져오기
	public Rez getRezData(String mem_id) {
		// 사용자 아이디에 대한 객실예약 정보 가져오기
		Rez rez = myPageMapper.getRezData(mem_id);
		return rez;
	}

	// 옵션선택정보 가져오기
	public List<OptionReservation> getOptRezData(String mem_id) {
		// 객실예약정보의 id를 이용한 옵션선택정보 가져오기
		List<OptionReservation> opt_rez = myPageMapper.getOptRezData(mem_id);
		return opt_rez;
	}

	// 결제정보 가져오기
	public Payment getPayment(String mem_id) {
		// 객실예약에 대한 결재 정보 가져오기
		Payment payment = myPageMapper.getPayment("user01");
		return payment;
	}
	
	public List<OptionReservation> getOptRezData(String mem_id, int opt_id){
		List<OptionReservation> opt_rez = myPageMapper.getOptRezData(mem_id);
		List<OptionReservation> opt =  new ArrayList<OptionReservation>();
		
		for(int i = 0 ; i < opt_rez.size(); i++) {
			if(opt_rez.get(i).getOPTION_ID() == opt_id) {
				opt.add(opt_rez.get(i));
			}
		}
		
		return opt;
	}
	
	//체크아웃 날짜 - 체크인 날짜 -> 몇일
	
	public long getDateSub(String start, String end) {
		long day  = 0;
		try {
			DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			Date date1 = (Date) format.parse(end);
			Date date2 = (Date) format.parse(start);
			
			long sec = (date2.getTime() - date1.getTime())/1000;
			day = sec/(24*60*60);
			
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return day;
	}
}

