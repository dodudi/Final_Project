package com.hotel.asia.service;

import com.hotel.asia.dto.Rez;

public interface RezService {
	// 객실 예약
	public int reservation(Rez rez);
	// 객실 예약 취소 (DB 삭제)
	public int deleteRez(int REZ_ID);

}
