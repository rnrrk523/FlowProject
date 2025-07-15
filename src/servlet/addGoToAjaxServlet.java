package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.AdminChangeHistoryDao;
import dao.GoToDao;

@WebServlet("/addGoToAjaxServlet")
public class addGoToAjaxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int companyIdx = Integer.parseInt(request.getParameter("companyIdx"));
		String name = request.getParameter("name");
		String url = request.getParameter("url");
		String state = request.getParameter("state").equals("on") ? "Y" : "N";
		int changerIdx = Integer.parseInt(request.getParameter("changerIdx"));
		
//		관리자변경이력 INSERT
		AdminChangeHistoryDao adao = new AdminChangeHistoryDao();
		try {
			adao.addAdminChangeRecord(changerIdx, "바로가기 관리", "바로가기 추가", name, "");
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		
		GoToDao gDao = new GoToDao();
//		바로가기 생성
		try {
			gDao.addGoTo(companyIdx, name, url, state);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
