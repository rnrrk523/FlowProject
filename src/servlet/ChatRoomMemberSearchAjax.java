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

import dao.ChattingDao;
import dto.MemberDto;

@WebServlet("/ChatRoomMemberSearchAjax")
public class ChatRoomMemberSearchAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int chatRoomIdx = Integer.parseInt(request.getParameter("chatRoomIdx"));
		ChattingDao dao = new ChattingDao();
		ArrayList<MemberDto> list = null;
		try {
			list = dao.ChatRoomMemberSearch(chatRoomIdx);
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
			array1.add(obj1);
		}
		out.println(array1);
	}

}
