package com.hotel.asia.mybatis.mapper;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.hotel.asia.dto.Member;
import com.hotel.asia.dto.OptionReservation;
import com.hotel.asia.dto.Payment;
import com.hotel.asia.dto.Rez;

@SpringBootTest
public class MyPageMapperTDD {

	private static final Logger log = LoggerFactory.getLogger(MyPageMapperTDD.class);

	@Autowired
	private MyPageMapper myPageMapper;

	@Test
	public void getRezData() {
		// 사용자 아이디에 대한 객실예약 정보 가져오기
		Rez rez = myPageMapper.getRezData("user01");
		log.info("=============================");
		log.info("객실예약번호 : " + rez.getREZ_ID());
		log.info("방번호 : " + rez.getROOM_ID());
		log.info("사용자 아이디 : " + rez.getMEM_ID());
		log.info("체크인 날짜 : " + rez.getREZ_CHECKIN());
		log.info("체크아웃 날짜 : " + rez.getREZ_CHECKOUT());
		log.info("성인 : " + rez.getREZ_ADULT() + "");
		log.info("아동 : " + rez.getREZ_CHILD() + "");
		log.info("=============================");
	}

	@Test
	public void getOptRezData() {

		// 객실예약정보의 id를 이용한 옵션선택정보 가져오기
		List<OptionReservation> opt_rez = myPageMapper.getOptRezData("user01");

		for (OptionReservation optionReservation : opt_rez) {
			log.info("=============================");
			log.info("옵션예약번호 : " + optionReservation.getOPTION_RESERVATION_ID());
			log.info("객실예약번호 : " + optionReservation.getREZ_ID());
			log.info("옵션아이디(조식-1, 디너-2, 수영-3) : " + optionReservation.getOPTION_ID());
			log.info("실행날짜 : " + optionReservation.getOPTION_RESERVATION_DATE());
			log.info("성인 : " + optionReservation.getADULT());
			log.info("아동 : " + optionReservation.getCHILD());
			log.info("=============================");
		}
	}

	@Test
	public void getPayment() {
		// 객실예약에 대한 결재 정보 가져오기
		Payment payment = myPageMapper.getPayment("user01");
		log.info("=============================");
		log.info("결제번호 : " + payment.getPAYMENT_ID());
		log.info("객실예약번호 : " + payment.getREZ_ID());
		log.info("결제금액 : " + payment.getPAYMENT_PRICE());
		log.info("결제날짜 : " + payment.getPAYMENT_DATE());
		log.info("=============================");

	}
	
	@Test
	public void getMemberData() {
		Member member = myPageMapper.getMemberData("user01");
		log.info(member + "");
		log.info("" + member.getMEM_ID());
		log.info("" + member.getMEM_PASS());
		log.info("" + member.getMEM_NAME());
		log.info("" + member.getMEM_PHONE());
		log.info("" + member.getMEM_EMAIL());
		log.info("" + member.getMEM_POINT());
	}
}

