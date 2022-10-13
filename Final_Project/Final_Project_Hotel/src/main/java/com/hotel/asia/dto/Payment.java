package com.hotel.asia.dto;

public class Payment {
	private String PAYMENT_ID;
	private int REZ_ID;
	private String PAYMENT_PRICE; // jsp에서 넘어오는 값을 바로 받기 위해 문자형으로 지정
	private String PAYMENT_DATE;
	private int COUPON_HISTORY_ID;
	private int POINT_DISCOUNT;
	
	// REZ_ID(예약번호) 구하기 위한 필드
	//private int ROOM_ID;
	//private String MEM_ID;
	
	
	// getter, setter
	public String getPAYMENT_ID() {
		return PAYMENT_ID;
	}
	public void setPAYMENT_ID(String pAYMENT_ID) {
		PAYMENT_ID = pAYMENT_ID;
	}
	public int getREZ_ID() {
		return REZ_ID;
	}
	public void setREZ_ID(int rEZ_ID) {
		REZ_ID = rEZ_ID;
	}
	public String getPAYMENT_PRICE() {
		return PAYMENT_PRICE;
	}
	public void setPAYMENT_PRICE(String pAYMENT_PRICE) {
		PAYMENT_PRICE = pAYMENT_PRICE;
	}
	public String getPAYMENT_DATE() {
		return PAYMENT_DATE;
	}
	public void setPAYMENT_DATE(String pAYMENT_DATE) {
		PAYMENT_DATE = pAYMENT_DATE;
	}
	public int getCOUPON_HISTORY_ID() {
		return COUPON_HISTORY_ID;
	}
	public void setCOUPON_HISTORY_ID(int cOUPON_HISTORY_ID) {
		COUPON_HISTORY_ID = cOUPON_HISTORY_ID;
	}
	public int getPOINT_DISCOUNT() {
		return POINT_DISCOUNT;
	}
	public void setPOINT_DISCOUNT(int pOINT_DISCOUNT) {
		POINT_DISCOUNT = pOINT_DISCOUNT;
	}
	
}
