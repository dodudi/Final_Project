package com.hotel.asia.mybatis.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.hotel.asia.dto.Notice;

@Mapper
public interface NoticeMapper {

	public int getListCount();

	public List<Notice> getNoticeList(HashMap<String, Object> map);

	public int setReadCountUpdate(int num);

	public Notice getDetail(int num);

	public int modify(Notice notice);

	public int delete(int notice_NUM);

	public int write(Notice notice);

}
