package com.hotel.asia.mybatis.mapper;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.hotel.asia.dto.CouponMemberVO;
import com.hotel.asia.dto.CouponVO;

@SpringBootTest
public class CouponMapperTDD {

	private static final Logger log = LoggerFactory.getLogger(CouponMapperTDD.class);

	@Autowired
	private CouponMapper mapper;

	@Test
	public void getCouponMember() {
		List<CouponMemberVO> data = mapper.getCouponMember("user01");
		
		for (CouponMemberVO couponMemberVO : data) {
			log.info("" + couponMemberVO.getCOUPON_NUMBER());
			log.info("" + couponMemberVO.getCOUPON_TYPE_NUMBER());
			log.info("" + couponMemberVO.getMEM_ID());
			log.info("" + couponMemberVO.getCOUPON_GET_DATE());
			log.info("" + couponMemberVO.getCOUPON_END_DATE());
		}
	}

	
	@Test
	public void getCouponMemberCount() {
		int data = mapper.getCouponMemberCount("user01");
		log.info("user01의 쿠폰 개수 : " + data);
	}
	
	@Test
	public void getCoupon() {
		List<CouponMemberVO> data = mapper.getCouponMember("user01");
		CouponVO vo=mapper.getCoupon(data.get(0).getCOUPON_TYPE_NUMBER());
		log.info(""+vo.getCOUPON_TYPE_NUMBER());
		log.info(""+vo.getCOUPON_NAME());
		log.info(""+vo.getCOUPON_PRICE());
		log.info(""+vo.getCOUPON_COMMENT());
	}
	
	@Test
	public void useCouponMember() {
		List<CouponMemberVO> data = mapper.getCouponMember("user01");
		int result = mapper.useCouponMember(data.get(0).getCOUPON_NUMBER());
		log.info("삭제된 컬럼 수 : " + result);
	}
	
	@Test
	public void saveUseCoupon() {
		List<CouponMemberVO> data = mapper.getCouponMember("user01");
		
		int result = mapper.saveUseCoupon(data.get(0).getCOUPON_NUMBER());
		int result2 = mapper.useCouponMember(data.get(0).getCOUPON_NUMBER());
		log.info(data.get(0).getCOUPON_NUMBER() + "");
	}
	
	@Test
	public void autoDelCouponMember() {
		mapper.autoDelCouponMember();
	}
	
	@Test
	public void saveDelCoupon() {
		mapper.saveDelCoupon();
	}
	
	
	@Test
	public void getUseCoupon(){
		List<CouponMemberVO> data = mapper.getUseCoupon("user01");
		
		for (CouponMemberVO couponMemberVO : data) {
			log.info("" + couponMemberVO.getCOUPON_NUMBER());
			log.info("" + couponMemberVO.getCOUPON_TYPE_NUMBER());
			log.info("" + couponMemberVO.getMEM_ID());
			log.info("" + couponMemberVO.getCOUPON_GET_DATE());
			log.info("" + couponMemberVO.getCOUPON_END_DATE());
		}
	}
	@Test
	public void getUseCouponCount() {
		int result = mapper.getUseCouponCount("user01");
		log.info(result + "");
	}
	
	@Test
	public void getDelCoupon(){
		List<CouponMemberVO> data =mapper.getDelCoupon("user01");
		for (CouponMemberVO couponMemberVO : data) {
			log.info("" + couponMemberVO.getCOUPON_NUMBER());
			log.info("" + couponMemberVO.getCOUPON_TYPE_NUMBER());
			log.info("" + couponMemberVO.getMEM_ID());
			log.info("" + couponMemberVO.getCOUPON_GET_DATE());
			log.info("" + couponMemberVO.getCOUPON_END_DATE());
		}
	}
	@Test
	public void getDelCouponCount() {
		int result = mapper.getDelCouponCount("user01");
		log.info(result + "");
	}
}
