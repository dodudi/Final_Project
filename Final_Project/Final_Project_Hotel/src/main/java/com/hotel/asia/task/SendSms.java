package com.hotel.asia.task;

import java.util.HashMap;

import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

//import net.nurigo.java_sdk.api.Message;
//import net.nurigo.java_sdk.exceptions.CoolsmsException;

@Component
public class SendSms {
	private static final Logger logger = LoggerFactory.getLogger(SendSms.class);
	
	public void sendSms(String phone,String cerNum) {
		String api_key = "NCS7Y9VOMUGY6NU6";
		String api_secret = "C6GWKJPSS4FPGKELZPLOQS0FIYSOCDXC";
		Message coolsms = new Message(api_key, api_secret);
		
		HashMap<String, String> sms = new HashMap<String, String>();
		sms.put("to", phone);
		//sms.put("from", "01011111111");	//발신번호 
		sms.put("type", "SMS");
		sms.put("text", "인증번호는 " + "[" + cerNum + "]" + "입니다." );
		sms.put("app_version", "test app 1.2");
		
	try {
	        JSONObject obj = (JSONObject) coolsms.send(sms);
	        logger.info(obj.toString());
	      } catch (CoolsmsException e) {
	    	  logger.info(e.getMessage());
	    	 // logger.info(e.getCode());
	      }

	}//sendSms end;
	
}//class SendSms end;
