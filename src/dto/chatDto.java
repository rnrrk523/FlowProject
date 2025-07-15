package dto;

public class chatDto {
	private String flyemotionURL;
	private String customName;
	private String baseName;
	private String inputDateTime;
	private String fileUrl;
	private String name;
	private String emotionFilename;
	private String conversation;
	private String noticeYn;
	private int chatIdx;
	private int chatRoomIdx; 
	private int flyemotionIdx;
	private int memberIdx;
	private String profileImg;
	private int replyIdx;
	public int getFlyemotionIdx() {
		return flyemotionIdx;
	}
	public void setFlyemotionIdx(int flyemotionIdx) {
		this.flyemotionIdx = flyemotionIdx;
	}
	public String getFlyemotionURL() {
		return flyemotionURL;
	}
	public String getProfileImg() {
		return profileImg;
	}
	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
	}
	public int getReplyIdx() {
		return replyIdx;
	}
	public void setReplyIdx(int replyIdx) {
		this.replyIdx = replyIdx;
	}
	public void setFlyemotionURL(String flyemotionURL) {
		this.flyemotionURL = flyemotionURL;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmotionFilename() {
		return emotionFilename;
	}
	public void setEmotionFilename(String emotionFilename) {
		this.emotionFilename = emotionFilename;
	}
	public String getNoticeYn() {
		return noticeYn;
	}
	public void setNoticeYn(String noticeYn) {
		this.noticeYn = noticeYn;
	}
	public int getChatIdx() {
		return chatIdx;
	}
	public void setChatIdx(int chatIdx) {
		this.chatIdx = chatIdx;
	}
	
	
	public int getMemberIdx() {
		return memberIdx;
	}
	public void setMemberIdx(int memberIdx) {
		this.memberIdx = memberIdx;
	}
	public int getChatRoomIdx() {
		return chatRoomIdx;
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
	public String getFileUrl() {
		return fileUrl;
	}
	public void setFileUrl(String fileUrl) {
		this.fileUrl = fileUrl;
	}
	public void setChatRoomIdx(int chatRoomIdx) {
		this.chatRoomIdx = chatRoomIdx;
	}
	public String getBaseName() {
		return baseName;
	}
	public void setBaseName(String baseName) {
		this.baseName = baseName;
	}
	public String getCustomName() {
		return customName;
	}
	public void setCustomName(String customName) {
		this.customName = customName;
	}
	public chatDto(int chatRoomIdx) {
		this.chatRoomIdx = chatRoomIdx;
	}
	public chatDto(String customName , String baseName) {
		this.customName = customName;
		this.baseName = baseName;
	}
	public chatDto(String inputDateTime, String fileUrl, String name, String emotionFilename,
			String conversation, String noticeYn, int chatIdx , int memberIdx , int replyIdx , String profileImg) {
		this.inputDateTime = inputDateTime;
		this.fileUrl = fileUrl;
		this.name = name;
		this.emotionFilename = emotionFilename;
		this.conversation = conversation;
		this.noticeYn = noticeYn;
		this.chatIdx = chatIdx;
		this.memberIdx = memberIdx;
		this.replyIdx = replyIdx;
		this.profileImg = profileImg;
	}
	public chatDto(String customName, String baseName, String inputDateTime, String fileUrl, String conversation,
			int flyemotionIdx , int chatRoomIdx) {
		this.customName = customName;
		this.baseName = baseName;
		this.inputDateTime = inputDateTime;
		this.fileUrl = fileUrl;
		this.conversation = conversation;
		this.flyemotionIdx = flyemotionIdx;
		this.chatRoomIdx = chatRoomIdx;
		
	}
	
	
}
