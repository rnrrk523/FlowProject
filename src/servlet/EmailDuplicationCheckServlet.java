package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import dao.MemberDao;
import dto.MemberDto;

/**
 * Servlet implementation class EmailDuplicationCheckServlet
 */
@WebServlet("/EmailDuplicationCheckServlet")
public class EmailDuplicationCheckServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email = request.getParameter("email");
		MemberDao dao = new MemberDao();
		ArrayList<MemberDto> list = null;
		try {
			list = dao.GetUserEmail();
		} catch (Exception e) {
			e.printStackTrace();
		}
		String Check = "N";
		for (MemberDto dto : list) {
		    if (email.equals(dto.getEmail())) {
		        Check = "Y";
		        break;
		    }
		}
		response.setCharacterEncoding("utf-8");
 	    response.setContentType("application/json");
 	    PrintWriter out = response.getWriter();
 	    JSONObject obj1 = new JSONObject();
 	    obj1.put("Check",Check);
 	    out.println(obj1);
	}

}
