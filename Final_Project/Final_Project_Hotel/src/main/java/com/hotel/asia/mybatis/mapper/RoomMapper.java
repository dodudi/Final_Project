package com.hotel.asia.mybatis.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.hotel.asia.dto.Room;

@Mapper
public interface RoomMapper {
	
	// 전체 객실 리스트
	public List<Room> getRoomList();
	// 전체 객실 리스트 수
	public int getRoomListCount();
	
	// 선택된 객실 유형만 필터링한 객실 리스트
	public List<Room> getRoomList2(List<String> list);
	
	
	// 특정 객실 정보
	public Room getRoomDetail(int room_ID);
	
	// 객실 예약 후 해당 객실 상태 Y로 바꾸기
	public int updateRezState(int room_ID);


	
	
}
