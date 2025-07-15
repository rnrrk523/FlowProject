package servlet;

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

import dao.CompanyDao;
import dao.MemberDao;

@WebServlet("/emailInviteServlet")
public class emailInviteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession WebSession = request.getSession();
		int companyIdx = (Integer)WebSession.getAttribute("companyIdx");
		MemberDao mDao = new MemberDao();
		CompanyDao cDao = new CompanyDao();
		String mName = null;
		try {
			mName = mDao.getMemberInfo((int)WebSession.getAttribute("memberIdx")).getName();
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		String cName = null;
		try {
			cName = cDao.getCompanyInfo((int)WebSession.getAttribute("companyIdx")).getCompanyName();
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		String host = "smtp.naver.com";					// ★ (수정) SMTP 서버명 작성
		String port = "587";				// ★ (수정) POP3/SMTP 465  IMAP/SMTP 587
		final String id = "lms44567@naver.com";			// ★ (수정) 송신자이메일주소
		final String pw = "Dlalstjr123!";				// ★ (수정) 2차인증X ( 비밀번호 ) 2차인증 O ( 앱비밀번호 )
		// String to = "rnrrk523@naver.com";				// ★ (수정) 수신자이메일주소
		String[] tos = request.getParameterValues("email");
		String title = "[플로우]'"+mName+"'님이 '"+cName+"' 회사에 초대하였습니다.";
		String content = "<div>		<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"margin:0;padding:0;border-collapse:collapse;border-spacing:0;max-width: 350px;min-width: 300px;table-layout:fixed;\">			<tbody><tr><td align=\"left\" valign=\"top\" style=\"margin:0;padding:0;vertical-align:top;text-align:left;\">					<h1 style=\"margin:0;padding:0;\"><img alt=\"플로우\" src=\"https://flow.team/flow-renewal/assets/images/email/email-logo.png\" loading=\"lazy\"></h1>					<h2 style=\"margin:15px 0 0 0;padding:0;font-weight:bold;font-size:26px;text-align:left;\">회사를 위한 업무공간<br>플로우를 함께하세요!</h2>				</td></tr><tr><td align=\"left\" valign=\"top\" style=\"margin:0;padding:40px 0 0 0;vertical-align:top;\" bgcolor=\"#ffffff\">					<p style=\"font-size:15px;word-break: keep-all;\">'"+mName+"'님이 '"+cName+"'회사에 초대합니다.</p><br>					<p style=\"font-size:15px;word-break: keep-all;\"><strong style=\"font-size:14px;\">궁금한 점이 있으신가요?</strong><br> 회사 관리자 '"+mName+"'에게 문의하세요.<br><br>아래 버튼을 눌러 함께할 수 있습니다.</p>				</td></tr><tr><td align=\"left\" style=\"margin:0;padding:20px 0 0 0;text-align:left;background:#ffffff;\">					<a href=\"http://43.201.111.209:8080//Project/Controller?command=AccountMemberShip&companyIdx="+companyIdx+"\" style=\"display:block;:100%;margin:0;padding:20px 0;color:#ffffff;font-weight:bold;font-size:17px;border-radius:8px;text-decoration:none;white-space:nowrap;background:#5f5ab9;text-align:center;\" target=\"_blank\" rel=\"noreferrer noopener\">참여하기</a>				</td></tr><tr><td align=\"left\" valign=\"top\" style=\"margin:0;padding:60px 0 0 0;white-space:nowrap;vertical-align:top;text-align:left;line-height:18px;font-size:12px;color:#bebebe;\">					<p style=\"margin:0;padding:6px 0 0 0;font-size:12px;color:#bebebe;\">본 메일은 발신 전용입니다.</p>				</td></tr></tbody>		</table>	</div>";
		
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
		
		// [3] 로그인 실시
		Session session = Session.getDefaultInstance(props, new Authenticator() {
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(id, pw);
			}
		});
		
		System.out.println("[system.out] 2");
		
		for(int i=0; i<=tos.length-1; i++) {
			String email = tos[i];
		    if (email == null || email.trim().isEmpty()) {
		        System.out.println("[경고] 비어있는 이메일 주소가 포함되어 있어 건너뜁니다.");
		        continue;
		    }
			try {
				
				// [4] 메시지 내용 보내기 설정
				MimeMessage message = new MimeMessage(session);
				message.setFrom(new InternetAddress(id));
				message.addRecipient(Message.RecipientType.TO, new InternetAddress(tos[i]));
				
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
				System.out.println("[system.out] 메일 발송 성공 "+i+"번째");
				
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		response.sendRedirect("Controller?command=admin_page3");
	}
}