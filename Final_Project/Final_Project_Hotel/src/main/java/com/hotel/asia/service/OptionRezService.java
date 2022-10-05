package com.hotel.asia.service;

import java.util.List;

import com.hotel.asia.dto.OptionReservation;

public interface OptionRezService {
	
	// 옵션 예약
	public int optReservation(OptionReservation orz);
	
	
	// 옵션 예약 리스트 갯수
	public int getOptRezListCount(int REZ_ID);
	// 옵션 예약 리스트
	public List<OptionReservation> getOptRezList(int REZ_ID);
	

}
