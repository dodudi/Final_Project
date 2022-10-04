package com.hotel.asia.mybatis.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.hotel.asia.dto.Payment;

@Mapper
public interface PaymentMapper {

	public int payment(Payment pm);

}
