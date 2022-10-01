package com.hotel.asia.service;

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
	
}
