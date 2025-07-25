package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import dao.SettingDao;

@WebServlet("/UserMainHomeSettingModifyAjaxServlet")
public class UserMainHomeSettingModifyAjaxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int memberIdx = Integer.parseInt(request.getParameter("memberIdx"));
		SettingDao sDao = new SettingDao();
		
		String mainHomeStr = null;
		try {
			mainHomeStr = sDao.modifyUserMainHomeSetting(memberIdx);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		
		JSONObject obj = new JSONObject();
		obj.put("mainHomeStr", mainHomeStr);
		out.println(obj);
	}
}