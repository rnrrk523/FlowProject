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
import dao.TaskALLDao;
import dto.TaskMangerViewProjectDto;



@WebServlet("/TaskManagerChangeAjax")
public class TaskManagerChangeAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		  int taskIdx = Integer.parseInt(request.getParameter("taskIdx"));
		    String mnoValuesJson = request.getParameter("mnoValues");  

		    // mnoValuesJson이 null인지 확인
		    if (mnoValuesJson == null || mnoValuesJson.isEmpty()) {
		        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
		        response.getWriter().write("mnoValuesJson is missing or empty");
		        return;
		    }

		    TaskALLDao dao = new TaskALLDao();
		    BoardALLDao bdao = new BoardALLDao();
		    ProjectALLDao pdao = new ProjectALLDao();
		    // 이전에 추가된 TaskManager 모두 삭제
		    try {
		        dao.DeleteALLtaskManager(taskIdx);
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
		            dao.ADDtaskManager(taskIdx, mnoInt);
		        } catch (Exception e) {
		            e.printStackTrace();
		        }
		        TaskMangerViewProjectDto dto = null;
		        try {
		            dto = dao.TaskManagerViewProjectOne(taskIdx, mnoInt);
		        } catch (Exception e) {
		            e.printStackTrace();
		        }
		        try {
					managercount = dao.taskManagerCount(taskIdx);
				} catch (Exception e) {
					e.printStackTrace();
				}
		        if (dto != null) {
		            obj1.put("profileImg", dto.getProfileImg());
		            if (dto.getName() == null || dto.getName().length() == 0) {
		                obj1.put("name", "-");
		            } else {
		                obj1.put("name", dto.getName());
		            }
		            obj1.put("memberIdx", dto.getMemberIdx());
		            obj1.put("ManagerCount", managercount);
		            array1.add(obj1);
		            isDtoNull = false; // dto가 null이 아니므로 isDtoNull을 false로 변경
		        } else {
		        	obj1.put("name", "-");
		            obj1.put("ManagerCount", managercount);
		            array1.add(obj1);
		        }
		    }
		    int boardIdx = 0;
		    int projectIdx = 0;
			try {
				boardIdx = bdao.TaskBoardIdx(taskIdx);
				projectIdx = bdao.ProjectIdxSearch(boardIdx);
				pdao.ProjectUpdate(projectIdx);
			} catch (Exception e) {
				e.printStackTrace();
			}
		    // dto가 모두 null인 경우 "완료" 메시지를 반환
		    if (isDtoNull) {
		    	out.println(array1);
		    } else {
		        out.println(array1);
		    }
		}
}
