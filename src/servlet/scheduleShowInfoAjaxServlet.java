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

import dao.MemberDao;
import dao.ScheduleDao;
import dto.MemberCompanyDepartmentDto;
import dto.ScheduleAttenderDto;
import dto.ScheduleBoardInfoDto;

@WebServlet("/scheduleShowInfoAjaxServlet")
public class scheduleShowInfoAjaxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int boardIdx = Integer.parseInt(request.getParameter("boardIdx"));
		int memberIdx = Integer.parseInt(request.getParameter("memberIdx"));
		String attend = "";
		
		ScheduleDao sDao = new ScheduleDao();
		ScheduleBoardInfoDto boardInfo = null;
		try {
			boardInfo = sDao.getScheduleBoardInfo(boardIdx);
			
			ScheduleDao sdao = new ScheduleDao();
			try {
				attend = sdao.getMemberAttend(memberIdx, boardInfo.getScheduleIdx());
				if(attend == null) attend = "";
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		MemberDao mDao = new MemberDao();
		MemberCompanyDepartmentDto memberInfo = null;
		try {
			memberInfo = mDao.getMemberInfo(boardInfo.getWriterIdx());
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		
		ArrayList<ScheduleAttenderDto> scheduleAttenderList = new ArrayList<ScheduleAttenderDto>();
		try {
			scheduleAttenderList = sDao.getScheduleAttenderList(boardInfo.getScheduleIdx());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json");
		
		JSONObject jsonResponse = new JSONObject();
		JSONArray jsonList = new JSONArray();
		
		for(ScheduleAttenderDto dto : scheduleAttenderList) {
			JSONObject obj = new JSONObject();
			obj.put("memberIdx", dto.getMemberIdx());
			obj.put("name", dto.getName());
			obj.put("profImg", dto.getProfileImg());
			obj.put("attendWhether", dto.getAttendWhether());
			jsonList.add(obj);
		}
		jsonResponse.put("attenders", jsonList);
		
		JSONObject obj2 = new JSONObject();
		obj2.put("scheduleIdx", boardInfo.getScheduleIdx());
		obj2.put("projectIdx", boardInfo.getProjectIdx());
		obj2.put("projectName", boardInfo.getProjectName());
		obj2.put("writerName", memberInfo.getName());
		obj2.put("writeDate", boardInfo.getWriteDate());
		obj2.put("releaseYN", boardInfo.getReleaseYN()+"");
		obj2.put("title", boardInfo.getTitle());
		obj2.put("startDate", boardInfo.getStartDate());
		obj2.put("endDate", boardInfo.getEndDate());
		obj2.put("allDayYN", boardInfo.getAllDayYN()+"");
		obj2.put("location", boardInfo.getLocation());
		obj2.put("content", boardInfo.getContent());
		obj2.put("attend", attend);
		jsonResponse.put("boardInfo", obj2);
		
		PrintWriter out = response.getWriter();
		out.println(jsonResponse);
		out.flush();
		out.close();
	}
}