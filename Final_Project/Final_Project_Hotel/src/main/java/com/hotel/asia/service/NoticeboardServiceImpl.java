package com.hotel.asia.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hotel.asia.dto.Notice;
import com.hotel.asia.mybatis.mapper.NoticeMapper;

@Service
public class NoticeboardServiceImpl implements NoticeboardService{
	
	private NoticeMapper dao;
	
	@Autowired
	public NoticeboardServiceImpl(NoticeMapper dao) {
		this.dao = dao;
	}

	@Override
	public int getListCount() {
		return dao.getListCount();
	}

	@Override
	public List<Notice> getNoticeList(int page, int limit) {
		HashMap<String, Object> map = new HashMap<String, Object>();		
		int startrow = (page-1) * limit + 1; 
		int endrow = startrow + limit - 1; 		
		
		map.put("startrow", startrow);
		map.put("endrow", endrow);
		return dao.getNoticeList(map);
	}

	@Override
	public int setReadCountUpdate(int num) {
		return dao.setReadCountUpdate(num);
	}

	@Override
	public Notice getDetail(int num) {
		return dao.getDetail(num);
	}

	@Override
	public int modify(Notice notice) {
		return dao.modify(notice);
	}

	@Override
	public int delete(int notice_NUM) {
		return dao.delete(notice_NUM);
	}

	@Override
	public int write(Notice notice) {
		return dao.write(notice);
	}

}
