package dto;

public class MemberDto {
	private String profileImg;
	private	int memberIdx;
	private int companyIdx;
	private String companyName;
	private String name;
	private String departmentName;
	private String position;
	private String email;
	private String phone;
	private String hireDate;
	private String state;
	private String hometabSetting;
	private char adminYN;
	private String statusMessage;
	private char projectColorFix;
	
	

	public MemberDto(int memberIdx,int companyIdx, String companyName, String name, String departmentName, String position,
			String email, String phone, String hireDate, String state, char adminYN, String statusMessage,
			char projectColorFix, String profileImg, String hometabSetting) {
		this.memberIdx = memberIdx;
		this.companyIdx = companyIdx;
		this.companyName = companyName;
		this.name = name;
		this.departmentName = departmentName;
		this.position = position;
		this.email = email;
		this.phone = phone;
		this.hireDate = hireDate;
		this.state = state;
		this.adminYN = adminYN;
		this.statusMessage = statusMessage;
		this.projectColorFix = projectColorFix;
		this.profileImg = profileImg;
		this.hometabSetting = hometabSetting;
	}
	
	public String getHometabSetting() {
		return hometabSetting;
	}

	public void setHometabSetting(String hometabSetting) {
		this.hometabSetting = hometabSetting;
	}

	public int getCompanyIdx() {
		return companyIdx;
	}

	public void setCompanyIdx(int companyIdx) {
		this.companyIdx = companyIdx;
	}

	public String getProfileImg() {
		return profileImg;
	}

	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
	}

	public char getProjectColorFix() {
		return projectColorFix;
	}

	public void setProjectColorFix(char projectColorFix) {
		this.projectColorFix = projectColorFix;
	}

	public void setStatusMessage(String statusMessage) {
		this.statusMessage = statusMessage;
	}

	public int getMemberIdx() {
		return memberIdx;
	}

	public void setMemberIdx(int memberIdx) {
		this.memberIdx = memberIdx;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDepartmentName() {
		return departmentName;
	}

	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getHireDate() {
		return hireDate;
	}

	public void setHireDate(String hireDate) {
		this.hireDate = hireDate;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public char getAdminYN() {
		return adminYN;
	}

	public void setAdminYN(char adminYN) {
		this.adminYN = adminYN;
	}
	public String getStatusMessage() {
		return statusMessage;
	}
	public void setStateMessage(String statusMessage) {
		this.statusMessage = statusMessage;
	}
	
}
