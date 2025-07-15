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


@WebServlet("/ProjectMemberExportAjax")
public class ProjectMemberExportAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int projectIdx = Integer.parseInt(request.getParameter("ProjectIdx"));
		int memberIdx = Integer.parseInt(request.getParameter("memberIdx"));
		ProjectALLDao dao = new ProjectALLDao();
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
 	    obj1.put("admin",dto.getAdminYN()+"");
 	    obj1.put("CompanyIdx",dto.getCompanyIdx());
    	out.println(obj1);
		try {
			dao.ExitProject(projectIdx,memberIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
