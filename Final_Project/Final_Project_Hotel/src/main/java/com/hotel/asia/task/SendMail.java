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
		
		//MimeMessagePreparator는 인터페이스! new 쓸수없어(생성): 추상메서드라서 -> 근데 얘는 왜 쓸수있을까?
		//익명함수 (한번만 사용할때 나옴) : 부모가 중요하다! 
		//익명함수(클래스)는 구현해야할 메서드가 있어야한다 -> override로 prepare 사용 
		MimeMessagePreparator mp = new MimeMessagePreparator() {	
			@Override
			public void prepare(MimeMessage mimeMessage) throws Exception{
				/*
				 	MimeMessage : 이 클래스는 MIME 스타일 이메일 메시지를 나타냅니다. 
				 	MIME (영어:Multipurpose Internet Mail Extensions)는 
				 	전자 우편을 위한 인터넷 표준 포맷입니다.
				 	
				 	MimeMessageHelper를 이용하면 첨부 파일이나 특수 문자 인코딩으로 작업할 때 전달된 
				 	MimeMessage를 채우는데 편리합니다. 
				 */
				//두번째 인자 true는 멀티 파트 메시지를 사용하겠다는 의미입니다.
				//특수문자 인코딩 
				MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, "UTF-8");
				helper.setFrom(vo.getFrom());
				helper.setTo(vo.getTo());
				helper.setSubject(vo.getSubject());
				
				//1.문자로만 전송하는 경우 
				//두번째 인자는 html을 사용하겠다는 뜻 
				//helper.setText(vo.getContent(), true);
				
				//2. 이미지를 내장해서 보내는 경우 
				//cid(content id)
				String content = "<img src='cid:Home'>" + vo.getContent();
				helper.setText(content, true);
				
				FileSystemResource file = new FileSystemResource(new File(sendfile));
				//addInline메서드의 첫번째 메서드에는 cid(content id)를 지정합니다. 
				helper.addInline("Home", file);
				
				//3. 파일을 첨부해서 보내는 경우 
				//첫번째 인자 : 첨부될 파일의 이름 
				//두번째 인자 : 첨부파일 
				helper.addAttachment("google.png", file);
				
			}//prepare() end 
		};//MimeMessagePreparator end 
		
		mailSender.send(mp);	//메일 전송 
		logger.info("메일 전송했습니다.");
		
	}//sendMail end;
}//class SendMail end;
