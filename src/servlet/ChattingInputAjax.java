package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import dao.ChattingDao;
import dto.ChatContentsDto;

/**
 * Servlet implementation class ChattingInputAjax
 */
@WebServlet("/ChattingInputAjax")
public class ChattingInputAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String chatText = request.getParameter("chatText");
		int memberIdx = Integer.parseInt(request.getParameter("memberIdx"));
		int chatRoomIdx = Integer.parseInt(request.getParameter("chatRoomIdx"));
		ChattingDao dao = new ChattingDao();
		int Idx = 0;
		ChatContentsDto Cdto = null;
		ChatContentsDto Cdto2 = null;
		try {
			Idx = dao.ChattingIdxSearch();
			dao.chattingInsert(chatRoomIdx, memberIdx, chatText);
			Cdto = dao.ChatContents(Idx);
			Cdto2 = dao.ChatContents(Idx-1);
			dao.ReadChat(memberIdx, Idx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd (E)");
        SimpleDateFormat timeFormat = new SimpleDateFormat("a hh:mm");
		response.setCharacterEncoding("utf-8");
 	    response.setContentType("application/json");
 	    PrintWriter out = response.getWriter();
 	    JSONObject obj1 = new JSONObject();
 	    obj1.put("chatIdx",Cdto.getChatIdx());
 	    obj1.put("WriterIdx",Cdto.getWriterIdx());
 	    obj1.put("Conversation",Cdto.getConversation());
 	   String inputDateTimeStr = Cdto.getInputDateTime();
 	   String previousDate = Cdto2.getInputDateTime();
       try {
           SimpleDateFormat inputDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
           Date inputDateTime = inputDateFormat.parse(inputDateTimeStr); // String → Date
           Date inputDateTime2 = inputDateFormat.parse(previousDate); // String → Date
           String inputDateStr = sdf.format(inputDateTime); // 예: "2024-11-20"
           String inputDateStr2 = sdf.format(inputDateTime2); // 예: "2024-11-20"
           String formattedTime = timeFormat.format(inputDateTime); // 예: "오후 01:00"
           formattedTime = formattedTime.replace("AM", "오전").replace("PM", "오후");
           obj1.put("InputDate", inputDateStr);  // "2024-11-20"과 같은 형식으로 날짜 추가
           obj1.put("InputDateTime", formattedTime);  // "오후 01:00"과 같은 형식으로 시간 추가
           if (inputDateStr2 != null) {
               char a = (inputDateStr.equals(inputDateStr2)) ? 'N' : 'Y';
               obj1.put("DateComparison", a+"");  // 비교 결과를 JSONObject에 추가
           }
       } catch (Exception e) {
           e.printStackTrace();
       }
 	    obj1.put("Count",Cdto.getUnreadMemberCount());
 	    out.println(obj1);
	}

}
