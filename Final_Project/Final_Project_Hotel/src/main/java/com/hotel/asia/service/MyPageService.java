package com.hotel.asia.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.hotel.asia.dto.OptionReservation;
import com.hotel.asia.dto.Payment;
import com.hotel.asia.dto.Rez;

@Service
public interface MyPageService {
	//객실정보 가져오기
	public Rez getRezData(String mem_id);
	//옵션선택정보 가져오기
	public List<OptionReservation> getOptRezData(String mem_id);
	//결제정보 가져오기
	public Payment getPayment(String mem_id);
}
