package com.hotel.asia.service;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

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
	
	
}
