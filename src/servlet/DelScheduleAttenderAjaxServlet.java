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
import dto.ProjectAttenderYNDto;

@WebServlet("/DelScheduleAttenderAjaxServlet")
public class DelScheduleAttenderAjaxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int scheduleIdx = Integer.parseInt(request.getParameter("scheduleIdx"));
		ScheduleDao sDao = new ScheduleDao();
		
		ArrayList<ProjectAttenderYNDto> attenderList = new ArrayList<ProjectAttenderYNDto>();
		try {
			attenderList = sDao.getScheduleAttendYN(scheduleIdx);
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		try {
			sDao.delScheduleMember(scheduleIdx);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		
		JSONArray jsonList = new JSONArray();
		for(ProjectAttenderYNDto dto : attenderList) {
			JSONObject obj = new JSONObject();
			obj.put("memberIdx", dto.getMemberIdx());
			obj.put("attendWhether", dto.getAttendWhether());
			jsonList.add(obj);
		}
		out.println(jsonList);
	}
}