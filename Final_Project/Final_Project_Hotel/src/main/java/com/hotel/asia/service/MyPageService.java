package com.hotel.asia.service;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hotel.asia.controller.MyPageController;
import com.hotel.asia.dto.Option;
import com.hotel.asia.dto.OptionReservation;
import com.hotel.asia.dto.Payment;
import com.hotel.asia.dto.Rez;
import com.hotel.asia.module.PageCalc;
import com.hotel.asia.mybatis.mapper.MyPageMapper;

@Service
public interface MyPageService {

	// 객실정보 가져오기
	public Rez getRezData(String mem_id);
	// 옵션선택정보 가져오기
	public List<OptionReservation> getOptRezData(String mem_id);
	// 결제정보 가져오기
	public Payment getPayment(String mem_id) ;
	// 멤버 아이디에 대한 옵션 가져오기
	public List<OptionReservation> getOptRezData(String mem_id, int opt_id);

	// 날짜에 대한 옵션 가져오기
	public List<OptionReservation> getOptRezData(String mem_id, String date, int opt_id);
	

	// 체크아웃 날짜 - 체크인 날짜 -> 몇일 ex) 2022-10-10 ~ 2022-10-13 -> 3
	public long getDateSub(String start, String end) ;


	// 옵션 날짜 구하기 -> ex) 2022-10-10 3일 -> 2022-10-10~2022-10-13까지의 날짜를 배열로 반환
	public List<String> calcBreakFastDate(String checkIn, long subDate);
	
	public Map<String, Map<String, Integer>> getOptPrice(List<OptionReservation> opts, List<Option> optInfo,  int opt_id);

	
	//결제 데이터 삭제!
	public void delRezData(int rez_id, String mem_id);
	//새로운 결제데이터 추가
	public void addRez(Rez rez); 
	//새로운 결제데이터 추가
	public void addOptRez(List<OptionReservation> opt); 
	public void addPayment(Payment payment);
	
	
	//질문 게시판----------------------------------------
	public int getQuestionBoardCount(String mem_id);
	public List<Integer> getQuestionBoard(HashMap<String, Object> data);
}
