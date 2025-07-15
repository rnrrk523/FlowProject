package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.BoardALLDao;
import dao.LiveAlarmDao;
import dao.MemberDao;
import dao.ProjectALLDao;
import dao.ProjectAlarmDao;
import dao.ProjectDao;
import dto.MemberCompanyDepartmentDto;
import dto.ProjectMemberListDto;
import dto.ProjectsDto;

@WebServlet("/BoardTypePostUpdateAjax")
public class BoardTypePostUpdateAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		char Release = request.getParameter("Release").charAt(0);
		int boardIdx = Integer.parseInt(request.getParameter("boardIdx"));
		int memberIdx = Integer.parseInt(request.getParameter("memberIdx"));
		BoardALLDao dao = new BoardALLDao();
		ProjectALLDao pdao = new ProjectALLDao();
		int projectIdx = 0;
		try {
			dao.boardUpdate(boardIdx, title, content, Release);
			projectIdx = dao.ProjectIdxSearch(boardIdx);
			pdao.ProjectUpdate(projectIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
//		실시간알림테이블 INSERT
		LiveAlarmDao laDao = new LiveAlarmDao();
		
		ProjectDao pDao = new ProjectDao();
		ArrayList<ProjectMemberListDto> pmList = new ArrayList<ProjectMemberListDto>();
		try {
			pmList = pDao.getProjectMemberList(projectIdx);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		ProjectsDto projectInfo = null;
		try {
			projectInfo = pDao.getProjectSimpleInfo(projectIdx);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		MemberDao mDao = new MemberDao();
		MemberCompanyDepartmentDto memberInfo = null;
		try {
			memberInfo = mDao.getMemberInfo(memberIdx);
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		for(ProjectMemberListDto dto : pmList) {
			try {
				laDao.addLiveAlarm(dto.getMemberIdx(), projectInfo.getpName(), memberInfo.getName()+"님의 글 수정", projectInfo.getpName(), null, boardIdx, null, 'N', 'Y', 'N', memberIdx);
			// laDao.addLiveAlarm( memberIdx,          title, 				   simpleContent, 					 fullContent, 		companyIdx, boardIdx, commentIdx, mentionMeYN, myBoardYN, workYN, writerIdx);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
      try {
			pdao.ProjectUpdate(projectIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
      ProjectAlarmDao padao = new ProjectAlarmDao();
      try {
		padao.setProjectAlarmCommentWrite(projectIdx, memberIdx, "글", title, memberInfo.getName(),"수정");
	} catch (Exception e) {
		e.printStackTrace();
	}
	}

}
