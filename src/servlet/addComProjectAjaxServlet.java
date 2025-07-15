package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.AdminChangeHistoryDao;
import dao.ProjectDao;

@WebServlet("/addComProjectAjaxServlet")
public class addComProjectAjaxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int companyIdx = Integer.parseInt(request.getParameter("companyIdx"));
		int memberIdx = Integer.parseInt(request.getParameter("memberIdx"));
		String pName = request.getParameter("pName");
		int writingGrant = Integer.parseInt(request.getParameter("writingGrant"));
		int commentGrant = Integer.parseInt(request.getParameter("commentGrant"));
		int postViewGrant = Integer.parseInt(request.getParameter("postViewGrant"));
		int editPostGrant = Integer.parseInt(request.getParameter("editPostGrant"));
		
		ProjectDao pDao = new ProjectDao();
		
		int projectIdx = 0;
//		회사 프로젝트를 생성한다
		try {
			projectIdx = pDao.addCompanyProject(companyIdx, memberIdx, pName, writingGrant, commentGrant, postViewGrant, editPostGrant);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
//		모든 직원들을 회사프로젝트에 참가시킨다
		try {
			pDao.addCompanyProjectMembers(companyIdx, projectIdx);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
//		작성자를 관리자로 부여한다
		try {
			pDao.setCompanyProjectAdmin(projectIdx, memberIdx);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		AdminChangeHistoryDao adao = new AdminChangeHistoryDao();
		try {
			adao.addAdminChangeRecord(memberIdx, "회사 프로젝트 관리", "회사 프로젝트 등록", pName+"("+projectIdx+")", "");
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
	}
}
