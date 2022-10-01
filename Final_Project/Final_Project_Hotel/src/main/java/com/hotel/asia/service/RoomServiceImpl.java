package com.hotel.asia.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hotel.asia.dto.Room;
import com.hotel.asia.mybatis.mapper.RoomMapper;

@Service
public class RoomServiceImpl implements RoomService{
	
	@Autowired
	private RoomMapper mapper;
	
	// 특정 객실 정보
	@Override
	public Room getRoomDetail(int room_ID) {
		return mapper.getRoomDetail(room_ID);
	}

}
