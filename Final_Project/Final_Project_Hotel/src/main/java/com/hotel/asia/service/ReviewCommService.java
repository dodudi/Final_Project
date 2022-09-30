package com.hotel.asia.service;

import java.util.List;

import com.hotel.asia.dto.ReviewComm;

public interface ReviewCommService {
	
	// 총 댓글 수
	public int getCommListCount(int REVIEW_NUM);
	
	// 댓글 리스트
	public List<ReviewComm> getCommentList(int REVIEW_NUM, int page);
	
	// 댓글 등록
	public int commWrite(ReviewComm rc);
	
	// 댓글 수정
	public int commModify(ReviewComm rc);
	
	// 댓글 삭제
	public int commDelete(int REVIEW_COMMENT_NUM);
	
	// 답댓글 등록
	int commReplyUpdate(ReviewComm rc);  // BOARD_RE_SEQ값 수정
	public int commReply(ReviewComm rc);

	public ReviewComm refComm(int REVIEW_COMMENT_NUM);

	

}
