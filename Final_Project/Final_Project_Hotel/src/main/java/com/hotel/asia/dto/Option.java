package com.hotel.asia.dto;

public class Option {
	private int OPTION_ID;
	private String OPTION_NAME;
	private int OPTION_DEFAULT_PRICE;
	private int OPTION_CHILD_PRICE;
	
	// getter, setter
	public int getOPTION_ID() {
		return OPTION_ID;
	}
	public void setOPTION_ID(int oPTION_ID) {
		OPTION_ID = oPTION_ID;
	}
	public String getOPTION_NAME() {
		return OPTION_NAME;
	}
	public void setOPTION_NAME(String oPTION_NAME) {
		OPTION_NAME = oPTION_NAME;
	}
	public int getOPTION_DEFAULT_PRICE() {
		return OPTION_DEFAULT_PRICE;
	}
	public void setOPTION_DEFAULT_PRICE(int oPTION_DEFAULT_PRICE) {
		OPTION_DEFAULT_PRICE = oPTION_DEFAULT_PRICE;
	}
	public int getOPTION_CHILD_PRICE() {
		return OPTION_CHILD_PRICE;
	}
	public void setOPTION_CHILD_PRICE(int oPTION_CHILD_PRICE) {
		OPTION_CHILD_PRICE = oPTION_CHILD_PRICE;
	}

}
