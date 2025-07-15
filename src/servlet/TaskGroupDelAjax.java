package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import dao.BoardALLDao;
import dao.ProjectALLDao;
import dao.TaskALLDao;

@WebServlet("/TaskGroupDelAjax")
public class TaskGroupDelAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int taskIdx = Integer.parseInt(request.getParameter("taskIdx"));
		TaskALLDao dao = new TaskALLDao();
		try {
			dao.UpdateTaskDelete(taskIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		ProjectALLDao pdao = new ProjectALLDao();
		BoardALLDao bdao = new BoardALLDao();
		try {
			int boardIdx = bdao.TaskBoardIdx(taskIdx);
			int projectIdx = bdao.ProjectIdxSearch(boardIdx);
			pdao.ProjectUpdate(projectIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		JSONObject obj1 = new JSONObject();
		obj1.put("check","check");
		out.println(obj1);
	}

}
