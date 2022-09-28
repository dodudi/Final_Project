package com.hotel.asia.service;

import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hotel.asia.controller.ReviewController;
import com.hotel.asia.dto.ReviewBoard;
import com.hotel.asia.mybatis.mapper.ReviewBoardMapper;

@Service
public class ReviewBoardServiceImpl implements ReviewBoardService{
	private static final Logger logger = LoggerFactory.getLogger(ReviewBoardServiceImpl.class);
	
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
	
	// 글 수정
	@Override
	public int modify(ReviewBoard rb) {
		return mapper.modify(rb);
	}
	
	// 글 수정, 삭제 시 비밀번호 맞는지 확인
	@Override
	public boolean isReviewWriter(int review_NUM, String review_PASS) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("REVIEW_NUM", review_NUM);
		map.put("REVIEW_PASS", review_PASS);

		ReviewBoard review = mapper.isReviewWriter(map);
		
		if(review == null) {
			return false;
		} else {
			return true;
		}
	}
	
	// 글 삭제
	@Override
	public int reviewDelete(int review_NUM) {
		return mapper.delete(review_NUM);
	}
	
	

}
