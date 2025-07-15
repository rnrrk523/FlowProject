package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import dao.BoardALLDao;
import dao.TaskALLDao;
import dto.TaskMangerViewProjectDto;


@WebServlet("/TaskManagerViewAjax")
public class TaskManagerViewAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int taskIdx = Integer.parseInt(request.getParameter("taskIdx"));
		int projectIdx = Integer.parseInt(request.getParameter("projectIdx"));
		TaskALLDao dao = new TaskALLDao();
		BoardALLDao bdao = new BoardALLDao();
		int boardIdx = 0;
		try {
			boardIdx = dao.ShowBoardIdx(taskIdx);
			projectIdx = bdao.ProjectIdxSearch(boardIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		ArrayList<TaskMangerViewProjectDto> list = null;
		try {
			list = dao.TaskMangerViewProject(taskIdx, projectIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		int managercount = 0 ;
		try {
			managercount = dao.taskManagerCount(taskIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		JSONArray array1 = new JSONArray();
		for(TaskMangerViewProjectDto dto : list) {
			JSONObject obj1 = new JSONObject();
			obj1.put("profileImg",dto.getProfileImg());
			obj1.put("memberIdx",dto.getMemberIdx());
			obj1.put("name",dto.getName());
			obj1.put("position",dto.getPosition());
			obj1.put("companyName",dto.getCompanyName());
			obj1.put("departmentName",dto.getDepartmentName());
			obj1.put("ManagerYN",dto.getManagerYN()+"");
			obj1.put("ManagerCount",managercount);
			array1.add(obj1);
		}
		out.println(array1);
	}

}
