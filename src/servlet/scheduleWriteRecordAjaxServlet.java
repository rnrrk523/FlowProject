package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.LiveAlarmDao;
import dao.MemberDao;
import dao.ProjectALLDao;
import dao.ProjectAlarmDao;
import dao.ProjectDao;
import dao.ScheduleDao;
import dto.MemberCompanyDepartmentDto;
import dto.ProjectMemberListDto;
import dto.ProjectsDto;

@WebServlet("/scheduleWriteRecordAjaxServlet")
public class scheduleWriteRecordAjaxServlet extends HttpServlet {
   private static final long serialVersionUID = 1L;
       
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	  int projectIdx = Integer.parseInt(request.getParameter("projectIdx"));
      int writerIdx = Integer.parseInt(request.getParameter("writerIdx"));
      String title = request.getParameter("title");
      String startDate = request.getParameter("startDate");
      String endDate = request.getParameter("endDate");
      char allDayYN = request.getParameter("allDayYN").charAt(0);
      String content = request.getParameter("content");
      String alarmTypeStr = request.getParameter("alarmType");
      String location = request.getParameter("location");
      char releaseYn = request.getParameter("releaseYn").charAt(0);
      String  memberIdxArray[] = request.getParameter("memberIdxArray").split(",");
      ProjectALLDao pdao = new ProjectALLDao();
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
      
      ScheduleDao sDao = new ScheduleDao();
      int boardIdx = 0;
      try {
         boardIdx = sDao.addBoard(projectIdx, writerIdx, title, content, "일정", releaseYn);
      } catch (Exception e) {
         e.printStackTrace();
      }
      int scheduleIdx = 0;
      try {
         scheduleIdx = sDao.addSchedule(boardIdx, location, startDate, endDate, alarmType, allDayYN);
      } catch (Exception e) {
         e.printStackTrace();
      }
      
      for(int i=0; i<=memberIdxArray.length-1; i++) {
         try {
            sDao.addScheduleMember(scheduleIdx, Integer.parseInt(memberIdxArray[i]), "");
         } catch (Exception e) {
            // TODO Auto-generated catch block
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
			memberInfo = mDao.getMemberInfo(writerIdx);
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		for(ProjectMemberListDto dto : pmList) {
			try {
				laDao.addLiveAlarm(dto.getMemberIdx(), projectInfo.getpName(), memberInfo.getName()+"님의 일정 등록", projectInfo.getpName(), null, boardIdx, null, 'N', 'Y', 'N', writerIdx);
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
		padao.setProjectAlarmCommentWrite(projectIdx, writerIdx, "일정", title, memberInfo.getName(),"작성");
	} catch (Exception e) {
		e.printStackTrace();
	}
   }
}