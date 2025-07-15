package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.TaskALLDao;

/**
 * Servlet implementation class SubTaskDelAjax
 */
@WebServlet("/SubTaskDelAjax")
public class SubTaskDelAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int TaskIdx = Integer.parseInt(request.getParameter("taskIdx"));
		TaskALLDao dao = new TaskALLDao();
		try {
			dao.DelTaskSubTask(TaskIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
