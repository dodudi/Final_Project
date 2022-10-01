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
	
	// 답댓글 등록
	int commReplyUpdate(ReviewComm rc);  // BOARD_RE_SEQ값 수정
	public int commReply(ReviewComm rc);
	public ReviewComm refComm(int REVIEW_COMMENT_NUM); // 답댓글 다는 원문 댓글 정보
	public String refCommMem(int REVIEW_COMMENT_RE_REF, int REVIEW_COMMENT_RE_SEQ); // 답댓글 다는 원문 댓글 작성자
	
	
	// 댓글 삭제
	public int commDeleteAll(int REVIEW_COMMENT_NUM); // 원문 댓글인 경우, 답댓글까지 모두 삭제
	public int commDelete(int REVIEW_COMMENT_NUM); // 답댓글인 경우 해당 댓글만 삭제
	

}
