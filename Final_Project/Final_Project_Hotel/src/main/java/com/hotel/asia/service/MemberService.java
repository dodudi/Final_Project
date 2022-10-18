package com.hotel.asia.service;

import java.util.List;
import com.hotel.asia.dto.Member;

public interface MemberService {
	
	public int isId(String id, String password);
	
	public int insert(Member m);
	
	public int isId(String id);
	
	public Member member_info(String id);
	
	public void delete(String id);
	
	public int update(Member m);
	
	public List<Member> getSearchList(int index, String search_word,int page, int limit);
	
	public int getSearchListCount(int index, String search_word);
	
	//아이디 찾기 
	public String findId(String id, String password);
	
	//비밀번호 찾기 
	public int searchPw(String name, String id, String email);
	
	public int updatePw(Member m);
	
	
	
	// ==========[현능] 22-10-05 수정==========
	   // 회원 정보
	   public Member getMemberInfo(String id);
	   // 휴대폰 번호 중복 검사 
	   public int phoneCheck(int phone);
	   // 포인트 적립
	   public int rewardPoint(String id, int point);

	
}
