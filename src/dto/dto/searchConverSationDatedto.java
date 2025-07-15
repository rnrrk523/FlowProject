package dto;

public class searchConverSationDatedto {
	private String name;
	private String inputDateTime;
	private String emotionFileName;
	private String fileUrl;
	private String conversation;
	private int chatIdx;
	public searchConverSationDatedto(String name, String inputDateTime, String emotionFileName, String fileUrl, String conversation, int chatIdx) {
		this.name = name;
		this.inputDateTime = inputDateTime;
		this.emotionFileName = emotionFileName;
		this.fileUrl = fileUrl;
		this.conversation = conversation;
		this.chatIdx = chatIdx;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getInputDateTime() {
		return inputDateTime;
	}
	public void setInputDateTime(String inputDateTime) {
		this.inputDateTime = inputDateTime;
	}
	public String getEmotionFileName() {
		return emotionFileName;
	}
	public void setEmotionFileName(String emotionFileName) {
		this.emotionFileName = emotionFileName;
	}
	public String getFileUrl() {
		return fileUrl;
	}
	public void setFileUrl(String fileUrl) {
		this.fileUrl = fileUrl;
	}
	public String getconversation() {
		return conversation;
	}
	public void setconversation(String conversation) {
		this.conversation = conversation;
	}
	public int getchatIdx() {
		return chatIdx;
	}
	public void setchatIdx(int chatIdx) {
		this.chatIdx = chatIdx;
	}

}
