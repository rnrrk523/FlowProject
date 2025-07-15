package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.AdminChangeHistoryDao;
import dao.LiveAlarmDao;
import dao.LoginOrJoinDao;
import dao.MemberDao;
import dto.CompanyNameDto;
import dto.MemberCompanyDepartmentDto;
import dto.MemberDto;
import dto.ProjectMemberListDto;

@WebServlet("/memberApprovalAjaxServlet")
public class memberApprovalAjaxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		int memberIdx = Integer.parseInt(request.getParameter("memberIdx"));
		int changerIdx = Integer.parseInt(request.getParameter("changerIdx"));
		int companyIdx = (int)session.getAttribute("companyIdx");
		MemberDao mDao = new MemberDao();
		try {
			mDao.setMemberApproval(memberIdx);
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
		try {
			adao.addAdminChangeRecord(changerIdx, "사용자 관리", "가입 승인", target, "");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		MemberDao dao = new MemberDao();
		MemberDto mdto = null;
		try {
			mdto = dao.GetMyProfile(memberIdx);
		} catch (Exception e2) {
			e2.printStackTrace();
		}
		LiveAlarmDao laDao = new LiveAlarmDao();
		try {
			laDao.addLiveAlarm(memberIdx, "가입승인", mdto.getCompanyName()+" 가입이 승인 되었습니다.", mdto.getName()+"님 환영합니다.", companyIdx, null, null, 'N', 'Y', 'N', memberIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}