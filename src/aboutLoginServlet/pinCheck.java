package aboutLoginServlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import dao.LoginOrJoinDao;

@WebServlet("/pinCheck")
public class pinCheck extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 HttpSession session = request.getSession();
		LoginOrJoinDao dao = new LoginOrJoinDao();
		String email = (String) session.getAttribute("email");
		int pinNumber = Integer.parseInt(request.getParameter("pinNumber"));
		System.out.println(email);
		System.out.println(pinNumber);
		boolean judge = false;
		try{
			judge = dao.checkCertification(email, null, pinNumber);
		}catch(Exception e) {}
	response.setCharacterEncoding("UTF-8");
	response.setContentType("application/json");
	PrintWriter out = response.getWriter();
	JSONObject obj = new JSONObject();
	obj.put("bool" , judge );
	out.print(obj);
	}
}
