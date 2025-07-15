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
import dao.ProjectDao;
import dto.ChatRoomListDto;
import dto.CompanyDto;
import dto.CompanyNameDto;
import dto.CompanyPublicProjectDto;
import dto.LastActivityProjectDto;
import dto.LiveAlarmDto;
import dto.MemberDto;
import dto.MyProjectViewDto;
import dto.OnlyMemberDto;
import dto.dto.ProjectUserFolder;

public class PublicProjectAction implements Action {
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

		int memberIdx = (int) session.getAttribute("memberIdx");
		int companyIdx = (int) session.getAttribute("companyIdx");
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
			try {
				MPlist = pdao.MyProjectSearch(memberIdx);
				Olist = dao.OutSiderMember(companyIdx, memberIdx);
				CMlist = dao.CompanyMember(companyIdx);
				Clist = cdao.ChatRoomList(memberIdx,"");
			} catch (Exception e1) {
				e1.printStackTrace();
			}
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
			request.setAttribute("readCount", readCount);
			request.setAttribute("list", list);
			request.setAttribute("Olist", Olist);
			request.setAttribute("CMlist", CMlist);
			request.setAttribute("Clist", Clist);
			request.setAttribute("memberIdx", memberIdx);
			request.setAttribute("companyIdx", companyIdx);
			request.setAttribute("MPlist", MPlist);
			request.setAttribute("colornum", colornum);
		ProjectDao pDao = new ProjectDao();
		// 공개프로젝트리스트
		ArrayList<CompanyPublicProjectDto> publicProjectList = null;
		try {
			publicProjectList = pDao.getPublicProjectList(memberIdx, "");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		request.setAttribute("publicProjectList", publicProjectList);
		request.setAttribute("publicProjectListSize", publicProjectList.size());

		// 카테고리종류리스트
		ArrayList<String> categoryList = null;
		try {
			categoryList = pDao.getProjectCategoryList(memberIdx);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		request.setAttribute("categoryList", categoryList);

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

		// 실시간알림
		LiveAlarmDao lADao = new LiveAlarmDao();
		ArrayList<LiveAlarmDto> alarmList = new ArrayList<LiveAlarmDto>();
		try {
			alarmList = lADao.getLiveAlarmSearchList(memberIdx, 'N', "");
		} catch (Exception e) {
		}
		request.setAttribute("alarmList", alarmList);

		int notReadAlarmCnt = -1;
		try {
			notReadAlarmCnt = lADao.getNotReadAlarmCnt(memberIdx);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		request.setAttribute("notReadAlarmCnt", notReadAlarmCnt);

		// 현재 유저 정보 가져오기
		MemberDao mDao = new MemberDao();
		OnlyMemberDto memberInfo = null;
		try {
			memberInfo = mDao.getMemberInfoAll(memberIdx);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		request.setAttribute("memberInfo", memberInfo);

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
		request.setAttribute("PUFlist", PUFlist);

		request.getRequestDispatcher("companyPublicProject.jsp").forward(request, response);
	}
}