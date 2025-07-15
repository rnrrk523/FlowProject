package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ProjectALLDao;


@WebServlet("/ProjectpeopleAjax")
public class ProjectpeopleAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
        int projectIdx = Integer.parseInt(request.getParameter("projectIdx"));
        ProjectALLDao pdao = new ProjectALLDao();
        int participantCount = 0;
		try {
			participantCount = pdao.ProjectParticipantsNum(projectIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}

        // 응답을 JSON으로 반환
        response.setCharacterEncoding("utf-8");
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.println("{\"participantCount\": " + participantCount + "}");
	}

}
