package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.BoardALLDao;
import dao.ProjectALLDao;


@WebServlet("/BookmarkremoveAjax")
public class BookmarkremoveAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int boardIdx = Integer.parseInt(request.getParameter("boardIdx"));
		int memberIdx = Integer.parseInt(request.getParameter("memberIdx"));
		BoardALLDao dao = new BoardALLDao();
		try {
			dao.RemoveBookmark(boardIdx, memberIdx);
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
	}

}
