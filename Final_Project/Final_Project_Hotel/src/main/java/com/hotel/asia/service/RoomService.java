package com.hotel.asia.service;

import com.hotel.asia.dto.Room;

public interface RoomService {
	
	// 특정 객실 정보
	public Room getRoomDetail(int room_ID);
	
	// 객실 예약 후 해당 객실 상태 Y로 바꾸기
	public int updateRezState(int room_ID);

}
