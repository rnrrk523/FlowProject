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
import dto.CompanyProjectDto;

@WebServlet("/companyProjectSearchAjaxServlet")
public class companyProjectSearchAjaxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int companyIdx = Integer.parseInt(request.getParameter("companyIdx"));
		String str = request.getParameter("str");
		
		ProjectDao pDao = new ProjectDao();
		ArrayList<CompanyProjectDto> cpList = new ArrayList<CompanyProjectDto>();
		try {
			cpList = pDao.getCompanyProjectSearch(companyIdx, str);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		
		JSONArray jsonList = new JSONArray();
		for(CompanyProjectDto dto : cpList) {
			JSONObject obj = new JSONObject();
			obj.put("lastActivity", dto.getLastActivity());
			obj.put("openingDate", dto.getOpeningDate());
			obj.put("pName", dto.getpName());
			obj.put("boardCnt", dto.getBoardCnt());
			obj.put("commentCnt", dto.getCommentCnt());
			obj.put("writer", dto.getWriter());
			jsonList.add(obj);
		}
		out.println(jsonList);
	}
}
