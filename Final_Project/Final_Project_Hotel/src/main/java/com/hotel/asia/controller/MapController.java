package com.hotel.asia.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;


/*
 * 카카오 맵 API가 적용된 페이지로 이동합니다.
 */

@Controller
public class MapController {
	
	@GetMapping("/map")
	public String map() {
		return "map/map";
	}
}
