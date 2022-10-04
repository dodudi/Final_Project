package com.hotel.asia.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hotel.asia.dto.PaymentDTO;
/*
 * 결제관련 Controller입니다.
 * */
@Controller
@RequestMapping(value="/payment")
public class PaymentController {
	private static final Logger logger = LoggerFactory.getLogger(PaymentController.class);
	
	@GetMapping("/payment")
	public String payment(PaymentDTO payment, Model model) {
		model.addAttribute("paymentDTO",payment);
		return "payment/payment";
	}
	
	@GetMapping("/payment_test")
	public String paymentTest() {
		return "payment/payment_test";
	}
	
	
	// ========== [현능] 22.10.04 추가 ==========
	/*
	@Autowired
	private PaymentService paymentService;
	
	@ResponseBody
	@PostMapping("/payment")
	public Map<String, Integer> payment(Payment pm) {
		logger.info("***** [payment] 넘어온 정보 *****");
		logger.info("*결제번호 : " + pm.getPAYMENT_ID());
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		// 결제
		//pm.setCOUPON_HISTORY_ID( ); // 넘어오는 쿠폰 정보 받기
		//pm.setPOINT_DISCOUNT(100); // 넘어오는 할인가격 받기
		int paymentResult = paymentService.payment(pm);
		logger.info("[결제 성공 여부] paymentResult=" + paymentResult);
		int REZ_ID = pm.getREZ_ID();
		logger.info("[객실예약 id] REZ_ID=" + REZ_ID);
		
		map.put("paymentResult", paymentResult);
		map.put("REZ_ID", REZ_ID);
		return map;
	}
	*/
	
}
