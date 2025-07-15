package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import dao.ProjectALLDao;


@WebServlet("/ProjectCreateAjax")
public class ProjectCreateAjax extends HttpServlet {
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
		char colorfix = request.getParameter("colorfix").charAt(0);
		if(hometabIdx ==1 ) {
			hometab = "피드";
		}
		if(hometabIdx ==2 ) {
			hometab = "업무";		
		}
		if(hometabIdx ==3 ) {
			hometab = "캘린더";
		}
		if(hometabIdx ==4 ) {
			hometab = "파일";
		}
		int projectColor = 0;
		if(colorfix=='Y') {
			projectColor = 12;
		} else {
			projectColor = (int)(Math.random()*12)+1;
		}
		ProjectALLDao pdao = new ProjectALLDao();
		try {
			pdao.Createproject(memberIdx, title,explanation, memberIdx, hometab, adminvalue, dataCode2, dataCode1, dataCode3, dataCode4, publicIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		int projectIdx = 0;
		try {
			projectIdx = pdao.ProjectIdxView();
			System.out.println(projectIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		try {
			pdao.CreateProjectMember(projectIdx, memberIdx, projectColor);
		} catch (Exception e) {
			e.printStackTrace();
		}
		response.setCharacterEncoding("utf-8");
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        JSONObject obj1 = new JSONObject();
        obj1.put("projectIdx",projectIdx);
        obj1.put("hometab", hometab);
        out.println(obj1);
		
	}

}
