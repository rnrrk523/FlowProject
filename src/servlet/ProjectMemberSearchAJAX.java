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
import dto.MemberDto;
import dto.ProjectMemberViewDto;

/**
 * Servlet implementation class ProjectMemberSearchAJAX
 */
@WebServlet("/ProjectMemberSearchAJAX")
public class ProjectMemberSearchAJAX extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int projectIdx = Integer.parseInt(request.getParameter("projectIdx"));
		ProjectALLDao dao = new ProjectALLDao();
		ArrayList<ProjectMemberViewDto> list = null;
		try {
			list = dao.participantselect(projectIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		JSONArray array1 = new JSONArray();
		for(ProjectMemberViewDto dto : list) {
			JSONObject obj1 = new JSONObject();
			obj1.put("profileIMG", dto.getProfileImg());
			obj1.put("name", dto.getName());
			obj1.put("companyName", dto.getCompanyName());
			obj1.put("memberIdx", dto.getMemberIdx());
			obj1.put("position", dto.getPosition());
			obj1.put("departmentName", dto.getDepartmentName());
			obj1.put("adminYN", dto.getAdminYN()+"");
			array1.add(obj1);
		}
		out.println(array1);
	}

}
