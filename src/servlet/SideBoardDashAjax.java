package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import dao.BoardALLDao;
import dao.ProjectALLDao;
import dao.TaskALLDao;
import dto.BoardCommentViewDto;
import dto.BoardEmotionDto;
import dto.BoardPostViewDto;
import dto.MyboardViewTaskDto;
import dto.ProjectViewProjecIdxDto;
import dto.TaskGroupViewDto;
import dto.TaskManagerDto;

@WebServlet("/SideBoardDashAjax")
public class SideBoardDashAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int taskIdx = Integer.parseInt(request.getParameter("taskIdx"));
		int memberIdx = Integer.parseInt(request.getParameter("memberIdx"));
		ProjectALLDao pdao = new ProjectALLDao();
		TaskALLDao tdao = new TaskALLDao();
		BoardALLDao bdao = new BoardALLDao();
		int boardIdx = 0;
		int projectIdx = 0;
		try {
			boardIdx = tdao.ShowBoardIdx(taskIdx);
			projectIdx = bdao.ProjectIdxSearch(boardIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		int colorCode = 12;
		String projectName = "";
		try {
			colorCode = pdao.ProjectMemberColorView(memberIdx, projectIdx);
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		ProjectViewProjecIdxDto Pdto = null;
		try {
			Pdto = pdao.ProjectViewProjecIdx(projectIdx);
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		projectName = Pdto.getProjectName();
		BoardPostViewDto BPVdto = null;
		try {
			BPVdto = bdao.PostViewBoard(boardIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		MyboardViewTaskDto MBVdto = null;
		try {
			MBVdto = bdao.ViewTask(boardIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		ArrayList<TaskManagerDto> TMlist = null;
		try {
			TMlist = bdao.ViewTaskManager(taskIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		int managerCount = 0;
		try {
			managerCount = tdao.taskManagerCount(taskIdx);
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		int emotionTotal = 0;
		try {
			emotionTotal = bdao.BoardEmotionTotalCount(boardIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		ArrayList<BoardEmotionDto> BElist = null; 
		ArrayList<BoardEmotionDto> BElist1 = null; 
		String emotionName = "";
		if(emotionTotal > 0) {
			try {
				BElist1 = bdao.BoardEmotionView(boardIdx,1);
			} catch (Exception e) {
				e.printStackTrace();
			}
			for(BoardEmotionDto dto : BElist1) {
				emotionName = dto.getName();
			}
		}
		try {
			BElist1 = bdao.BoardEmotionView(boardIdx,0);
		} catch (Exception e2) {
			e2.printStackTrace();
		}
		try {
			BElist = bdao.BoardEmotionTypeCount(boardIdx);
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		int MyCount = 0;
		try {
			MyCount = bdao.BoardEmotionMine(boardIdx, memberIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		int MyEmotion = 0;
		if(MyCount > 0) {
			BoardEmotionDto BEdto = null;
			try {
				BEdto = bdao.MyAddEmotionCheck(boardIdx,memberIdx);
			} catch (Exception e) {
				e.printStackTrace();
			}
			MyEmotion = BEdto.getEmotionType();
		}
		int bookMark = 0;
		try {
			bookMark = bdao.bookmarkView(boardIdx,memberIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		int commentCount = 0;
		try {
			commentCount = bdao.CommentCount(boardIdx, 0, 0);
		} catch (Exception e) {
			e.printStackTrace();
		}
		ArrayList<BoardCommentViewDto> BCVlist = null;
		try {
			BCVlist = bdao.BoardCommentViewer(boardIdx,0);
		} catch (Exception e) {
			e.printStackTrace();
		}
		int read = 0;
		try {
			read = bdao.ReadCount(boardIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		SimpleDateFormat sdf = new SimpleDateFormat("EEEE"); 
	    SimpleDateFormat sdfInput = new SimpleDateFormat("yyyy-MM-dd");
	    Date currentDate = new Date();
        currentDate.setHours(0); 

        String endDateString = MBVdto.getEndDate();
        Date endDate = null;
        String endValue = "N";
        try {
            if (endDateString != null) {
                endDate = sdfInput.parse(endDateString);
                if (endDate.before(currentDate)) {
                    endValue = "Y";  
                }
            }
        } catch (ParseException e) {
            e.printStackTrace();
        }
        ArrayList<TaskGroupViewDto> TGVlist = null;
        try {
			TGVlist = tdao.TaskGroupView(projectIdx);
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		response.setCharacterEncoding("utf-8");
 	    response.setContentType("application/json");
 	    PrintWriter out = response.getWriter();
 	    JSONArray array1 = new JSONArray();
 	    JSONArray array2 = new JSONArray();
 	    JSONArray array3 = new JSONArray();
 	    JSONArray array4 = new JSONArray();
 	    JSONArray array5 = new JSONArray();
 	   for (TaskManagerDto dto : TMlist) {
 		  JSONObject obj1 = new JSONObject();
 		  obj1.put("taskManagerId", dto.getMemberIdx());
 		  obj1.put("taskManagerName", dto.getName());
 		  obj1.put("taskManagerProfileImg", dto.getProfileImg());
 		  array1.add(obj1);
 	   }
 	   for (BoardCommentViewDto dto : BCVlist) {
 		  JSONObject obj1 = new JSONObject();
 		  obj1.put("commentProfileImg",dto.getProfileImg());
 		  obj1.put("commentIdx",dto.getCommentIdx());
 		  obj1.put("commentwriter",dto.getName());
 		  obj1.put("commentTime",dto.getWriteTime());
 		  obj1.put("commentContent",dto.getCommentContent());
 		  array2.add(obj1);
 	   }
 	   for (BoardEmotionDto dto : BElist) {
 		  JSONObject obj1 = new JSONObject();
 		  obj1.put("emotionType", dto.getEmotionType());
 		  obj1.put("emotionCount", dto.getCountemotion());
 		  array3.add(obj1);
 	   }
 	   for (BoardEmotionDto dto : BElist1) {
 		   JSONObject obj1 = new JSONObject();
 		   obj1.put("emotionType", dto.getEmotionType());
 		   obj1.put("memberIdx", dto.getMemberIdx());
 		   obj1.put("memberName", dto.getName());
 		   obj1.put("profileImg", dto.getProfileImg());
 		   array4.add(obj1);
 	   }
 	   for (TaskGroupViewDto dto : TGVlist) {
 		   JSONObject obj1 = new JSONObject();
 		   obj1.put("taskGroupName", dto.getTaskGroupName());
 		   obj1.put("taskGroupIdx", dto.getTaskGroupIdx());
 		   array5.add(obj1);
 	   }
 	   JSONObject obj1 = new JSONObject();
 	   obj1.put("manager", array1);
 	   obj1.put("comment", array2);
 	   obj1.put("emotion", array3);
 	   obj1.put("emotionMember", array4);
 	   obj1.put("taskGroup", array5);
 	   obj1.put("boardIdx", boardIdx);
 	   obj1.put("projectColor", colorCode);
 	   obj1.put("projectName", projectName);
 	   obj1.put("WriterName",BPVdto.getName());
 	   obj1.put("BoardWriteTime",BPVdto.getWriteDate());
 	   obj1.put("fix",BPVdto.getTopFixed()+"");
 	   obj1.put("title",BPVdto.getTitle());
 	   obj1.put("content",BPVdto.getContent());
 	   obj1.put("ProfileImg",BPVdto.getProfileImg());
 	   obj1.put("Release",BPVdto.getReleaseYN()+"");
 	   obj1.put("taskIdx",taskIdx);
 	   String startOfWeek = null;
	   if (MBVdto.getStartDate() != null) {
	 	    String startDateString = MBVdto.getStartDate();
	 	    Date startDate = null;
			try {
				startDate = sdfInput.parse(startDateString);
			} catch (ParseException e) {
				e.printStackTrace();
			}
	 	    Calendar calendar = Calendar.getInstance();
	 	    calendar.setTime(startDate);
	 	    int dayOfWeekInt = calendar.get(Calendar.DAY_OF_WEEK);  
	 	    String dayOfWeek = "";
	 	    switch (dayOfWeekInt) {
	 	        case Calendar.MONDAY:
	 	        	dayOfWeek = "월"; break;
	 	        case Calendar.TUESDAY:
	 	        	dayOfWeek = "화"; break;
	 	        case Calendar.WEDNESDAY:
	 	        	dayOfWeek = "수"; break;
	 	        case Calendar.THURSDAY:
	 	        	dayOfWeek = "목"; break;
	 	        case Calendar.FRIDAY:
	 	        	dayOfWeek = "금"; break;
	 	        case Calendar.SATURDAY:
	 	        	dayOfWeek = "토"; break;
	 	        case Calendar.SUNDAY:
	 	        	dayOfWeek = "일"; break;
	 	        default:
	 	        	dayOfWeek = null; break;
	 	    }
	 	   if (MBVdto.getStartDate() != null) {
               if (MBVdto.getStartDate().endsWith("00:00:00")) {
            	   startOfWeek = MBVdto.getStartDate().substring(0, 10) + "("+dayOfWeek+") 부터";
               } else {
            	   startOfWeek = MBVdto.getStartDate() + "("+dayOfWeek+") 부터";
               }
	 	  }
 	    obj1.put("startDate",startOfWeek);
	} else {
		obj1.put("startDate",startOfWeek);
	}
	String endOfWeek = null;
	if (MBVdto.getEndDate() != null) {
	 	    String startDateString = MBVdto.getEndDate();
	 	    Date startDate = null;
			try {
				startDate = sdfInput.parse(startDateString);
			} catch (ParseException e) {
				e.printStackTrace();
			}
	 	    Calendar calendar = Calendar.getInstance();
	 	    calendar.setTime(startDate);
	 	    int dayOfWeekInt = calendar.get(Calendar.DAY_OF_WEEK);  
	 	    String dayOfWeek = "";
	 	    switch (dayOfWeekInt) {
	 	        case Calendar.MONDAY:
	 	        	dayOfWeek = "월"; break;
	 	        case Calendar.TUESDAY:
	 	        	dayOfWeek = "화"; break;
	 	        case Calendar.WEDNESDAY:
	 	        	dayOfWeek = "수"; break;
	 	        case Calendar.THURSDAY:
	 	        	dayOfWeek = "목"; break;
	 	        case Calendar.FRIDAY:
	 	        	dayOfWeek = "금"; break;
	 	        case Calendar.SATURDAY:
	 	        	dayOfWeek = "토"; break;
	 	        case Calendar.SUNDAY:
	 	        	dayOfWeek = "일"; break;
	 	        default:
	 	        	dayOfWeek = null; break;
	 	    }
	 	   if (MBVdto.getEndDate() != null) {
	           if (MBVdto.getEndDate().endsWith("00:00:00")) {
	        	   endOfWeek = MBVdto.getEndDate().substring(0, 10) + "("+dayOfWeek+") 까지";
	           } else {
	        	   endOfWeek = MBVdto.getEndDate() + "("+dayOfWeek+") 까지";
	           }
	 	  }
		    obj1.put("endDate",endOfWeek);
		} else {
			obj1.put("endDate",endOfWeek);
		}
		obj1.put("state",MBVdto.getState());
		obj1.put("priority",MBVdto.getPriority());
		obj1.put("TaskGroupIdx",MBVdto.getTaskGroupIdx());
		obj1.put("TaskGroupName",MBVdto.getTaskGroupName());
		obj1.put("progress",MBVdto.getProgress());
		obj1.put("managerCount",managerCount);
		obj1.put("bookmark",bookMark);
		obj1.put("commentCount",commentCount);
		obj1.put("read",read);
		obj1.put("endValue",endValue + "");
		obj1.put("emotionName",emotionName);
		obj1.put("emotionTotal",emotionTotal);
		out.print(obj1.toJSONString());
	}

}
