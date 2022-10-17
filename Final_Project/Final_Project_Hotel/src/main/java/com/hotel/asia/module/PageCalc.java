package com.hotel.asia.module;

public class PageCalc {
	// 페이징 번호 제한 1번~10번, 1번~5번 등
	private int pageLimit;
	// 시작 페이지 번호
	private int startPage;
	// 마지막 페이지 번호
	private int endPage;
	// 실제 마지막 페이지 번호 endPage가 최대치를 넘을 때 사용
	private int realEndPage;
	
	//아이템 시작 번호
	private int startItem;
	//아이템 마지막 번호
	private int endItem;
	

	// 다음, 이전 버튼 여부 확인
	private boolean prev, next;
	// 총 아이템 개수
	private int total;
	private PageData pageData;

	public PageCalc() {
	}

	public PageCalc(int total, int pageLimit, PageData pageData) {
		this.total = total;
		this.pageData = pageData;
		this.pageLimit = pageLimit;
		
		this.endPage = (int) (Math.ceil(pageData.getPageNum() * 1.0 / pageLimit)) * pageLimit;
		this.startPage = endPage - (pageLimit - 1);
		realEndPage = (int) (Math.ceil(total * 1.0 / pageData.getItemLimit()));

		if (endPage > realEndPage) {
			endPage = realEndPage == 0 ? 1 : realEndPage;
		}

		prev = startPage > 1;
		next = endPage < realEndPage;

		
		startItem = (pageData.getPageNum()-1) * pageData.getItemLimit() + 1;
		endItem = pageData.getPageNum() * pageData.getItemLimit();
		
	}

	public int getPageLimit() {
		return pageLimit;
	}

	public void setPageLimit(int pageLimit) {
		this.pageLimit = pageLimit;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public int getRealEndPage() {
		return realEndPage;
	}

	public void setRealEndPage(int realEndPage) {
		this.realEndPage = realEndPage;
	}

	public boolean isPrev() {
		return prev;
	}

	public void setPrev(boolean prev) {
		this.prev = prev;
	}

	public boolean isNext() {
		return next;
	}

	public void setNext(boolean next) {
		this.next = next;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public PageData getPageData() {
		return pageData;
	}

	public void setPageData(PageData pageData) {
		this.pageData = pageData;
	}
	
	public int getStartItem() {
		return startItem;
	}

	public void setStartItem(int startItem) {
		this.startItem = startItem;
	}

	public int getEndItem() {
		return endItem;
	}

	public void setEndItem(int endItem) {
		this.endItem = endItem;
	}

}
