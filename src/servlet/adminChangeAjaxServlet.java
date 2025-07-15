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
import dto.ProjectAdminDto;
import dto.ProjectAdminDto2;

@WebServlet("/adminChangeAjaxServlet")
public class adminChangeAjaxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int companyIdx = Integer.parseInt(request.getParameter("companyIdx"));
		int projectIdx = Integer.parseInt(request.getParameter("projectIdx"));
		int memberIdx = Integer.parseInt(request.getParameter("memberIdx"));
		String state = request.getParameter("state");
		
		ProjectDao pDao = new ProjectDao();
		
		int adminCount = 0;
		try {
			adminCount = pDao.getProjectAdminCount(projectIdx);
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		if(adminCount <= 1) {
			if(state.equals("red") || state.equals("clear")) {
				response.setCharacterEncoding("utf-8");
				response.setContentType("application/json");
				PrintWriter out = response.getWriter();
				
				JSONObject obj = new JSONObject();
				obj.put("adminCnt", adminCount);
				out.println(obj);
			}else {
				try {
					pDao.setAdminYN(projectIdx, memberIdx);
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				ArrayList<ProjectAdminDto2> adminList = null;
				try {
					adminList = pDao.getProjectAdminInfo(companyIdx, projectIdx);
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				response.setCharacterEncoding("utf-8");
				response.setContentType("application/json");
				PrintWriter out = response.getWriter();
				
				JSONArray jsonList = new JSONArray();
				for(ProjectAdminDto2 dto : adminList) {
					JSONObject obj = new JSONObject();
					obj.put("idx", dto.getParticipantIdx());
					obj.put("name", dto.getName());
					obj.put("email", dto.getEmail());
					obj.put("departmentName", dto.getDepartmentName());
					obj.put("affiliation", dto.getAffiliation());
					jsonList.add(obj);
				}
				out.println(jsonList);
			}
		}else {
			try {
				pDao.setAdminYN(projectIdx, memberIdx);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			ArrayList<ProjectAdminDto2> adminList = null;
			try {
				adminList = pDao.getProjectAdminInfo(companyIdx, projectIdx);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			response.setCharacterEncoding("utf-8");
			response.setContentType("application/json");
			PrintWriter out = response.getWriter();
			
			JSONArray jsonList = new JSONArray();
			for(ProjectAdminDto2 dto : adminList) {
				JSONObject obj = new JSONObject();
				obj.put("idx", dto.getParticipantIdx());
				obj.put("name", dto.getName());
				obj.put("email", dto.getEmail());
				obj.put("departmentName", dto.getDepartmentName());
				obj.put("affiliation", dto.getAffiliation());
				jsonList.add(obj);
			}
			out.println(jsonList);
		}
	}
}
