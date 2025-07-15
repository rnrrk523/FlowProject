package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import dao.BoardALLDao;
import dao.ProjectALLDao;
import dto.BoardEmotionDto;


@WebServlet("/BoardEmotionAddAjax")
public class BoardEmotionAddAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int boardIdx = Integer.parseInt(request.getParameter("boardIdx"));
		int code = Integer.parseInt(request.getParameter("code"));
		int memberIdx = Integer.parseInt(request.getParameter("memberIdx"));
		BoardALLDao dao = new BoardALLDao();
		
		try {
			dao.boardEmotion(boardIdx,memberIdx,code);
		} catch (Exception e) {
			e.printStackTrace();
		}
		int count = 0;
		try {
			if(dao.BoardEmotionTotalCount(boardIdx)-1==0) {
				count = 0;
			} else {
				count = dao.BoardEmotionTotalCount(boardIdx)-1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		BoardEmotionDto dto = null;
		try {
			dto = dao.MyAddEmotionCheck(boardIdx, memberIdx);
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
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		JSONObject obj1 = new JSONObject();
		obj1.put("name",dto.getName());
		obj1.put("totalcount",count);
		obj1.put("emotionType",dto.getEmotionType());
		out.println(obj1);
	}
}
