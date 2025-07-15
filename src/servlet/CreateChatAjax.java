package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import dao.ChattingDao;
import dao.MemberDao;
import dto.ChatContentsDto;
import dto.ChatRoomListDto;
import dto.ChattingRoomContentsDto;
import dto.MemberDto;

@WebServlet("/CreateChatAjax")
public class CreateChatAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int MemberIdx = Integer.parseInt(request.getParameter("MemberIdx"));
		ChattingDao dao = new ChattingDao();
		MemberDao mdao = new MemberDao();
		ArrayList<ChatRoomListDto> Clist = null; 
		try {
			Clist = dao.ChatRoomList(MemberIdx,"");
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		int ChatRoomIdx = 0;
		try {
			ChatRoomIdx = dao.ChatRoomIdx();
		} catch (Exception e) {
			e.printStackTrace();
		}
		String chatmnoValuesJson = request.getParameter("chatmnoValues");
        JSONParser parser = new JSONParser();
        List<Integer> chatmnoValues = new ArrayList<>();
        try {
            JSONArray jsonArray = (JSONArray) parser.parse(chatmnoValuesJson);
            
            for (Object obj : jsonArray) {
                chatmnoValues.add(((Long) obj).intValue());
            }
        } catch (ParseException e) {
            e.printStackTrace();
            response.getWriter().write("Error parsing JSON");
        }
        String title = "";
        for (int i = 0; i < chatmnoValues.size(); i++) {
            int value = chatmnoValues.get(i);
            MemberDto dto = null;
            try {
				dto = mdao.GetProfile(value);
			} catch (Exception e) {
				e.printStackTrace();
			}
            if(i == chatmnoValues.size()-1) {
            	title += dto.getName();
            } else {
            	title += (dto.getName() + ", ");
            }
        }
        try {
			dao.ChatCreate(title, MemberIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
        for (int i = 0; i < chatmnoValues.size(); i++) {
            int value = chatmnoValues.get(i);
            if(value == MemberIdx) {
            	try {
					dao.ChatMemberInsert(ChatRoomIdx, value, 'Y');
				} catch (Exception e) {
					e.printStackTrace();
				}
            } else {
            	try {
					dao.ChatMemberInsert(ChatRoomIdx, value, 'N');
				} catch (Exception e) {
					e.printStackTrace();
				}
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
