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

import dao.ProjectCalendarDao;
import dao.ScheduleDao;
import dto.ScheduleCalendarDto;
import dto.TaskCalendarDto;

@WebServlet("/calrendarFilterServlet")
public class calrendarFilterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		int projectIdx = Integer.parseInt(request.getParameter("projectIdx"));
		int memberIdx = Integer.parseInt(request.getParameter("memberIdx"));
		int companyIdx = Integer.parseInt(request.getParameter("companyIdx"));
		
		String scheduleStandard = request.getParameter("schedule-filter");
		String taskStandard = request.getParameter("task-filter");
		String str = request.getParameter("schedule_name");
		
		ScheduleDao sDao = new ScheduleDao();
		ArrayList<ScheduleCalendarDto> scheduleList = new ArrayList<ScheduleCalendarDto>();
		try {
			scheduleList = sDao.getProjectCalendar(projectIdx, memberIdx, scheduleStandard, str);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		ProjectCalendarDao pDao = new ProjectCalendarDao();
		ArrayList<TaskCalendarDto> taskList = new ArrayList<TaskCalendarDto>();
		try {
			taskList = pDao.getTaskCalendarList(projectIdx, memberIdx, taskStandard, str);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		request.setAttribute("scheduleList", scheduleList);
		request.setAttribute("taskList", taskList);
		request.setAttribute("scheduleStandard", scheduleStandard);
		request.setAttribute("taskStandard", taskStandard);
		request.setAttribute("str", str);
		request.getRequestDispatcher("flow_calendar.jsp").forward(request, response);
	}
}