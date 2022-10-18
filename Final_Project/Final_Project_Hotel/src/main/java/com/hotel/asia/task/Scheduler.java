package com.hotel.asia.task;

import java.util.Date;

import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;

@SpringBootApplication
@EnableScheduling
public class Scheduler {
	 @Scheduled(cron = "*/10 * * * * *")
	    public void run() {
	        // TODO
	        System.out.println("현재 시간은 " + new Date());
	    }
}
