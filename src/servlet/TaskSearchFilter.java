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

import dao.TaskALLDao;
import dto.TaskMangerViewProjectDto;
import dto.TaskSearchDto;


@WebServlet("/TaskSearchFilter")
public class TaskSearchFilter extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String stateData = request.getParameter("state");
        String priorityData = request.getParameter("priority");
        String search = request.getParameter("search");
        int taskfilter = Integer.parseInt(request.getParameter("taskfilter"));
        int startdate = Integer.parseInt(request.getParameter("startdate"));
        int enddate = Integer.parseInt(request.getParameter("enddate"));
        int projectIdx = Integer.parseInt(request.getParameter("projectIdx"));
        int memberIdx = Integer.parseInt(request.getParameter("memberIdx"));
        TaskALLDao dao = new TaskALLDao();
        JSONParser parser = new JSONParser();
        JSONArray stateArray = null;
        JSONArray priorityArray = null;

        try {
            stateArray = (JSONArray) parser.parse(stateData);
            priorityArray = (JSONArray) parser.parse(priorityData);
        } catch (ParseException e) {
            e.printStackTrace();
            response.getWriter().write("{\"status\":\"error\", \"message\":\"JSON 파싱 오류\"}");
            return;
        }

        int[] states = new int[stateArray.size()]; 
        for (int i = 0; i < stateArray.size(); i++) {
            Long stateValue = (Long) stateArray.get(i);  
            states[i] = stateValue.intValue();  
        }
        int[] priorities = new int[priorityArray.size()];
        for (int i = 0; i < priorityArray.size(); i++) {
            Long priorityValue = (Long) priorityArray.get(i);  
            priorities[i] = priorityValue.intValue(); 
        }
        int state1 = 0;
        int state2 = 0;
        int state3 = 0;
        int state4 = 0;
        int state5 = 0;
        int priority1 = 0;
        int priority2 = 0;
        int priority3 = 0;
        int priority4 = 0;
        int priority5 = 0;
        if(states.length == 1) {
        	state1 = states[0];
        	state2 = states[0];
        	state3 = states[0];
        	state4 = states[0];
        	state5 = states[0];
        }
        if(states.length == 2) {
        	state1 = states[0];
        	state2 = states[1];
        	state3 = states[1];
        	state4 = states[1];
        	state5 = states[1];
        }
        if(states.length == 3) {
        	state1 = states[0];
        	state2 = states[1];
        	state3 = states[2];
        	state4 = states[2];
        	state5 = states[2];
        }
        if(states.length == 4) {
        	state1 = states[0];
        	state2 = states[1];
        	state3 = states[2];
        	state4 = states[3];
        	state5 = states[3];
        }
        if(states.length == 5) {
        	state1 = states[0];
        	state2 = states[1];
        	state3 = states[2];
        	state4 = states[3];
        	state5 = states[4];
        }
        if(priorities.length == 1) {
        	priority1 = priorities[0];
            priority2 = priorities[0];
            priority3 = priorities[0];
            priority4 = priorities[0];
            priority5 = priorities[0];
        }
        if(priorities.length == 2) {
        	priority1 = priorities[0];
            priority2 = priorities[1];
            priority3 = priorities[1];
            priority4 = priorities[1];
            priority5 = priorities[1];
        }
        if(priorities.length == 3) {
        	priority1 = priorities[0];
            priority2 = priorities[1];
            priority3 = priorities[2];
            priority4 = priorities[2];
            priority5 = priorities[2];
        }
        if(priorities.length == 4) {
        	priority1 = priorities[0];
            priority2 = priorities[1];
            priority3 = priorities[2];
            priority4 = priorities[3];
            priority5 = priorities[3];
        }
        if(priorities.length == 5) {
        	priority1 = priorities[0];
            priority2 = priorities[1];
            priority3 = priorities[2];
            priority4 = priorities[3];
            priority5 = priorities[4];
        }
        ArrayList<TaskSearchDto> list = null;
        try {
			list = dao.TaskBasicSearchInt(search, memberIdx, memberIdx, state1, state2, state3, state4, state5, priority1, priority2, priority3, priority4, priority5, projectIdx, taskfilter, startdate, enddate);
		} catch (Exception e) {
			e.printStackTrace();
		}
        response.setCharacterEncoding("utf-8");
	    response.setContentType("application/json");
	    PrintWriter out = response.getWriter();
	    JSONArray array1 = new JSONArray();
	    for (TaskSearchDto dto : list) {
	        JSONObject obj1 = new JSONObject();
	        obj1.put("title",dto.getTitle());
	        obj1.put("state",dto.getState());
	        obj1.put("priority",dto.getPriority());
	        obj1.put("startDate",dto.getStartDate());
	        obj1.put("endDate",dto.getEndDate());
	        obj1.put("writeDate",dto.getWriteDate());
	        obj1.put("taskIdx",dto.getTaskIdx());
	        obj1.put("name",dto.getName());
	        obj1.put("lastModifiedDate",dto.getLastModifiedDate());
	        obj1.put("progress",dto.getProgress());
	        obj1.put("taskGroupIdx",dto.getTaskGroupIdx());
	        try {
				obj1.put("taskManager",dao.TaskManagerOneView(dto.getTaskIdx()));
			} catch (Exception e) {
				e.printStackTrace();
			}
	        try {
				obj1.put("taskManagerCount", dao.taskManagerCount(dto.getTaskIdx()));
			} catch (Exception e1) {
				e1.printStackTrace();
			}
	        if(dto.getTaskGroupIdx()==0) {
	        	try {
					obj1.put("taskGroupCount", dao.taskGroupCount(search, memberIdx, memberIdx, state1, state2, state3, state4, state5, priority1, priority2, priority3, priority4, priority5, projectIdx, taskfilter,  startdate, enddate, 0, 1));
				} catch (Exception e) {
					e.printStackTrace();
				}
	        } else {
	        	try {
					obj1.put("taskGroupCount", dao.taskGroupCount(search, memberIdx, memberIdx, state1, state2, state3, state4, state5, priority1, priority2, priority3, priority4, priority5, projectIdx, taskfilter,  startdate, enddate, dto.getTaskGroupIdx(), 0));
				} catch (Exception e) {
					e.printStackTrace();
				}
	        }
	        array1.add(obj1);
	    }
	    out.println(array1);
	}

}
