package com.hotel.asia.dto;

/*
 * 결제 시스템에 필요한 데이터들
 * */
public class PaymentDTO {
	private String itemName;	//구매아이템 내용
	private String itemPrice;	//구매아이템 가격
	private String phone;		//사용자 전화번호
	private String name;		//사용자 이름
	private String addr;		//사용자 주소
	
	public PaymentDTO() {
		this("defaultName", "1000", "010-1111-1111","TestName","서울특별시 강남구 신사동");
	}

	
	public PaymentDTO(String itemName, String itemPrice, String phone, String name, String addr) {
		this.itemName = itemName;
		this.itemPrice = itemPrice;
		this.phone = phone;
		this.name = name;
		this.addr = addr;
	}

	public String getItemName() {
		return itemName;
	}
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}
	public String getItemPrice() {
		return itemPrice;
	}
	public void setItemPrice(String itemPrice) {
		this.itemPrice = itemPrice;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	
	
}

