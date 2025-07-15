package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ProjectDao;

@WebServlet("/alterProjectAjaxServlet")
public class alterProjectAjaxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int projectIdx = Integer.parseInt(request.getParameter("projectIdx"));
		String pName = request.getParameter("pName");
		int writingGrant = Integer.parseInt(request.getParameter("writingGrant"));
		int commentGrant = Integer.parseInt(request.getParameter("commentGrant"));
		int postViewGrant = Integer.parseInt(request.getParameter("postViewGrant"));
		int editPostGrant = Integer.parseInt(request.getParameter("editPostGrant"));
		
		ProjectDao pDao =  new ProjectDao();
		try {
			pDao.setProjectInfo(projectIdx, pName, writingGrant, commentGrant, postViewGrant,editPostGrant);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
