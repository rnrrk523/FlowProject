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
import dao.ScheduleDao;
import dto.ProjectMemberListDto;

/**
 * Servlet implementation class ScheduleSearchAjax
 */
@WebServlet("/ScheduleSearchAjax")
public class ScheduleSearchAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int scheduleIdx = Integer.parseInt(request.getParameter("scheduleIdx"));
		int projectIdx = Integer.parseInt(request.getParameter("projectIdx"));
		String search = request.getParameter("search");
		ScheduleDao sdao = new ScheduleDao();
		BoardALLDao bdao = new BoardALLDao();
		System.out.println(search);
		ArrayList<ProjectMemberListDto> list = null;
		try {
			list = sdao.getScheduleMemberList(projectIdx,scheduleIdx,search);
		} catch (Exception e) {
			e.printStackTrace();
		}
		int managercount = 0 ;
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		JSONArray array1 = new JSONArray();
		for(ProjectMemberListDto dto : list) {
			JSONObject obj1 = new JSONObject();
			obj1.put("prof",dto.getProf());
			obj1.put("memberIdx",dto.getMemberIdx());
			obj1.put("name",dto.getMemberName());
			obj1.put("position",dto.getPosition());
			obj1.put("cName",dto.getCompanyName());
			obj1.put("dName",dto.getDepartmentName());
			obj1.put("attendYN",dto.getAttendYN()+"");
			array1.add(obj1);
		}
		out.println(array1);
	}

}
