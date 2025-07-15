package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.LoginOrJoinDao;

@WebServlet("/Insert_companySevlet")
public class Insert_companySevlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(); 
		request.setCharacterEncoding("UTF-8");
		String email = (String) session.getAttribute("email");
        String name = (String) session.getAttribute("name");
        String password = (String) session.getAttribute("password");
        String phone = (String) session.getAttribute("phone");
        String choice_agree = (String) session.getAttribute("choice_agree");
		String company_name = request.getParameter("company_name");
		if(choice_agree == null) {
			choice_agree = "N";
		}
		int indust = Integer.parseInt(request.getParameter("indust"));
		int expect_per = Integer.parseInt(request.getParameter("expect_per"));
		if (phone != null && phone.length() == 11) {  
	            phone = phone.substring(0, 3) + "-" + phone.substring(3, 7) + "-" + phone.substring(7);
	    }
		System.out.println(company_name);
		LoginOrJoinDao dao = new LoginOrJoinDao();
		int companyIdx = 0;
		int memberIdx = 0;
		try {
			companyIdx = dao.CreateCompanyIdx();
			dao.CreateCompany(company_name,indust,expect_per,"http://43.201.111.209:8080//Project/Controller?command=AccountMemberShip&companyIdx="+companyIdx);
			memberIdx = dao.CreateMemberIdx();
			dao.insertMember(companyIdx, name, email, password, phone, choice_agree);
			dao.ProjectFolderAccount(memberIdx, "마케팅");
			dao.ProjectFolderAccount(memberIdx, "디자인");
			dao.ProjectFolderAccount(memberIdx, "엔지니어링");
			dao.DashBoardAccount(memberIdx, 2, 0);
			dao.DashBoardAccount(memberIdx, 3, 1);
			dao.DashBoardAccount(memberIdx, 13, 0);
			dao.ViewSettingAccount(memberIdx);
			dao.ProjectCategoryAccount(companyIdx, "업무관련");
			dao.ProjectCategoryAccount(companyIdx, "동호회");
			dao.ProjectCategoryAccount(companyIdx, "정보공유");
			dao.ProjectCategoryAccount(companyIdx, "학습");
			dao.GOTOAccount(companyIdx, "https://calendar.google.com/calendar/", "Y", "Google 캘린더", "https://www.google.com/s2/favicons?sz=64&domain=https://calendar.google.com/calendar/");
			dao.GOTOAccount(companyIdx, "https://www.naver.com/", "N", "네이버", "https://www.google.com/s2/favicons?sz=64&domain=https://www.naver.com/");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		response.sendRedirect("Controller?command=Login");
		
	}

}
