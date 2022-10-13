package com.hotel.asia.service;

import com.hotel.asia.dto.Payment;

public interface PaymentService {
	
	// 결제
	public int payment(Payment pm);
	
	
	// *****결제취소*****
	// 예약번호 구하기
	public int getRezId(String merchant_uid);

}
