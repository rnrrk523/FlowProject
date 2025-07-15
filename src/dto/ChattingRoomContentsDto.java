package dto;

public class ChattingRoomContentsDto {
	private int chatRoomIdx;
	private String chatRoomName;
	private int projectIdx;
	private char groupChatIdx;
	private int count;
	private int Admincount;
	private int Employeecount;
	private int Outsidercount;
	public ChattingRoomContentsDto(int chatRoomIdx, String chatRoomName, int projectIdx, char groupChatIdx, int count,
			int admincount, int employeecount, int outsidercount) {
		this.chatRoomIdx = chatRoomIdx;
		this.chatRoomName = chatRoomName;
		this.projectIdx = projectIdx;
		this.groupChatIdx = groupChatIdx;
		this.count = count;
		Admincount = admincount;
		Employeecount = employeecount;
		Outsidercount = outsidercount;
	}
	public int getChatRoomIdx() {
		return chatRoomIdx;
	}
	public void setChatRoomIdx(int chatRoomIdx) {
		this.chatRoomIdx = chatRoomIdx;
	}
	public String getChatRoomName() {
		return chatRoomName;
	}
	public void setChatRoomName(String chatRoomName) {
		this.chatRoomName = chatRoomName;
	}
	public int getProjectIdx() {
		return projectIdx;
	}
	public void setProjectIdx(int projectIdx) {
		this.projectIdx = projectIdx;
	}
	public char getGroupChatIdx() {
		return groupChatIdx;
	}
	public void setGroupChatIdx(char groupChatIdx) {
		this.groupChatIdx = groupChatIdx;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public int getAdmincount() {
		return Admincount;
	}
	public void setAdmincount(int admincount) {
		Admincount = admincount;
	}
	public int getEmployeecount() {
		return Employeecount;
	}
	public void setEmployeecount(int employeecount) {
		Employeecount = employeecount;
	}
	public int getOutsidercount() {
		return Outsidercount;
	}
	public void setOutsidercount(int outsidercount) {
		Outsidercount = outsidercount;
	}
	
}
