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
import dto.BoardPostViewDto;
import dto.BoardScheduleDto;
import dto.MyboardViewTaskDto;
import dto.TaskManagerDto;


@WebServlet("/ScheduleCategoryAjax")
public class ScheduleCategoryAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int boardIdx = Integer.parseInt(request.getParameter("boardIdx"));
		BoardALLDao dao = new BoardALLDao();
		BoardPostViewDto dto = null;
		BoardScheduleDto sdto = null; 
		ArrayList<BoardScheduleDto> list = null;
		try {
			dto = dao.PostViewBoard(boardIdx);
			sdto = dao.viewSchedule(boardIdx);
			list = dao.viewMemberSchdule(sdto.getScheduleIdx(), 0, 0);
		} catch (Exception e) {
			e.printStackTrace();
		}
		response.setCharacterEncoding("utf-8");
 	    response.setContentType("application/json");
 	    PrintWriter out = response.getWriter();
 	   JSONArray array1 = new JSONArray();
	    for(BoardScheduleDto sddto : list) {
	    	JSONObject obj1 = new JSONObject();
	    	obj1.put("memberIdx",sddto.getMemberIdx());
	    	obj1.put("ProfileImg",sddto.getProfileImg());
	    	obj1.put("Name",sddto.getName());
	    	array1.add(obj1);
	    }
 	    JSONObject obj1 = new JSONObject();
 	    obj1.put("array1",array1);
 	    obj1.put("releaseYN",dto.getReleaseYN()+"");
 	    obj1.put("title",dto.getTitle());
 	    obj1.put("content",dto.getContent());
 	    obj1.put("ScheduleIdx",sdto.getScheduleIdx());
 	    obj1.put("location",sdto.getLocation());
 	    obj1.put("StartDate",sdto.getStartDate());
 	    obj1.put("EndDate",sdto.getEndDate());
 	    obj1.put("AllDayYN",sdto.getAllDayYN()+"");
 	    obj1.put("AlarmType",sdto.getAlarmType());
 	    out.println(obj1);
	}

}
