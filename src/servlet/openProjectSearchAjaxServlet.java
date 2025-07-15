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
import dto.OpenProjectDto;

@WebServlet("/openProjectSearchAjaxServlet")
public class openProjectSearchAjaxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int companyIdx = Integer.parseInt(request.getParameter("companyIdx"));
		String str = request.getParameter("str");
		
		ProjectDao pDao = new ProjectDao();
		ArrayList<OpenProjectDto> searchList = new ArrayList<OpenProjectDto>();
		try {
			searchList = pDao.getOpenProjectsSearch(companyIdx, str);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		
		JSONArray jsonList = new JSONArray();
		for(OpenProjectDto dto : searchList) {
			JSONObject obj = new JSONObject();
			obj.put("idx", dto.getProjectIdx());
			obj.put("categoryName", dto.getCategoryName());
			obj.put("pName", dto.getpName());
			obj.put("pmCnt", dto.getMemberCnt());
			obj.put("boardCnt", dto.getBoardCnt());
			obj.put("commentCnt", dto.getCommentCnt());
			obj.put("lastActivity", dto.getLastActivity());
			obj.put("openDate", dto.getOpDate());
			jsonList.add(obj);
		}
		out.println(jsonList);
	}
}