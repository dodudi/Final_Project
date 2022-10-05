package com.hotel.asia.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hotel.asia.dto.OptionReservation;
import com.hotel.asia.mybatis.mapper.OptionRezMapper;

@Service
public class OptionRezServiceImpl implements OptionRezService {
	@Autowired
	private OptionRezMapper mapper;
	
	// 옵션 예약
	@Override
	public int optReservation(OptionReservation orz) {
		return mapper.optReservation(orz);
	}
	
	
	// 옵션 예약 리스트 갯수
	@Override
	public int getOptRezListCount(int REZ_ID) {
		return mapper.getOptRezListCount(REZ_ID);
	}
	// 옵션 예약 리스트
	@Override
	public List<OptionReservation> getOptRezList(int REZ_ID) {
		return mapper.getOptRezList(REZ_ID);
	}

	
	
}
