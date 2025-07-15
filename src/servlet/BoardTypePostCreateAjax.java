package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import dao.BoardALLDao;
import dao.LiveAlarmDao;
import dao.MemberDao;
import dao.ProjectALLDao;
import dao.ProjectAlarmDao;
import dao.ProjectDao;
import dto.BoardPostViewDto;
import dto.MemberCompanyDepartmentDto;
import dto.ProjectMemberListDto;
import dto.ProjectsDto;


@WebServlet("/BoardTypePostCreateAjax")
public class BoardTypePostCreateAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String category = request.getParameter("category");
		int memberIdx = Integer.parseInt(request.getParameter("memberIdx"));
		int projectIdx = Integer.parseInt(request.getParameter("projectIdx"));
		char Release = request.getParameter("Release").charAt(0);
		char temporary = request.getParameter("temporary").charAt(0);
		BoardALLDao bdao = new BoardALLDao();
		 ProjectALLDao pdao = new ProjectALLDao();
		 int boardIdx = 0;
	        try {
	            boardIdx = bdao.boardIdxsearch();
	        } catch (Exception e1) {
	            e1.printStackTrace();
	        }
		 try {
			bdao.WriteBoardBasicText(memberIdx,projectIdx, title, content, category, temporary, Release);
		} catch (Exception e) {
			e.printStackTrace();
		}
		try {
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
				laDao.addLiveAlarm(dto.getMemberIdx(), projectInfo.getpName(), memberInfo.getName()+"님의 글 등록", projectInfo.getpName(), null, boardIdx, null, 'N', 'Y', 'N', memberIdx);
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
			padao.setProjectAlarmCommentWrite(projectIdx, memberIdx, "글", title, memberInfo.getName(),"작성");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
