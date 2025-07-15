package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.LiveAlarmDao;
import dao.LoginOrJoinDao;
import dao.ProjectDao;
import dto.ProjectMemberListDto;

/**
 * Servlet implementation class AccountUser
 */
@WebServlet("/AccountUser")
public class AccountUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(); 
		request.setCharacterEncoding("UTF-8");
		String email = request.getParameter("email");
		String name = request.getParameter("name");
		String password = request.getParameter("password");
		String check = request.getParameter("check2");
		int companyIdx = (Integer) session.getAttribute("companyIdx");
		LoginOrJoinDao dao = new LoginOrJoinDao();
		if (check == null) {
			check = "N";
		}
		int memberIdx = 0;
		try {
			memberIdx = dao.CreateMemberIdx();
			dao.waitStateMemberINSERT(companyIdx, name, email, password, check);
			dao.ProjectFolderAccount(memberIdx, "마케팅");
			dao.ProjectFolderAccount(memberIdx, "디자인");
			dao.ProjectFolderAccount(memberIdx, "엔지니어링");
			dao.DashBoardAccount(memberIdx, 2, 0);
			dao.DashBoardAccount(memberIdx, 3, 1);
			dao.DashBoardAccount(memberIdx, 13, 0);
			dao.ViewSettingAccount(memberIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		LiveAlarmDao laDao = new LiveAlarmDao();
		ProjectDao pDao = new ProjectDao();
		ArrayList<ProjectMemberListDto> pmList = new ArrayList<ProjectMemberListDto>();
		try {
			pmList = pDao.getProjectMemberList(companyIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		for(ProjectMemberListDto dto : pmList) {
			try {
				laDao.addLiveAlarm(dto.getMemberIdx(), "가입요청", name+"님의 가입 요청", name+"님의 가입 요청을 요청하였습니다.", companyIdx, null, null, 'N', 'Y', 'N', memberIdx);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		response.sendRedirect("Controller?command=Login");
		
	}

}
