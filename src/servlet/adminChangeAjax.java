package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.AdminChangeHistoryDao;
import dao.MemberDao;

@WebServlet("/adminChangeAjax")
public class adminChangeAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int memberIdx = Integer.parseInt(request.getParameter("memberIdx"));
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String yn = request.getParameter("yn");
		int changerIdx = Integer.parseInt(request.getParameter("changerIdx"));
		
		MemberDao mDao = new MemberDao();
		try {
			mDao.setMemberAdmin(memberIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		AdminChangeHistoryDao adao = new AdminChangeHistoryDao();
		String target = name+"("+email+")";
		String func = "";
		if(yn.equals("Y")) {
			func = "관리자 해제";
		}if(yn.equals("N")) {
			func = "관리자 지정";
		}
		try {
			adao.addAdminChangeRecord(changerIdx, "사용자 관리", func, target, "");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
