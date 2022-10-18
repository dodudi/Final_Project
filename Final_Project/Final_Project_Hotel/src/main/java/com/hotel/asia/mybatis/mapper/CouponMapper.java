package com.hotel.asia.mybatis.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.hotel.asia.dto.CouponMemberVO;
import com.hotel.asia.dto.CouponVO;

@Mapper
public interface CouponMapper {
	public List<CouponMemberVO> getCouponMember(String mem_id);
	public int getCouponMemberCount(String mem_id);
	public CouponVO getCoupon(int COUPON_TYPE_NUMBER);
	public int useCouponMember(int COUPON_NUMBER);
	public int saveUseCoupon();
}
