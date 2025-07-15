package action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.MemberDao;
import dao.ProjectDao;
import dto.DelProjectDto;
import dto.MemberCompanyDepartmentDto;
import dto.ProjectAdminDto2;
import dto.ProjectsDto;
import jstl.ProjectAdminInfo;
import jstl.ProjectInfo;

public class AdminPage6Action implements Action{
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
		int companyIdx = (int)session.getAttribute("companyIdx");
		int memberIdx = (int)session.getAttribute("memberIdx");
		
		ProjectDao pDao = new ProjectDao();
		MemberDao mDao = new MemberDao();
		
		ArrayList<ProjectsDto> projectList = null;
		try {
			projectList = pDao.getProjectInfo(companyIdx);
		} catch (Exception e) {
			System.out.println("실패1");
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		ArrayList<ProjectInfo> projectInfoList = new ArrayList<ProjectInfo>();

	        for (ProjectsDto dto : projectList) {
	            ArrayList<ProjectAdminDto2> adminList = null;
	            try {
					adminList = pDao.getProjectAdminInfo(companyIdx, dto.getpIdx());
				} catch (Exception e) {
					System.out.println("실패2");
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	            
	            int adminCnt = adminList.size();
	            String adminName = adminCnt > 0 ? adminList.get(0).getName() : "";
	            
	            int memberCnt = 0;
				try {
					memberCnt = pDao.getEmployeeCnt(companyIdx, dto.getpIdx());
				} catch (Exception e) {
					System.out.println("실패3");
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	            int outsiderCnt = 0;
				try {
					outsiderCnt = pDao.getOutsiderCnt(companyIdx, dto.getpIdx());
				} catch (Exception e) {
					System.out.println("실패4");
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	            int commentCnt = 0;
				try {
					commentCnt = pDao.getCommentCnt(companyIdx, dto.getpIdx());
				} catch (Exception e) {
					System.out.println("실패5");
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	            int chatCnt = 0;
				try {
					chatCnt = pDao.getChatCnt(companyIdx, dto.getpIdx());
				} catch (Exception e) {
					System.out.println("실패6");
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	            int scheduleCnt = 0;
				try {
					scheduleCnt = pDao.getScheduleCnt(companyIdx, dto.getpIdx());
				} catch (Exception e) {
					System.out.println("실패7");
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	            int taskCnt = 0;
				try {
					taskCnt = pDao.getTaskCnt(companyIdx, dto.getpIdx());
				} catch (Exception e) {
					System.out.println("실패8");
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	            int boardCnt = 0;
				try {
					boardCnt = pDao.getBoardCnt(companyIdx, dto.getpIdx());
				} catch (Exception e) {
					System.out.println("실패9");
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

	            ProjectInfo projectInfo = new ProjectInfo(dto.getpIdx(), adminCnt, adminName, memberCnt, outsiderCnt, commentCnt, chatCnt, scheduleCnt, taskCnt, boardCnt, dto.getLastActivity(), dto.getOpeningDate());
	            projectInfo.setProjectIdx(dto.getpIdx());
	            projectInfo.setAdminCnt(adminCnt);
	            projectInfo.setAdminName(adminName);
	            projectInfo.setMemberCnt(memberCnt);
	            projectInfo.setOutsiderCnt(outsiderCnt);
	            projectInfo.setCommentCnt(commentCnt);
	            projectInfo.setChatCnt(chatCnt);
	            projectInfo.setScheduleCnt(scheduleCnt);
	            projectInfo.setTaskCnt(taskCnt);
	            projectInfo.setBoardCnt(boardCnt);
	            projectInfo.setLastActivity(dto.getLastActivity());
	            projectInfo.setOpeningDate(dto.getOpeningDate());

	            projectInfoList.add(projectInfo);
	        }
		
		ArrayList<DelProjectDto> delProjectList = null;
		try {
			delProjectList = pDao.getDelProjects(companyIdx);
		} catch (Exception e) {
			System.out.println("실패10");
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		ArrayList<ProjectAdminInfo> projectAdminInfoList = new ArrayList<ProjectAdminInfo>();
        for (DelProjectDto dto : delProjectList) {
            ArrayList<ProjectAdminDto2> adminList = null;
            try {
				adminList = pDao.getProjectAdminInfo(companyIdx, dto.getProjectIdx());
			} catch (Exception e1) {
				System.out.println("실패11");
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
            int adminCnt = adminList.size();
            String adminName = adminCnt > 0 ? adminList.get(0).getName() : "";
            
            MemberCompanyDepartmentDto memberInfo = null;
            try {
				memberInfo = mDao.getMemberInfo(dto.getDelMemberIdx());
			} catch (Exception e) {
				System.out.println("실패12");
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

            ProjectAdminInfo projectAdminInfo = new ProjectAdminInfo(dto.getProjectIdx(), adminCnt, adminName, memberInfo);
            projectAdminInfo.setProjectIdx(dto.getProjectIdx());
            projectAdminInfo.setAdminCnt(adminCnt);
            projectAdminInfo.setAdminName(adminName);
            projectAdminInfo.setMemberInfo(memberInfo);

            projectAdminInfoList.add(projectAdminInfo);
        }
		
		request.setAttribute("companyIdx", companyIdx);
		request.setAttribute("memberIdx", memberIdx);
		
		request.setAttribute("projectList", projectList);
		request.setAttribute("projectInfoList", projectInfoList);
		
		request.setAttribute("delProjectList", delProjectList);
		request.setAttribute("projectAdminInfoList", projectAdminInfoList);
		
		request.getRequestDispatcher("flow_admin6.jsp").forward(request, response);
	}
}