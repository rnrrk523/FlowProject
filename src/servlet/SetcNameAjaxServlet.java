package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.AdminChangeHistoryDao;
import dao.CompanyDao;

@WebServlet("/SetcNameAjaxServlet")
public class SetcNameAjaxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int companyIdx = Integer.parseInt(request.getParameter("companyIdx"));
		String cName = request.getParameter("cName");
		int memberIdx = Integer.parseInt(request.getParameter("memberIdx"));
		String prevCName = request.getParameter("prevCName");
		
		CompanyDao cDao = new CompanyDao();
		try {
			cDao.updateCompanyName(companyIdx, cName);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		String changeContent = "'"+prevCName+"'->'"+cName+"'";
		AdminChangeHistoryDao adao = new AdminChangeHistoryDao();
		if(!(prevCName.equals(cName))) {
			try {
				adao.addAdminChangeRecord(memberIdx, "회사정보", "회사명 변경", "", changeContent);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
}