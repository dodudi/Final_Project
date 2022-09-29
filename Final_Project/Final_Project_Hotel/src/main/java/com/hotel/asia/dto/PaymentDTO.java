package com.hotel.asia.dto;

/*
 * 결제 시스템에 필요한 데이터들
 * */
public class PaymentDTO {
	private String itemName;
	private String itemPrice;
	private String phone;
	private String name;
	private String addr;
	
	public PaymentDTO() {
		this("defaultName", "1000", "010-1111-1111","TestName","서울특별시 강남구 신사동");
	}

	
	public PaymentDTO(String itemName, String itemPrice, String phone, String name, String addr) {
		super();
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

