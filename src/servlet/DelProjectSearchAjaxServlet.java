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

import dao.MemberDao;
import dao.ProjectDao;
import dto.DelProjectDto;
import dto.MemberCompanyDepartmentDto;
import dto.ProjectAdminDto;
import dto.ProjectAdminDto2;

@WebServlet("/DelProjectSearchAjaxServlet")
public class DelProjectSearchAjaxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int companyIdx = Integer.parseInt(request.getParameter("companyIdx"));
		String str = request.getParameter("str");
		
		ProjectDao pDao = new ProjectDao();
		ArrayList<DelProjectDto> delProjectSearchList = null;
		try {
			delProjectSearchList = pDao.getDelProjectSearch(companyIdx, str);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		
		JSONArray jsonList = new JSONArray();
		for(DelProjectDto dto : delProjectSearchList) {
			JSONObject obj = new JSONObject();
			MemberDao mDao = new MemberDao();
			MemberCompanyDepartmentDto memberInfo = null;
			try {
				memberInfo = mDao.getMemberInfo(dto.getDelMemberIdx());
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			ArrayList<ProjectAdminDto2> adminList = new ArrayList<ProjectAdminDto2>();
			try {
				adminList = pDao.getProjectAdminInfo(companyIdx, dto.getProjectIdx());
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			JSONArray adminArray = new JSONArray();
			for(ProjectAdminDto2 a : adminList) {
				JSONObject obj2 = new JSONObject();
				obj2.put("name", a.getName());
				adminArray.add(obj2);
			}
			obj.put("adminList", adminArray);
			obj.put("delName", memberInfo.getName());
			obj.put("delEmail", memberInfo.getEmail());
			obj.put("projectIdx", dto.getProjectIdx());
			obj.put("pName", dto.getpName());
			obj.put("pmCnt", dto.getParticipantCnt());
			obj.put("lastActivity", dto.getLastActivity());
			obj.put("openingDate", dto.getOpeningDate());
			obj.put("deleteDate", dto.getDeleteDate());
			jsonList.add(obj);
		}
		out.println(jsonList);
	}
}
