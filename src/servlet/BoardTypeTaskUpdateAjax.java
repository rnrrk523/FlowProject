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
import dao.TaskALLDao;
import dto.MemberCompanyDepartmentDto;
import dto.ProjectMemberListDto;
import dto.ProjectsDto;

@WebServlet("/BoardTypeTaskUpdateAjax")
public class BoardTypeTaskUpdateAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		String  memberIdxArray[] = request.getParameter("memberValue").split(",");
		char Release = request.getParameter("Release").charAt(0);
		int boardIdx = Integer.parseInt(request.getParameter("boardIdx"));
		int Taskpriority = Integer.parseInt(request.getParameter("Taskpriority"));
		int taskGroupIdx = Integer.parseInt(request.getParameter("taskGroupIdx"));
		int taskState = Integer.parseInt(request.getParameter("taskState"));
		int Taskprogress = Integer.parseInt(request.getParameter("Taskprogress"));
		int memberIdx = Integer.parseInt(request.getParameter("memberIdx"));
		int taskIdx = Integer.parseInt(request.getParameter("taskIdx"));
		BoardALLDao dao = new BoardALLDao();
		ProjectALLDao pdao = new ProjectALLDao();
		TaskALLDao tdao = new TaskALLDao();
		int projectIdx = 0;
		try {
			dao.boardUpdate(boardIdx, title, content, Release);
			projectIdx = dao.ProjectIdxSearch(boardIdx);
			pdao.ProjectUpdate(projectIdx);
			tdao.UpdateTask(taskState, Taskpriority, startDate, endDate, Taskprogress, taskGroupIdx, taskIdx);
			tdao.DeleteALLtaskManager(taskIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		for(int i=0; i<=memberIdxArray.length-1; i++) {
	          try {
	             tdao.ADDtaskManager(taskIdx, Integer.parseInt(memberIdxArray[i]));
	          } catch (Exception e) {
	             e.printStackTrace();
	          }
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
				laDao.addLiveAlarm(dto.getMemberIdx(), projectInfo.getpName(), memberInfo.getName()+"님의 업무 수정", projectInfo.getpName(), null, boardIdx, null, 'N', 'Y', 'N', memberIdx);
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
		padao.setProjectAlarmCommentWrite(projectIdx, memberIdx, "업무", title, memberInfo.getName(),"수정");
		} catch (Exception e) {
			e.printStackTrace();
		}
      
	}

}
