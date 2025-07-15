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
import dto.MyboardViewTaskDto;
import dto.TaskManagerDto;

/**
 * Servlet implementation class TaskCategoryAjax
 */
@WebServlet("/TaskCategoryAjax")
public class TaskCategoryAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int boardIdx = Integer.parseInt(request.getParameter("boardIdx"));
		BoardALLDao dao = new BoardALLDao();
		BoardPostViewDto dto = null;
		MyboardViewTaskDto tdto = null;
		ArrayList<TaskManagerDto> list = null;
		try {
			dto = dao.PostViewBoard(boardIdx);
			tdto = dao.ViewTask(boardIdx);
			list = dao.ViewTaskManager(tdto.getTaskIdx());
		} catch (Exception e) {
			e.printStackTrace();
		}
		response.setCharacterEncoding("utf-8");
 	    response.setContentType("application/json");
 	    PrintWriter out = response.getWriter();
 	    JSONArray array1 = new JSONArray();
 	    for(TaskManagerDto tmdto : list) {
 	    	JSONObject obj1 = new JSONObject();
 	    	obj1.put("memberIdx",tmdto.getMemberIdx());
 	    	obj1.put("ProfileImg",tmdto.getProfileImg());
 	    	obj1.put("Name",tmdto.getName());
 	    	array1.add(obj1);
 	    }
 	    JSONObject obj1 = new JSONObject();
 	    obj1.put("array1",array1);
 	    obj1.put("releaseYN",dto.getReleaseYN()+"");
 	    obj1.put("title",dto.getTitle());
 	    obj1.put("content",dto.getContent());
 	    obj1.put("TaskIdx",tdto.getTaskIdx());
 	    obj1.put("State",tdto.getState());
 	    obj1.put("StartDate",tdto.getStartDate());
 	    obj1.put("EndDate",tdto.getEndDate());
 	    obj1.put("Priority",tdto.getPriority());
 	    obj1.put("TaskGroupIdx",tdto.getTaskGroupIdx());
 	    obj1.put("TaskGroupName",tdto.getTaskGroupName());
 	    obj1.put("Progress",tdto.getProgress());
 	    out.println(obj1);
	}
}
