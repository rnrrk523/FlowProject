package action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.GoToDao;
import dto.GoToDto2;

public class AdminPage5Action implements Action{
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false); // false: 세션 없으면 null 반환

		if (session == null || session.getAttribute("memberIdx") == null) {
        	response.setContentType("text/html; charset=UTF-8");
        	response.setCharacterEncoding("UTF-8");
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
		GoToDao gDao = new GoToDao();
		ArrayList<GoToDto2> goToList = null;
		try {
			goToList = gDao.getGoTo(companyIdx);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		request.setAttribute("companyIdx", companyIdx);
		request.setAttribute("memberIdx", memberIdx);
		request.setAttribute("goToList", goToList);
		request.getRequestDispatcher("flow_admin5.jsp").forward(request, response);
	}
}