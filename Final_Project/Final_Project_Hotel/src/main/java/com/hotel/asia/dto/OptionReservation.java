package com.hotel.asia.dto;

public class OptionReservation {
	private int OPTION_RESERVATION_ID;
	private int REZ_ID;
	private int OPTION_ID;
	private String OPTION_RESERVATION_DATE;
	private int ADULT;
	private int CHILD;
	
	// REZ_ID(예약번호) 구하기 위한 필드
	private int ROOM_ID;
	private String MEM_ID;
	
	
	// getter, setter
	public int getOPTION_RESERVATION_ID() {
		return OPTION_RESERVATION_ID;
	}
	public void setOPTION_RESERVATION_ID(int oPTION_RESERVATION_ID) {
		OPTION_RESERVATION_ID = oPTION_RESERVATION_ID;
	}
	public int getREZ_ID() {
		return REZ_ID;
	}
	public void setREZ_ID(int rEZ_ID) {
		REZ_ID = rEZ_ID;
	}
	public int getOPTION_ID() {
		return OPTION_ID;
	}
	public void setOPTION_ID(int oPTION_ID) {
		OPTION_ID = oPTION_ID;
	}
	public String getOPTION_RESERVATION_DATE() {
		return OPTION_RESERVATION_DATE;
	}
	public void setOPTION_RESERVATION_DATE(String oPTION_RESERVATION_DATE) {
		OPTION_RESERVATION_DATE = oPTION_RESERVATION_DATE;
	}
	public int getADULT() {
		return ADULT;
	}
	public void setADULT(int aDULT) {
		ADULT = aDULT;
	}
	public int getCHILD() {
		return CHILD;
	}
	public void setCHILD(int cHILD) {
		CHILD = cHILD;
	}
	
	
	public int getROOM_ID() {
		return ROOM_ID;
	}
	public void setROOM_ID(int rOOM_ID) {
		ROOM_ID = rOOM_ID;
	}
	public String getMEM_ID() {
		return MEM_ID;
	}
	public void setMEM_ID(String mEM_ID) {
		MEM_ID = mEM_ID;
	}

}
