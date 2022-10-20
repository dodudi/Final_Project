package com.hotel.asia.service;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.hotel.asia.dto.CouponMemberVO;
import com.hotel.asia.dto.CouponVO;

@SpringBootTest
public class CouponServiceTDD {
	private static final Logger log = LoggerFactory.getLogger(CouponServiceTDD.class);

	@Autowired
	private CouponService service;

	@Test
	public void getCouponMember() {
		List<CouponMemberVO> data = service.getCouponMember("user01");

		for (CouponMemberVO couponMemberVO : data) {
			log.info("" + couponMemberVO.getCOUPON_NUMBER());
			log.info("" + couponMemberVO.getCOUPON_TYPE_NUMBER());
			log.info("" + couponMemberVO.getMEM_ID());
			log.info("" + couponMemberVO.getCOUPON_GET_DATE());
			log.info("" + couponMemberVO.getCOUPON_END_DATE());
		}
	}

	// 사용자가 소지한 쿠폰 개수 가져오기 테스트
	@Test
	public void getCouponMemberCount() {
		int data = service.getCouponMemberCount("user01");
		log.info("user01의 쿠폰 개수 : " + data);
	}

	// 사용자가 소지한 쿠폰 가져오기 테스트
	@Test
	public void getCoupon() {
		List<CouponMemberVO> data = service.getCouponMember("user01");
		CouponVO vo = service.getCoupon(data.get(0).getCOUPON_TYPE_NUMBER());
		log.info("" + vo.getCOUPON_TYPE_NUMBER());
		log.info("" + vo.getCOUPON_NAME());
		log.info("" + vo.getCOUPON_PRICE());
		log.info("" + vo.getCOUPON_COMMENT());
	}

	// 쿠폰 사용 내역으로 저장 테스트
	@Test
	public void saveUseCoupon() {
		List<CouponMemberVO> data = service.getCouponMember("user01");
		service.saveUseCoupon(data.get(0).getCOUPON_NUMBER());
	}

	// 사용한 쿠폰 삭제하기 테스트
	@Test
	public void useCouponMember() {
		List<CouponMemberVO> data = service.getCouponMember("user01");
		int result = service.useCouponMember(data.get(0).getCOUPON_NUMBER());
		log.info("삭제된 컬럼 수 : " + result);
	}

	// 쿠폰을 사용하면 삭제함과 동시에 사용내역으로 저장 테스트
	@Test
	public void useAndSaveCoupon() {
		List<CouponMemberVO> data = service.getCouponMember("user01");
		boolean result = service.useAndSaveCoupon(data.get(0).getCOUPON_NUMBER());
		log.info("성공? : " + result);
	}

	// 만료기한이 지한 쿠폰 삭제 테스트
	@Test
	public void autoDelCouponMember() {
		service.autoDelCouponMember();
	}

	// 쿠폰 만료 내역에 저장 테스트
	@Test
	public void saveDelCoupon() {
		service.saveDelCoupon();
	}

	// 쿠폰 만료 내역에 저장하면서 삭제 테스트
	@Test
	public void delAndSaveCoupon() {
		service.delAndSaveCoupon();
	}

	// 쿠폰 사용 내역 가져오기 테스트
	@Test
	public void getUseCoupon() {
		List<CouponMemberVO> data = service.getUseCoupon("user01");
		for (CouponMemberVO couponMemberVO : data) {
			log.info("" + couponMemberVO.getCOUPON_NUMBER());
			log.info("" + couponMemberVO.getCOUPON_TYPE_NUMBER());
			log.info("" + couponMemberVO.getMEM_ID());
			log.info("" + couponMemberVO.getCOUPON_GET_DATE());
			log.info("" + couponMemberVO.getCOUPON_END_DATE());
		}
	}

	// 쿠폰 사용 내역 개수 가져오기 테스트
	@Test
	public void getUseCouponCount() {
		int result = service.getUseCouponCount("user01");
		log.info(result + "");
	}

	// 쿠폰 만료 내역 가져오기 테스트
	@Test
	public void getDelCoupon() {
		List<CouponMemberVO> data = service.getDelCoupon("user01");
		for (CouponMemberVO couponMemberVO : data) {
			log.info("" + couponMemberVO.getCOUPON_NUMBER());
			log.info("" + couponMemberVO.getCOUPON_TYPE_NUMBER());
			log.info("" + couponMemberVO.getMEM_ID());
			log.info("" + couponMemberVO.getCOUPON_GET_DATE());
			log.info("" + couponMemberVO.getCOUPON_END_DATE());
		}
	}

	// 쿠폰 만료 내역 개수 가져오기 테스트
	@Test
	public void getDelCouponCount() {
		int result = service.getDelCouponCount("user01");
		log.info(result + "");
	}

	@Test
	public void getCouponAboutMember() {
		List<CouponMemberVO> data = service.getCouponMember("user01");
		log.info(data.size() + "");
		List<CouponVO> data2 = service.getCouponAboutId(data);
		for (CouponVO couponVO : data2) {
			log.info("" + couponVO.getCOUPON_TYPE_NUMBER());
			log.info("" + couponVO.getCOUPON_NAME());
			log.info("" + couponVO.getCOUPON_PRICE());
			log.info("" + couponVO.getCOUPON_COMMENT());
		}
	}
}
