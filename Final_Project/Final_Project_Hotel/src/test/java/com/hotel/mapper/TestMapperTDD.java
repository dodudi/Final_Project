package com.hotel.mapper;

import org.junit.jupiter.api.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.hotel.asia.mybatis.mapper.TestMapper;

//여기는 Junit Test를 하는 곳입니다.

@SpringBootTest
public class TestMapperTDD {
	
	@Autowired
	private TestMapper testMapper;

	private static final Logger log = LoggerFactory.getLogger(TestMapperTDD.class);

	@Test
	public void Test() {
		log.info(testMapper.getCounts()+"");
		log.info("Test");
	}
}
