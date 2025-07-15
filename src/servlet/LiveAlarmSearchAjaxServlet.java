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

import dao.LiveAlarmDao;
import dto.LiveAlarmDto;

@WebServlet("/LiveAlarmSearchAjaxServlet")
public class LiveAlarmSearchAjaxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int memberIdx = Integer.parseInt(request.getParameter("memberIdx"));
		char checkYN = request.getParameter("checkYN").charAt(0);
		String str = request.getParameter("str");
		
		
		LiveAlarmDao laDao = new LiveAlarmDao();
		ArrayList<LiveAlarmDto> alarmList = new ArrayList<LiveAlarmDto>();
		try {
			alarmList = laDao.getLiveAlarmSearchList(memberIdx, checkYN, str);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		
		JSONArray jsonList = new JSONArray();
		for(LiveAlarmDto dto : alarmList) {
			JSONObject obj = new JSONObject();
			obj.put("liveAlarmIdx", dto.getLiveAlarmIdx());
			obj.put("writerProf", dto.getWriterProf());
			obj.put("title", dto.getTitle());
			obj.put("writerIdx", dto.getWriterIdx());
			obj.put("writerName", dto.getWriterName());
			obj.put("simpleContent", dto.getSimpleContent());
			obj.put("fullContent", dto.getFullContent());
			obj.put("alarmInfoDate", dto.getAlarmInfoDate());
			obj.put("alarmDate", dto.getAlarmDate());
			obj.put("checkYN", dto.getCheckYN()+"");
			obj.put("coordinate", dto.getCoordinate());
			
			obj.put("mentionMeYN", dto.getMentionMeYn()+"");
			obj.put("myBoardYN", dto.getMyBoardYn()+"");
			obj.put("workYN", dto.getWorkYn()+"");
			
			jsonList.add(obj);
		}
		out.println(jsonList);
	}
}