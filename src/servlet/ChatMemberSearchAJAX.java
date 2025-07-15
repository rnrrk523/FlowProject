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
import dto.ChatRoomListDto;
import dto.MemberDto;

/**
 * Servlet implementation class ChatMemberSearchAJAX
 */
@WebServlet("/ChatMemberSearchAJAX")
public class ChatMemberSearchAJAX extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String search = request.getParameter("search");
		int memberIdx = Integer.parseInt(request.getParameter("memberIdx"));
		int companyIdx = Integer.parseInt(request.getParameter("companyIdx"));
		MemberDao dao = new MemberDao();
		ArrayList<MemberDto> list = null;
		try {
			list = dao.ChatMember(companyIdx,memberIdx,search);
		} catch (Exception e) {
			e.printStackTrace();
		}
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		JSONArray array1 = new JSONArray();
		for(MemberDto dto : list) {
			JSONObject obj1 = new JSONObject();
			obj1.put("memberIdx",dto.getMemberIdx());
			obj1.put("name",dto.getName());
			obj1.put("url",dto.getProfileImg());
			obj1.put("position",dto.getPosition());
			obj1.put("companyName",dto.getCompanyName());
			obj1.put("departmentName",dto.getDepartmentName());
			array1.add(obj1);
		}
		out.println(array1);
	}

}
