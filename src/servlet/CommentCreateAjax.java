package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.BoardALLDao;
import dao.ProjectALLDao;
import dao.ProjectAlarmDao;

/**
 * Servlet implementation class commentCreateAjax
 */
@WebServlet("/CommentCreateAjax")
public class CommentCreateAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String comment = request.getParameter("comment");
		int boardIdx = Integer.parseInt(request.getParameter("boardIdx"));
		int memberIdx = Integer.parseInt(request.getParameter("memberIdx"));
		BoardALLDao dao = new BoardALLDao();
		try {
			dao.Commentinput(boardIdx, memberIdx, comment, "SYSDATE", null);
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
