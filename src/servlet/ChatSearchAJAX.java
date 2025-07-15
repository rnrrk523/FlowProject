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
import dto.BoardEmotionDto;
import dto.ChatRoomListDto;

/**
 * Servlet implementation class ChatSearchAJAX
 */
@WebServlet("/ChatSearchAJAX")
public class ChatSearchAJAX extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String search = request.getParameter("search");
		int memberIdx = Integer.parseInt(request.getParameter("memberIdx"));
		ChattingDao dao = new ChattingDao();
		ArrayList<ChatRoomListDto> list = null;
		try {
			list = dao.ChatRoomList(memberIdx, search);
		} catch (Exception e) {
			e.printStackTrace();
		}
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		JSONArray array1 = new JSONArray();
		for(ChatRoomListDto dto : list) {
			JSONObject obj1 = new JSONObject();
			obj1.put("chatRoomIdx",dto.getChatRoomIdx());
			obj1.put("chatRoomName",dto.getChatRoomName());
			obj1.put("projectIdx",dto.getProjectIdx());
			obj1.put("createrChatIdx",dto.getCreaterChatIdx());
			obj1.put("groupChatYN",dto.getGroupChatYN()+"");
			obj1.put("Conversation",dto.getConversation());
			obj1.put("date",dto.getDate());
			obj1.put("time",dto.getTime());
			obj1.put("amPm",dto.getAmPm());
			obj1.put("readNotCount",dto.getReadNotCount());
			array1.add(obj1);
		}
		out.println(array1);
	}

}
