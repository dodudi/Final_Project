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
	public int getListCount(int index, String search_word) {
		HashMap<String, String> map = new HashMap<String, String>();
		// index == -1 : search_field가 넘어오지 않은 상태로, defaultValue="-1"
		if(index != -1) {
			String[] search_field= new String[] {"REVIEW_SUBJECT", "MEM_ID"};
			map.put("search_field", search_field[index]);
			map.put("search_word", "%" + search_word + "%");
		}
		return mapper.getListCount(map);
	}
	
	// 글 리스트
	@Override
	public List<ReviewBoard> getReviewList(int page, int limit, String sortBy, int index, String search_word) {
		HashMap<String, Object> map = new HashMap<String, Object>();		
		int startrow = (page-1) * limit + 1; 
		int endrow = startrow + limit - 1;
		
		// index == -1 : search_field가 넘어오지 않은 상태로, defaultValue="-1"
		if(index != -1) {
			String[] search_field= new String[] {"REVIEW_SUBJECT", "MEM_ID"};
			map.put("search_field", search_field[index]);
			map.put("search_word", "%" + search_word + "%");
		}
		
		map.put("startrow", startrow);
		map.put("endrow", endrow);
		map.put("sortBy", sortBy);
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
	
	// 글 이전에 추천한 사람인지 확인
	@Override
	public int reviewRecommMem(int review_NUM, String id) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("REVIEW_NUM", review_NUM);
		map.put("MEM_ID", id);
		ReviewBoard review = mapper.reviewRecommMem(map);
		
		// 새로 추천하는 사람이면 0, 기존에 추천한 사람이면 1
		if(review == null) { 
			return 0;
		} else {
			return 1;
		}
	}
	// 추천 테이블에 추가
	@Override
	public int reviewRecommTab(int review_NUM, String id) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("REVIEW_NUM", review_NUM);
		map.put("MEM_ID", id);
		return mapper.reviewRecommTab(map);
	}
	// 추천 성공 여부
	@Override
	public int reviewRecomm(int review_NUM) {
		return mapper.reviewRecomm(review_NUM);
	}
	// 추천 테이블에서 삭제
	@Override
	public int reviewRecommTabDel(int review_NUM, String id) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("REVIEW_NUM", review_NUM);
		map.put("MEM_ID", id);
		return mapper.reviewRecommTabDel(map);
	}
	// 추천 해제 여부
	@Override
	public int reviewRecommDel(int review_NUM) {
		return mapper.reviewRecommDel(review_NUM);
	}
	
	
	// 검색어 리스트 추가 or 갱신
	@Override
	public int addSearchWord(String searchWord) {
		return mapper.addSearchWord(searchWord);
	}
	// 인기검색어 리스트
	@Override
	public List<String> getTopSearchWordList() {
		return mapper.getTopSearchWordList();
	}
	// 인기검색어 삭제 (only 관리자)
	@Override
	public int deleteSearchWord(String searchWord) {
		return mapper.deleteSearchWord(searchWord);
	}
}
