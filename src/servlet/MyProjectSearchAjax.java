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

import dao.ProjectALLDao;
import dto.MyProjectViewDto;

/**
 * Servlet implementation class MyProjectSearchAjax
 */
@WebServlet("/MyProjectSearchAjax")
public class MyProjectSearchAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String search = request.getParameter("search");
		int memberIdx = Integer.parseInt(request.getParameter("memberIdx"));
		ProjectALLDao dao = new ProjectALLDao();
		ArrayList<MyProjectViewDto> list = null;
		try {
			list = dao.MyProjectSearch(memberIdx, search);
		} catch (Exception e) {
			e.printStackTrace();
		}
		response.setCharacterEncoding("utf-8");
 	    response.setContentType("application/json");
 	    PrintWriter out = response.getWriter();
 	    JSONArray array1 = new JSONArray();
 	    for(MyProjectViewDto dto : list) {
 	    	JSONObject obj1 = new JSONObject();
 	    	obj1.put("ProjectName",dto.getProjectName());
 	    	obj1.put("ProjectColor",dto.getProjectColor());
 	    	obj1.put("ProjectIdx",dto.getProjectIdx());
 	    	array1.add(obj1);
 	    }
 	    out.println(array1);
	}

}
