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
import dto.ComProjectAdminListDto;
import dto.ProjectMemberDto;

@WebServlet("/comProjectAdminAddAjaxServlet")
public class comProjectAdminAddAjaxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int projectIdx = Integer.parseInt(request.getParameter("projectIdx"));
		
		ProjectDao pDao = new ProjectDao();
		ArrayList<ComProjectAdminListDto> pmList = new ArrayList<ComProjectAdminListDto>();
		try {
			pmList = pDao.getComProjectMemberList(projectIdx);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		
		JSONArray jsonList = new JSONArray();
		for(ComProjectAdminListDto dto : pmList) {
			JSONObject obj = new JSONObject();
			obj.put("idx", dto.getMemberIdx());
			obj.put("name", dto.getName());
			obj.put("email", dto.getEmail());
			jsonList.add(obj);
		}
		out.println(jsonList);
	}
}
