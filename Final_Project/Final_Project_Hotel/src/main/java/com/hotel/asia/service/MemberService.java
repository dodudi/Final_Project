package com.hotel.asia.service;

import java.util.List;
import com.hotel.asia.dto.Member;

public interface MemberService {
	
	public int isId(String id, String pass);
	
	public int insert(Member m);
	
	public int isId(String id);
	
	public Member member_info(String id);
	
	public void delete(String id);
	
	public int update(Member m);
	
	public List<Member> getSearchList(int index, String search_word,int page, int limit);
	
	public int getSearchListCount(int index, String search_word);
	
	
	
	
	
	
	
	// ==========[현능] 22-09-30 추가==========
	// 회원 정보
	public Member getMemberInfo(String attribute);
	// 휴대폰 번호 중복 검사 
	public int phoneCheck(int phone);
}
