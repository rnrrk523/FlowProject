package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.AdminChangeHistoryDao;
import dao.ProjectDao;

@WebServlet("/comProjectAlterAjaxServlet")
public class comProjectAlterAjaxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int projectIdx = Integer.parseInt(request.getParameter("projectIdx"));
		String pName = request.getParameter("pName");
		int writingGrant = Integer.parseInt(request.getParameter("writingGrant"));
		int commentGrant = Integer.parseInt(request.getParameter("commentGrant"));
		int postViewGrant = Integer.parseInt(request.getParameter("postViewGrant"));
		int editPostGrant = Integer.parseInt(request.getParameter("editPostGrant"));
		String normalChangeYN = request.getParameter("normalChangeYN");
		String nameChangeYN = request.getParameter("nameChangeYN");
		String prevPName = request.getParameter("prevPName");
		int changerIdx = Integer.parseInt(request.getParameter("changerIdx"));
		
		ProjectDao pDao = new ProjectDao();
		try {
			pDao.setProjectInfo(projectIdx, pName, writingGrant, commentGrant, postViewGrant,  editPostGrant);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
		AdminChangeHistoryDao adao = new AdminChangeHistoryDao();
		if(normalChangeYN.equals("Y")) {
//			회사 프로젝트에서 일반 프로젝트로 변경
			try {
				pDao.setCompanyProjectChange(projectIdx);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
//			관리자 변경 이력 INSERT
			try {
				adao.addAdminChangeRecord(changerIdx, "회사 프로젝트 관리", "일반 프로젝트로 변경", pName+"("+projectIdx+")"	, "'회사' → 일반'");
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		if(nameChangeYN.equals("true")) {
			String changeContent = "'"+prevPName+"' -> '"+pName+"'";
//			관리자 변경 이력 INSERT
			try {
				adao.addAdminChangeRecord(changerIdx, "회사 프로젝트 관리", "프로젝트명 변경", pName+"("+projectIdx+")", changeContent);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
}
