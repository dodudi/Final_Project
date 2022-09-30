package com.hotel.asia.dto;

public class ReviewBoard {
	private int REVIEW_NUM;
	private String MEM_ID;
	private String REVIEW_PASS;
	private String REVIEW_SUBJECT;
	private String REVIEW_CONTENT;
	private String REVIEW_DATE;
	private int REVIEW_READCOUNT;
	private int REVIEW_RECOMM;
	private int CNT; // 댓글 수
	
	
	//getter, setter
	public int getREVIEW_NUM() {
		return REVIEW_NUM;
	}
	public void setREVIEW_NUM(int rEVIEW_NUM) {
		REVIEW_NUM = rEVIEW_NUM;
	}
	public String getMEM_ID() {
		return MEM_ID;
	}
	public void setMEM_ID(String mEM_ID) {
		MEM_ID = mEM_ID;
	}
	public String getREVIEW_PASS() {
		return REVIEW_PASS;
	}
	public void setREVIEW_PASS(String rEVIEW_PASS) {
		REVIEW_PASS = rEVIEW_PASS;
	}
	public String getREVIEW_SUBJECT() {
		return REVIEW_SUBJECT;
	}
	public void setREVIEW_SUBJECT(String rEVIEW_SUBJECT) {
		REVIEW_SUBJECT = rEVIEW_SUBJECT;
	}
	public String getREVIEW_CONTENT() {
		return REVIEW_CONTENT;
	}
	public void setREVIEW_CONTENT(String rEVIEW_CONTENT) {
		REVIEW_CONTENT = rEVIEW_CONTENT;
	}
	public String getREVIEW_DATE() {
		return REVIEW_DATE;
	}
	public void setREVIEW_DATE(String rEVIEW_DATE) {
		REVIEW_DATE = rEVIEW_DATE;
	}
	public int getREVIEW_READCOUNT() {
		return REVIEW_READCOUNT;
	}
	public void setREVIEW_READCOUNT(int rEVIEW_READCOUNT) {
		REVIEW_READCOUNT = rEVIEW_READCOUNT;
	}
	public int getREVIEW_RECOMM() {
		return REVIEW_RECOMM;
	}
	public void setREVIEW_RECOMM(int rEVIEW_RECOMM) {
		REVIEW_RECOMM = rEVIEW_RECOMM;
	}
	public int getCNT() {
		return CNT;
	}
	public void setCNT(int cNT) {
		CNT = cNT;
	}
}
