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
import dao.ProjectALLDao;
import dto.BoardEmotionDto;


@WebServlet("/BoardEmotionDeleteAjax")
public class BoardEmotionDeleteAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int boardIdx = Integer.parseInt(request.getParameter("boardIdx"));
		int memberIdx = Integer.parseInt(request.getParameter("memberIdx"));
		BoardALLDao dao = new BoardALLDao();
		BoardEmotionDto dto = null;
		try {
			dto = dao.MyAddEmotionCheck(boardIdx, memberIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println(dto.getName());
		String name = dto.getName();
		int emotion = dto.getEmotionType();
		try {
			dao.boardEmotiondel(boardIdx,memberIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		int count = 0;
		try {
				count = dao.BoardEmotionTotalCount(boardIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		ArrayList<BoardEmotionDto> list =null;
		try {
			list = dao.boardEmotionvalueCount(boardIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		ProjectALLDao pdao = new ProjectALLDao();
		try {
			int projectIdx = dao.ProjectIdxSearch(boardIdx);
			pdao.ProjectUpdate(projectIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println(dto.getName());
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		JSONArray array1 = new JSONArray();
		for(BoardEmotionDto dto2 : list) {
			JSONObject obj1 = new JSONObject();
			obj1.put("countEmotion",dto2.getCountemotion());
			obj1.put("EmotionType",dto2.getEmotionType());
			obj1.put("name",name);
			obj1.put("Emotion",emotion);
			obj1.put("totalcount",count);
			array1.add(obj1);
		}
		out.println(array1);
	}

}
