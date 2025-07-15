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

@WebServlet("/useStopAjaxServlet")
public class useStopAjaxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int memberIdx = Integer.parseInt(request.getParameter("memberIdx"));
		int changerIdx = Integer.parseInt(request.getParameter("changerIdx"));
		
		MemberDao mDao = new MemberDao();
		try {
			mDao.setMemberState(memberIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
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
		String func = "";
		if(memberInfo.getState().equals("이용가능")) {
			func = "상태변경(이용중지 해제)";
		}else {
			func = "상태변경(이용중지)";
		}
		try {
			adao.addAdminChangeRecord(changerIdx, "사용자 관리", func, target, "");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
