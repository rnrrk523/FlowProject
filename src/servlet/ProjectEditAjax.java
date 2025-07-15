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


@WebServlet("/ProjectEditAjax")
public class ProjectEditAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String title = request.getParameter("title");
		String explanation = request.getParameter("explanation");
		int hometabIdx = Integer.parseInt(request.getParameter("hometabIdx"));
		String hometab = "";
		int publicIdx = Integer.parseInt(request.getParameter("publicIdx"));
		char adminvalue = request.getParameter("adminvalue").charAt(0);
		int dataCode1 = Integer.parseInt(request.getParameter("dataCode1"));
		int dataCode2 = Integer.parseInt(request.getParameter("dataCode2"));
		int dataCode3 = Integer.parseInt(request.getParameter("dataCode3"));
		int dataCode4 = Integer.parseInt(request.getParameter("dataCode4"));
		int memberIdx = Integer.parseInt(request.getParameter("idx"));
		int projectIdx = Integer.parseInt(request.getParameter("projectIdx"));
		if(hometabIdx ==1 ) {
			hometab = "피드";
		}
		if(hometabIdx ==2 ) {
			hometab = "업무";		
		}
		if(hometabIdx ==3 ) {
			hometab = "캘린더";
		}
		ProjectALLDao pdao = new ProjectALLDao();
		try {
				pdao.ProjectUpdate(title, explanation, hometab, publicIdx, adminvalue, dataCode2, dataCode1,dataCode4, projectIdx, memberIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		try {
			pdao.ProjectUpdate(projectIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		response.setCharacterEncoding("utf-8");
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        JSONObject obj1 = new JSONObject();
        obj1.put("title", title);
        obj1.put("explanation", explanation);
        obj1.put("hometab", hometab);
        obj1.put("adminvalue", adminvalue + "");
        obj1.put("publicIdx", publicIdx);
        out.println(obj1);
	}

}
