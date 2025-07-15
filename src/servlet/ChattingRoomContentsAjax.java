package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Locale;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import dao.ChattingDao;
import dto.ChatContentsDto;
import dto.ChattingRoomContentsDto;
import dto.MemberDto;


@WebServlet("/ChattingRoomContentsAjax")
public class ChattingRoomContentsAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int chatRoomIdx = Integer.parseInt(request.getParameter("chatRoomIdx"));
		int companyIdx = Integer.parseInt(request.getParameter("companyIdx"));
		ChattingDao dao = new ChattingDao();
		ChattingRoomContentsDto ChatDto = null;
		ArrayList<MemberDto> AdminList = null;
		ArrayList<ChatContentsDto> ChatContentsList = null;
		try {
			ChatDto = dao.ChattingRoomContents(chatRoomIdx);
			AdminList = dao.AdminChatMemberList(chatRoomIdx);
			ChatContentsList = dao.ChatContentsList(chatRoomIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd (E)", Locale.KOREA);
	    SimpleDateFormat timeFormat = new SimpleDateFormat("a hh:mm", Locale.KOREA);
        String previousDate = null;
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		JSONArray array1 = new JSONArray();
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
 	    obj1.put("array4",array4);
		obj1.put("chatRoomIdx",ChatDto.getChatRoomIdx());
		obj1.put("chatRoomName",ChatDto.getChatRoomName());
		obj1.put("projectIdx",ChatDto.getProjectIdx());
		obj1.put("groupChatYN",ChatDto.getGroupChatIdx()+"");
		obj1.put("count",ChatDto.getCount());
		out.print(obj1.toJSONString());
	}

}
