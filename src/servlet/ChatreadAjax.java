package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ChattingDao;
import dto.ChatNumDto;

@WebServlet("/ChatreadAjax")
public class ChatreadAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int memberIdx = Integer.parseInt(request.getParameter("memberIdx"));
		ChattingDao dao = new ChattingDao();
		ArrayList<ChatNumDto> list = null;
		try {
			list = dao.ChatNumber(memberIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		for(ChatNumDto dto : list) {
			try {
				dao.ReadChat(memberIdx, dto.getChatIdx());
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

}
