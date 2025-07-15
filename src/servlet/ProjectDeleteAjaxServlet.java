package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.AdminChangeHistoryDao;
import dao.ProjectDao;
import dto.PermissionSettingDto;

@WebServlet("/ProjectDeleteAjaxServlet")
public class ProjectDeleteAjaxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int memberIdx = Integer.parseInt(request.getParameter("memberIdx"));
		int projectIdx = Integer.parseInt(request.getParameter("projectIdx"));
		
		ProjectDao pDao = new ProjectDao();
		try {
			pDao.setProjectDel(projectIdx, memberIdx);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
