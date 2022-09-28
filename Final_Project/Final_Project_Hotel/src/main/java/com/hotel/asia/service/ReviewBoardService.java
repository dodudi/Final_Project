package com.hotel.asia.service;

import java.util.List;
import com.hotel.asia.dto.ReviewBoard;

public interface ReviewBoardService {
	
	// 글 작성
	public int write(ReviewBoard rb);
	
	// 글 갯수
	public int getListCount();
	
	// 글 리스트
	public List<ReviewBoard> getReviewList(int page, int limit, String sortBy);
	
	// 조회수
	public int setReadCountUpdate(int num);
	
	// 글 상세보기
	public ReviewBoard getDetail(int num);
	
	// 글 수정
	public int modify(ReviewBoard rb);
	
	// 글 수정, 삭제 시 비밀번호 맞는지 확인
	public boolean isReviewWriter(int review_NUM, String review_PASS);
	
	// 글 삭제
	public int reviewDelete(int review_NUM);

}
