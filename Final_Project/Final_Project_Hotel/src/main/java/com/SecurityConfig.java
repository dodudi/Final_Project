package com;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import com.hotel.security.CustomAccessDeniedHandler;
import com.hotel.security.CustomUserDetailsService;
import com.hotel.security.LoginFailHandler;
import com.hotel.security.LoginSuccessHandler;

@EnableWebSecurity //스프링과 시큐리티 결합
@Configuration
public class SecurityConfig extends WebSecurityConfigurerAdapter{

	//<security:http> 설정부분
	@Override
	protected void configure (HttpSecurity http) throws Exception{
		http.authorizeRequests()
				.antMatchers("/resources/**/**").permitAll()	//누구나 접근 허용 
				.antMatchers("/main/main").permitAll()
				.antMatchers("/member/login").permitAll()
				.antMatchers("/member/join").permitAll()
				.antMatchers("/member/idcheck").permitAll()
				.antMatchers("/member/joinProcess").permitAll()
				.antMatchers("/member/list").access("hasRole('ROLE_ADMIN')")	//'ROLE_ADMIN'만 접근 가능 
				.antMatchers("/member/info").access("hasRole('ROLE_ADMIN')");
				//.antMatchers("/**").access("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN')");
		
		http.formLogin().loginPage("/member/login")
						.loginProcessingUrl("/member/loginProcess")
						.usernameParameter("id")
						.passwordParameter("password")
						.successHandler(loginSuccessHandler())
						.failureHandler(loginFailHandler());
		
		http.logout().logoutSuccessUrl("/") //로그아웃 성공시 리다이렉트 주소 
					 .logoutUrl("/member/logout")
					 .invalidateHttpSession(true)
					 .deleteCookies("remember-me", "JSESSION_ID");
		
		http.rememberMe()
			.rememberMeParameter("remember-me")
			.rememberMeCookieName("remember-me")
			.tokenValiditySeconds(2419200);
		
		http.exceptionHandling().accessDeniedHandler(accessDeniedHandler());
	}
	
	@Override
	protected void configure (AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService(customUserService()).passwordEncoder(passwordEncoder());
	}
	
	//로그인 성공시 실행할 객체 생성 
	@Bean
	public AuthenticationSuccessHandler loginSuccessHandler() {
		return new LoginSuccessHandler();
	}
	
	@Bean
	public UserDetailsService customUserService() {
		return new CustomUserDetailsService();
	}
	
	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}
	
	@Bean
	public AccessDeniedHandler accessDeniedHandler() {
		return new CustomAccessDeniedHandler();
	}
	
	@Bean
	public AuthenticationFailureHandler loginFailHandler() {
		return new LoginFailHandler();
	}
}
