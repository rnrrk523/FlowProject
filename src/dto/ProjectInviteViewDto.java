package dto;

public class ProjectInviteViewDto {
	private int memberIdx;
	private String profileImg;
	private String name;
	private String position;
	private String companyName;
	private String departmentName;
	private String readDate;
	public ProjectInviteViewDto(int memberIdx, String profileImg, String name, String position, String companyName,
			String departmentName, String readDate) {
		this.memberIdx = memberIdx;
		this.profileImg = profileImg;
		this.name = name;
		this.position = position;
		this.companyName = companyName;
		this.departmentName = departmentName;
		this.readDate = readDate;
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public String getDepartmentName() {
		return departmentName;
	}
	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}
	public String getReadDate() {
		return readDate;
	}
	public void setReadDate(String readDate) {
		this.readDate = readDate;
	}
	
}
