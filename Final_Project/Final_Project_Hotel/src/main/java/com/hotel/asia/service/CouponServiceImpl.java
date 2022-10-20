package com.hotel.asia.service;

import java.util.ArrayList;
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

	@Override
	public int saveUseCoupon(int COUPON_NUMBER) {
		return mapper.saveUseCoupon(COUPON_NUMBER);
	}

	@Override
	public boolean useAndSaveCoupon(int COUPON_NUMBER) {
		int result = mapper.saveUseCoupon(COUPON_NUMBER);
		int result1 = mapper.useCouponMember(COUPON_NUMBER);
		return (result>=1 && result1>=1);
	}

	@Override
	public void autoDelCouponMember() {
		mapper.autoDelCouponMember();
	}

	@Override
	public void saveDelCoupon() {
		mapper.saveDelCoupon();
	}

	@Override
	public void delAndSaveCoupon() {
		mapper.saveDelCoupon();
		mapper.autoDelCouponMember();
	}

	@Override
	public List<CouponMemberVO> getUseCoupon(String mem_id) {
		// TODO Auto-generated method stub
		return mapper.getUseCoupon(mem_id);
	}

	@Override
	public int getUseCouponCount(String mem_id) {
		// TODO Auto-generated method stub
		return mapper.getUseCouponCount(mem_id);
	}

	@Override
	public List<CouponMemberVO> getDelCoupon(String mem_id) {
		// TODO Auto-generated method stub
		return mapper.getDelCoupon(mem_id);
	}

	@Override
	public int getDelCouponCount(String mem_id) {
		// TODO Auto-generated method stub
		return mapper.getDelCouponCount(mem_id);
	}

	@Override
	public List<CouponVO> getCouponAboutId(List<CouponMemberVO> memberCoupons) {
		List<CouponVO> coupons = new ArrayList<>();
		
		for (CouponMemberVO couponMemberVO : memberCoupons) {
			CouponVO getCoupon = mapper.getCoupon(couponMemberVO.getCOUPON_TYPE_NUMBER());
			coupons.add(getCoupon);
		}
		return coupons;
	}

}
