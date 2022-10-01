package com.hotel.asia.mybatis.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.hotel.asia.dto.OptionReservation;

@Mapper
public interface OptionRezMapper {
	// 옵션 예약
	int optReservation(OptionReservation orz);

}
