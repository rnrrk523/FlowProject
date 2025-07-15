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

import dao.MyBoardDao;
import dto.BookmarkSideTabDto;
import dto.MyBoardSideTabDto;

@WebServlet("/myboardTextSearchAjaxServlet")
public class myboardTextSearchAjaxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int memberIdx = Integer.parseInt(request.getParameter("memberIdx"));
		String str = request.getParameter("str");
		
		MyBoardDao mDao = new MyBoardDao();
		ArrayList<MyBoardSideTabDto> list = new ArrayList<MyBoardSideTabDto>();
		try {
			list = mDao.getSidetabMyBoardTextSearch(memberIdx, str);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();

		JSONArray jsonList = new JSONArray();
		for(MyBoardSideTabDto dto : list) {
			JSONObject obj = new JSONObject();
			obj.put("boardIdx", dto.getBoardIdx());
			obj.put("boardTitle", dto.getBoardTitle());
			obj.put("projectIdx", dto.getProjectIdx());
			obj.put("projectName", dto.getProjectName());
			obj.put("boardCategory", dto.getBoardCategory());
			obj.put("writerIdx", dto.getWriterIdx());
			obj.put("writeDate", dto.getWriteDate());
			obj.put("writerName", dto.getWriterName());
			jsonList.add(obj);
		}
		out.println(jsonList);
	}
}