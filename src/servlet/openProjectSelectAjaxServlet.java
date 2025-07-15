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
import dto.OpenProjectInfoDto;
import dto.ProjectAdminDto;
import dto.ProjectAdminDto2;

@WebServlet("/openProjectSelectAjaxServlet")
public class openProjectSelectAjaxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int companyIdx = Integer.parseInt(request.getParameter("companyIdx"));
		int projectIdx = Integer.parseInt(request.getParameter("projectIdx"));
		
		ProjectDao pDao = new ProjectDao();
		OpenProjectInfoDto openProjectInfo = null;
		try {
			openProjectInfo = pDao.getOpenProjectInfo(projectIdx);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		ArrayList<ProjectAdminDto2> adminList = new ArrayList<ProjectAdminDto2>();
		try {
			adminList = pDao.getProjectAdminInfo(companyIdx, projectIdx);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		JSONArray adminArray = new JSONArray();
		for(ProjectAdminDto2 dto : adminList) {
			JSONObject obj2 = new JSONObject();
			obj2.put("memberIdx", dto.getParticipantIdx());
			obj2.put("name", dto.getName());
			obj2.put("email", dto.getEmail());
			obj2.put("departmentName", dto.getDepartmentName());
			obj2.put("phone", dto.getPhone());
			adminArray.add(obj2);
		}
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		
		JSONObject obj = new JSONObject();
		obj.put("adminList", adminArray);
		obj.put("categoryIdx", openProjectInfo.getCategoryIdx());
		obj.put("categoryName", openProjectInfo.getCategoryName());
		obj.put("pName", openProjectInfo.getpName());
		obj.put("writingGrant", openProjectInfo.getWritingGrant());
		obj.put("commentGrant", openProjectInfo.getCommentGrant());
		obj.put("postViewGrant", openProjectInfo.getPostViewGrant());
		obj.put("editPostGrant", openProjectInfo.getEditPostGrant());
		out.println(obj);
	}
}
