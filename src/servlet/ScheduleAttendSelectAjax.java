package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import dao.BoardALLDao;
import dao.ProjectALLDao;
import dao.ScheduleDao;
import dto.ScheduleCountDto;

@WebServlet("/ScheduleAttendSelectAjax")
public class ScheduleAttendSelectAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int memberIdx = Integer.parseInt(request.getParameter("memberIdx"));
		String str = request.getParameter("str");
		int scheduleIdx = Integer.parseInt(request.getParameter("scheduleIdx"));
		ScheduleDao sdao = new ScheduleDao();
		try {
			sdao.setScheduleParticipant(scheduleIdx, memberIdx, str);
		} catch (Exception e) {
			e.printStackTrace();
		}
		BoardALLDao bdao = new BoardALLDao();
		ScheduleCountDto dto = null;
		try {
			dto = bdao.scheduleCount(scheduleIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		ProjectALLDao pdao = new ProjectALLDao();
		try {
			int boardIdx = bdao.ScheduleBoardIdx(scheduleIdx);
			int projectIdx = bdao.ProjectIdxSearch(boardIdx);
			pdao.ProjectUpdate(projectIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		response.setCharacterEncoding("utf-8");
 	    response.setContentType("application/json");
 	    PrintWriter out = response.getWriter();
 	    JSONObject obj1 = new JSONObject();
 	   obj1.put("Count1",dto.getCount1());
	   obj1.put("Count2",dto.getCount2());
	   obj1.put("Count3",dto.getCount3());
	   out.println(obj1);
	}

}
