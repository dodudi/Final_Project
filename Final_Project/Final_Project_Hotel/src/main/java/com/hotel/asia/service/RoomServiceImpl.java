package com.hotel.asia.service;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hotel.asia.dto.Room;
import com.hotel.asia.mybatis.mapper.RoomMapper;

@Service
public class RoomServiceImpl implements RoomService{
	private static final Logger logger = LoggerFactory.getLogger(RoomServiceImpl.class);
	
	
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
	
	// 선택된 객실 유형만 필터링한 객실 리스트 
	@Override
	public List<Room> getRoomList(String roomTypes) {
		logger.info("==========[RoomServiceImpl]==========");
		List<String> list = new ArrayList<String>();
		String[] roomTypeArr = roomTypes.split(",");
		
		logger.info("*선택된 객실 유형");
		for(String roomType : roomTypeArr) {
			logger.info(roomType);
			list.add(roomType);
		}
		return mapper.getRoomList2(list);
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
