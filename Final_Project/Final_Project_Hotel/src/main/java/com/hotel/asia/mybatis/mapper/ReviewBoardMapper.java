package com.hotel.asia.mybatis.mapper;

import java.util.HashMap;
import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.hotel.asia.dto.ReviewBoard;

@Mapper
public interface ReviewBoardMapper {
	// 글 작성
	public int write(ReviewBoard rb);
	
	// 글 개수
	public int getListCount();
	
	// 글 리스트
	public List<ReviewBoard> getReviewList(HashMap<String, Integer> map);
	
	// 조회수 증가
	public int setReadCountUpdate(int num);
	
	// 글 상세보기
	public ReviewBoard getDetail(int num);
	
	

}
