package com.hotel.asia.controller;

import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value = "/main")
public class MainController {
   
   private static final Logger logger = LoggerFactory.getLogger(MainController.class);
   
   @GetMapping(value = "/main") 
   public String home(Locale locale, ModelAndView mv) {
      logger.info("main/main");
      return "main/main";
   }
   
}