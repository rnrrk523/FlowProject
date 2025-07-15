package servlet;

import java.io.File;
import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import dao.CompanyDao;
import dto.CompanyDto;

@WebServlet("/adminPageLogoAddServlet")
public class adminPageLogoAddServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ServletContext application = getServletContext();
		
		String path = application.getRealPath("upload");
		System.out.println("(참고) 절대경로real path : "+path);
		String fileName = "";
		try {
			File filePath = new File(path);
			if(!filePath.exists()) {
				filePath.mkdirs();
			}
			
			int fileLimit = 500 * 1024;
			MultipartRequest multi = new MultipartRequest(
					request,
					path,
					fileLimit,
					"UTF-8",
					new DefaultFileRenamePolicy()
			);
			
			Enumeration<?> files = multi.getFileNames();
			
			String fileObject = (String)files.nextElement();
			fileName = multi.getFilesystemName(fileObject);
		} catch(Exception e) {}
		HttpSession session = request.getSession();
		CompanyDao cDao = new CompanyDao();
		int companyIdx = (int)session.getAttribute("companyIdx");
		System.out.println(fileName);
		try {
			cDao.updateCompanyLogo(companyIdx, fileName);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("!");
		}
		
		
		CompanyDto companyInfo = null;
		try {
			companyInfo = cDao.getCompanyInfo(companyIdx);
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		session.setAttribute("companyInfo", companyInfo);
		// request.setAttribute("fileName", fileName);
		// request.getRequestDispatcher("flow_admin1.jsp").forward(request, response);
		response.sendRedirect("flow_admin1.jsp");
	}
}