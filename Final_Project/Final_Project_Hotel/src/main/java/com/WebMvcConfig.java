package com;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer{
	private static final String[] CLASSPATH_RESOURCE_LOCATIONS
	= {
				"classpath:/static/",
				"classpath:/resources/",
				"classpath:/META-INF/resources"
	};
	
	@Override
	public void addViewControllers(ViewControllerRegistry registry) {
		//url mapping "/"로 접속하면 "/member/login"으로 이동합니다. 
		registry.addViewController("/").setViewName("forward:/main/main");
	}
	
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/resources/**")
		.addResourceLocations(CLASSPATH_RESOURCE_LOCATIONS);
		
		//=====리뷰보드 이미지 처리=====
		//web root가 아닌 외부 경로에 있는 리소스를 url로 불러올 수 있도록 설정
		registry.addResourceHandler("/reviewImage/**")
        .addResourceLocations("file:///C:/hotelAsiaReviewImage/");
	}
}
