package com.hotel.asia.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hotel.asia.dto.Rez;
import com.hotel.asia.mybatis.mapper.RezMapper;

@Service
public class RezServiceImpl  implements RezService{
	@Autowired
	private RezMapper mapper;
	 
	// 객실 예약
	@Override
	public int reservation(Rez rez) {
		return mapper.reservation(rez);
	}
	
	// 객실 예약 취소 (DB 삭제)
	@Override
	public int deleteRez(int REZ_ID) {
		return mapper.deleteRez(REZ_ID);
	}
	
	
	// 객실 예약 리스트
	@Override
	public List<Rez> getRezList() {
		return mapper.getRezList();
	}
	
}
