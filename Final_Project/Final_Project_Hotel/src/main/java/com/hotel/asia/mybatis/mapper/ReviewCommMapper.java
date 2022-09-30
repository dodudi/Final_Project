package com.hotel.asia.mybatis.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.hotel.asia.dto.ReviewComm;

@Mapper
public interface ReviewCommMapper {
	// 총 댓글 
	public int getCommListCount(int REVIEW_NUM);
	
	// 댓글 리스트
	public List<ReviewComm> getCommentList(HashMap<String, Integer> map);
	
	// 댓글 등록
	public int commWrite(ReviewComm rc);
	
	// 댓글 수정
	public int commModify(ReviewComm rc);
	
	// 답댓글 등록
	public int commReplyUpdate(ReviewComm rc); // BOARD_RE_SEQ값 수정
	public int commReply(ReviewComm rc);
	public ReviewComm refComm(int REVIEW_COMMENT_NUM); // 답댓글 다는 원문 댓글 정보
	
	// 답댓글 다는 원문 댓글 작성자
	public String refCommMem(int REVIEW_COMMENT_RE_REF, int REVIEW_COMMENT_RE_SEQ);
	
	
	// 댓글 삭제
	public ReviewComm commDetail(int REVIEW_COMMENT_NUM);
	public int commDeleteAll(ReviewComm rc);  // 원문 댓글인 경우, 답댓글까지 모두 삭제
	public int commDelete(int REVIEW_COMMENT_NUM); // 답댓글인 경우 해당 댓글만 삭제

	

	

}
