package com.hotel.asia.mybatis.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.hotel.asia.dto.OptionReservation;
import com.hotel.asia.dto.Payment;
import com.hotel.asia.dto.Rez;

//마이페이지에서 필요한 데이터들
@Mapper
public interface MyPageMapper {
	//객실정보 가져오기
	public Rez getRezData(String mem_id);
	//옵션선택정보 가져오기
	public List<OptionReservation> getOptRezData(String mem_id);
	//결제정보 가져오기
	public Payment getPayment(String mem_id);
}
