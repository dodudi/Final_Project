package com.hotal.asia.config;

import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

public class WebConfig implements WebMvcConfigurer {
	@Override
	public void addViewControllers(ViewControllerRegistry registry) {
		registry.addViewController("/").setViewName("home");
	}
	
	@Bean
	public SpringSecurityDialect securityDialect(){
		return new SpringSecurityDialect();
	}
출처: https://zeroco.tistory.com/101 [zeroco:티스토리]
}
