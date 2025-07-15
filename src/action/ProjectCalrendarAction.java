package action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

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
import dao.ProjectCalendarDao;
import dao.ProjectDao;
import dao.ScheduleDao;
import dto.ChatRoomListDto;
import dto.CompanyDto;
import dto.CompanyNameDto;
import dto.LastActivityProjectDto;
import dto.LiveAlarmDto;
import dto.MemberDto;
import dto.MyProjectViewDto;
import dto.OnlyMemberDto;
import dto.ProjectAlarmListDto;
import dto.ProjectColorDto;
import dto.ProjectMemberListDto;
import dto.ProjectMemberViewDto;
import dto.ProjectViewProjecIdxDto;
import dto.ScheduleCalendarDto;
import dto.TaskCalendarDto;
import dto.dto.ProjectUserFolder;

public class ProjectCalrendarAction implements Action{
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
		String scheduleStandard = null;
		try {
			scheduleStandard = request.getParameter("schedule-filter");
		} catch(Exception e) {}
		
		String taskStandard = null;
		try {
			taskStandard = request.getParameter("task-filter");
		} catch(Exception e) {}
		
		String str = null;
		try {
			str = request.getParameter("schedule_name");
		} catch(Exception e) {}
		
		scheduleStandard = scheduleStandard == null ? "전체" : request.getParameter("schedule-filter");
		taskStandard = taskStandard == null ? "선택안함" : request.getParameter("task-filter");
		str = str == null ? "" : request.getParameter("schedule_name");
		
//		scheduleStandard = (String)request.getAttribute("scheduleStandard") == null ? "전체" : (String)request.getAttribute("scheduleStandard");
//		taskStandard = (String)request.getAttribute("taskStandard") == null ? "선택안함" : (String)request.getAttribute("taskStandard");
//		str = (String)request.getAttribute("str") == null ? "" : (String)request.getAttribute("str");
		
		ArrayList<ScheduleCalendarDto> scheduleList = new ArrayList<ScheduleCalendarDto>();
		ScheduleDao sDao = new ScheduleDao();
		try {
			scheduleList = sDao.getProjectCalendar(projectIdx, memberIdx, scheduleStandard, str);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		ProjectCalendarDao pcDao = new ProjectCalendarDao();
		ArrayList<TaskCalendarDto> taskList = new ArrayList<TaskCalendarDto>();
		try {
			taskList = pcDao.getTaskCalendarList(projectIdx, memberIdx, taskStandard, str);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
		// 왼쪽 사이드바 필터 상태 받기
//		ArrayList<ScheduleCalendarDto> scheduleList = null;
//		try {
//			scheduleList = (ArrayList<ScheduleCalendarDto>)request.getAttribute("scheduleList");
//		} catch(Exception e) {}
//		ArrayList<TaskCalendarDto> taskList = null;
//		try {
//			taskList = (ArrayList<TaskCalendarDto>)request.getAttribute("taskList");
//		} catch(Exception e) {}
		
		// 받은게 없을 시
		if(scheduleList == null) {
			try {
				scheduleList = sDao.getProjectCalendar(projectIdx, memberIdx, "전체", "");
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		if(taskList == null) {
			try {
				taskList = pcDao.getTaskCalendarList(projectIdx, memberIdx, "선택안함", "");
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		// 현재 유저 정보 가져오기
		MemberDao mDao = new MemberDao();
		OnlyMemberDto memberInfo = null;
		try {
			memberInfo = mDao.getMemberInfoAll(memberIdx);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		// 프로젝트 컬러와 이름 가져오기
		ProjectDao pDao = new ProjectDao();
		ArrayList<ProjectColorDto> projectList = new ArrayList<ProjectColorDto>();
		try {
			projectList = pDao.getProjectColor(companyIdx, memberIdx);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		int writeProjectIdx = projectIdx;
		String projectName = "";
		String projectColor = "";
		for(ProjectColorDto dto : projectList){
			if(projectIdx == dto.getProjectIdx()) {
				projectName = dto.getProjectName();
				projectColor = dto.getColorCode();
			}
		}
		
		ArrayList<ProjectMemberListDto> pmList = new ArrayList<ProjectMemberListDto>();
		try {
			pmList = pDao.getProjectMemberList(projectIdx);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		// 실시간알림
		LiveAlarmDao lADao = new LiveAlarmDao();
		ArrayList<LiveAlarmDto> alarmList = new ArrayList<LiveAlarmDto>();
		try {
			alarmList = lADao.getLiveAlarmSearchList(memberIdx, 'N', "");
		} catch(Exception e) {}
		request.setAttribute("alarmList", alarmList);
		
		int notReadAlarmCnt = -1;
		try {
			notReadAlarmCnt = lADao.getNotReadAlarmCnt(memberIdx);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		request.setAttribute("notReadAlarmCnt", notReadAlarmCnt);
		
		// 최근업데이트 정보
		ArrayList<LastActivityProjectDto> lastActivityProjectList = null;
		try {
			lastActivityProjectList = pDao.getLastActivityProjectList(memberIdx);
		} catch (Exception e) {
			System.out.println("실패3");
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		request.setAttribute("lastActivityProjectList", lastActivityProjectList);
		
		// 부서명 가져오기
		DepartmentDao dDao = new DepartmentDao();
		String departmentName = null;
		try {
			departmentName = dDao.getDepartmentName(memberInfo.getDepartmentIdx());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		request.setAttribute("departmentName", departmentName);
		
		// 회사정보
		CompanyDao cDao = new CompanyDao();
		CompanyDto companyInfo = null;
		try {
			companyInfo = cDao.getCompanyInfo(companyIdx);
		} catch (Exception e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
		request.setAttribute("companyInfo", companyInfo);
				
		request.setAttribute("memberIdx", memberIdx);
		request.setAttribute("projectIdx", projectIdx);
		request.setAttribute("companyIdx", companyIdx);
		request.setAttribute("scheduleList", scheduleList);
		request.setAttribute("taskList", taskList);
		request.setAttribute("scheduleStandard", scheduleStandard);
		request.setAttribute("taskStandard", taskStandard);
		request.setAttribute("str", str);
		request.setAttribute("projectName", projectName);
		request.setAttribute("projectColor", projectColor);
		request.setAttribute("writeProjectIdx", writeProjectIdx);
		request.setAttribute("projectList", projectList);
		request.setAttribute("memberInfo", memberInfo);
		request.setAttribute("pmList", pmList);
		
		request.getRequestDispatcher("flow_calendar.jsp").forward(request, response);
	}
}