package dto;

public class ChatRoomListDto {
	private int chatRoomIdx; 
    private String chatRoomName;
    private int projectIdx;
    private int createrChatIdx;
    private char groupChatYN;
    private String Conversation;
    private String date;
    private String time;
    private String amPm;
    private int readNotCount;
	public ChatRoomListDto(int chatRoomIdx, String chatRoomName, int projectIdx, int createrChatIdx, char groupChatYN,
			String conversation, String date, String time, String amPm, int readNotCount) {
		this.chatRoomIdx = chatRoomIdx;
		this.chatRoomName = chatRoomName;
		this.projectIdx = projectIdx;
		this.createrChatIdx = createrChatIdx;
		this.groupChatYN = groupChatYN;
		this.Conversation = conversation;
		this.date = date;
		this.time = time;
		this.amPm = amPm;
		this.readNotCount = readNotCount;
	}
	
	public int getReadNotCount() {
		return readNotCount;
	}

	public void setReadNotCount(int readNotCount) {
		this.readNotCount = readNotCount;
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
	public int getCreaterChatIdx() {
		return createrChatIdx;
	}
	public void setCreaterChatIdx(int createrChatIdx) {
		this.createrChatIdx = createrChatIdx;
	}
	public char getGroupChatYN() {
		return groupChatYN;
	}
	public void setGroupChatYN(char groupChatYN) {
		this.groupChatYN = groupChatYN;
	}
	public String getConversation() {
		return Conversation;
	}
	public void setConversation(String conversation) {
		Conversation = conversation;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public String getAmPm() {
		return amPm;
	}
	public void setAmPm(String amPm) {
		this.amPm = amPm;
	}
	
    
}
