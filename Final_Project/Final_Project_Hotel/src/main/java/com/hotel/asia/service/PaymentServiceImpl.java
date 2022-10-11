package com.hotel.asia.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hotel.asia.dto.Payment;
import com.hotel.asia.mybatis.mapper.PaymentMapper;

@Service
public class PaymentServiceImpl implements PaymentService{
	@Autowired
	private PaymentMapper mapper;
	
	// 결제
	@Override
	public int payment(Payment pm) {
		return mapper.payment(pm);
	}
	
	
	// *****결제취소*****
	// 예약번호 구하기
	@Override
	public int getRezId(String merchant_uid) {
		return mapper.getRezId(merchant_uid);
	}
}
