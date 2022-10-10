package com.hotel.asia.mybatis.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.hotel.asia.dto.Rez;

@Mapper
public interface RezMapper {
	// 객실 예약
	public int reservation(Rez rez);
}
