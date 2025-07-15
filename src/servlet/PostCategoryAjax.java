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
import dto.BoardPostViewDto;

/**
 * Servlet implementation class PostCategoryAjax
 */
@WebServlet("/PostCategoryAjax")
public class PostCategoryAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int boardIdx = Integer.parseInt(request.getParameter("boardIdx"));
		BoardALLDao dao = new BoardALLDao();
		BoardPostViewDto dto = null;
		try {
			dto = dao.PostViewBoard(boardIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		response.setCharacterEncoding("utf-8");
 	    response.setContentType("application/json");
 	    PrintWriter out = response.getWriter();
 	    JSONObject obj1 = new JSONObject();
 	    obj1.put("releaseYN",dto.getReleaseYN()+"");
 	    obj1.put("title",dto.getTitle());
 	    obj1.put("content",dto.getContent());
 	    out.println(obj1);
	}

}
