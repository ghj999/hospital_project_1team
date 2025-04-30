package service;

import java.util.Random;

import javax.mail.internet.MimeMessage;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;

import vo.PatientVO;

public class MailSendService {
	private JavaMailSender javaMailSender;
	private int authNumber = 0;
	
	public MailSendService( JavaMailSender javaMailSender ) {
		this.javaMailSender = javaMailSender;
	}
	
	//인증번호 생성 메서드
	public void makeRandomNumber() {
		authNumber = new Random().nextInt(999999 - 111111 + 1) + 111111;
		System.out.println("인증번호 : " + authNumber);
	}
	
	//인증번호 발송 메일 보내기
	public String sendNumberEmail( String email ) {
		makeRandomNumber();
		
		String setFrom = "rhruf329@naver.com"; //보내는 사람의 메일주소
		String toMail = email; //받을사람의 메일주소
		
		String title = "[MediCompile] 인증번호 발송 메일 입니다.";
		
		String content = "인증번호는 <b>" + authNumber + "</b>입니다";
		
		try {
			MimeMessage mail = javaMailSender.createMimeMessage();
			MimeMessageHelper mailHelper = new MimeMessageHelper(mail, true, "utf-8");
			
			mailHelper.setFrom(setFrom);
			mailHelper.setTo(toMail);
			mailHelper.setSubject(title);
			mailHelper.setText(content, true);
			
			javaMailSender.send(mail);
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return "" + authNumber;
	}
	
	//회원가입 발송 메일 보내기
	public void sendRegisterEmail( String email, PatientVO vo ) {
		String setFrom = "rhruf329@naver.com"; //보내는 사람의 메일주소
		String toMail = email; //받을사람의 메일주소
		
		String title = "[MediCompile] MediCompile 대학병원의 회원가입을 축하합니다.";
		
		String content = "<h3 style=\"font-size:30px\">MediCompile 대학병원의 회원가입을 축하합니다.</h3>\r\n"
				+ "<hr>\r\n"
				+ "<p style=\"font-size:20px;margine: 10px 0px;\"><a style=\"color:blue\">" + vo.getPat_name() + "</a> 님, MediCompile 홈페이지 회원이 되신 것을 환영합니다.</p>\r\n"
				+ "<p style=\"font-size:15px\">MediCompile에서는 만족스러운 서비스 제공을 위해 항상 노력하겠습니다. 감사합니다.</p>";
		
		try {
			MimeMessage mail = javaMailSender.createMimeMessage();
			MimeMessageHelper mailHelper = new MimeMessageHelper(mail, true, "utf-8");
			
			mailHelper.setFrom(setFrom);
			mailHelper.setTo(toMail);
			mailHelper.setSubject(title);
			mailHelper.setText(content, true);
			
			javaMailSender.send(mail);
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return;
	}
}
