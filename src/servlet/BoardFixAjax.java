package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import dao.BoardALLDao;
import dao.ProjectALLDao;
import dto.BoardTopFixedDto;

/**
 * Servlet implementation class BoardFixAjax
 */
@WebServlet("/BoardFixAjax")
public class BoardFixAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int boardIdx = Integer.parseInt(request.getParameter("boardIdx"));
		BoardALLDao dao = new BoardALLDao();
		try {
			dao.boardTopFix('Y',boardIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		String category = "";
		BoardTopFixedDto dto = null;
		try {
			dto = dao.BoardTopFixCategoryOne(boardIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		int projectIdx = 0;
		ProjectALLDao pdao = new ProjectALLDao();
		try {
			projectIdx = dao.ProjectIdxSearch(boardIdx);
			pdao.ProjectUpdate(projectIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		category = dto.getCategory();
		BoardTopFixedDto bdto = null;
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		JSONObject obj1 = new JSONObject();
		obj1.put("category",category);
		if(category.equals("글")) {
			try {
				bdto = dao.BoardTopFixViewOne(boardIdx,"글");
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		if(category.equals("업무")) {
			try {
				bdto = dao.BoardTopFixViewOne(boardIdx,"업무");
			} catch (Exception e) {
				e.printStackTrace();
			}
			obj1.put("state",bdto.getState());
		}
		if(category.equals("일정")) {
			try {
				bdto = dao.BoardTopFixViewOne(boardIdx,"일정");
			} catch (Exception e) {
				e.printStackTrace();
			}
			String startDate = bdto.getStartDate();
			String endDate = bdto.getEndDate();
			String Startresult = startDate.replaceAll("\\s\\d{2}:\\d{2} \\([a-zA-Z]\\)", "");
			String endresult = endDate.replaceAll("\\s\\d{2}:\\d{2} \\([a-zA-Z]\\)", "");
			obj1.put("startDate", Startresult);
			obj1.put("endDate", endresult);
		}
		obj1.put("title",bdto.getTitle());
		out.println(obj1);
	}

}
