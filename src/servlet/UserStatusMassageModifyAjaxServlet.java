package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.SettingDao;

@WebServlet("/UserStatusMassageModifyAjaxServlet")
public class UserStatusMassageModifyAjaxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int memberIdx = Integer.parseInt(request.getParameter("memberIdx"));
		String statusMassageStr = request.getParameter("statusMassageStr");
		
		SettingDao sDao = new SettingDao();
		try {
			sDao.modifyUserStatusMassage(memberIdx, statusMassageStr);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}