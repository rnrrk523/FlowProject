package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import dao.MemberDao;

/**
 * Servlet implementation class MemberStateMessageAjax
 */
@WebServlet("/MemberStateMessageAjax")
public class MemberStateMessageAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String stateMessage = request.getParameter("stateMessage");
		int memberIdx = Integer.parseInt(request.getParameter("memberIdx"));
		MemberDao dao = new MemberDao();
		try {
			dao.StatementMessageUpdate(stateMessage, memberIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		JSONObject obj1 = new JSONObject();
		obj1.put("check","check");
		out.println(obj1);
	}

}
