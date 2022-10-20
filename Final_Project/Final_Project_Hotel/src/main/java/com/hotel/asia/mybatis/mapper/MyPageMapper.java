package com.hotel.asia.mybatis.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.hotel.asia.dto.Member;
import com.hotel.asia.dto.OptionReservation;
import com.hotel.asia.dto.Payment;
import com.hotel.asia.dto.Rez;

//마이페이지에서 필요한 데이터들
@Mapper
public interface MyPageMapper {
	//객실정보 가져오기
	public  List<Rez> getRezDatas(String mem_id);
	//옵션선택정보 가져오기
	public List<OptionReservation> getOptRezData(String mem_id);
	//결제정보 가져오기
	public Payment getPayment(String mem_id);
	
	//로그인한 회원 정보 가져오기
	public Member getMemberData(String mem_id);
	

	//게시판 쿼리
	//질문게시판 질문 개수 가져오기(유저 아이디)
	public int getQuestionBoardCount(String mem_id);
	//질문게시판 질문 가져오기(아이디)
	public List<Integer> getQuestionBoard(HashMap<String, Object> data);
	
	//회원정보 쿼리
}
