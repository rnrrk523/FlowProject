package dto;

public class chatRoomMemberListAndStatedto {
	private String name;
	private String profileImg;
	private String chatMemberAdminYn;
	public chatRoomMemberListAndStatedto(String name, String profileImg, String chatMemberAdminYn) {
		super();
		this.name = name;
		this.profileImg = profileImg;
		this.chatMemberAdminYn = chatMemberAdminYn;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getProfileImg() {
		return profileImg;
	}
	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
	}
	public String getChatMemberAdminYn() {
		return chatMemberAdminYn;
	}
	public void setChatMemberAdminYn(String chatMemberAdminYn) {
		this.chatMemberAdminYn = chatMemberAdminYn;
	}

}
