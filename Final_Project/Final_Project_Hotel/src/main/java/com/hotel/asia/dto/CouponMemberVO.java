package com.hotel.asia.dto;

public class CouponMemberVO {
	private int COUPON_NUMBER;
	private int COUPON_TYPE_NUMBER;
	private String MEM_ID;
	private String COUPON_GET_DATE;
	private String COUPON_END_DATE;
	public int getCOUPON_NUMBER() {
		return COUPON_NUMBER;
	}
	public void setCOUPON_NUMBER(int cOUPON_NUMBER) {
		COUPON_NUMBER = cOUPON_NUMBER;
	}
	public int getCOUPON_TYPE_NUMBER() {
		return COUPON_TYPE_NUMBER;
	}
	public void setCOUPON_TYPE_NUMBER(int cOUPON_TYPE_NUMBER) {
		COUPON_TYPE_NUMBER = cOUPON_TYPE_NUMBER;
	}
	public String getMEM_ID() {
		return MEM_ID;
	}
	public void setMEM_ID(String mEM_ID) {
		MEM_ID = mEM_ID;
	}
	public String getCOUPON_GET_DATE() {
		return COUPON_GET_DATE;
	}
	public void setCOUPON_GET_DATE(String cOUPON_GET_DATE) {
		COUPON_GET_DATE = cOUPON_GET_DATE;
	}
	public String getCOUPON_END_DATE() {
		return COUPON_END_DATE;
	}
	public void setCOUPON_END_DATE(String cOUPON_END_DATE) {
		COUPON_END_DATE = cOUPON_END_DATE;
	}
	
}
