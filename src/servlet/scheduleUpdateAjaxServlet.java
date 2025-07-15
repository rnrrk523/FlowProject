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
import dao.ScheduleDao;
import dto.MemberCompanyDepartmentDto;
import dto.ProjectMemberListDto;
import dto.ProjectsDto;

@WebServlet("/scheduleUpdateAjaxServlet")
public class scheduleUpdateAjaxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		String location = request.getParameter("location");
		String alarmTypeStr = request.getParameter("alarmType");
		String  memberIdxArray[] = request.getParameter("memberIdxArray").split(",");
		char Release = request.getParameter("releaseYn").charAt(0);
		char allDayYN = request.getParameter("allDayYN").charAt(0);
		int boardIdx = Integer.parseInt(request.getParameter("boardIdx"));
		int scheduleIdx = Integer.parseInt(request.getParameter("scheduleIdx"));
		int memberIdx = Integer.parseInt(request.getParameter("memberIdx"));
		int alarmType = 0;
	      if(alarmTypeStr.equals("없음")) {
	         alarmType = 0;
	      }else if(alarmTypeStr.equals("10분 전 미리 알림")) {
	         alarmType = 1;
	      }else if(alarmTypeStr.equals("30분 전 미리 알림")) {
	         alarmType = 2;
	      }else if(alarmTypeStr.equals("1 시간 전 미리 알림")) {
	         alarmType = 3;
	      }else if(alarmTypeStr.equals("2 시간 전 미리 알림")) {
	         alarmType = 4;
	      }else if(alarmTypeStr.equals("3 시간 전 미리 알림")) {
	         alarmType = 5;
	      }else if(alarmTypeStr.equals("1일 전 미리 알림")) {
	         alarmType = 6;
	      }else if(alarmTypeStr.equals("2일 전 미리 알림")) {
	         alarmType = 7;
	      }else if(alarmTypeStr.equals("7일 전 미리 알림")) {
	         alarmType = 8;
	      }
	      if(allDayYN == 'Y') {
	          startDate = startDate.substring(0, 10);
	          endDate = endDate.substring(0, 10);
	       }else {
	          startDate = startDate.replace(startDate.substring(11, 16), "");
	          endDate = endDate.replace(endDate.substring(11, 16), "");
	       }
	      BoardALLDao dao = new BoardALLDao();
	      ScheduleDao sDao = new ScheduleDao();
	      ProjectALLDao pdao = new ProjectALLDao();
	      int projectIdx = 0;
			try {
				dao.boardUpdate(boardIdx, title, content, Release);
				projectIdx = dao.ProjectIdxSearch(boardIdx);
				pdao.ProjectUpdate(projectIdx);
				sDao.UpdateSchedule(location, alarmType, allDayYN, startDate, endDate, scheduleIdx);
				sDao.delScheduleMember(scheduleIdx);
			} catch (Exception e) {
				e.printStackTrace();
			}
	      for(int i=0; i<=memberIdxArray.length-1; i++) {
	          try {
	             sDao.addScheduleMember(scheduleIdx, Integer.parseInt(memberIdxArray[i]), "");
	          } catch (Exception e) {
	             e.printStackTrace();
	          }
	       }
//			실시간알림테이블 INSERT
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
					laDao.addLiveAlarm(dto.getMemberIdx(), projectInfo.getpName(), memberInfo.getName()+"님의 일정 수정", projectInfo.getpName(), null, boardIdx, null, 'N', 'Y', 'N', memberIdx);
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
			padao.setProjectAlarmCommentWrite(projectIdx, memberIdx, "일정", title, memberInfo.getName(),"수정");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
