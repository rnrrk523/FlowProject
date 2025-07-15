package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import dao.DashDao;

@WebServlet("/WidgetDeleteAjax")
public class WidgetDeleteAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int dashIdx = Integer.parseInt(request.getParameter("dashIdx"));
		DashDao dao =  new DashDao();
		try {
			dao.WidgetDelete(dashIdx);
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
