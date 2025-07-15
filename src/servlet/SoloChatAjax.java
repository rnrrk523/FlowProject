package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import dao.ChattingDao;
import dao.MemberDao;
import dto.ChatContentsDto;
import dto.ChatRoomListDto;
import dto.ChattingRoomContentsDto;
import dto.MemberDto;

@WebServlet("/SoloChatAjax")
public class SoloChatAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int memberIdx1 = Integer.parseInt(request.getParameter("memberIdx1"));
		int memberIdx2 = Integer.parseInt(request.getParameter("memberIdx2"));
		ChattingDao dao = new ChattingDao();
		MemberDao mdao = new MemberDao();
		int ChatRoomIdx = 0;
		MemberDto mdto = null;;
		MemberDto mdto2 = null; 
		ArrayList<ChatRoomListDto> Clist = null; 
		try {
			Clist = dao.ChatRoomList(memberIdx1,"");
			mdto = mdao.GetProfile(memberIdx1);
			mdto2 = mdao.GetProfile(memberIdx2);
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		if(memberIdx1 == memberIdx2) {
			try {
				ChatRoomIdx = dao.ChattingRoomIdxSearchOne(memberIdx1);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			try {
				ChatRoomIdx = dao.ChattingRoomIdxSearch(memberIdx1,memberIdx2);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		String YN = "N";
		if(ChatRoomIdx == 0) {
			String title = "";
			YN = "Y";
			if(memberIdx1 == memberIdx2) {
				title = mdto.getName();
			} else {
				title = mdto.getName()+", "+mdto2.getName(); 
			}
			try {
				ChatRoomIdx = dao.ChatRoomIdx();
				dao.ChatCreate(title,memberIdx1);
				if(memberIdx1 == memberIdx2) {
					dao.ChatMemberInsert(ChatRoomIdx, memberIdx1, 'Y');
				} else {
					dao.ChatMemberInsert(ChatRoomIdx, memberIdx1, 'Y');
					dao.ChatMemberInsert(ChatRoomIdx, memberIdx2, 'N');
				}
			} catch (Exception e) {
				e.printStackTrace();
				
			}
		} 
		ChattingRoomContentsDto ChatDto = null;
		ArrayList<MemberDto> AdminList = null;
		ArrayList<ChatContentsDto> ChatContentsList = null;
		try {
			ChatDto = dao.ChattingRoomContents(ChatRoomIdx);
			AdminList = dao.AdminChatMemberList(ChatRoomIdx);
			ChatContentsList = dao.ChatContentsList(ChatRoomIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd (E)");
        SimpleDateFormat timeFormat = new SimpleDateFormat("a hh:mm");
        String previousDate = null;
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		JSONArray array1 = new JSONArray();
		JSONArray array2 = new JSONArray();
 	    JSONArray array4 = new JSONArray();
 	    for(MemberDto dto : AdminList) {
 	    	JSONObject obj1 = new JSONObject();
 	    	obj1.put("profileImg",dto.getProfileImg());
 	    	obj1.put("memberIdx",dto.getMemberIdx());
 	    	obj1.put("name",dto.getName());
 	    	obj1.put("departmentName",dto.getDepartmentName());
 	    	obj1.put("position",dto.getPosition());
 	    	obj1.put("companyName",dto.getCompanyName());
 	    	array1.add(obj1);
 	    }
 	    for(ChatRoomListDto dto : Clist) {
 	    	JSONObject obj1 = new JSONObject();
 	    	obj1.put("chatRoomIdx",dto.getChatRoomIdx());
 	    	obj1.put("chatRoomName",dto.getChatRoomName());
 	    	obj1.put("Conversation",dto.getConversation());
 	    	obj1.put("time",dto.getTime());
 	    	obj1.put("amPm",dto.getAmPm());
 	    	obj1.put("readNotCount",dto.getReadNotCount());
 	    	array2.add(obj1);
 	    }
 	    for(ChatContentsDto dto : ChatContentsList) {
 	    	JSONObject obj1 = new JSONObject();
			obj1.put("ChatIdx",dto.getChatIdx());
			obj1.put("WriterIdx",dto.getWriterIdx());
			obj1.put("Conversation",dto.getConversation());
            String inputDateTimeStr = dto.getInputDateTime();
            try {
                SimpleDateFormat inputDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                Date inputDateTime = inputDateFormat.parse(inputDateTimeStr); // String → Date
                String inputDateStr = sdf.format(inputDateTime); // 예: "2024-11-20"
                String formattedTime = timeFormat.format(inputDateTime); // 예: "오후 01:00"
                formattedTime = formattedTime.replace("AM", "오전").replace("PM", "오후");
                obj1.put("InputDate", inputDateStr);  // "2024-11-20"과 같은 형식으로 날짜 추가
                obj1.put("InputDateTime", formattedTime);  // "오후 01:00"과 같은 형식으로 시간 추가
                if (previousDate != null) {
                    char a = (inputDateStr.equals(previousDate)) ? 'N' : 'Y';
                    obj1.put("DateComparison", a+"");  // 비교 결과를 JSONObject에 추가
                }
                previousDate = inputDateStr;
            } catch (Exception e) {
                e.printStackTrace();
            }
			obj1.put("UnreadMemberCount",dto.getUnreadMemberCount());
			array4.add(obj1);
 	    }
 	    JSONObject obj1 = new JSONObject();
 	    obj1.put("array1",array1);
 	    obj1.put("array2",array2);
 	    obj1.put("array4",array4);
		obj1.put("chatRoomIdx",ChatDto.getChatRoomIdx());
		obj1.put("chatRoomName",ChatDto.getChatRoomName());
		obj1.put("groupChatYN",ChatDto.getGroupChatIdx()+"");
		obj1.put("count",ChatDto.getCount());
		out.print(obj1.toJSONString());
	}

}
