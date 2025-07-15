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

@WebServlet("/addScheduleAttenderAjaxServlet")
public class addScheduleAttenderAjaxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int memberIdx = Integer.parseInt(request.getParameter("memberIdx"));
		int scheduleIdx = Integer.parseInt(request.getParameter("scheduleIdx"));
		String attendWhether = request.getParameter("attendWhether");
		
		ScheduleDao sDao = new ScheduleDao();
		
		if(attendWhether == null) { attendWhether = ""; }
		
//		참석자 추가
		try {
			sDao.addScheduleMember(scheduleIdx, memberIdx, attendWhether);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		ScheduleAttenderDto attender = null;
		try {
			attender = sDao.getScheduleAttender(scheduleIdx, memberIdx);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		
		JSONObject obj = new JSONObject();
		obj.put("memberIdx", attender.getMemberIdx());
		obj.put("name", attender.getName());
		obj.put("prof", attender.getProfileImg());
		obj.put("whether", attender.getAttendWhether());
		out.println(obj);
	}
}