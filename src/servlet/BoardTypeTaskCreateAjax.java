package servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

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
import dto.TaskMangerViewProjectDto;

/**
 * Servlet implementation class BoardTypeTaskCreateAjax
 */
@WebServlet("/BoardTypeTaskCreateAjax")
public class BoardTypeTaskCreateAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 String title = request.getParameter("title");
	        String content = request.getParameter("content");
	        String category = request.getParameter("category");
	        int memberIdx = Integer.parseInt(request.getParameter("memberIdx"));
	        int projectIdx = Integer.parseInt(request.getParameter("projectIdx"));
	        char Release = request.getParameter("Release").charAt(0);
	        char temporary = request.getParameter("temporary").charAt(0);
	        String startDate = request.getParameter("startDate");
	        String endDate = request.getParameter("endDate");
	        int priority = Integer.parseInt(request.getParameter("Taskpriority"));
	        int GroupIdx = Integer.parseInt(request.getParameter("taskGroupIdx"));
	        int state = Integer.parseInt(request.getParameter("taskState"));
	        int progress = Integer.parseInt(request.getParameter("Taskprogress"));
	        String memberValueJson = request.getParameter("memberValue");  

		    if (memberValueJson == null || memberValueJson.isEmpty()) {
		        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
		        response.getWriter().write("mnoValuesJson is missing or empty");
		        return;
		    }
		    JSONParser parser = new JSONParser();
		    JSONArray mnoValuesArray = null;
		    try {
		        mnoValuesArray = (JSONArray) parser.parse(memberValueJson);
		    } catch (ParseException e) {
		        e.printStackTrace();
		        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
		        response.getWriter().write("Invalid JSON format");
		        return;
		    }
	        BoardALLDao bdao = new BoardALLDao();
	        TaskALLDao tdao = new TaskALLDao();
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
	            if (GroupIdx == 0) {
	                bdao.WriteBoardTaskText(boardIdx, state, priority, startDate, endDate, progress, null);
	            } else {
	                bdao.WriteBoardTaskText(boardIdx, state, priority, startDate, endDate, progress, GroupIdx);
	            }
	        } catch (Exception e1) {
	            e1.printStackTrace();
	        }

	        int taskIdx = 0;
	        try {
	            taskIdx = bdao.taskIdxsearch();
	        } catch (Exception e1) {
	            e1.printStackTrace();
	        }

		    for (Object obj : mnoValuesArray) {
		        JSONObject obj1 = new JSONObject();

		        Long mno = (Long) obj;
		        int mnoInt = mno.intValue(); 
		        try {
					tdao.ADDtaskManager(taskIdx, mnoInt);
				} catch (Exception e) {
					e.printStackTrace();
				}
		    }
		    try {
				pdao.ProjectUpdate(projectIdx);
			} catch (Exception e) {
				e.printStackTrace();
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
					laDao.addLiveAlarm(dto.getMemberIdx(), projectInfo.getpName(), memberInfo.getName()+"님의 업무 등록", projectInfo.getpName(), null, boardIdx, null, 'N', 'Y', 'N', memberIdx);
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
			padao.setProjectAlarmCommentWrite(projectIdx, memberIdx, "업무", title, memberInfo.getName(),"작성");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
