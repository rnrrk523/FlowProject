package action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.LoginOrJoinDao;
import dto.CompanyNameDto;

public class AccountMemberShipAction implements Action {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		LoginOrJoinDao dao = new LoginOrJoinDao();
		int companyIdx = Integer.parseInt(request.getParameter("companyIdx"));
		CompanyNameDto dto = null;
		try {
			dto = dao.CompanyName(companyIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		 request.setAttribute("companyIdx", companyIdx);
	     request.setAttribute("CompanyName", dto.getCompanyName());
		 request.setAttribute("CompanyURL", dto.getCompanyURL());
		 
		 RequestDispatcher rd = request.getRequestDispatcher("MemberShipAccount.jsp");
			rd.forward(request, response);
	}
}
