package com.hotel.asia.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.hotel.asia.dto.CouponMemberVO;
import com.hotel.asia.dto.CouponVO;
@Service
public interface CouponService {
	public List<CouponMemberVO> getCouponMember(String mem_id);
	public int getCouponMemberCount(String mem_id);
	public CouponVO getCoupon(int COUPON_TYPE_NUMBER);
	public int useCouponMember(int COUPON_NUMBER);
}
