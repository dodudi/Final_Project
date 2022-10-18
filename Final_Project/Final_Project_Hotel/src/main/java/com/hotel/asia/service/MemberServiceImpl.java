package com.hotel.asia.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.hotel.asia.dto.Member;
import com.hotel.asia.mybatis.mapper.MemberMapper;

@Service
public class MemberServiceImpl implements MemberService {
	
	private MemberMapper dao;
	private PasswordEncoder passwordEncoder;
	
	@Autowired
	public MemberServiceImpl(MemberMapper dao, PasswordEncoder passwordEncoder) {
		this.dao = dao;
		this.passwordEncoder = passwordEncoder;
	}

	@Override
	public int isId(String id) {
		Member rmember = dao.isId(id);
		return (rmember==null) ? -1 : 1;	//-1은 아이디가 존재핳지 않는 경우 
											//1은 아이디가 존재하는 경우 
	}

	@Override
	public int insert(Member m) {
		int rmember = dao.insert(m);
		return rmember;
		//return dao.insert(m);
	}

	//회원 정보 수정창 보임 
	@Override
	public Member member_info(String id) {
		return dao.isId(id);
	}

	//회원 삭제 
	@Override
	public void delete(String id) {
		dao.delete(id);
	}

	//회원정보 수정 
	@Override
	public int update(Member m) {
		return dao.update(m);
	}

	//회원정보 보기(검색포함)
	@Override
	public List<Member> getSearchList(int index, String search_word, int page, int limit) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(index!=-1) {	
			String[] search_field = new String[] {"id", "name", "age", "gender"};
			map.put("search_field", search_field[index]);
			map.put("search_word", "%" + search_word + "%"); }
		
		int startrow = (page-1)*limit + 1;
		int endrow = startrow + limit -1;
		map.put("start", startrow);
		map.put("end", endrow);
	
		return dao.getSearchList(map);
	}

	//회원정보 보기(검색+회원수 포함)
	@Override
	public int getSearchListCount(int index, String search_word) {
		Map<String, String> map = new HashMap<String, String>();
		if(index!=-1) {
			String[] search_field = new String[] {"id", "name"};
			map.put("search_field", search_field[index]);
			map.put("search_word", "%" + search_word + "%");
		} return dao.getSearchListCount(map);
	}
	
	//아이디 존재 여부 
	@Override
	public int isId(String id, String password) {
		Member rmember = dao.isId(id);
		int result = -1;	
		if(rmember != null) {	//아이디가 존재하는 경우
			if(passwordEncoder.matches(password, rmember.getMEM_PASS())) {
				result = 1;		//아이디와 비밀번호가 일치하는 경우 
			}else
				result=0;		//아이디는 존재하지만 비밀번호가 일치하지 않는 경우 
		}
		return result;
	}
	
	//아이디 찾기 
	@Override
	public String findId(String name, String email) {
		return dao.findId(name, email);
	}
	
	//비밀번호 찾기 
	@Override
	public int searchPw(String name, String id, String email) {
		Member member = dao.searchPw(name, id, email);
		int result = -1;
		if(member != null) {
			result = 1;		//비번존재 
		}else {
			result = 0;		//비번무 
		}
		return result;		//에러 
	}
	
	//비밀번호 변경 
	@Override
	public int updatePw(Member m) {
		return dao.updatePw(m);
	}
	
	// ==========[현능] 22-10-05 수정==========
	   // 회원 정보
	   @Override
	   public Member getMemberInfo(String id) {
	      return dao.getMemberInfo(id);
	   }
	   // 휴대폰 번호 중복 검사 
	   @Override
	   public int phoneCheck(int phone) {
	      int result = -1;
	      Member m = dao.phoneCheck(phone);
	      if(m == null) {
	         result = 0;
	      } else {
	         result = 1;
	      }
	      return result; // 휴대폰번호 있으면 1, 없으면 0, 매퍼 작동 안 하면 -1
	   }
	   // 포인트 적립
	   @Override
	   public int rewardPoint(String id, int point) {
	      HashMap<String, Object> map = new HashMap<String, Object>();
	      map.put("MEM_ID", id);
	      map.put("MEM_POINT", point);
	      return dao.rewardPoint(map);
	   }

	
}
