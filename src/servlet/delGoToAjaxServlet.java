package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.AdminChangeHistoryDao;
import dao.GoToDao;

@WebServlet("/delGoToAjaxServlet")
public class delGoToAjaxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int goToIdx = Integer.parseInt(request.getParameter("goToIdx"));
		int changerIdx = Integer.parseInt(request.getParameter("changerIdx"));
		String goToName = request.getParameter("goToName");
		
//		관리자 변경이력 INSERT
		AdminChangeHistoryDao adao = new AdminChangeHistoryDao();
		try {
			adao.addAdminChangeRecord(changerIdx, "바로가기 관리", "바로가기 삭제", goToName, "");
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		GoToDao gDao = new GoToDao();
//		바로가기 삭제
		try {
			gDao.delGoTo(goToIdx);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
