package com.hotel.asia.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hotel.asia.dto.Payment;
import com.hotel.asia.mybatis.mapper.PaymentMapper;

@Service
public class PaymentServiceImpl implements PaymentService{
	@Autowired
	private PaymentMapper mapper;

	@Override
	public int payment(Payment pm) {
		return mapper.payment(pm);
	}
}
