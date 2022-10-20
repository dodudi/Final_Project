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
	
	public List<CouponMemberVO> getUseCoupon(String mem_id);
	public int getUseCouponCount(String mem_id);
	public int useCouponMember(int COUPON_NUMBER);
	public int saveUseCoupon(int COUPON_NUMBER);
	public boolean useAndSaveCoupon(int COUPON_NUMBER);

	public List<CouponMemberVO> getDelCoupon(String mem_id);
	public int getDelCouponCount(String mem_id);
	public void autoDelCouponMember();
	public void saveDelCoupon();
	public void delAndSaveCoupon();
	
	public List<CouponVO> getCouponAboutId(List<CouponMemberVO> memberCoupons);
	
	
	
	// ==========[현능] 22-10-19 추가==========
	// 특정회원이 가진 쿠폰 리스트
	public List<CouponVO> getCouponList(String loginId);
	
	// 사용된 쿠폰 삭제
	public int useCoupon(int useCouponNum);
}
