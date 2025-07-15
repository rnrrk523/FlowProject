package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import dao.LiveAlarmDao;

@WebServlet("/LiveAlarmItemReadFuncAjaxServlet")
public class LiveAlarmItemReadFuncAjaxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int liveAlarmIdx = Integer.parseInt(request.getParameter("liveAlarmIdx"));
		LiveAlarmDao laDao = new LiveAlarmDao();
		try {
			laDao.setAlarmSelectReadFunc(liveAlarmIdx);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}