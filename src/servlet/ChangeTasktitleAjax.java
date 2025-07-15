package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.TaskALLDao;

@WebServlet("/ChangeTasktitleAjax")
public class ChangeTasktitleAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String title = request.getParameter("title");
		int taskIdx = Integer.parseInt(request.getParameter("taskIdx"));
		TaskALLDao dao = new TaskALLDao();
		int boardIdx = 0;
		try {
			boardIdx = dao.ShowBoardIdx(taskIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		try {
			dao.UpdateTitle(boardIdx, title);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
