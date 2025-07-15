package aboutLoginServlet;

import java.io.IOException;
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
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.LoginOrJoinDao;

@WebServlet("/emailPin")
public class emailPin extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String email = request.getParameter("email");
		int randomNumber = (int)(Math.random() * (999999 - 100000 + 1)) + 100000;
		LoginOrJoinDao dao = new LoginOrJoinDao();
		dao.cartificationEmail(email, randomNumber);
		try {
			dao.deleteUpdate();
		}catch(Exception e) {}
		session.setAttribute("email"  ,email );
		String host = "smtp.naver.com";					// ★ (수정) SMTP 서버명 작성
		String port = "587";				// ★ (수정) POP3/SMTP 465  IMAP/SMTP 587
		final String id = "lms44567@naver.com";			// ★ (수정) 송신자이메일주소
		final String pw = "Dlalstjr123!";				// ★ (수정) 2차인증X ( 비밀번호 ) 2차인증 O ( 앱비밀번호 )
		String to = email;				// ★ (수정) 수신자이메일주소
		String title = "[플로우] 인증번호";
		String content = "<tbody><tr><td align=\"left\" valign=\"top\" style=\"margin:0;padding:45px 30px 15px 15px; width : 300px; vertical-align:top;text-align:left\">            <table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"margin:0;padding:0;border-collapse:collapse;border-spacing:0;width:100%;table-layout:fixed\"><tbody>  <tr> <td align=\"left\" valign=\"top\" style=\"margin:0;padding:15px 0 25px 0;vertical-align:top;border-top:1px solid #dee0e2;border-bottom:1px solid #dee0e2\"><span class=\"im\">                        <p style=\"margin:0;padding:0;font-size:14px;color:#111111;font-weight:normal;line-height:22px;text-align:left\">                            본 메일은 '플로우'에서 본인 확인을 위해<br>                            자동으로 발송되는 메일입니다.<br></p>                        <p style=\"margin:0;padding:0;font-size:14px;color:#111111;font-weight:normal;line-height:36px;text-align:left\">                            <b style=\"letter-spacing:-0.5px\">인증번호 입력창에 아래 인증번호를 입력하세요.</b></p>                        </span><table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" height=\"50px\" style=\"margin:15px 0 0 0;padding:0;border-collapse:collapse;border-spacing:0;width:100%;height:50px;table-layout:fixed\">                            <tbody>                            <tr>                                <td align=\"center\" valign=\"middle\" width=\"280px\" height=\"50px\" style=\"margin:0;padding:0;vertical-align:middle;width:280px;height:50px;font-size:20px;color:#111111;font-weight:bold;text-align:center;background-color:#eeeff0\">"+randomNumber+"</td></tr>                            </tbody>                        </table>                    </td>                </tr>                <tr>                    <td align=\"left\" valign=\"top\" style=\"margin:0;padding:15px 0 18px 0;vertical-align:top\">                        <p style=\"margin:0;padding:0;font-size:13px;color:#808284;font-weight:normal;line-height:22px;text-align:left\">                            만약 인증 요청을 하지 않으셨다면 기기에서 요청<br>시도가 있었는지 확인하시길 바랍니다.<br>(설정-기기관리 메뉴에서 확인)                        </p>                    </td>                </tr>                <tr>                    <td align=\"center\" valign=\"top\" style=\"margin:0;padding:92px 0 0 0;vertical-align:top\">                        <p style=\"margin:0;padding:0;font-size:13px;color:#999b9f;font-weight:normal;line-height:20px;text-align:center\">본 메일은 발신전용 메일로 회신되지 않습니다.</p></td></tr></tbody></table></td></tr></tbody>";
		
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
			Session sessions = Session.getDefaultInstance(props, new Authenticator() {
				@Override
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(id, pw);
				}
			});
			
			System.out.println("[system.out] 2");
			
			// [4] 메시지 내용 보내기 설정
			MimeMessage message = new MimeMessage(sessions);
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
		response.sendRedirect("Controller?command=account-emailPin");
	}

}
