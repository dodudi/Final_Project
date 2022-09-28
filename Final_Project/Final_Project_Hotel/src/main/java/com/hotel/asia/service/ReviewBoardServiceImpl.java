package com.hotel.asia.service;

import java.util.HashMap;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.hotel.asia.dto.ReviewBoard;
import com.hotel.asia.mybatis.mapper.ReviewBoardMapper;

@Service
public class ReviewBoardServiceImpl implements ReviewBoardService{
	
	@Autowired
	private ReviewBoardMapper mapper;
	
	// 글 작성
	@Override
	public int write(ReviewBoard rb) {
		return mapper.write(rb);
	}
	
	// 글 갯수
	@Override
	public int getListCount() {
		return mapper.getListCount();
	}
	
	// 글 리스트
	@Override
	public List<ReviewBoard> getReviewList(int page, int limit) {
		HashMap<String, Integer> map = new HashMap<String, Integer>();		
		int startrow = (page-1) * limit + 1; 
		int endrow = startrow + limit - 1; 		
		map.put("startrow", startrow);
		map.put("endrow", endrow);
		return mapper.getReviewList(map);
	}
	
	// 조회수 증가
	@Override
	public int setReadCountUpdate(int num) {
		return mapper.setReadCountUpdate(num);
	}
	
	// 글 상세보기
	@Override
	public ReviewBoard getDetail(int num) {
		return mapper.getDetail(num);
	}
	
	

}
