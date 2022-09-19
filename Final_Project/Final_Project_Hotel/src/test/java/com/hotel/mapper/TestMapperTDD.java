package com.hotel.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import com.hotel.mapper.TestMapper;

//여기는 Junit Test를 하는 곳입니다.

@RunWith(SpringRunner.class)
@SpringBootTest
public class TestMapperTDD {
	@Autowired
	private TestMapper testMapper;

	private static final Logger log = LoggerFactory.getLogger(TestMapperTDD.class);

	@Test
	public void Test() {
		log.info(testMapper.getCount()+"");
		log.info("Test");
	}
}
