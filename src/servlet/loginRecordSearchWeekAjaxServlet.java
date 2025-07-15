package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import dao.LoginRecordDao;
import dto.LoginRecordDto;

@WebServlet("/loginRecordSearchWeekAjaxServlet")
public class loginRecordSearchWeekAjaxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int companyIdx = Integer.parseInt(request.getParameter("companyIdx"));
		String standard = request.getParameter("standard");
		String str = request.getParameter("str");
		String dateStr = request.getParameter("date");
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date date = null;
		try {
			date = dateFormat.parse(dateStr);
		} catch (ParseException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		
		cal.set(Calendar.DAY_OF_MONTH, -6);
		Date sixMonthAgo = cal.getTime();
		
		String monday = dateFormat.format(sixMonthAgo);
		String sunday = dateFormat.format(date);
		
		LoginRecordDao lrDao = new LoginRecordDao();
		ArrayList<LoginRecordDto> searchList = new ArrayList<LoginRecordDto>();
		try {
			searchList = lrDao.getLoginRecordSearchDto(companyIdx, standard, str, monday, sunday);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		
		JSONArray jsonList = new JSONArray();
		for(LoginRecordDto dto : searchList) {
			JSONObject obj = new JSONObject();
			obj.put("cName", dto.getcName());
			obj.put("mName", dto.getmName());
			obj.put("dName", dto.getdName());
			obj.put("position", dto.getPosition());
			obj.put("email", dto.getEmail());
			obj.put("loginCnt", dto.getLoginCnt());
			jsonList.add(obj);
		}
		out.println(jsonList);
	}
}
