package com.hotel.asia.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.hotel.asia.dto.PaymentDTO;
/*
 * 결제관련 Controller입니다.
 * */
@Controller
public class PaymentController {
	
	@GetMapping("/payment")
	public String payment(PaymentDTO payment, Model model) {
		model.addAttribute("paymentDTO",payment);
		return "payment/payment";
	}
	
	@GetMapping("/payment_test")
	public String paymentTest() {
		return "payment/payment_test";
	}
}
