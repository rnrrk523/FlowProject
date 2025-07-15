package dto;

public class BoardEmotionDto {
	private int memberIdx;
	private String name;
	private String profileImg;
	private int emotionType;
	private int countemotion;
	public BoardEmotionDto(int memberIdx, String name, String profileImg, int emotionType, int countemotion) {
		this.memberIdx = memberIdx;
		this.name = name;
		this.profileImg = profileImg;
		this.emotionType = emotionType;
		this.countemotion = countemotion;
	}
	
	

	public int getMemberIdx() {
		return memberIdx;
	}



	public void setMemberIdx(int memberIdx) {
		this.memberIdx = memberIdx;
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
	public int getEmotionType() {
		return emotionType;
	}
	public void setEmotionType(int emotionType) {
		this.emotionType = emotionType;
	}
	public int getCountemotion() {
		return countemotion;
	}
	public void setCountemotion(int countemotion) {
		this.countemotion = countemotion;
	}
}
