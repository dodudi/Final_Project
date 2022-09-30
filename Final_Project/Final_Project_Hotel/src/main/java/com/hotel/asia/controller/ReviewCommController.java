package com.hotel.asia.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.hotel.asia.dto.ReviewComm;
import com.hotel.asia.service.ReviewCommService;


@RestController
@RequestMapping(value="/reviewComm")
public class ReviewCommController { 
	
	private static final Logger logger = LoggerFactory.getLogger(ReviewCommController.class);
	
	
	@Autowired
	private ReviewCommService reviewCommService;
	
	// 댓글 리스트
	@PostMapping(value="/reviewCommList")
	public Map<String, Object> reviewCommList(int REVIEW_NUM, int page) {
		
		int listcount = reviewCommService.getCommListCount(REVIEW_NUM); // 총 댓글 수
		List<ReviewComm> commList = reviewCommService.getCommentList(REVIEW_NUM, page); // 댓글 리스트
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("listcount", listcount);
		map.put("commList", commList);
		return map;
	}
	// 답댓글인 경우 원문 댓글 작성자 구하기
	@PostMapping(value="/commReplyRefMem")
	public String commReplyRefMem(int REVIEW_COMMENT_RE_REF, int REVIEW_COMMENT_RE_SEQ) {
		logger.info("=====[commReplyRefMem]=====");
		logger.info("*답댓글 seq: " + REVIEW_COMMENT_RE_SEQ);
		REVIEW_COMMENT_RE_SEQ -= 1; // 답댓글의 원문 댓글은 답댓글의 seq보다 1 작다
		logger.info("*원문 seq: " + REVIEW_COMMENT_RE_SEQ);
		
		String refCommMem = reviewCommService.refCommMem(REVIEW_COMMENT_RE_REF, REVIEW_COMMENT_RE_SEQ);
		logger.info("*원문댓글 작성자: " + refCommMem);
		return refCommMem;
	}
	
	
	
	// 댓글 등록
	@PostMapping(value="/commWrite")
	public int commWrite(ReviewComm rc) {
		logger.info("=====[reviewWrite]=====");
		int result = reviewCommService.commWrite(rc);
		if(result == 1) {
			logger.info("*등록된 댓글 => " + rc.getREVIEW_COMMENT_CONTENT());
			logger.info("댓글 등록 성공");
		} else {
			logger.info("댓글 등록 실패");
		}
		return result;
	}
	
	// 답댓글 등록
	@PostMapping("/commReply")
	public int commReply(ReviewComm rc) {
		ReviewComm refComm = reviewCommService.refComm(rc.getREVIEW_COMMENT_RE_REF());
		rc.setREVIEW_COMMENT_RE_REF(refComm.getREVIEW_COMMENT_RE_REF());  
		rc.setREVIEW_COMMENT_RE_LEV(refComm.getREVIEW_COMMENT_RE_LEV());  
		rc.setREVIEW_COMMENT_RE_SEQ(refComm.getREVIEW_COMMENT_RE_SEQ());  
		
		int result = reviewCommService.commReply(rc);
		if(result == 1) {
			logger.info("*등록된 답댓글 => " + rc.getREVIEW_COMMENT_CONTENT());
			logger.info("답댓글 등록 성공");
		} else {
			logger.info("답댓글 등록 실패");
		}
		return result;
	}
	
	
	
	// 댓글 수정
	@PostMapping(value="/commModify")
	public int commModify(ReviewComm rc) {
		logger.info("=====[commModify]=====");
		logger.info("*수정할 댓글 => " + rc.getREVIEW_COMMENT_CONTENT());
		
		int result = reviewCommService.commModify(rc);
		if(result == 1) {
			logger.info("댓글 수정 성공");
		} else {
			logger.info("댓글 수정 실패");
		}
		return result;
	}
	
	/*
	// 댓글 삭제
	@PostMapping(value="/commDelete")
	public int commDelete(int REVIEW_COMMENT_NUM) {
		logger.info("=====[reviewDelete]=====");
		
		int result = reviewCommService.reviewDelete(REVIEW_COMMENT_NUM);
		if(result == 1) {
			logger.info("댓글 삭제 성공");
		} else {
			logger.info("댓글 삭제 실패");
		}
		return result;
	}
	*/
}
