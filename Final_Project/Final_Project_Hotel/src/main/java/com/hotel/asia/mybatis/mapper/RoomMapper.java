package com.hotel.asia.mybatis.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.hotel.asia.dto.Room;

@Mapper
public interface RoomMapper {
	
	// 특정 객실 정보
	public Room getRoomDetail(int room_ID);
	
	// 객실 예약 후 해당 객실 상태 Y로 바꾸기
	public void updateRezState(int room_ID);
}
