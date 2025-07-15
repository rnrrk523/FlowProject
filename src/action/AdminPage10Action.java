package action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.ProjectDao;
import dto.DeactivProjectDto;
import dto.ProjectAdminDto2;
import jstl.delprojectInfo;

public class AdminPage10Action implements Action{
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
		ArrayList<DeactivProjectDto> deactiveProjectList = null;
		try {
			deactiveProjectList = pDao.getDeactivProject(companyIdx);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		ArrayList<delprojectInfo> delprojectInfoList = new ArrayList<>();
		for (DeactivProjectDto dto : deactiveProjectList) {
            ArrayList<ProjectAdminDto2> adminList = null;
            try {
				adminList = pDao.getProjectAdminInfo(companyIdx, dto.getProjectIdx());
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
            String adminName = adminList.get(0).getName();
            int adminCnt = adminList.size();
            int outsiderCnt = 0;
			try {
				outsiderCnt = pDao.getOutsiderCnt(companyIdx, dto.getProjectIdx());
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
            int taskCnt = 0;
			try {
				taskCnt = pDao.getTaskCnt(companyIdx, dto.getProjectIdx());
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
            int boardCnt = 0;
			try {
				boardCnt = pDao.getBoardCnt(companyIdx, dto.getProjectIdx());
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
            int commentCnt = 0;
			try {
				commentCnt = pDao.getCommentCnt(companyIdx, dto.getProjectIdx());
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

            delprojectInfo delprojectInfo = new delprojectInfo(dto.getProjectIdx(), adminName, adminCnt, outsiderCnt, dto.getWriter(), taskCnt, boardCnt, commentCnt, dto.getLastActivity());
            delprojectInfo.setProjectIdx(dto.getProjectIdx());
            delprojectInfo.setAdminName(adminName);
            delprojectInfo.setAdminCnt(adminCnt);
            delprojectInfo.setOutsiderCnt(outsiderCnt);
            delprojectInfo.setWriter(dto.getWriter());
            delprojectInfo.setTaskCnt(taskCnt);
            delprojectInfo.setBoardCnt(boardCnt);
            delprojectInfo.setCommentCnt(commentCnt);
            delprojectInfo.setLastActivity(dto.getLastActivity());

            delprojectInfoList.add(delprojectInfo);
        }
		
		request.setAttribute("companyIdx", companyIdx);
		request.setAttribute("memberIdx", memberIdx);
		request.setAttribute("deactiveProjectList", deactiveProjectList);
		request.getRequestDispatcher("flow_admin10.jsp").forward(request, response);
	}
}