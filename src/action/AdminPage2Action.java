package action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.MemberDao;
import dto.MemberCompanyDepartmentDto;

public class AdminPage2Action implements Action{
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false); // false: 세션 없으면 null 반환

		if (session == null || session.getAttribute("memberIdx") == null) {
        	response.setContentType("text/html; charset=UTF-8");
        	response.setCharacterEncoding("UTF-8");
        	PrintWriter out = response.getWriter();
            out.println("<script>");
            out.println("alert('로그인이 필요합니다.');");
            out.println("location.href='Controller?command=Login';");
            out.println("</script>");
            out.close();
            return; // 더 이상 실행 안 하고 종료
        }
//		int companyIdx = Integer.parseInt(request.getParameter("companyIdx"));
		int companyIdx = 0;
		//companyIdx = Integer.parseInt(request.getParameter("companyIdx"));
		companyIdx = (int)session.getAttribute("companyIdx");
		int memberIdx = 0;
//		memberIdx = Integer.parseInt(request.getParameter("memberIdx"));
		memberIdx = (int)session.getAttribute("memberIdx");
		MemberDao dao = new MemberDao();
		ArrayList<MemberCompanyDepartmentDto> memberInfoList = null;
		try {
			memberInfoList = dao.getAllMembersAvailable(companyIdx);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		ArrayList<MemberCompanyDepartmentDto> stopUseMemberList = null;
		try {
			stopUseMemberList = dao.getStopUseMember(companyIdx);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		ArrayList<MemberCompanyDepartmentDto> waitJoinStateMemberList = null;
		try {
			waitJoinStateMemberList = dao.getWaitJoinStateMember(companyIdx);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		request.setAttribute("companyIdx", companyIdx);
		request.setAttribute("memberIdx", memberIdx);
		request.setAttribute("memberInfoList", memberInfoList);
		request.setAttribute("stopUseMemberList", stopUseMemberList);
		request.setAttribute("waitJoinStateMemberList", waitJoinStateMemberList);
		request.getRequestDispatcher("flow_admin2.jsp").forward(request, response);
	}
}