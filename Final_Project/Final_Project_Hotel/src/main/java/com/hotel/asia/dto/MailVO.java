package com.hotel.asia.dto;

public class MailVO {
	private String from ="freshkurly@naver.com";	//mail.properties에서 작성한 아이디에 해당하는 이메일 주소 작성 
	private String to;
	private String subject;
	private String content;
	
	public String getFrom() {
		return from;
	}
	
	public void setFrom(String from) {
		this.from = from;
	}
	
	public String getTo() {
		return to;
	}
	
	public void setTo(String to) {
		this.to = to;
	}
	
	public String getSubject() {
		return subject;
	}
	
	public void setSubject(String subject) {
		this.subject = subject;
	}
	
	public String getContent() {
		return content;
	}
	
	public void setContent(String content) {
		this.content = content;
	}
	
	
}
