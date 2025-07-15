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
import dto.CompanyPublicProjectDto;

@WebServlet("/PublicProjectSearchAjaxServlet")
public class PublicProjectSearchAjaxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int memberIdx = Integer.parseInt(request.getParameter("memberIdx"));
		String str = request.getParameter("str");
		ProjectDao pDao = new ProjectDao();
		
		// 공개프로젝트리스트
		ArrayList<CompanyPublicProjectDto> publicProjectList = null;
		try {
			publicProjectList = pDao.getPublicProjectList(memberIdx, str);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		
		JSONArray jsonList = new JSONArray();
		for(CompanyPublicProjectDto dto : publicProjectList) {
			JSONObject obj = new JSONObject();
			obj.put("projectIdx", dto.getProjectIdx());
			obj.put("projectName", dto.getProjectName());
			obj.put("categoryIdx", dto.getCategoryIdx());
			obj.put("categoryName", dto.getCategoryName());
			obj.put("memberCnt", dto.getMemberCnt());
			obj.put("participant_yn", dto.getParticipant_yn());
			obj.put("firstAdminName", dto.getFirstAdminName());
			jsonList.add(obj);
		}
		out.println(jsonList);
	}
}