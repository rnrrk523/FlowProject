package action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
public class AccountEmailMemberShipAction implements Action {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 
		 RequestDispatcher rd = request.getRequestDispatcher("make_company_input_email.jsp");
			rd.forward(request, response);
	}
}
