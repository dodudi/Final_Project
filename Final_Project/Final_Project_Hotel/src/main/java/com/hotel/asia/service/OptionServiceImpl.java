package com.hotel.asia.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hotel.asia.mybatis.mapper.OptionMapper;

@Service
public class OptionServiceImpl {
	@Autowired
	private OptionMapper mapper;
}
