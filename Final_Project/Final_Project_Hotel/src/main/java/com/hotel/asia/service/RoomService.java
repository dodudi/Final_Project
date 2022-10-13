package com.hotel.asia.service;

import java.util.List;

import com.hotel.asia.dto.Room;

public interface RoomService {
	
	// 특정 객실 정보
	public Room getRoomDetail(int room_ID);
	
	// 객실 예약 후 해당 객실 상태 Y로 바꾸기
	public int updateRezState(int room_ID);

	public List<Room> getRoomList(Room room);

	


}
