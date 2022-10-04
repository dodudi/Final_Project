package com.hotel.asia.mybatis.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.hotel.asia.dto.OptionReservation;

@Mapper
public interface OptionRezMapper {
	// 옵션 예약
	public int optReservation(OptionReservation orz);
	
	
	// 옵션 예약 리스트 갯수
	public int getOptRezListCount(int REZ_ID);
	// 옵션 예약 리스트
	public List<OptionReservation> getOptRezList(int REZ_ID);

}
