package com.hotel.asia.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hotel.asia.dto.CouponMemberVO;
import com.hotel.asia.dto.CouponVO;
import com.hotel.asia.mybatis.mapper.CouponMapper;

@Service
public class CouponServiceImpl implements CouponService{

	@Autowired
	private CouponMapper mapper;
	
	@Override
	public List<CouponMemberVO> getCouponMember(String mem_id) {
		return mapper.getCouponMember(mem_id);
	}

	@Override
	public int getCouponMemberCount(String mem_id) {
		// TODO Auto-generated method stub
		return mapper.getCouponMemberCount(mem_id);
	}

	@Override
	public CouponVO getCoupon(int COUPON_TYPE_NUMBER) {
		// TODO Auto-generated method stub
		return mapper.getCoupon(COUPON_TYPE_NUMBER);
	}

	@Override
	public int useCouponMember(int COUPON_NUMBER) {
		// TODO Auto-generated method stub
		return mapper.useCouponMember(COUPON_NUMBER);
	}
	
	
	
	
	// ==========[현능] 22-10-19 추가==========
	@Override
	public List<CouponVO> getCouponList(String loginId) {
		return mapper.getCouponList(loginId);
	}

}
