package action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.ProjectDao;
import dto.OpenProjectCategoryDto;
import dto.OpenProjectDto;

public class AdminPage8Action implements Action{
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false); // false: 세션 없으면 null 반환

        if (session == null || session.getAttribute("memberIdx") == null) {
            PrintWriter out = response.getWriter();
            out.println("<script>");
            out.println("alert('로그인이 필요합니다.');");
            out.println("location.href='Controller?command=Login';");
            out.println("</script>");
            out.close();
            return; // 더 이상 실행 안 하고 종료
        }
//		int companyIdx = Integer.parseInt(request.getParameter("companyIdx"));
		int companyIdx = (int)session.getAttribute("companyIdx");
//		int memberIdx = Integer.parseInt(request.getParameter("memberIdx"));
		int memberIdx = (int)session.getAttribute("memberIdx");
		ProjectDao pDao = new ProjectDao();
		ArrayList<OpenProjectDto> openProjectList = null;
		try {
			openProjectList = pDao.getOpenProjects(companyIdx);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		ArrayList<OpenProjectCategoryDto> categoryList = null;
		try {
			categoryList = pDao.getOpenProjectCategory(companyIdx);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		request.setAttribute("companyIdx", companyIdx);
		request.setAttribute("memberIdx", memberIdx);
		request.setAttribute("openProjectList", openProjectList);
		request.setAttribute("categoryList", categoryList);
		request.getRequestDispatcher("flow_admin8.jsp").forward(request, response);
	}
}