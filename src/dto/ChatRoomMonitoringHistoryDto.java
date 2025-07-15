package dto;

import java.util.ArrayList;

public class ChatRoomMonitoringHistoryDto {
	private int chatRoomIdx;
	private String roomName;
	private ArrayList<String> memberList;
	private String chatDate;
	
	public ChatRoomMonitoringHistoryDto(int chatRoomIdx, String roomName, ArrayList<String> memberList,
			String chatDate) {
		this.chatRoomIdx = chatRoomIdx;
		this.roomName = roomName;
		this.memberList = memberList;
		this.chatDate = chatDate;
	}
	
	public int getChatRoomIdx() {
		return chatRoomIdx;
	}
	public void setChatRoomIdx(int chatRoomIdx) {
		this.chatRoomIdx = chatRoomIdx;
	}
	public String getRoomName() {
		return roomName;
	}
	public void setRoomName(String roomName) {
		this.roomName = roomName;
	}
	public ArrayList<String> getMemberList() {
		return memberList;
	}
	public void setMemberList(ArrayList<String> memberList) {
		this.memberList = memberList;
	}
	public String getChatDate() {
		return chatDate;
	}
	public void setChatDate(String chatDate) {
		this.chatDate = chatDate;
	}
}
