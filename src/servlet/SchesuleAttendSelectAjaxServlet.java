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
import dto.ScheduleAttenderDto;

@WebServlet("/SchesuleAttendSelectAjaxServlet")
public class SchesuleAttendSelectAjaxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int scheduleIdx = Integer.parseInt(request.getParameter("scheduleIdx"));
		int memberIdx = Integer.parseInt(request.getParameter("memberIdx"));
		String str = request.getParameter("str");
		
		ScheduleDao sDao = new ScheduleDao();
		try {
			sDao.setScheduleParticipant(scheduleIdx, memberIdx, str);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		ArrayList<ScheduleAttenderDto> ateendersList = new ArrayList<ScheduleAttenderDto>();
		try {
			ateendersList = sDao.getScheduleAttenderList(scheduleIdx);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		
		JSONArray jsonList = new JSONArray();
		for(ScheduleAttenderDto dto : ateendersList) {
			JSONObject obj = new JSONObject();
			obj.put("memberIdx", dto.getMemberIdx());
			obj.put("name", dto.getName());
			obj.put("scheduleIdx", dto.getScheduleIdx());
			obj.put("attendWhether", dto.getAttendWhether());
			obj.put("profileImg", dto.getProfileImg());
			jsonList.add(obj);
		}
		out.println(jsonList);
	}
}