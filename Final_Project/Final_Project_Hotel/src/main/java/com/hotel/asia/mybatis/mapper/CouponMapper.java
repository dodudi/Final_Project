package com.hotel.asia.mybatis.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.hotel.asia.dto.CouponMemberVO;
import com.hotel.asia.dto.CouponVO;

@Mapper
public interface CouponMapper {
	//사용자가 가지고 있는 쿠폰을 리스트로 가져옵니다.
	public List<CouponMemberVO> getCouponMember(String mem_id);
	//사용자가 가지고있는 쿠폰의 개수를 가져옵니다.
	public int getCouponMemberCount(String mem_id);
	//쿠폰 번호에 따른 쿠폰 정보를 가져옵니다.
	public CouponVO getCoupon(int COUPON_TYPE_NUMBER);
	
	public List<CouponMemberVO> getUseCoupon(String mem_id);
	public int getUseCouponCount(String mem_id);
	public int useCouponMember(int COUPON_NUMBER);
	//쿠폰을 사용하면 삭제함과 동시에 사용내역으로 저장
	public int saveUseCoupon(int COUPON_NUMBER);
	
	
	public List<CouponMemberVO> getDelCoupon(String mem_id);
	public int getDelCouponCount(String mem_id);
	//유효기간이 만료되면 자동으로 쿠폰 삭제
	public void autoDelCouponMember();
	//쿠폰을 만료내역으로 추가, autoDelCouponMember와 같이 사용하자
	public void saveDelCoupon();
	public int saveUseCoupon();
	
	
	// ==========[현능] 22-10-19 추가==========
	// 특정회원이 가진 쿠폰 리스트
	public List<CouponVO> getCouponList(String MEM_ID);
	// 사용된 쿠폰 삭제
	public int useCoupon(int COUPON_NUMBER);

}
