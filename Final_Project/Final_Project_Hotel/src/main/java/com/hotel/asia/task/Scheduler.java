package com.hotel.asia.task;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;

import com.hotel.asia.service.CouponService;

@SpringBootApplication
@EnableScheduling
public class Scheduler {
	
	@Autowired
	private CouponService couponService;
	 @Scheduled(cron = "*/10 * * * * *")
	    public void run() {
	        // TODO
	        //couponService.delAndSaveCoupon();
	    }
}
