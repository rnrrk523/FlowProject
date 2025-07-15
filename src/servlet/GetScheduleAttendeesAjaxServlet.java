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

import dao.ScheduleDao;
import dto.ProjectMemberListDto;

@WebServlet("/GetScheduleAttendeesAjaxServlet")
public class GetScheduleAttendeesAjaxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int scheduleIdx = Integer.parseInt(request.getParameter("scheduleIdx"));
		int projectIdx = Integer.parseInt(request.getParameter("projectIdx"));
		String str = request.getParameter("str");
		str = str == null ? "" : str;
		
		ScheduleDao sDao = new ScheduleDao();
		ArrayList<ProjectMemberListDto> projectMemberList = new ArrayList<ProjectMemberListDto>();
		try {
			projectMemberList = sDao.getScheduleMemberList(projectIdx, scheduleIdx, str);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		
		JSONArray jsonList = new JSONArray();
		for(ProjectMemberListDto dto : projectMemberList) {
			JSONObject obj = new JSONObject();
			obj.put("memberIdx", dto.getMemberIdx());
			obj.put("name", dto.getMemberName());
			obj.put("cName", dto.getCompanyName());
			obj.put("position", dto.getPosition());
			obj.put("dName", dto.getDepartmentName());
			obj.put("prof", dto.getProf());
			obj.put("attendYN", dto.getAttendYN()+"");
			jsonList.add(obj);
		}
		out.println(jsonList);
	}
}