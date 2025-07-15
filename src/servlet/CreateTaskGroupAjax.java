package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ProjectALLDao;
import dao.TaskALLDao;


@WebServlet("/CreateTaskGroupAjax")
public class CreateTaskGroupAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String title = request.getParameter("title");
		int projectIdx = Integer.parseInt(request.getParameter("projectIdx"));
		TaskALLDao dao = new TaskALLDao();
		try {
			dao.ADDProjectTaskGroup(title, projectIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		ProjectALLDao pdao = new ProjectALLDao();
		try {
			pdao.ProjectUpdate(projectIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
