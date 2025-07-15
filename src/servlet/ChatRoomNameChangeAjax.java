package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ChattingDao;

/**
 * Servlet implementation class ChatRoomNameChangeAjax
 */
@WebServlet("/ChatRoomNameChangeAjax")
public class ChatRoomNameChangeAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int chatRoomIdx = Integer.parseInt(request.getParameter("chatRoomIdx"));
		String chatText = request.getParameter("text");
		ChattingDao dao = new ChattingDao();
		try {
			dao.ChattingRoomNameChange(chatRoomIdx, chatText);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
