package dto;

public class myChatRoomConversationDto {
	private int chatIdx;
	private String conversation;
	public myChatRoomConversationDto(int chatIdx, String conversation) {
		super();
		this.chatIdx = chatIdx;
		this.conversation = conversation;
	}
	public int getChatIdx() {
		return chatIdx;
	}
	public void setChatIdx(int chatIdx) {
		this.chatIdx = chatIdx;
	}
	public String getConversation() {
		return conversation;
	}
	public void setConversation(String conversation) {
		this.conversation = conversation;
	}

}
