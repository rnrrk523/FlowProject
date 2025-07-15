package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ChatMonitoringHistoryDao;
import dao.CompanyDao;
import dto.CompanyDto;

@WebServlet("/companyAuditChatDateSetAjaxServlet")
public class companyAuditChatDateSetAjaxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int companyIdx = Integer.parseInt(request.getParameter("companyIdx"));
		int memberIdx = Integer.parseInt(request.getParameter("memberIdx"));
		
		ChatMonitoringHistoryDao cmhDao = new ChatMonitoringHistoryDao();
//		채팅감사 기능 켜키/끄기
		try {
			cmhDao.setCompanyAuditChatDate(companyIdx);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		CompanyDao cDao = new CompanyDao();
		CompanyDto companyInfo = null;
		try {
			companyInfo = cDao.getCompanyInfo(companyIdx);
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		
		String auditChatDate = companyInfo.getAuditChatDate();
//		감사 이력 테이블 INSERT
		try {
			if(auditChatDate != null) {
				cmhDao.addAuditRecord(companyIdx, memberIdx, "활성화/비활성화", "임직원 전체", "OFF -> ON");
			}else {
				cmhDao.addAuditRecord(companyIdx, memberIdx, "활성화/비활성화", "임직원 전체", "ON -> OFF");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}