package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.AdminChangeHistoryDao;
import dao.ProjectDao;
import dto.PermissionSettingDto;

@WebServlet("/ProjectAbsoluteDelAjaxServlet")
public class ProjectAbsoluteDelAjaxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int projectIdx = Integer.parseInt(request.getParameter("projectIdx"));
		int changerIdx = Integer.parseInt(request.getParameter("changerIdx"));
		
		ProjectDao pDao = new ProjectDao();
		PermissionSettingDto projectInfo = null;
		try {
			projectInfo = pDao.getPermissionSetting(projectIdx);
		} catch (Exception e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
		String pName = projectInfo.getpName();
		String changeContent = "'"+pName+"' 삭제 상태에서 완전 삭제";
//		관리자 변경 이력 INSERT
		AdminChangeHistoryDao adao = new AdminChangeHistoryDao();
		try {
			adao.addAdminChangeRecord(changerIdx, "프로젝트 관리", "삭제된 프로젝트 완전 삭제	", pName, changeContent);
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
//		프로젝트 완전삭제
		try {
			pDao.absoluteDeleteProject(projectIdx);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
