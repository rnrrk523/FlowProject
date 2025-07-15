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

import dao.AdminChangeHistoryDao;
import dto.AdminChangeHistoryDto;

@WebServlet("/adminChangeHistoryAjaxServlet")
public class adminChangeHistoryAjaxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int companyIdx = Integer.parseInt(request.getParameter("companyIdx"));
		String standard = request.getParameter("standard");
		String str = request.getParameter("str");
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		
		AdminChangeHistoryDao achDao = new AdminChangeHistoryDao();
		ArrayList<AdminChangeHistoryDto> historyList = new ArrayList<AdminChangeHistoryDto>();
		try {
			historyList = achDao.getAdminChangeHistory(companyIdx, standard, str, startDate, endDate);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		
		JSONArray jsonList = new JSONArray();
		for(AdminChangeHistoryDto dto : historyList) {
			JSONObject obj = new JSONObject();
			obj.put("changer", dto.getChangerNameAndEmail());
			obj.put("menu", dto.getMenu());
			obj.put("func", dto.getFunc());
			obj.put("target", dto.getTarget());
			obj.put("changeContent", dto.getChangeContent());
			obj.put("changeDate", dto.getChangeDate());
			jsonList.add(obj);
		}
		out.println(jsonList);
	}
}