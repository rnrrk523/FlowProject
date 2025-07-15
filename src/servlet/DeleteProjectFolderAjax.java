package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ProjectALLDao;

@WebServlet("/DeleteProjectFolderAjax")
public class DeleteProjectFolderAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int folderIdx = Integer.parseInt(request.getParameter("folderIdx"));
		ProjectALLDao dao = new ProjectALLDao();
		try {
			dao.ProjectFolderDelete(folderIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
