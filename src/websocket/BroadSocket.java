package websocket;

import java.io.IOException;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import org.json.simple.JSONObject;

import dao.ChattingDao;
import dto.ChatContentsDto;

@ServerEndpoint("/Broadcasting")
public class BroadSocket {

    private static Set<Session> clients = Collections.synchronizedSet(new HashSet<Session>());

    // 메시지를 받았을 때
    @OnMessage
    public void onMessage(Session session, String message) {
        try {
            // 받은 메시지 파싱
            JSONObject jsonMessage = (JSONObject) new org.json.simple.parser.JSONParser().parse(message);
            String chatText = (String) jsonMessage.get("chatText");
            long memberIdx = (long) jsonMessage.get("memberIdx");  // json-simple에서는 Long 타입으로 반환됨
            long chatRoomIdx = (long) jsonMessage.get("chatRoomIdx");

            // 데이터베이스에 메시지 저장
            ChatContentsDto chatContents = saveChatMessage(chatText, (int) memberIdx, (int) chatRoomIdx);

            // 저장된 메시지를 클라이언트로 전송
            broadcastMessage(chatContents);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 메시지를 데이터베이스에 저장하는 메서드
    private ChatContentsDto saveChatMessage(String chatText, int memberIdx, int chatRoomIdx) {
        ChattingDao dao = new ChattingDao();
        int idx = 0;
		try {
			idx = dao.ChattingIdxSearch();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}  // 새로운 메시지의 ID 찾기
        try {
			dao.chattingInsert(chatRoomIdx, memberIdx, chatText);
		} catch (Exception e) {
			e.printStackTrace();
		}  
        ChatContentsDto num = null;
        try {
			num = dao.ChatContents(idx);
		} catch (Exception e) {
			e.printStackTrace();
		}  
        return num;
    }

    // 모든 클라이언트에게 메시지를 방송하는 메서드
    private void broadcastMessage(ChatContentsDto message) {
        for (Session client : clients) {
            try {
                JSONObject response = new JSONObject();
                response.put("chatIdx", message.getChatIdx());
                response.put("Conversation", message.getConversation());
                response.put("InputDateTime", message.getFormattedTime());
                response.put("InputDate", message.getFormattedDate());
                response.put("DateComparison", message.getDateComparison());
                response.put("memberIdx", message.getWriterIdx());
                
                // 메시지를 전송
                client.getBasicRemote().sendText(response.toString());
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    // 클라이언트가 연결되었을 때
    @OnOpen
    public void onOpen(Session session) {
        clients.add(session);
        System.out.println(clients.size() + "명");
    }

    // 클라이언트가 연결을 종료했을 때
    @OnClose
    public void onClose(Session session) {
        clients.remove(session);
    }

    // 오류가 발생했을 때
    @OnError
    public void onError(Session session, Throwable error) {
        error.printStackTrace();
    }
}

