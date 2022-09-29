package com.hotel.asia.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hotel.asia.dto.ReviewComm;
import com.hotel.asia.mybatis.mapper.ReviewCommMapper;

@Service
public class ReviewCommServiceImpl implements ReviewCommService{
	@Autowired
	private ReviewCommMapper mapper;
	
	// 총 댓글 수
	@Override
	public int getCommListCount(int REVIEW_NUM) {
		return mapper.getCommListCount(REVIEW_NUM);
	}
	
	// 댓글 리스트
	@Override
	public List<ReviewComm> getCommentList(int REVIEW_NUM, int page) {
		int startrow = 1;
		int endrow = page*5; // 5개씩 보여줌
		
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("REVIEW_NUM", REVIEW_NUM);
		map.put("startrow", startrow);
		map.put("endrow", endrow);
		return mapper.getCommentList(map);
	}
	
	// 댓글 등록
	@Override
	public int commWrite(ReviewComm rc) {
		return mapper.commWrite(rc);
	}
	
	// 댓글 수정
	@Override
	public int commModify(ReviewComm rc) {
		return mapper.commModify(rc);
	}
	
	// 댓글 삭제
	@Override
	public int commDelete(int REVIEW_COMMENT_NUM) {
		return mapper.commDelete(REVIEW_COMMENT_NUM);
	}
	
	// 답댓글 등록
	@Override
	public int commReplyUpdate(ReviewComm rc) { // BOARD_RE_SEQ값 수정
		return mapper.commReplyUpdate(rc);
	}
	@Override
	public int commReply(ReviewComm rc) {
		commReplyUpdate(rc);
		rc.setREVIEW_COMMENT_RE_LEV(rc.getREVIEW_COMMENT_RE_LEV() + 1);
		rc.setREVIEW_COMMENT_RE_SEQ(rc.getREVIEW_COMMENT_RE_SEQ() + 1);
		return mapper.commReply(rc);
	}

	@Override
	public ReviewComm refComm(int REVIEW_COMMENT_NUM) {
		return mapper.refComm(REVIEW_COMMENT_NUM);
	}
	
}	
