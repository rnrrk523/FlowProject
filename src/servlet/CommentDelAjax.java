package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.BoardALLDao;
import dao.ProjectALLDao;

/**
 * Servlet implementation class CommentDelAjax
 */
@WebServlet("/CommentDelAjax")
public class CommentDelAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int commentIdx = Integer.parseInt(request.getParameter("commentIdx"));
		BoardALLDao dao = new BoardALLDao();
		try {
			dao.CommentDelete(commentIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		ProjectALLDao pdao = new ProjectALLDao();
		try {
			int boardIdx = dao.CommentBoardIdx(commentIdx);
			int projectIdx = dao.ProjectIdxSearch(boardIdx);
			pdao.ProjectUpdate(projectIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
