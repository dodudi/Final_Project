package com.hotel.asia.service;

import java.util.Date;
import java.util.HashMap;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hotel.asia.controller.MyPageController;
import com.hotel.asia.dto.Option;
import com.hotel.asia.dto.OptionReservation;
import com.hotel.asia.dto.Payment;
import com.hotel.asia.dto.Rez;
import com.hotel.asia.module.PageCalc;
import com.hotel.asia.mybatis.mapper.MyPageMapper;

@Service
public class MyPageServiceImpl implements MyPageService {

	@Autowired
	private MyPageMapper myPageMapper;

	private static final Logger log = LoggerFactory.getLogger(MyPageController.class);

	// 객실정보 가져오기
	public Rez getRezData(String mem_id) {
		// 사용자 아이디에 대한 객실예약 정보 가져오기
		Rez rez = myPageMapper.getRezData(mem_id);
		return rez;
	}

	// 옵션선택정보 가져오기
	public List<OptionReservation> getOptRezData(String mem_id) {
		// 객실예약정보의 id를 이용한 옵션선택정보 가져오기
		List<OptionReservation> opt_rez = myPageMapper.getOptRezData(mem_id);
		return opt_rez;
	}

	// 결제정보 가져오기
	public Payment getPayment(String mem_id) {
		// 객실예약에 대한 결재 정보 가져오기
		Payment payment = myPageMapper.getPayment("user01");
		return payment;
	}

	// 멤버 아이디에 대한 옵션 가져오기
	public List<OptionReservation> getOptRezData(String mem_id, int opt_id) {
		List<OptionReservation> opt_rez = myPageMapper.getOptRezData(mem_id);
		List<OptionReservation> opt = new ArrayList<OptionReservation>();

		for (int i = 0; i < opt_rez.size(); i++) {
			if (opt_rez.get(i).getOPTION_ID() == opt_id) {
				opt.add(opt_rez.get(i));
			}
		}

		return opt;
	}

	// 날짜에 대한 옵션 가져오기
	public List<OptionReservation> getOptRezData(String mem_id, String date, int opt_id) {
		List<OptionReservation> opt_rez = myPageMapper.getOptRezData(mem_id);
		List<OptionReservation> opt = null;

		for (int i = 0; i < opt_rez.size(); i++) {
			if (opt_rez.get(i).getOPTION_ID() == opt_id && opt_rez.get(i).getOPTION_RESERVATION_DATE().equals(date)) {
				if (opt == null)
					opt = new ArrayList<OptionReservation>();

				opt.add(opt_rez.get(i));
			}
		}
		return opt;
	}

	// 체크아웃 날짜 - 체크인 날짜 -> 몇일 ex) 2022-10-10 ~ 2022-10-13 -> 3
	public long getDateSub(String start, String end) {
		long day = 0;
		try {
			DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			Date date1 = (Date) format.parse(end);
			Date date2 = (Date) format.parse(start);

			long sec = (date2.getTime() - date1.getTime()) / 1000;
			day = sec / (24 * 60 * 60);

		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return day;
	}

	// 옵션 날짜 구하기 -> ex) 2022-10-10 3일 -> 2022-10-10~2022-10-13까지의 날짜를 배열로 반환
	public List<String> calcBreakFastDate(String checkIn, long subDate) {
		ArrayList<String> dates = new ArrayList<String>();
		SimpleDateFormat tf = new SimpleDateFormat("yyyy-MM-dd");
		try {
			Date date = tf.parse(checkIn);
			Calendar cal = Calendar.getInstance();
			cal.setTime(date);
			for (int i = 0; i < subDate; i++) {
				dates.add(tf.format(cal.getTime()).toString());
				cal.add(Calendar.DATE, 1);
			}
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return dates;
	}

	// 옵션별 가격 측정 ex)(날짜별조식리스트, 옵션성인아동얼마인지 정보, 옵션아이디)
	public Map<String, Map<String, Integer>> getOptPrice(List<OptionReservation> opts, List<Option> optInfo,
			int opt_id) {
		Map<String, Map<String, Integer>> opt_price = new HashMap<String, Map<String, Integer>>();

		Option opt = optInfo.get(opt_id - 1);

		for (int i = 0; i < opts.size(); i++) {
			Map<String, Integer> age_price = new HashMap<String, Integer>();
			OptionReservation opRez = opts.get(i);
			int adult_price = opRez.getADULT() * opt.getOPTION_DEFAULT_PRICE();
			int child_price = opRez.getCHILD() * opt.getOPTION_CHILD_PRICE();
			log.info("<MyPageService> 디너 : " + opRez.getADULT() + " " + opt.getOPTION_DEFAULT_PRICE());
			log.info("<MyPageService> 아침 : " + opRez.getCHILD() + " " + opt.getOPTION_CHILD_PRICE());
			age_price.put("adultPrice", adult_price);
			age_price.put("childPrice", child_price);
			opt_price.put(opRez.getOPTION_RESERVATION_DATE(), age_price);
		}
		log.info("<MyPageService> : " + opt_price);
		return opt_price;
	}

	// 결제 초기화
	public void delRezData(int rez_id, String mem_id) {
		myPageMapper.delOptRez(rez_id);
		log.info("<MyPageServiceImpl> 객실예약 돕션 삭제 완료");
		myPageMapper.delPayment(rez_id);
		log.info("<MyPageServiceImpl> 객실예약 결제 데이터 삭제 완료");
		myPageMapper.delRez(mem_id);
		log.info("<MyPageServiceImpl> 객실예약 삭제 완료");
	}
	
	// 결제 추가
	public void addRez(Rez rez) {
		myPageMapper.addRez(rez);
	}

	public void addOptRez(List<OptionReservation> opt) {
		for (int i = 0; i < opt.size(); i++) {
			myPageMapper.addOptRez(opt.get(i));
		}

	}

	public void addPayment(Payment payment) {
		myPageMapper.addPayment(payment);
	}

	
	//질문게시판-------------------------------------------------------------------------
	public int getQuestionBoardCount(String mem_id) {
		return myPageMapper.getQuestionBoardCount(mem_id);
	}

	@Override
	public List<Integer> getQuestionBoard(HashMap<String, Object> data) {
		return myPageMapper.getQuestionBoard(data);
	}
	

}
