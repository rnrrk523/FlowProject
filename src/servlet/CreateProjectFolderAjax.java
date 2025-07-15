package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import dao.ProjectALLDao;
import dto.MemberDto;
import dto.dto.ProjectUserFolder;

@WebServlet("/CreateProjectFolderAjax")
public class CreateProjectFolderAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String title = request.getParameter("folderTitle");
		int memberIdx = Integer.parseInt(request.getParameter("memberIdx"));
		ProjectALLDao dao = new ProjectALLDao();
		int count = 0;
		ProjectUserFolder dto = null;
		try {
			count = dao.ProjectFolderIdx();
			dao.ProjectFolder(title, memberIdx);
			dto = dao.ProjectUserFolderOne(count);
		} catch (Exception e) {
			e.printStackTrace();
		}
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		JSONObject obj1 = new JSONObject();
		obj1.put("folderIdx",dto.getFolderIdx());
		obj1.put("name",dto.getName());
		out.println(obj1);
	}
}
