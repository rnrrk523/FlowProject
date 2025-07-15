package action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.ChattingDao;
import dao.CompanyDao;
import dao.DepartmentDao;
import dao.LiveAlarmDao;
import dao.LoginOrJoinDao;
import dao.MemberDao;
import dao.ProjectALLDao;
import dao.ProjectAlarmDao;
import dao.ProjectDao;
import dto.ChatRoomListDto;
import dto.CompanyDto;
import dto.CompanyNameDto;
import dto.LastActivityProjectDto;
import dto.LiveAlarmDto;
import dto.MemberDto;
import dto.MyProjectViewDto;
import dto.OnlyMemberDto;
import dto.ProjectAlarmListDto;
import dto.ProjectMemberViewDto;
import dto.ProjectViewProjecIdxDto;
import dto.dto.ProjectUserFolder;

public class ProjectAlarmAction implements Action{

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
		int companyIdx = (int)session.getAttribute("companyIdx");
//		int memberIdx = Integer.parseInt(request.getParameter("memberIdx"));
		int memberIdx = (int)session.getAttribute("memberIdx");
		int projectIdx = Integer.parseInt(request.getParameter("projectIdx"));
		MemberDao dao = new MemberDao();
		ProjectALLDao pdao = new ProjectALLDao();
		ChattingDao cdao = new ChattingDao();
		 ArrayList<ProjectUserFolder> PUFlist = null;
		    try {
				PUFlist = pdao.ProjectUserFolderList(memberIdx);
			} catch (Exception e) {
				e.printStackTrace();
			}
		    int readCount = 0;
			try {
				readCount = cdao.NotReadALLCheck(memberIdx);
			} catch (Exception e2) {
				e2.printStackTrace();
			}
			ArrayList<MemberDto> list = null;
			try {
				list = dao.ChatMember(companyIdx, memberIdx,"");
			} catch (Exception e) {
				e.printStackTrace();
			}
			MemberDto mdto = null;
			try {
				mdto = dao.GetMyProfile(memberIdx);
			} catch (Exception e) {
				e.printStackTrace();
			}
			int colornum = 0;
			char colorfix='N';
			colorfix = mdto.getProjectColorFix();
			if(colorfix=='Y') {
				colornum = 1;
			} else {
				colornum = 0;
			}
			ArrayList<MemberDto> Olist = null;
			ArrayList<MemberDto> CMlist = null;
			ArrayList<ChatRoomListDto> Clist = null;
			ArrayList<MyProjectViewDto> MPlist = null;
			ProjectMemberViewDto PMdto2 = null;
			ProjectViewProjecIdxDto pvdto = null;
			ArrayList<MemberDto> Mlist = null;
			int projectColors = 0;
			int projectadminmember = 0;
			int projectNoNadminmember = 0;
			int projectOutsidermember = 0;
			ProjectViewProjecIdxDto pdto = null;
			try {
				pdto = pdao.ProjectViewProjecIdx(projectIdx);
				Mlist = dao.ChatMember(companyIdx, memberIdx,"");
				projectNoNadminmember = pdao.ProjectAdminCount(projectIdx,companyIdx,2);
				projectOutsidermember = pdao.ProjectAdminCount(projectIdx,companyIdx,3);
				projectadminmember = pdao.ProjectAdminCount(projectIdx,companyIdx,1);
				projectColors = pdao.ProjectMemberColorView(memberIdx, projectIdx);
				pvdto = pdao.ProjectViewProjecIdx(projectIdx);
				MPlist = pdao.MyProjectSearch(memberIdx);
				Olist = dao.OutSiderMember(companyIdx, memberIdx);
				CMlist = dao.CompanyMember(companyIdx);
				Clist = cdao.ChatRoomList(memberIdx,"");
				PMdto2 = pdao.participantselectMY(projectIdx,memberIdx);
			} catch (Exception e1) {
				e1.printStackTrace();
			}
			char adminMy = PMdto2.getAdminYN();
			LoginOrJoinDao LJdao = new LoginOrJoinDao();
			CompanyNameDto Cdto = null;
			try {
				Cdto = LJdao.CompanyName(companyIdx);
			} catch (Exception e) {
				e.printStackTrace();
			}
			String hometab = mdto.getHometabSetting();
			request.setAttribute("hometab", hometab);
			request.setAttribute("companyLogo", Cdto.getLogo());
			request.setAttribute("Mlist", Mlist);
			request.setAttribute("projectOutsidermember", projectOutsidermember);
			request.setAttribute("projectNoNadminmember", projectNoNadminmember);
			request.setAttribute("projectadminmember", projectadminmember);
			request.setAttribute("projectColors", projectColors);
			request.setAttribute("PMdto2", PMdto2);
	 		request.setAttribute("adminMy", adminMy + "");
			request.setAttribute("readCount", readCount);
			request.setAttribute("list", list);
			request.setAttribute("Olist", Olist);
			request.setAttribute("CMlist", CMlist);
			request.setAttribute("Clist", Clist);
			request.setAttribute("memberIdx", memberIdx);
			request.setAttribute("companyIdx", companyIdx);
			request.setAttribute("MPlist", MPlist);
			request.setAttribute("colornum", colornum);
			request.setAttribute("PUFlist", PUFlist);
			request.setAttribute("projectIdx", projectIdx);
			request.setAttribute("pvdto", pvdto);
			request.setAttribute("pdto", pdto);
		MemberDao mDao = new MemberDao();
		CompanyDao cDao = new CompanyDao();
		CompanyDto companyInfo = null;
		try {
			companyInfo = cDao.getCompanyInfo(companyIdx);
		} catch (Exception e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
		
		OnlyMemberDto memberInfo = null;
		try {
			memberInfo = mDao.getMemberInfoAll(memberIdx);
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		// 현재시간 가져오기
//		Date now = new Date();
		
		// 실시간알림
		LiveAlarmDao lADao = new LiveAlarmDao();
		ArrayList<LiveAlarmDto> alarmList = new ArrayList<LiveAlarmDto>();
		try {
			alarmList = lADao.getLiveAlarmSearchList(memberIdx, 'N', "");
		} catch(Exception e) {}
		
		ProjectAlarmDao paDao = new ProjectAlarmDao();
		ArrayList<ProjectAlarmListDto> projectAlarmList = new ArrayList<ProjectAlarmListDto>();
		try {
			projectAlarmList = paDao.getProjectAlarmList(projectIdx, "", "전체");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		int notReadAlarmCnt = -1;
		try {
			notReadAlarmCnt = lADao.getNotReadAlarmCnt(memberIdx);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		request.setAttribute("notReadAlarmCnt", notReadAlarmCnt);
		
		// 부서명 가져오기
		DepartmentDao dDao = new DepartmentDao();
		String departmentName = null;
		try {
			departmentName = dDao.getDepartmentName(memberInfo.getDepartmentIdx());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		// 최근업데이트 정보
		ProjectDao pDao = new ProjectDao();
		ArrayList<LastActivityProjectDto> lastActivityProjectList = null;
		try {
			lastActivityProjectList = pDao.getLastActivityProjectList(memberIdx);
		} catch (Exception e) {
			System.out.println("실패3");
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		request.setAttribute("lastActivityProjectList", lastActivityProjectList);
				
		request.setAttribute("memberIdx", memberIdx);
		request.setAttribute("projectIdx", projectIdx);
		request.setAttribute("companyIdx", companyIdx);
		request.setAttribute("companyInfo", companyInfo);
		request.setAttribute("alarmList", alarmList);
		request.setAttribute("projectAlarmList", projectAlarmList);
		request.setAttribute("memberInfo", memberInfo);
		request.setAttribute("departmentName", departmentName);
		
		request.getRequestDispatcher("flow_alarm.jsp").forward(request, response);
	}
}