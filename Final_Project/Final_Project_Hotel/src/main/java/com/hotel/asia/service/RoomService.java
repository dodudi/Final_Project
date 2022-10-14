package com.hotel.asia.service;

import java.util.List;

import com.hotel.asia.dto.Room;

public interface RoomService {
	
	// 전체 객실 리스트
	public List<Room> getRoomList();
	// 전체 객실 리스트 수
	public int getRoomListCount();
	

	// 선택된 객실 유형만 필터링한 객실 리스트
	public List<Room> getRoomList(String roomTypes);
	
	

	// 특정 객실 정보
	public Room getRoomDetail(int num);
	
	// 객실 예약 후 해당 객실 상태 Y로 바꾸기
	public int updateRezState(int room_ID);
	
	
	
	


	


}
