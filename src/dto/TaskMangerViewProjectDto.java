package dto;

public class TaskMangerViewProjectDto {
	private String profileImg;
	private int memberIdx;
	private String name;
	private String position;
	private String companyName;
	private String departmentName;
	private char ManagerYN;
	public TaskMangerViewProjectDto(String profileImg, int memberIdx, String name, String position, String companyName,
			String departmentName, char managerYN) {
		this.profileImg = profileImg;
		this.memberIdx = memberIdx;
		this.name = name;
		this.position = position;
		this.companyName = companyName;
		this.departmentName = departmentName;
		ManagerYN = managerYN;
	}
	public String getProfileImg() {
		return profileImg;
	}
	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
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
	public char getManagerYN() {
		return ManagerYN;
	}
	public void setManagerYN(char managerYN) {
		ManagerYN = managerYN;
	}
}
