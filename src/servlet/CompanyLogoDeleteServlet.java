package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.CompanyDao;
import dto.CompanyDto;

@WebServlet("/CompanyLogoDeleteServlet")
public class CompanyLogoDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		CompanyDao cDao = new CompanyDao();
		int companyIdx = (int)session.getAttribute("companyIdx");
		try {
			cDao.updateCompanyLogo(companyIdx, "");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("!");
		}
		CompanyDto companyInfo = null;
		try {
			companyInfo = cDao.getCompanyInfo(companyIdx);
			session.setAttribute("companyInfo", companyInfo);
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
			System.out.println("!!");
		}
	}
}