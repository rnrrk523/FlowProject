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

import dao.ChatMonitoringHistoryDao;
import dto.ObservingRecordDto;

@WebServlet("/getObservingRecordAjaxServlet")
public class getObservingRecordAjaxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int companyIdx = Integer.parseInt(request.getParameter("companyIdx"));
		String standard = request.getParameter("standard");
		String str = request.getParameter("str");
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		ChatMonitoringHistoryDao cmhDao = new ChatMonitoringHistoryDao();
		ArrayList<ObservingRecordDto> recordList = new ArrayList<ObservingRecordDto>();
		try {
			recordList = cmhDao.getObservingRecordList(companyIdx, standard, str, startDate, endDate);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		
		JSONArray jsonList = new JSONArray();
		for(ObservingRecordDto dto : recordList) {
			JSONObject obj = new JSONObject();
			obj.put("modifier", dto.getModifier());
			obj.put("func", dto.getFunc());
			obj.put("target", dto.getTarget());
			obj.put("changeContent", dto.getChangeContent());
			obj.put("changeDate", dto.getChangeDate());
			jsonList.add(obj);
		}
		out.println(jsonList);
	}
}
