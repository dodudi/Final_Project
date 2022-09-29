package com.hotel.asia.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.hotel.asia.dto.PaymentDTO;
/*
 * 결제관련 Controller입니다.
 * */
@Controller
public class PaymentController {
	
	@GetMapping("/payment")
	public String payment(Model model) {
		model.addAttribute("paymentDTO",new PaymentDTO());
		return "payment/payment";
	}
}
