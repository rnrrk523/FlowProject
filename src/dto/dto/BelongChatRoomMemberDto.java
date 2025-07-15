package dto;

public class BelongChatRoomMemberDto {
	private int memberIdx;
	private String MemberName;
	private int companyIdx;
	private String companyName;
	private String profileImg;
	public BelongChatRoomMemberDto(int memberIdx, String memberName , int companyIdx , String companyName , String profileImg) {
		this.memberIdx = memberIdx;
		this.MemberName = memberName;
		this.companyIdx = companyIdx;
		this.companyName = companyName;
		this.profileImg = profileImg;
	}
	public int getCompanyIdx() {
		return companyIdx;
	}
	public void setCompanyIdx(int companyIdx) {
		this.companyIdx = companyIdx;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public int getMemberIdx() {
		return memberIdx;
	}
	public void setMemberIdx(int memberIdx) {
		this.memberIdx = memberIdx;
	}
	public String getProfileImg() {
		return profileImg;
	}
	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
	}
	public String getMemberName() {
		return MemberName;
	}
	public void setMemberName(String memberName) {
		MemberName = memberName;
	}
	
}
