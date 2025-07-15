package mail;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

public class Mail {

	public static void main(String[] args) {
		String host = "smtp.naver.com";					// ★ (수정) SMTP 서버명 작성
		String port = "587";				// ★ (수정) POP3/SMTP 465  IMAP/SMTP 587
		final String id = "lms44567@naver.com";			// ★ (수정) 송신자이메일주소
		final String pw = "dlalstjr12!";				// ★ (수정) 2차인증X ( 비밀번호 ) 2차인증 O ( 앱비밀번호 )
		String to = "lms44567@naver.com";				// ★ (수정) 수신자이메일주소
		String title = "제목이다 민재야";
		String content = "<div style=\"width: 100%;min-width: 300px;max-width: 600px;\">		"
				+ "<table cellpadding=\"0\" cellspacing=\"0\" style=\"margin:0;padding:0;border-collapse:collapse;border-spacing:0;width:100%;\">			"
				+ "<tbody><tr><td align=\"left\" valign=\"top\" style=\"margin:0;padding:0;vertical-align:top;text-align:left;\">						"
				+ "<h1 style=\"margin:0;padding:0;\"><img alt=\"플로우\" src=\"https://flow.team/flow-renewal/assets/images/email/email-logo.png\" loading=\"lazy\"></h1>						"
				+ "<h2 style=\"margin:15px 0 0 0;padding:0;font-weight:bold;font-size:26px;text-align:left;\">프로젝트 초대</h2>					"
				+ "</td></tr><tr><td align=\"left\" valign=\"top\" style=\"margin:0;padding:50px 0 0 0;vertical-align:top;\" bgcolor=\"#ffffff\">						"
				+ "<p style=\"font-size:15px;word-break: keep-all;\">이민석 님이 프로젝트에 초대합니다.</p>						"
				+ "<strong style=\"font-size:15px;\">\"협업툴 프로젝트\"</strong><br><br>						"
				+ "<p style=\"display:block;border:2px dotted #dfdfdf;border-radius:8px;margin:0;padding:10px;font-size:14px;color:#111111;font-weight:normal;line-height:26px;text-align:left;\">업무관리, 채팅, 파일공유를 한 곳에서! <br>아이폰, 안드로이드는 물론 PC에서도 사용해보세요.<br></p><br>						"
				+ "<p style=\"font-size:15px;word-break: keep-all;\">아래 버튼을 눌러 프로젝트에 참여할 수 있습니다.</p>					"
				+ "</td></tr><tr><td align=\"left\" style=\"margin:0;padding:30px 0 0 0;text-align:left;background:#ffffff;\">						"
				+ "<p style=\"width: 100% !important;min-width:300px !important; max-width:600px !important;background:rgb(95,90,185) !important;text-align:center;border-radius:8px;\">							"
				+ "<a href=\"https://flow.team/Invitation/37Is_09wFu\" target=\"_blank\" style=\"display:block;:100%;margin:0;padding:20px 0;color:#ffffff;font-weight:bold;font-size:17px;border-radius:8px;text-decoration:none;white-space:nowrap;background:#5f5ab9;text-align:center;\" rel=\"noreferrer noopener\">프로젝트 참여하기</a>						"
				+ "</p>					"
				+ "</td></tr><tr><td align=\"left\" valign=\"top\" style=\"margin:0;padding:50px 0 0 0;white-space:nowrap;vertical-align:top;text-align:left;line-height:18px;font-size:12px;color:#bebebe;\">						"
				+ "<p style=\"margin:0;padding:6px 0 0 0;font-size:12px;color:#bebebe;\">							"
				+ "본 메일은 발신 전용입니다.						"
				+ "</p>					"
				+ "</td></tr></tbody>		"
				+ "</table>	"
				+ "</div>";
		
		// [2-1] 이메일 환경 설정 ( 공통 )
		Properties props = new Properties();
		props.put("mail.smtp.host", host);						// SMTP 호스트
		props.put("mail.smtp.port", port);						// SMTP 포트
		props.put("mail.smtp.auth", "true");					// 인증 허용
		props.put("mail.smtp.ssl.protocols", "TLSv1.2");		// SSL/TLS 버전 호환 설정
		props.put("mail.smtp.ssl.enable", "false");				// 자동적으로 보안 채널을 생성하여 메일을 전송 [ SSL/TLS ]
		props.put("mail.smtp.ssl.trust", host);					// 인증 서 관련 오류 발생
		props.put("mail.debug", "true");						// 디버그 활성화 여부
		props.put("mail.smtp.socketFactory.fallback", "false"); // 도메인 이름을 SSL 속성 변경함

		
			if("587".equals(port)) {
			// starttls 역할 : javamail 에에 Tls 모드를 시작하라고 명시적으로 요청 → starttls 확인전까지 평문으로 보냄 → starttls true 이면 보안 관련채널 생성
			props.put("mail.smtp.starttls.enable", "true");			// 보안 관련 채널 생성해서 인증서 확인 등의 작업 [ Starttls ]
			props.put("mail.smtp.socketFactory.port", "587");
			
			System.out.println("[system.out] 1-2");
		}
		
		try {
			
			// [3] 로그인 실시
			Session session = Session.getDefaultInstance(props, new Authenticator() {
				@Override
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(id, pw);
				}
			});
			
			System.out.println("[system.out] 2");
			
			// [4] 메시지 내용 보내기 설정
			MimeMessage message = new MimeMessage(session);
			message.setFrom(new InternetAddress(id));
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
			
			System.out.println("[system.out] 3");
			
			message.setSubject(title);	// ★ (수정) 메일제목
			message.setText(content);		// ★ (수정) 메일내용
			
			// [5] 메세지 발송 프로세스
			message.setSentDate(new java.util.Date());
			System.out.println("[system.out] 4");

			MimeMultipart multipart = new MimeMultipart();
	        MimeBodyPart msgPart = new MimeBodyPart();

	        // 메일 본문 html
	        msgPart.setContent(content, "text/html;charset=UTF-8");
	        multipart.addBodyPart(msgPart);
			message.setContent(multipart);
			Transport.send(message);
			System.out.println("[system.out] 메일 발송 성공");
			
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
}
