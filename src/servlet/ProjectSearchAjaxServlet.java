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
import dto.ProjectsDto;

@WebServlet("/ProjectSearchAjaxServlet")
public class ProjectSearchAjaxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int companyIdx = Integer.parseInt(request.getParameter("companyIdx"));
		String str = request.getParameter("str");
		
		ProjectDao pDao = new ProjectDao();
		ArrayList<ProjectsDto> projectSearchList = null;
		try {
			projectSearchList = pDao.getProjectInfosearch(companyIdx, str);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		
		JSONArray jsonList = new JSONArray();
		for(ProjectsDto dto : projectSearchList) {
			JSONObject obj = new JSONObject();
			int empCnt = 0;
			try {
				empCnt = pDao.getEmployeeCnt(companyIdx, dto.getpIdx());
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			int outCnt = 0;
			try {
				outCnt = pDao.getOutsiderCnt(companyIdx, dto.getpIdx());
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			int commentCnt = 0;
			try {
				commentCnt = pDao.getCommentCnt(companyIdx, dto.getpIdx());
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			int chatCnt = 0;
			try {
				chatCnt = pDao.getChatCnt(companyIdx, dto.getpIdx());
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			int scheduleCnt = 0;
			try {
				scheduleCnt = pDao.getScheduleCnt(companyIdx, dto.getpIdx());
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			int taskCnt = 0;
			try {
				taskCnt = pDao.getTaskCnt(companyIdx, dto.getpIdx());
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			ArrayList<ProjectAdminDto2> adminList = null;
			try {
				adminList = pDao.getProjectAdminInfo(companyIdx, dto.getpIdx());
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			JSONArray adminArray = new JSONArray();
			for(ProjectAdminDto2 a : adminList) {
				JSONObject obj2 = new JSONObject();
				obj2.put("name",a.getName());
				adminArray.add(obj2);
			}
			
			obj.put("pIdx", dto.getpIdx());
			obj.put("pName", dto.getpName());
			obj.put("adminList", adminArray);
			obj.put("pmCnt", dto.getPmCnt());
			obj.put("empCnt", empCnt);
			obj.put("outCnt", outCnt);
			obj.put("boardCnt", dto.getBoardCnt());
			obj.put("commentCnt", commentCnt);
			obj.put("chatCnt", chatCnt);
			obj.put("scheduleCnt", scheduleCnt);
			obj.put("taskCnt", taskCnt);
			obj.put("lastActivity", dto.getLastActivity());
			obj.put("openingDate", dto.getOpeningDate());
			jsonList.add(obj);
		}
		out.println(jsonList);
	}
}