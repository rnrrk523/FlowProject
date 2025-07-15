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

import dao.BoardALLDao;
import dto.ProjectInviteViewDto;


@WebServlet("/BoardReadSearchAjax")
public class BoardReadSearchAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int boardIdx = Integer.parseInt(request.getParameter("boardIdx"));
		String name = request.getParameter("name");
		BoardALLDao dao = new BoardALLDao();
		ArrayList<ProjectInviteViewDto> list = null;
				try {
					list = dao.ReadMembersearchview(boardIdx,name);
				} catch (Exception e) {
					e.printStackTrace();
				}
				response.setCharacterEncoding("utf-8");
		 	    response.setContentType("application/json");
		 	    PrintWriter out = response.getWriter();
		 	    JSONArray array1 = new JSONArray();
				for(ProjectInviteViewDto dto : list) {
					   JSONObject obj1 = new JSONObject();
					   obj1.put("memberIdx",dto.getMemberIdx());
					   obj1.put("companyName",dto.getCompanyName());
					   obj1.put("departmentName",dto.getDepartmentName());
					   obj1.put("name",dto.getName());
					   obj1.put("position",dto.getPosition());
					   obj1.put("profileImg",dto.getProfileImg());
					   obj1.put("readDate",dto.getReadDate());
					   array1.add(obj1);
				}
				out.println(array1);
	}
}
