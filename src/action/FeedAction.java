package action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.BoardALLDao;
import dao.ChattingDao;
import dao.CompanyDao;
import dao.DepartmentDao;
import dao.LiveAlarmDao;
import dao.LoginOrJoinDao;
import dao.MemberDao;
import dao.ProjectALLDao;
import dao.ProjectDao;
import dao.TaskALLDao;
import dto.ChatRoomListDto;
import dto.CompanyDto;
import dto.CompanyNameDto;
import dto.LiveAlarmDto;
import dto.MemberDto;
import dto.MyProjectViewDto;
import dto.OnlyMemberDto;
import dto.ProjectMemberListDto;
import dto.ProjectMemberViewDto;
import dto.ProjectViewProjecIdxDto;
import dto.dto.ProjectUserFolder;



public class FeedAction implements Action {
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
		request.setCharacterEncoding("UTF-8");
		int memberIdx = (Integer)session.getAttribute("memberIdx");
		MemberDao dao = new MemberDao();
		ProjectALLDao pdao = new ProjectALLDao();
		BoardALLDao bdao = new BoardALLDao();
		TaskALLDao tdao = new TaskALLDao();
		ChattingDao cdao = new ChattingDao();
		
		
		int ProjectIdx = 1;
		try { 
			ProjectIdx = Integer.parseInt(request.getParameter("projectIdx"));
		} catch(NumberFormatException e) { }
		ProjectViewProjecIdxDto pdto = null;
		try {
			pdto = pdao.ProjectViewProjecIdx(ProjectIdx);
		} catch (Exception e2) {
			e2.printStackTrace();
		}
		int projectmember = 0;
		ArrayList<MemberDto> Mlist = null;
		MemberDto mdto = null;
		try {
			mdto = dao.GetMyProfile(memberIdx);
		} catch (Exception e2) {
			e2.printStackTrace();
		}
		String name = "";
		String StateMessage = "";
		int idx = 0;
		char colorfix='N';
		String profile = "";
		int companyIdx = 0;
		profile = mdto.getProfileImg();
		name = mdto.getName();
		StateMessage = mdto.getStatusMessage();
		idx = mdto.getMemberIdx();
		colorfix = mdto.getProjectColorFix();
		companyIdx = mdto.getCompanyIdx();
		int readCount = 0;
		try {
			readCount = cdao.NotReadALLCheck(idx);
		} catch (Exception e2) {
			e2.printStackTrace();
		}
		ArrayList<MemberDto> Olist = null;
		ArrayList<MemberDto> CMlist = null;
		try {
			Olist = dao.OutSiderMember(companyIdx, idx);
			CMlist = dao.CompanyMember(companyIdx);
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		ArrayList<ChatRoomListDto> Clist = null;
		try {
			Clist = cdao.ChatRoomList(idx,"");
		} catch (Exception e) {
			e.printStackTrace();
		}
		try {
			Mlist = dao.ChatMember(companyIdx, idx,"");
		} catch (Exception e) {
			e.printStackTrace();
		}
		int colornum = 0;
		if(colorfix=='Y') {
			colornum = 1;
		} else {
			colornum = 0;
		}
		try {
			projectmember = pdao.ProjectParticipantsNum(ProjectIdx);
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		int projectadminmember = 0;
		int projectNoNadminmember = 0;
		int projectOutsidermember = 0;
		try {
			projectadminmember = pdao.ProjectAdminCount(ProjectIdx,pdto.getCompanyIdx(),1);
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		try {
			projectNoNadminmember = pdao.ProjectAdminCount(ProjectIdx,pdto.getCompanyIdx(),2);
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		try {
			projectOutsidermember = pdao.ProjectAdminCount(ProjectIdx,pdto.getCompanyIdx(),3);
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		int projectColor = 0;
		try {
			projectColor = pdao.ProjectMemberColorView(idx, ProjectIdx);
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		ArrayList<MemberDto> Mlist1 = null;
		try {
			Mlist1 = dao.GetProjectMemberProfile(ProjectIdx, 1, companyIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		ArrayList<MemberDto> Mlist2 = null;
		try {
			Mlist2 = dao.GetProjectMemberProfile(ProjectIdx, 2, companyIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		ArrayList<MemberDto> Mlist3 = null;
		try {
			Mlist3 = dao.GetProjectMemberProfile(ProjectIdx, 3, companyIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		ProjectViewProjecIdxDto pvdto = null;
		try {
			pvdto = pdao.ProjectViewProjecIdx(ProjectIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		ArrayList<ProjectMemberViewDto> PAlist = null;
		try {
			PAlist = pdao.participantselect(ProjectIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		ProjectViewProjecIdxDto PVPdto = null;
		try {
			PVPdto = pdao.ProjectViewProjecIdx(ProjectIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		ProjectMemberViewDto PMdto2 = null;
		try {
			PMdto2 = pdao.participantselectMY(ProjectIdx,idx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		ArrayList<ProjectMemberListDto> pmList = null;
		try {
			pmList = pdao.getProjectMemberList(ProjectIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		ArrayList<MyProjectViewDto> MPlist = null;
	    try {
			MPlist = pdao.MyProjectSearch(idx);
		} catch (Exception e) {
			e.printStackTrace();
		}
	    ArrayList<ProjectUserFolder> PUFlist = null;
	    try {
			PUFlist = pdao.ProjectUserFolderList(idx);
		} catch (Exception e) {
			e.printStackTrace();
		}
 // 현재 유저 정보 가져오기
 		MemberDao mDao = new MemberDao();
 		OnlyMemberDto memberInfo = null;
 		try {
 			memberInfo = mDao.getMemberInfoAll(memberIdx);
 		} catch (Exception e) {
 			e.printStackTrace();
 		}
 // 회사정보
 		CompanyDao cDao = new CompanyDao();
 		CompanyDto companyInfo = null;
 		try {
 			companyInfo = cDao.getCompanyInfo(companyIdx);
 		} catch (Exception e2) {
 			e2.printStackTrace();
 		}
 // 부서명 가져오기
 		DepartmentDao dDao = new DepartmentDao();
 		String departmentName = null;
 		try {
 			departmentName = dDao.getDepartmentName(memberInfo.getDepartmentIdx());
 		} catch (Exception e) {
 			e.printStackTrace();
 		}
 		LiveAlarmDao lADao = new LiveAlarmDao();
 		int notReadAlarmCnt = -1;
 		try {
 			notReadAlarmCnt = lADao.getNotReadAlarmCnt(memberIdx);
 		} catch (Exception e) {
 			// TODO Auto-generated catch block
 			e.printStackTrace();
 		}
 		ArrayList<LiveAlarmDto> alarmList = new ArrayList<LiveAlarmDto>();
 		try {
 			alarmList = lADao.getLiveAlarmSearchList(memberIdx, 'N', "");
 		} catch(Exception e) {}
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
 		request.setAttribute("adminMy", adminMy + "");
 		request.setAttribute("alarmList", alarmList);
 		request.setAttribute("notReadAlarmCnt", notReadAlarmCnt);
 		request.setAttribute("memberInfo", memberInfo);
 		request.setAttribute("companyInfo", companyInfo);
 		request.setAttribute("departmentName", departmentName);
	    request.setAttribute("PUFlist", PUFlist);
	    request.setAttribute("MPlist", MPlist);
		request.setAttribute("projectIdx", ProjectIdx);
		request.setAttribute("name", name);
		request.setAttribute("readCount", readCount);
		request.setAttribute("memberIdx", idx);
		request.setAttribute("profile", profile);
		request.setAttribute("colornum", colornum);
		request.setAttribute("StateMessage", StateMessage);
		request.setAttribute("projectmember", projectmember);
		request.setAttribute("Mlist", Mlist);
		request.setAttribute("projectOutsidermember", projectOutsidermember);
		request.setAttribute("projectNoNadminmember", projectNoNadminmember);
		request.setAttribute("projectadminmember", projectadminmember);
		request.setAttribute("projectColor", projectColor);
		request.setAttribute("Mlist", Mlist);
		request.setAttribute("Mlist1", Mlist1);
		request.setAttribute("Mlist2", Mlist2);
		request.setAttribute("Mlist3", Mlist3);
		request.setAttribute("pmList", pmList);
		request.setAttribute("Clist", Clist);
		request.setAttribute("pvdto", pvdto);
		request.setAttribute("PAlist", PAlist);
		request.setAttribute("PVPdto", PVPdto);
		request.setAttribute("PMdto2", PMdto2);
		request.setAttribute("pdto", pdto);
		request.setAttribute("Olist", Olist);
		request.setAttribute("CMlist", CMlist);
		request.setAttribute("companyIdx", companyIdx);
		
		RequestDispatcher rd = request.getRequestDispatcher("FEED.jsp");
		rd.forward(request, response);
	}
}
