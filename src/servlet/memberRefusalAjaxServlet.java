package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.AdminChangeHistoryDao;
import dao.MemberDao;
import dto.MemberCompanyDepartmentDto;

@WebServlet("/memberRefusalAjaxServlet")
public class memberRefusalAjaxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int memberIdx = Integer.parseInt(request.getParameter("memberIdx"));
		int changerIdx = Integer.parseInt(request.getParameter("changerIdx"));
		
		MemberDao mDao = new MemberDao();
		
		MemberCompanyDepartmentDto memberInfo = null;
		try {
			memberInfo = mDao.getMemberInfo(memberIdx);
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		String targetName = memberInfo.getName();
		String targetEmail = memberInfo.getEmail();
		String target = targetName+"("+targetEmail+")";
		
		AdminChangeHistoryDao adao = new AdminChangeHistoryDao();
//		관리자 변경 이력 INSERT
		try {
			adao.addAdminChangeRecord(changerIdx, "사용자 관리", "가입 거절", target, "");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
//		삭제
		try {
			mDao.deleteMemberRefusal(memberIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
