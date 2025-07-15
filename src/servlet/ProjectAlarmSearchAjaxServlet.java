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

import dao.ProjectAlarmDao;
import dto.ProjectAlarmListDto;

@WebServlet("/ProjectAlarmSearchAjaxServlet")
public class ProjectAlarmSearchAjaxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int projectIdx = Integer.parseInt(request.getParameter("projectIdx"));
		String str = request.getParameter("str");
		String ctt = request.getParameter("ctt");
		String writ = request.getParameter("writ");
		
		String standard = "";
		if(ctt.equals("Y") && writ.equals("Y")) {
			standard = "전체";
		}else if(ctt.equals("Y")) {
			standard = "내용만";
		}else if(writ.equals("Y")) {
			standard = "작성자만";
		}
		
		ProjectAlarmDao paDao = new ProjectAlarmDao();
		ArrayList<ProjectAlarmListDto> alarmList = new ArrayList<ProjectAlarmListDto>();
		try {
			alarmList = paDao.getProjectAlarmList(projectIdx, str, standard);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		
		JSONArray jsonList = new JSONArray();
		for(ProjectAlarmListDto dto : alarmList) {
			JSONObject obj = new JSONObject();
			obj.put("alarmDate", dto.getAlarmDate());
			obj.put("content", dto.getContent());
			obj.put("memberIdx", dto.getMemberIdx());
			obj.put("name", dto.getMemberName());
			obj.put("prof", dto.getProf());
			obj.put("title", dto.getTitle());
			obj.put("type", dto.getType());
			jsonList.add(obj);
		}
		out.println(jsonList);
	}
}
