package com.hotel.asia.mybatis.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.hotel.asia.dto.Payment;

@Mapper
public interface PaymentMapper {
	
	// 결제
	public int payment(Payment pm);
	
	// *****결제취소*****
	// 예약번호 구하기
	public int getRezId(String PAYMENT_ID);

}
