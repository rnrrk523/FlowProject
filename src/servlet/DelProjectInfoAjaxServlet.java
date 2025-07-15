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

import dao.ProjectDao;
import dto.DelProjectInfoDto;

@WebServlet("/DelProjectInfoAjaxServlet")
public class DelProjectInfoAjaxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int projectIdx = Integer.parseInt(request.getParameter("projectIdx"));
		
		ProjectDao pDao = new ProjectDao();
		ArrayList<DelProjectInfoDto> pmList = new ArrayList<DelProjectInfoDto>();
		try {
			pmList = pDao.getDelProjectInfo(projectIdx);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		
		JSONArray jsonList = new JSONArray();
		for(DelProjectInfoDto dto : pmList) {
			JSONObject obj = new JSONObject();
			obj.put("name",dto.getName());
			obj.put("email",dto.getEmail());
			obj.put("phone",dto.getPhone());
			obj.put("departmentName",dto.getDepartmentName());
			obj.put("adminYN",dto.getAdminYN()+"");
			jsonList.add(obj);
		}
		out.println(jsonList);
	}
}
