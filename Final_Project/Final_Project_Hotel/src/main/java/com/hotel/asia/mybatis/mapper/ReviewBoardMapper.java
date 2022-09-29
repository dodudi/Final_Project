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
	public int getListCount(HashMap<String, String> map);
	
	// 글 리스트
	public List<ReviewBoard> getReviewList(HashMap<String, Object> map);
	
	// 조회수 증가
	public int setReadCountUpdate(int num);
	
	// 글 상세보기
	public ReviewBoard getDetail(int num);
	
	// 글 수정
	public int modify(ReviewBoard rb);
	
	// 글 수정, 삭제 시 비밀번호 맞는지 확인
	public ReviewBoard isReviewWriter(HashMap<String, Object> map);
	
	// 글 삭제
	public int delete(int review_NUM);
	
	// 글 이전에 추천한 사람인지 확인
	public ReviewBoard reviewRecommMem(HashMap<String, Object> map);
	// 추천 테이블에 추가
	public int reviewRecommTab(HashMap<String, Object> map);
	// 추천 성공 여부
	public int reviewRecomm(int review_NUM);
	// 추천 테이블에서 삭제
	public int reviewRecommTabDel(HashMap<String, Object> map);
	// 추천 해제 여부
	public int reviewRecommDel(int review_NUM);
	
	

}
