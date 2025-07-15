package action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
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
import dto.ChatRoomListDto;
import dto.CompanyDto;
import dto.CompanyNameDto;
import dto.LiveAlarmDto;
import dto.MemberDto;
import dto.MyProjectViewDto;
import dto.OnlyMemberDto;
import dto.dto.ProjectUserFolder;

public class ProjectFolderAction implements Action {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false); 
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
		ChattingDao cdao = new ChattingDao();
		ProjectALLDao pdao = new ProjectALLDao();
		int folderIdx = 1;
		folderIdx = Integer.parseInt(request.getParameter("folderIdx"));
		MemberDto mdto = null;
		ArrayList<MemberDto> list = null;
		try {
			mdto = dao.GetMyProfile(memberIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		String name = "";
		String StateMessage = "";
		char colorfix='N';
		int companyIdx = 0;
		name = mdto.getName();
		StateMessage = mdto.getStatusMessage();
		colorfix = mdto.getProjectColorFix();
		companyIdx = mdto.getCompanyIdx();
		int readCount = 0;
		try {
			readCount = cdao.NotReadALLCheck(memberIdx);
		} catch (Exception e2) {
			e2.printStackTrace();
		}
		try {
			list = dao.ChatMember(companyIdx, memberIdx,"");
		} catch (Exception e) {
			e.printStackTrace();
		}
		ArrayList<MemberDto> Olist = null;
		ArrayList<MemberDto> CMlist = null;
		try {
			Olist = dao.OutSiderMember(companyIdx, memberIdx);
			CMlist = dao.CompanyMember(companyIdx);
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		ArrayList<ChatRoomListDto> Clist = null;
		try {
			Clist = cdao.ChatRoomList(memberIdx,"");
		} catch (Exception e) {
			e.printStackTrace();
		}
		int colornum = 0;
		if(colorfix=='Y') {
			colornum = 1;
		} else {
			colornum = 0;
		}
		int a = 0;
		int b = 0;
		ArrayList<MyProjectViewDto> MPlist = null;
	    try {
			MPlist = pdao.MyProjectSearch(memberIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
	    ArrayList<ProjectUserFolder> PUFlist = null;
	    try {
			PUFlist = pdao.ProjectUserFolderList(memberIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
	    ProjectUserFolder pufdto = null;
	    int folderCount = 0;
	    try {
			pufdto = pdao.ProjectUserFolderOne(folderIdx);
			folderCount = pdao.ProjectFolderCount(folderIdx);
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
			request.setAttribute("hometab", hometab);
			request.setAttribute("companyLogo", Cdto.getLogo());
	 		request.setAttribute("alarmList", alarmList);
	 		request.setAttribute("notReadAlarmCnt", notReadAlarmCnt);
	 		request.setAttribute("memberInfo", memberInfo);
	 		request.setAttribute("companyInfo", companyInfo);
	 		request.setAttribute("departmentName", departmentName);
	    request.setAttribute("folderCount", folderCount);
	    request.setAttribute("folderName", pufdto.getName());
	    request.setAttribute("folderIdx", folderIdx);
	    request.setAttribute("PUFlist", PUFlist);
	    request.setAttribute("MPlist", MPlist);
		request.setAttribute("name", name);
		request.setAttribute("memberIdx", memberIdx);
		request.setAttribute("readCount", readCount);
		request.setAttribute("colornum", colornum);
		request.setAttribute("StateMessage", StateMessage);
		request.setAttribute("companyIdx", companyIdx);
		request.setAttribute("list", list);
		request.setAttribute("Clist", Clist);
		request.setAttribute("Olist", Olist);
		request.setAttribute("CMlist", CMlist);
		request.setAttribute("a", a);
		request.setAttribute("b", b);
		
		RequestDispatcher rd = request.getRequestDispatcher("ProjectFolder.jsp");
		rd.forward(request, response);
	}
}
