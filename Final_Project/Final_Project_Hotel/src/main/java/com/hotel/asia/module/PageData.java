package com.hotel.asia.module;

public class PageData {
	//현재 페이지 번호
	private int pageNum;
	//아이템 개수 제한
	private int itemLimit;
	
	private final static int DEFAULT_PAGE_NUM =1;
	private final static int DEFAULT_ITEM_COUNT = 10;
	
	public PageData() {
		this(DEFAULT_PAGE_NUM, DEFAULT_ITEM_COUNT);
	}
	
	public PageData(int pageNum, int itemLimit) {
		this.pageNum = pageNum;
		this.itemLimit = itemLimit;
	}
	
	public int getPageNum() {
		return pageNum;
	}
	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}

	public int getItemLimit() {
		return itemLimit;
	}

	public void setItemLimit(int itemLimit) {
		this.itemLimit = itemLimit;
	}

	
 	
}
