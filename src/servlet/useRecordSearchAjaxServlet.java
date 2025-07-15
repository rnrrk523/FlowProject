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

import dao.UseRecordDao;
import dto.UseRecordDto;

@WebServlet("/useRecordSearchAjaxServlet")
public class useRecordSearchAjaxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int companyIdx = Integer.parseInt(request.getParameter("companyIdx"));
		String standard = request.getParameter("standard");
		String str = request.getParameter("str");
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		
		UseRecordDao urDao = new UseRecordDao();
		ArrayList<UseRecordDto> urList = new ArrayList<UseRecordDto>();
		try {
			urList = urDao.getUseRecordSearch(companyIdx, standard, str, startDate, endDate);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		
		JSONArray jsonList = new JSONArray();
		for(UseRecordDto dto : urList) {
			JSONObject obj = new JSONObject();
			obj.put("companyName", dto.getcName());
			obj.put("name", dto.getmName());
			obj.put("departmentName", dto.getdName());
			obj.put("position", dto.getPosition());
			obj.put("email", dto.getEmail());
			obj.put("boardCnt", dto.getBoardUseCnt());
			obj.put("commentCnt", dto.getCommentUseCnt());
			obj.put("chatRoomCnt", dto.getChatRoomUseCnt());
			obj.put("chatCnt", dto.getChatUseCnt());
			jsonList.add(obj);
		}
		out.println(jsonList);
	}
}
