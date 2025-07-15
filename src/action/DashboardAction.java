package action;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.ChattingDao;
import dao.CompanyDao;
import dao.DashDao;
import dao.DepartmentDao;
import dao.LiveAlarmDao;
import dao.LoginOrJoinDao;
import dao.MemberDao;
import dao.ProjectALLDao;
import dto.ChatRoomListDto;
import dto.CompanyDto;
import dto.CompanyNameDto;
import dto.DashboardDto;
import dto.GoToDto;
import dto.LiveAlarmDto;
import dto.MemberDto;
import dto.MyProjectViewDto;
import dto.OnlyMemberDto;
import dto.RequestTaskDto;
import dto.dto.ProjectUserFolder;

public class DashboardAction implements Action {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MemberDao dao = new MemberDao();
		DashDao Ddao = new DashDao();
		ProjectALLDao pdao = new ProjectALLDao();
		ChattingDao cdao = new ChattingDao();
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
		MemberDto mdto = null;
		ArrayList<MemberDto> list = null;
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
		String name = mdto.getName();
		String StateMessage = mdto.getStatusMessage();
		int idx = mdto.getMemberIdx();
		int companyIdx = mdto.getCompanyIdx();
		String profile = mdto.getProfileImg();
		ArrayList<GoToDto> GoToList = null;
		try {
			list = dao.ChatMember(companyIdx, memberIdx, "");
			GoToList = Ddao.GoToList(companyIdx);
		} catch (Exception e3) {
			e3.printStackTrace();
		}
		int readCount = 0;
		try {
			readCount = cdao.NotReadALLCheck(idx);
		} catch (Exception e2) {
			e2.printStackTrace();
		}
		ArrayList<ChatRoomListDto> Clist = null;
		try {
			Clist = cdao.ChatRoomList(idx,"");
		} catch (Exception e) {
			e.printStackTrace();
		}
		ArrayList<MemberDto> Olist = null;
		ArrayList<MemberDto> CMlist = null;
		try {
			Olist = dao.OutSiderMember(companyIdx, idx);
			CMlist = dao.CompanyMember(companyIdx);
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		try {
			list = dao.ChatMember(companyIdx, idx,"");
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(StateMessage==null){
			StateMessage = "";
		}
		Date now = new Date(); 
		String hour = "";
		SimpleDateFormat df = new SimpleDateFormat("yyyy년 MM월 dd일 ", Locale.KOREA);
		String today = df.format(now);
		Calendar calendar = Calendar.getInstance();
	    int hours = calendar.get(Calendar.HOUR_OF_DAY);
	    String timeOfDay = (hours < 12) ? "오전" : "오후";
	    SimpleDateFormat sdf = new SimpleDateFormat("EEEE",Locale.KOREA);
	    String dayOfWeek = sdf.format(calendar.getTime());
	    ArrayList<MyProjectViewDto> Mlist = null;
	    try {
			Mlist = pdao.MyProjectView(idx,0,0);
		} catch (Exception e) {
			e.printStackTrace();
		}
	    ArrayList<DashboardDto> Dlist = null;
	    try {
			Dlist = Ddao.showDashboardWidget(idx);
		} catch (Exception e) {
			e.printStackTrace();
		}
	    ArrayList<RequestTaskDto> Rlist1 = null;
	    ArrayList<RequestTaskDto> Rlist2 = null;
	    try {
			Rlist1 = Ddao.requestlist(0, idx);
			Rlist2 = Ddao.requestlist(1, idx);
		} catch (Exception e) {
			e.printStackTrace();
		}
	    int requestCount1 = 0;
	    int requestCount2 = 0;
	    try {
			requestCount1 = Ddao.requestCount(0, idx);
			requestCount2 = Ddao.requestCount(1, idx);
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
		LoginOrJoinDao LJdao = new LoginOrJoinDao();
		CompanyNameDto Cdto = null;
		try {
			Cdto = LJdao.CompanyName(companyIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		String hometab = mdto.getHometabSetting();
		request.setAttribute("colornum", colornum);
		request.setAttribute("hometab", hometab);
		request.setAttribute("companyLogo", Cdto.getLogo());
		request.setAttribute("alarmList", alarmList);
		request.setAttribute("notReadAlarmCnt", notReadAlarmCnt);
		request.setAttribute("memberInfo", memberInfo);
		request.setAttribute("companyInfo", companyInfo);
		request.setAttribute("departmentName", departmentName);
	    request.setAttribute("PUFlist", PUFlist);
	    request.setAttribute("MPlist", MPlist);
	    request.setAttribute("Rlist1", Rlist1);
	    request.setAttribute("Rlist2", Rlist2);
	    request.setAttribute("requestCount1", requestCount1);
	    request.setAttribute("requestCount2", requestCount2);
		request.setAttribute("name", name);
		request.setAttribute("readCount", readCount);
		request.setAttribute("memberIdx", idx);
		request.setAttribute("StateMessage", StateMessage);
		request.setAttribute("profile", profile);
		request.setAttribute("hour", hour);
		request.setAttribute("today", today);
		request.setAttribute("timeOfDay", timeOfDay);
		request.setAttribute("dayOfWeek", dayOfWeek);
		request.setAttribute("list", list);
		request.setAttribute("Mlist", Mlist);
		request.setAttribute("Dlist", Dlist);
		request.setAttribute("Clist", Clist);
		request.setAttribute("Olist", Olist);
		request.setAttribute("CMlist", CMlist);
		request.setAttribute("GoToList", GoToList);
		request.setAttribute("companyIdx", companyIdx);
		RequestDispatcher rd = request.getRequestDispatcher("Dashboard.jsp");
		rd.forward(request, response);
	}
}
