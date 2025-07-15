package action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.CompanyDao;
import dto.CompanyDto;

public class AdminPage1Action implements Action{
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
		CompanyDao dao = new CompanyDao();
		int companyIdx = (int)session.getAttribute("companyIdx");
		int memberIdx = (int)session.getAttribute("memberIdx");
		CompanyDto companyInfo = null;
		try {
			companyInfo = dao.getCompanyInfo(companyIdx);
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		String fileName = null;
		try {
			fileName = (String)request.getAttribute("fileName");
		} catch(Exception e) {}
		
		session.setAttribute("companyIdx", companyIdx);
		session.setAttribute("memberIdx", memberIdx);
		session.setAttribute("companyInfo", companyInfo);
		session.setAttribute("fileName", fileName);
		
		request.getRequestDispatcher("flow_admin1.jsp").forward(request, response);
	}
}