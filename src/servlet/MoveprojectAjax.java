package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import dao.ProjectALLDao;
import dto.MyProjectViewDto;


@WebServlet("/MoveprojectAjax")
public class MoveprojectAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;
     
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int pno = Integer.parseInt(request.getParameter("pno"));
		ProjectALLDao pdao = new ProjectALLDao();
		MyProjectViewDto dto = null;
		try {
			dto = pdao.ProjectCategory(pno);
		} catch (Exception e) {
			e.printStackTrace();
		}
		String hometab = dto.getHometab();
		response.setCharacterEncoding("utf-8");
 	    response.setContentType("application/json");
 	    PrintWriter out = response.getWriter();
 	    JSONObject obj1 = new JSONObject();
 	    obj1.put("hometab",hometab);
 	    out.println(obj1);
	}
}
