package com.hotel.asia.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.junit.jupiter.api.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.hotel.asia.dto.OptionReservation;
import com.hotel.asia.dto.Rez;
import com.hotel.asia.module.PageCalc;
import com.hotel.asia.module.PageData;
import com.hotel.asia.mybatis.mapper.MyPageMapperTDD;

@SpringBootTest
public class MyPageServiceTDD {
	private static final Logger log = LoggerFactory.getLogger(MyPageServiceTDD.class);

	@Autowired
	private MyPageServiceImpl myPageServiceImpl;

	@Test
	public void getDate() {
		log.info(myPageServiceImpl + "");
		log.info(myPageServiceImpl.calcBreakFastDate("2022-10-10", 3) + "");
	}


	@Test
	public void getQuestionBoardCount() {
		int count = myPageServiceImpl.getQuestionBoardCount("user01");
		log.info("존재하는 아이디에 대한 질문 게시글은 : " + count);
	}

	@Test
	public void getQuestionBoard() {
		PageData pageData = new PageData();
		int total =  myPageServiceImpl.getQuestionBoardCount("user01");
		PageCalc pageCalc = new PageCalc(total,10,pageData);
		HashMap<String, Object> data = new HashMap<String, Object>();
		data.put("pageCalc", pageCalc);
		data.put("id", "user01");
		List<Integer> getData = myPageServiceImpl.getQuestionBoard(data);
		
	}
}