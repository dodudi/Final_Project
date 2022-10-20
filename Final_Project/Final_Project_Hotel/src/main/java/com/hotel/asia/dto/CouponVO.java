package com.hotel.asia.dto;

public class CouponVO {

	private String COUPON_TYPE_NUMBER;
	private String COUPON_NAME;
	private String COUPON_PRICE;
	private String COUPON_COMMENT;
	
	// [현능] 22-10-19 추가
	private int COUPON_NUMBER; // 조인으로 받아올 회원 쿠폰 발급 번호

	public String getCOUPON_TYPE_NUMBER() {
		return COUPON_TYPE_NUMBER;
	}

	public void setCOUPON_TYPE_NUMBER(String cOUPON_TYPE_NUMBER) {
		COUPON_TYPE_NUMBER = cOUPON_TYPE_NUMBER;
	}

	public String getCOUPON_NAME() {
		return COUPON_NAME;
	}

	public void setCOUPON_NAME(String cOUPON_NAME) {
		COUPON_NAME = cOUPON_NAME;
	}

	public String getCOUPON_PRICE() {
		return COUPON_PRICE;
	}

	public void setCOUPON_PRICE(String cOUPON_PRICE) {
		COUPON_PRICE = cOUPON_PRICE;
	}

	public String getCOUPON_COMMENT() {
		return COUPON_COMMENT;
	}

	public void setCOUPON_COMMENT(String cOUPON_COMMENT) {
		COUPON_COMMENT = cOUPON_COMMENT;
	}

	
	
	
	public int getCOUPON_NUMBER() {
		return COUPON_NUMBER;
	}

	public void setCOUPON_NUMBER(int cOUPON_NUMBER) {
		COUPON_NUMBER = cOUPON_NUMBER;
	}
}
