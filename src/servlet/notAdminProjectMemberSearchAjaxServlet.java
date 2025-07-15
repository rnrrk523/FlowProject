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

/**
 * Servlet implementation class notAdminProjectMemberSearchAjaxServlet
 */
@WebServlet("/notAdminProjectMemberSearchAjaxServlet")
public class notAdminProjectMemberSearchAjaxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int projectIdx = Integer.parseInt(request.getParameter("projectIdx"));
		String standard = request.getParameter("standard");
		String str = request.getParameter("str");
		
		ProjectDao pDao = new ProjectDao();
		
		ArrayList<ComProjectAdminListDto> memberList = new ArrayList<ComProjectAdminListDto>();
		try {
			memberList = pDao.getNotAdminProjectMember(projectIdx, standard, str);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		
		JSONArray jsonList = new JSONArray();
		for(ComProjectAdminListDto dto : memberList) {
			JSONObject obj = new JSONObject();
			obj.put("idx", dto.getMemberIdx());
			obj.put("name", dto.getName());
			obj.put("email", dto.getEmail());
			jsonList.add(obj);
		}
		out.println(jsonList);
	}
}
