package dto;

public class myChatFileListdto {
private String fileUrl;
private int chatRoomIdx;
private String customChatroomName;
private String baseChatroomName;
private int writerIdx;
private String inputDateTime;
public myChatFileListdto(String fileUrl, int chatRoomIdx, String customChatroomName, String baseChatroomName,
		int writerIdx, String inputDateTime) {
	super();
	this.fileUrl = fileUrl;
	this.chatRoomIdx = chatRoomIdx;
	this.customChatroomName = customChatroomName;
	this.baseChatroomName = baseChatroomName;
	this.writerIdx = writerIdx;
	this.inputDateTime = inputDateTime;
}
public String getFileUrl() {
	return fileUrl;
}
public void setFileUrl(String fileUrl) {
	this.fileUrl = fileUrl;
}
public int getChatRoomIdx() {
	return chatRoomIdx;
}
public void setChatRoomIdx(int chatRoomIdx) {
	this.chatRoomIdx = chatRoomIdx;
}
public String getCustomChatroomName() {
	return customChatroomName;
}
public void setCustomChatroomName(String customChatroomName) {
	this.customChatroomName = customChatroomName;
}
public String getBaseChatroomName() {
	return baseChatroomName;
}
public void setBaseChatroomName(String baseChatroomName) {
	this.baseChatroomName = baseChatroomName;
}
public int getWriterIdx() {
	return writerIdx;
}
public void setWriterIdx(int writerIdx) {
	this.writerIdx = writerIdx;
}
public String getInputDateTime() {
	return inputDateTime;
}
public void setInputDateTime(String inputDateTime) {
	this.inputDateTime = inputDateTime;
}

}
