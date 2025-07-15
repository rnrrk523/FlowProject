package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.MemberDao;

@WebServlet("/memberBatchRegisterServlet")
public class memberBatchRegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int companyIdx = Integer.parseInt(request.getParameter("companyIdx"));
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		int departmentIdx = Integer.parseInt(request.getParameter("departmentIdx"));
		String position = request.getParameter("position");
		
		MemberDao mDao = new MemberDao();
		try {
			mDao.addMember(companyIdx, name, email, "team~123!", departmentIdx, position, phone);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
