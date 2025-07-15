package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ProjectALLDao;

/**
 * Servlet implementation class UpdateProjectFolderNameAjax
 */
@WebServlet("/UpdateProjectFolderNameAjax")
public class UpdateProjectFolderNameAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String title = request.getParameter("folderTitle");
		int folderIdx = Integer.parseInt(request.getParameter("folderIdx"));
		ProjectALLDao dao = new ProjectALLDao();
		try {
			dao.ProjectFolderUpdate(folderIdx, title);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
