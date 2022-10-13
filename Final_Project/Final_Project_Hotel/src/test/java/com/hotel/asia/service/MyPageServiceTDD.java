package com.hotel.asia.service;

import java.util.ArrayList;
import java.util.List;

import org.junit.jupiter.api.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.hotel.asia.dto.OptionReservation;
import com.hotel.asia.dto.Rez;
import com.hotel.asia.mybatis.mapper.MyPageMapperTDD;
@SpringBootTest
public class MyPageServiceTDD {
	private static final Logger log = LoggerFactory.getLogger(MyPageServiceTDD.class);

	@Autowired
	private MyPageServiceImpl myPageServiceImpl;
	
	
	@Test
	public void getDate() {
		log.info(myPageServiceImpl + "");
		log.info(myPageServiceImpl.calcBreakFastDate("2022-10-10", 3)+ "");
	}
	
	@Test
	public void delRez() {
		myPageServiceImpl.delRezData(1,"user01");
	}
	
	@Test
	public void addRez() {
		//객실예약
		Rez rez = new Rez();
		rez.setMEM_ID("user01");
		rez.setREZ_ADULT(3);
		rez.setREZ_CHECKIN("2022-10-10");
		rez.setREZ_CHECKOUT("2022-10-13");
		rez.setREZ_CHILD(4);
		rez.setROOM_ID(7);
		
		myPageServiceImpl.addRez(rez);
		
		
		//객실예약 옵션
		OptionReservation opt = new OptionReservation();
		opt.setADULT(2);
		opt.setCHILD(3);
		opt.setMEM_ID("user01");
		opt.setOPTION_ID(1);
		opt.setOPTION_RESERVATION_DATE("2022-10-11");
		opt.setREZ_ID(1);
		opt.setROOM_ID(7);
		
		OptionReservation opt2 = new OptionReservation();
		opt2.setADULT(2);
		opt2.setCHILD(3);
		opt2.setMEM_ID("user01");
		opt2.setOPTION_ID(2);
		opt2.setOPTION_RESERVATION_DATE("2022-10-11");
		opt2.setREZ_ID(1);
		opt2.setROOM_ID(7);
		
		List<OptionReservation> opt_data = new ArrayList<OptionReservation>();
		opt_data.add(opt);
		opt_data.add(opt2);
		
		myPageServiceImpl.addOptRez(opt_data);
		
		
	}
	
}
