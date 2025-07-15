package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ProjectALLDao;


@WebServlet("/StarButtonAJAX")
public class StarButtonAJAX extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int pno = 0;
        int idx = 0;
        char btn = ' ';
        
        pno = Integer.parseInt(request.getParameter("pno"));
        idx = Integer.parseInt(request.getParameter("idx"));
        String btnStr = request.getParameter("btn");
        btn = btnStr.charAt(0);
        ProjectALLDao pdao = new ProjectALLDao();
        try {
            pdao.UPDATEprojectFavorites(btn, idx, pno);
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.setCharacterEncoding("utf-8");
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.println("{\"message\":\"완료\"}");
    }
}
