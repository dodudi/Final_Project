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
	}
}
