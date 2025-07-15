package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
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
import dto.BoardTopFixedDto;


@WebServlet("/ReadBoardInFeedAjax")
public class ReadBoardInFeedAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int memberIdx = Integer.parseInt(request.getParameter("memberIdx"));
		int projectIdx = Integer.parseInt(request.getParameter("projectIdx"));
		System.out.println(projectIdx);
		BoardALLDao dao = new BoardALLDao();
		ArrayList<BoardTopFixedDto> list = null;
		try {
			list = dao.SearchIdxOrCategory(projectIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		response.setCharacterEncoding("utf-8");
 	    response.setContentType("application/json");
 	    PrintWriter out = response.getWriter();
 	    JSONArray array1 = new JSONArray();
		for(BoardTopFixedDto dto : list) {
			JSONObject obj1 = new JSONObject();
			try {
			    dao.boardReadOrNot(dto.boardIdx, memberIdx);
			} catch (SQLIntegrityConstraintViolationException e) {
			} catch (SQLException e) {
			    e.printStackTrace();
			} catch (Exception e) {
				e.printStackTrace();
			}
			int readCount = 0;
			try {
				readCount = dao.ReadMemberCount(dto.boardIdx);
			} catch (Exception e1) {
				e1.printStackTrace();
			}
			obj1.put("boardIdx",dto.boardIdx);
			obj1.put("readCount",readCount);
		}
		ProjectALLDao pdao = new ProjectALLDao();
		try {
			pdao.ProjectUpdate(projectIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		out.println(array1);
	}

}
