package com.hotel.asia.mybatis.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.hotel.asia.dto.Option;

@Mapper
public interface OptionMapper {
	
	// 옵션 리스트
	public List<Option> getOptionList();

}
