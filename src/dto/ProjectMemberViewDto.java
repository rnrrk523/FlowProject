package dto;

public class ProjectMemberViewDto {
	private int memberIdx;
	private String name;
	private int companyIdx;
	private String companyName;
	private String position;
	private String departmentName;
	private char adminYN;
	private String ProfileImg;
	public ProjectMemberViewDto(int memberIdx, String name,int companyIdx, String companyName, String position, String departmentName, char adminYN, String ProfileImg) {
		this.name = name;
		this.companyName = companyName;
		this.position = position;
		this.departmentName = departmentName;
		this.adminYN = adminYN;
		this.ProfileImg = ProfileImg;
		this.memberIdx = memberIdx;
		this.companyIdx = companyIdx;
	}
	public int getCompanyIdx() {
		return companyIdx;
	}

	public void setCompanyIdx(int companyIdx) {
		this.companyIdx = companyIdx;
	}

	public int getMemberIdx() {
		return memberIdx;
	}

	public void setMemberIdx(int memberIdx) {
		this.memberIdx = memberIdx;
	}

	public String getProfileImg() {
		return ProfileImg;
	}

	public void setProfileImg(String profileImg) {
		ProfileImg = profileImg;
	}

	public char getAdminYN() {
		return adminYN;
	}

	public void setAdminYN(char adminYN) {
		this.adminYN = adminYN;
	}

	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public String getDepartmentName() {
		return departmentName;
	}
	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}
	
}
