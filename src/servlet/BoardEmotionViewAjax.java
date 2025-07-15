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

import dao.BoardALLDao;
import dto.BoardEmotionDto;


@WebServlet("/BoardEmotionViewAjax")
public class BoardEmotionViewAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int boardIdx = Integer.parseInt(request.getParameter("boardIdx"));
		BoardALLDao dao = new BoardALLDao();
		int totalcount = 0;
		try {
			totalcount = dao.BoardEmotionTotalCount(boardIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		ArrayList<BoardEmotionDto> list = null;
		ArrayList<BoardEmotionDto> list2 = null;
		try {
			list = dao.BoardEmotionTypeCount(boardIdx);
			list2 = dao.BoardEmotionView(boardIdx,0);
		} catch (Exception e) {
			e.printStackTrace();
		}
		response.setCharacterEncoding("utf-8");
 	    response.setContentType("application/json");
 	    PrintWriter out = response.getWriter();
 	    JSONArray array1 = new JSONArray();
 	    for(BoardEmotionDto dto2 : list2) {
 	    	JSONObject obj1 = new JSONObject();
 	    	obj1.put("memberIdx",dto2.getMemberIdx());
 	    	obj1.put("name",dto2.getName());
 	    	obj1.put("profileImg",dto2.getProfileImg());
 	    	obj1.put("emotionType2",dto2.getEmotionType());
 	    	for(BoardEmotionDto dto : list) {
 	    		obj1.put("totalcount",totalcount);
 	    		obj1.put("emotionType",dto.getEmotionType());
 	    		obj1.put("countemotion",dto.getCountemotion());
 	    	}
 	    	array1.add(obj1);
 	    }
 	    out.println(array1);
	}

}
