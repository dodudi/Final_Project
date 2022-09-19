package com.hotel.mapper;

import org.apache.ibatis.annotations.Mapper;

//Mapper 클래스 입니다. xml파일과 연동합니다.

@Mapper
public interface TestMapper {
	public int getCounts();
}
