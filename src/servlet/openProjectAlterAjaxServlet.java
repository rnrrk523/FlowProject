package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.AdminChangeHistoryDao;
import dao.ProjectDao;
import dto.OpenProjectCategoryDto;

@WebServlet("/openProjectAlterAjaxServlet")
public class openProjectAlterAjaxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int categoryIdx = Integer.parseInt(request.getParameter("categoryIdx"));
		int projectIdx = Integer.parseInt(request.getParameter("projectIdx"));
		String pName = request.getParameter("pName");
		int writingGrant = Integer.parseInt(request.getParameter("writingGrant"));
		int commentGrant = Integer.parseInt(request.getParameter("commentGrant"));
		int postViewGrant = Integer.parseInt(request.getParameter("postViewGrant"));
		int editPostGrant = Integer.parseInt(request.getParameter("editPostGrant"));
		int prevWritingGrant = Integer.parseInt(request.getParameter("prevWritingGrant"));
		int changerIdx = Integer.parseInt(request.getParameter("changerIdx"));
		int prevCategoryIdx = Integer.parseInt(request.getParameter("prevCategoryIdx"));
		int companyIdx = Integer.parseInt(request.getParameter("companyIdx"));
		
		ProjectDao pDao = new ProjectDao();	
		ArrayList<OpenProjectCategoryDto> companyCategoryList = new ArrayList<OpenProjectCategoryDto>();
		try {
			companyCategoryList = pDao.getOpenProjectCategory(companyIdx);
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		String nextCategoryName = "";
		String prevCategoryName = "";
		for(OpenProjectCategoryDto dto : companyCategoryList) {
			if(categoryIdx == dto.getCategoryIdx()) {
				nextCategoryName = dto.getName();
			}
			if(prevCategoryIdx == dto.getCategoryIdx()) {
				prevCategoryName = dto.getName();
			}
		}
//		관리자 변경 이력 INSERT
//		카테고리 변경 이력
		if(categoryIdx != prevCategoryIdx) {
			AdminChangeHistoryDao adao = new AdminChangeHistoryDao();
			try {
				adao.addAdminChangeRecord(changerIdx, "공개 프로젝트 관리", "카테고리 변경", pName+"("+projectIdx+")", "'"+prevCategoryName+"' -> '"+nextCategoryName+"'");
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
//		글 작성 권한 변경 이력
		if(writingGrant != prevWritingGrant) {
			String next = writingGrant == 0 ? "전체" : "관리자만 글 댓글 작성";
			String prev = writingGrant == 0 ? "관리자만 글 댓글 작성" : "전체";
			AdminChangeHistoryDao adao = new AdminChangeHistoryDao();
			try {
				adao.addAdminChangeRecord(changerIdx, "공개 프로젝트 관리", "글/댓글 작성 권한 변경", pName+"("+projectIdx+")", prev+" -> "+next);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
//		공개 프로젝트 수정
		try {
			pDao.setOpenProjectInfo(categoryIdx, projectIdx, pName, writingGrant, commentGrant, postViewGrant, editPostGrant);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}