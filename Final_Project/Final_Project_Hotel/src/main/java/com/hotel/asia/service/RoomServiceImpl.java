package com.hotel.asia.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hotel.asia.dto.Room;
import com.hotel.asia.mybatis.mapper.RoomMapper;

@Service
public class RoomServiceImpl implements RoomService{
	
	@Autowired
	private RoomMapper mapper;
	
	// 전체 객실 리스트
	@Override
	public List<Room> getRoomList() {
		return mapper.getRoomList();
	}
	// 전체 객실 리스트 수
	@Override
	public int getRoomListCount() {
		return mapper.getRoomListCount();
	}
	
	
	// 특정 객실 정보
	@Override
	public Room getRoomDetail(int num) {
		return mapper.getRoomDetail(num);
	}
	
	
	// 객실 예약 후 해당 객실 상태 Y로 바꾸기
	@Override
	public int updateRezState(int room_ID) {
		return mapper.updateRezState(room_ID);
	}


}
