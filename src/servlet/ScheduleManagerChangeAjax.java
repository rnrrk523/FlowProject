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
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import dao.BoardALLDao;
import dao.ProjectALLDao;
import dao.ScheduleDao;
import dao.TaskALLDao;
import dto.ScheduleAttenderDto;
import dto.ScheduleCountDto;
import dto.TaskMangerViewProjectDto;

@WebServlet("/ScheduleManagerChangeAjax")
public class ScheduleManagerChangeAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 int scheduleIdx = Integer.parseInt(request.getParameter("scheduleIdx"));
		    String mnoValuesJson = request.getParameter("mnoValues");  

		    // mnoValuesJson이 null인지 확인
		    if (mnoValuesJson == null || mnoValuesJson.isEmpty()) {
		        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
		        response.getWriter().write("mnoValuesJson is missing or empty");
		        return;
		    }
		    ScheduleDao dao = new ScheduleDao();
		    ProjectALLDao pdao = new ProjectALLDao();
		    BoardALLDao bdao = new BoardALLDao();
		    // 이전에 추가된 TaskManager 모두 삭제
		    try {
		        dao.delScheduleMember(scheduleIdx);
		    } catch (Exception e1) {
		        e1.printStackTrace();
		    }

		    // mnoValuesJson 파싱
		    JSONParser parser = new JSONParser();
		    JSONArray mnoValuesArray = null;
		    try {
		        mnoValuesArray = (JSONArray) parser.parse(mnoValuesJson);
		    } catch (ParseException e) {
		        e.printStackTrace();
		        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
		        response.getWriter().write("Invalid JSON format");
		        return;
		    }

		    // 응답 준비
		    response.setCharacterEncoding("utf-8");
		    response.setContentType("application/json");
		    PrintWriter out = response.getWriter();
		    JSONArray array1 = new JSONArray();
		    
		    boolean isDtoNull = true; // dto가 null인지를 추적하는 변수
		    int managercount = 0 ;
			
		    // mnoValuesArray 순회하면서 처리
		    for (Object obj : mnoValuesArray) {
		        JSONObject obj1 = new JSONObject();

		        Long mno = (Long) obj;
		        int mnoInt = mno.intValue(); 
		        try {
		            dao.addScheduleMember(scheduleIdx, mnoInt,null);
		        } catch (Exception e) {
		            e.printStackTrace();
		        }
		        String dto = null;
		        try {
		            dto = dao.getMemberAttend(mnoInt,scheduleIdx);
		        } catch (Exception e) {
		            e.printStackTrace();
		        }
		        ScheduleCountDto dto2 = null;
				try {
					dto2 = bdao.scheduleCount(scheduleIdx);
				} catch (Exception e) {
					e.printStackTrace();
				}
				 ScheduleAttenderDto dto3 = null;
				 try {
					dto3 = dao.getScheduleAttender(scheduleIdx,mnoInt);
				} catch (Exception e) {
					e.printStackTrace();
				}
		        if (dto != null) {
		            	
		            obj1.put("name", dto3.getName());
		            obj1.put("profile", dto3.getProfileImg());
		            obj1.put("attender", "dto");
		            obj1.put("Count1",dto2.getCount1());
		     	    obj1.put("Count2",dto2.getCount2());
		     	    obj1.put("Count3",dto2.getCount3());
		            array1.add(obj1);
		        } else {
		        	obj1.put("name", dto3.getName());
		            obj1.put("profile", dto3.getProfileImg());
		        	obj1.put("Count1",dto2.getCount1());
		     	    obj1.put("Count2",dto2.getCount2());
		     	    obj1.put("Count3",dto2.getCount3());
		            array1.add(obj1);
		        }
		    }
		    int boardIdx = 0;
		    int projectIdx = 0;
			try {
				boardIdx = bdao.ScheduleBoardIdx(scheduleIdx);
				projectIdx = bdao.ProjectIdxSearch(boardIdx);
				pdao.ProjectUpdate(projectIdx);
			} catch (Exception e) {
				e.printStackTrace();
			}
		    out.println(array1);
	}

}
