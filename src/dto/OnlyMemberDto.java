package dto;

public class OnlyMemberDto {
	int memberIdx;
	int companyIdx;
	String name;
	String email;
	String pw;
	String phone;
	String companyPhone;
	int departmentIdx;
	String position;
	char adminYN;
	String state;
	String profileImg;
	String hireDate;
	String recentDate;
	String statusMassage;
	String alarmPush;
	String homeTab;
	String projectColorFix;
	
	public OnlyMemberDto(int memberIdx, int companyIdx, String name, String email, String pw, String phone,
			String companyPhone, int departmentIdx, String position, char adminYN, String state, String profileImg,
			String hireDate, String recentDate, String statusMassage, String alarmPush, String homeTab,
			String projectColorFix) {
		this.memberIdx = memberIdx;
		this.companyIdx = companyIdx;
		this.name = name;
		this.email = email;
		this.pw = pw;
		this.phone = phone;
		this.companyPhone = companyPhone;
		this.departmentIdx = departmentIdx;
		this.position = position;
		this.adminYN = adminYN;
		this.state = state;
		this.profileImg = profileImg;
		this.hireDate = hireDate;
		this.recentDate = recentDate;
		this.statusMassage = statusMassage;
		this.alarmPush = alarmPush;
		this.homeTab = homeTab;
		this.projectColorFix = projectColorFix;
	}

	public int getMemberIdx() {
		return memberIdx;
	}

	public void setMemberIdx(int memberIdx) {
		this.memberIdx = memberIdx;
	}

	public int getCompanyIdx() {
		return companyIdx;
	}

	public void setCompanyIdx(int companyIdx) {
		this.companyIdx = companyIdx;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getCompanyPhone() {
		return companyPhone;
	}

	public void setCompanyPhone(String companyPhone) {
		this.companyPhone = companyPhone;
	}

	public int getDepartmentIdx() {
		return departmentIdx;
	}

	public void setDepartmentIdx(int departmentIdx) {
		this.departmentIdx = departmentIdx;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public char getAdminYN() {
		return adminYN;
	}

	public void setAdminYN(char adminYN) {
		this.adminYN = adminYN;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getProfileImg() {
		return profileImg;
	}

	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
	}

	public String getHireDate() {
		return hireDate;
	}

	public void setHireDate(String hireDate) {
		this.hireDate = hireDate;
	}

	public String getRecentDate() {
		return recentDate;
	}

	public void setRecentDate(String recentDate) {
		this.recentDate = recentDate;
	}

	public String getStatusMassage() {
		return statusMassage;
	}

	public void setStatusMassage(String statusMassage) {
		this.statusMassage = statusMassage;
	}

	public String getAlarmPush() {
		return alarmPush;
	}

	public void setAlarmPush(String alarmPush) {
		this.alarmPush = alarmPush;
	}

	public String getHomeTab() {
		return homeTab;
	}

	public void setHomeTab(String homeTab) {
		this.homeTab = homeTab;
	}

	public String getProjectColorFix() {
		return projectColorFix;
	}

	public void setProjectColorFix(String projectColorFix) {
		this.projectColorFix = projectColorFix;
	}
}
