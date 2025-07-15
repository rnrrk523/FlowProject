package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import dao.ProjectALLDao;
import dto.ProjectMemberViewDto;


@WebServlet("/ProjectAdminUpdateAjax")
public class ProjectAdminUpdateAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int projectIdx = Integer.parseInt(request.getParameter("projectIdx"));
		int memberIdx = Integer.parseInt(request.getParameter("memberIdx"));
		char admin = request.getParameter("admin").charAt(0);
		ProjectALLDao dao = new ProjectALLDao();
		try {
			dao.UPDATEProjectAdmin(admin, projectIdx, memberIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		try {
			dao.ProjectUpdate(projectIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		ProjectMemberViewDto dto = null;
		try {
			dto = dao.participantselectMY(projectIdx,memberIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		response.setCharacterEncoding("utf-8");
 	    response.setContentType("application/json");
 	    PrintWriter out = response.getWriter();
 	    JSONObject obj1 = new JSONObject();
 	    obj1.put("profileImg",dto.getProfileImg());
 	    obj1.put("memberIdx",dto.getMemberIdx());
 	    obj1.put("name",dto.getName());
 	    obj1.put("position",dto.getPosition());
 	    obj1.put("compnayName", dto.getCompanyName());
 	    obj1.put("departmentName",dto.getDepartmentName());
 	    obj1.put("CompanyIdx",dto.getCompanyIdx());
    	out.println(obj1);
	}
}
