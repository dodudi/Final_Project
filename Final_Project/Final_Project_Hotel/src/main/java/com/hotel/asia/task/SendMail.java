package com.hotel.asia.task;

import java.io.File;

import javax.mail.internet.MimeMessage;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.stereotype.Component;

import com.hotel.asia.dto.MailVO;
import com.hotel.asia.dto.MySaveFolder;


@Component
public class SendMail {
	private static final Logger logger = LoggerFactory.getLogger(SendMail.class);
	
	@Autowired
	private JavaMailSenderImpl mailSender;
	
	@Autowired
	private MySaveFolder mysavefolder;

	public void sendMail(MailVO vo) {
		String sendfile = mysavefolder.getSendfile();
		
		MimeMessagePreparator mp = new MimeMessagePreparator() {	
			@Override
			public void prepare(MimeMessage mimeMessage) throws Exception{
				
				MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, "UTF-8");
				helper.setFrom(vo.getFrom());
				helper.setTo(vo.getTo());
				helper.setSubject(vo.getSubject());
				
				
				//로고 이미지 내장해서 보냄 
				String content = "<img src='cid:Home'>" + vo.getContent();
				helper.setText(content, true);
				
				FileSystemResource file = new FileSystemResource(new File(sendfile));
				helper.addInline("Home", file);
				
			}//prepare() end 
		};//MimeMessagePreparator end 
		
		mailSender.send(mp);	//메일 전송 
		logger.info("메일 전송했습니다.");
		
	}//sendMail end;
	
	
}//class SendMail end;
