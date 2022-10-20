package com.hotel.asia.service;

import java.util.List;
import com.hotel.asia.dto.Notice;

public interface NoticeboardService {

	//글의 갯수
	public int getListCount();
	
	//글의 목록
	public List<Notice> getNoticeList(int page, int limit);

	//조회수 업데이트 
	public int setReadCountUpdate(int num);

	//글 내용 보기
	public Notice getDetail(int num);
	
	//글 수정
	public int modify(Notice notice);
	
	// 글 삭제
	public int delete(int notice_NUM);

	// 글쓰기
	public int write(Notice notice);

}
