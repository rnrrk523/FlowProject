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
 * Servlet implementation class BoardFixDelAjax
 */
@WebServlet("/BoardFixDelAjax")
public class BoardFixDelAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int boardIdx = Integer.parseInt(request.getParameter("boardIdx"));
		BoardALLDao dao = new BoardALLDao();
		try {
			dao.boardTopFix('N',boardIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		int projectIdx = 0;
		ProjectALLDao pdao = new ProjectALLDao();
		try {
			projectIdx = dao.ProjectIdxSearch(boardIdx);
			pdao.ProjectUpdate(projectIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
