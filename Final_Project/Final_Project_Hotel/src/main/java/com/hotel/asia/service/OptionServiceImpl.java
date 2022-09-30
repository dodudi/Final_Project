package com.hotel.asia.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hotel.asia.dto.Option;
import com.hotel.asia.mybatis.mapper.OptionMapper;

@Service
public class OptionServiceImpl implements OptionService{
	
	@Autowired
	private OptionMapper mapper;
	
	// 옵션 리스트
	@Override
	public List<Option> getOptionList() {
		return mapper.getOptionList();
	}
	
}
