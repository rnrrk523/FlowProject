package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.AdminChangeHistoryDao;
import dao.CompanyDao;

@WebServlet("/SetcUrlAjaxServlet")
public class SetcUrlAjaxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int companyIdx = Integer.parseInt(request.getParameter("companyIdx"));
		String url = request.getParameter("url");
		int memberIdx = Integer.parseInt(request.getParameter("memberIdx"));
		String prevCUrl = request.getParameter("prevCUrl");
		CompanyDao cDao = new CompanyDao();
		
		String prev = "https://";
		String next = ".flow.team";
		String completionUrl = prev+url+next;
		try {
			cDao.updateCompanyUrl(companyIdx, completionUrl);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		AdminChangeHistoryDao adao = new AdminChangeHistoryDao();
		String prevUrl = prevCUrl.replace("https://", "").replace(".flow.team", "");
		String changeContent = "'"+prevUrl+"'->'"+url+"'";
		try {
			adao.addAdminChangeRecord(memberIdx, "회사정보", "전용URL", "", changeContent);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
