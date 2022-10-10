package com.hotel.asia.dto;

public class Member {
	private String MEM_ID;
	private String MEM_PASS;
	private String MEM_NAME;
	private String MEM_EMAIL;
	private int MEM_PHONE;
	private int MEM_POINT;
	private String AUTH="ROLE_MEMBER";
	
	public String getMEM_ID() {
		return MEM_ID;
	}
	public void setMEM_ID(String mEM_ID) {
		MEM_ID = mEM_ID;
	}
	public String getMEM_PASS() {
		return MEM_PASS;
	}
	public void setMEM_PASS(String mEM_PASS) {
		MEM_PASS = mEM_PASS;
	}
	public String getMEM_NAME() {
		return MEM_NAME;
	}
	public void setMEM_NAME(String mEM_NAME) {
		MEM_NAME = mEM_NAME;
	}
	public String getMEM_EMAIL() {
		return MEM_EMAIL;
	}
	public void setMEM_EMAIL(String mEM_EMAIL) {
		MEM_EMAIL = mEM_EMAIL;
	}
	public int getMEM_PHONE() {
		return MEM_PHONE;
	}
	public void setMEM_PHONE(int mEM_PHONE) {
		MEM_PHONE = mEM_PHONE;
	}
	public int getMEM_POINT() {
		return MEM_POINT;
	}
	public void setMEM_POINT(int mEM_POINT) {
		MEM_POINT = mEM_POINT;
	}
	public String getAUTH() {
		return AUTH;
	}
	public void setAUTH(String aUTH) {
		AUTH = aUTH;
	}
	
}
