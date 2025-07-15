package dto;

import java.text.SimpleDateFormat;
import java.util.Date;

public class ChatContentsDto {
	private int chatIdx;
	private int writerIdx;
	private String conversation;
	private String inputDateTime;
	private int unreadMemberCount;
	public ChatContentsDto(int chatIdx, int writerIdx, String conversation, String inputDateTime,
			int unreadMemberCount) {
		this.chatIdx = chatIdx;
		this.writerIdx = writerIdx;
		this.conversation = conversation;
		this.inputDateTime = inputDateTime;
		this.unreadMemberCount = unreadMemberCount;
	}
	public int getChatIdx() {
		return chatIdx;
	}
	public void setChatIdx(int chatIdx) {
		this.chatIdx = chatIdx;
	}
	public int getWriterIdx() {
		return writerIdx;
	}
	public void setWriterIdx(int writerIdx) {
		this.writerIdx = writerIdx;
	}
	public String getConversation() {
		return conversation;
	}
	public void setConversation(String conversation) {
		this.conversation = conversation;
	}
	public String getInputDateTime() {
		return inputDateTime;
	}
	public void setInputDateTime(String inputDateTime) {
		this.inputDateTime = inputDateTime;
	}
	public int getUnreadMemberCount() {
		return unreadMemberCount;
	}
	public void setUnreadMemberCount(int unreadMemberCount) {
		this.unreadMemberCount = unreadMemberCount;
	}
	// 년월일만 포맷하는 메서드
    public String getFormattedDate() {
        try {
            SimpleDateFormat inputDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            Date date = inputDateFormat.parse(inputDateTime); // String → Date
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); // 년-월-일 형식
            return sdf.format(date); // 예: "2024-11-20"
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    // 오전/오후 시:분 포맷하는 메서드
    public String getFormattedTime() {
        try {
            SimpleDateFormat inputDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            Date date = inputDateFormat.parse(inputDateTime); // String → Date
            SimpleDateFormat timeFormat = new SimpleDateFormat("a hh:mm"); // 오전/오후 hh:mm 형식
            String formattedTime = timeFormat.format(date); // 예: "오전 01:00"
            return formattedTime.replace("AM", "오전").replace("PM", "오후"); // "AM"을 "오전"으로, "PM"을 "오후"로 변경
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    // 날짜 비교를 위한 메서드 (예시로, 같은 날짜인지를 비교)
    public String getDateComparison() {
        try {
            SimpleDateFormat inputDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            Date date = inputDateFormat.parse(inputDateTime); // 현재 메시지의 날짜
            Date previousDate = inputDateFormat.parse(inputDateTime); // 예시로 동일 날짜 사용, 실제로는 이전 날짜를 받아야 함
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String currentDate = sdf.format(date);
            String prevDate = sdf.format(previousDate);

            if (currentDate.equals(prevDate)) {
                return "N"; // 동일한 날짜
            } else {
                return "Y"; // 다른 날짜
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
