package dto;

public class searchConversationOrWriterDto {
private int writerIdx;
private String conversation;
private String inputDateTime;
private String emotionFilename;
private String fileUrl;
private String name;
private int chatIdx;
public searchConversationOrWriterDto(int writerIdx, String conversation, String inputDateTime, String emotionFilename, int chatIdx,
		String fileUrl, String name) {
	super();
	this.writerIdx = writerIdx;
	this.conversation = conversation;
	this.inputDateTime = inputDateTime;
	this.emotionFilename = emotionFilename;
	this.fileUrl = fileUrl;
	this.name = name;
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
public String getEmotionFilename() {
	return emotionFilename;
}
public void setEmotionFilename(String emotionFilename) {
	this.emotionFilename = emotionFilename;
}
public String getFileUrl() {
	return fileUrl;
}
public void setFileUrl(String fileUrl) {
	this.fileUrl = fileUrl;
}
public String getName() {
	return name;
}
public void setName(String name) {
	this.name = name;
}
public int getchatIdx() {
	return chatIdx;
}
public void setchatIdx(int chatIdx) {
	this.chatIdx = chatIdx;
}

}
