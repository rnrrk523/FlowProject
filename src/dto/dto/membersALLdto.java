package dto;

public class membersALLdto {
	private String companyName;
	private int memberIdx;
	private int companyIdx;
	private String name;
	private String email;
	private int pw;
	private String phone;
	private String companyPhone;
	private int departmentIdx;
	private String position;
	private char adminYn;
	private String state;
	private String profileImg;
	private String hireDate;
	private String recentDate;
	private String statusMessage;
	private char alarmPush;
	private String homeTabSetting;
	private char projectColorFix;
	private char agree1;
	private char agree2;
	private char agree3;
	private char benefitAgree;
	private char favoriteFix;
	
	public membersALLdto(int memberIdx, int companyIdx, String name, String email, int pw, String phone,
			String companyPhone, int departmentIdx, String position, char adminYn, String state, String profileImg,
			String hireDate, String recentDate, String statusMessage, char alarmPush, String homeTabSetting,
			char projectColorFix, char agree1, char agree2, char agree3, char benefitAgree, char favoriteFix) {
		this.memberIdx = memberIdx;
		this.companyIdx = companyIdx;
		this.name = name;
		this.email = email;
		this.pw = pw;
		this.phone = phone;
		this.companyPhone = companyPhone;
		this.departmentIdx = departmentIdx;
		this.position = position;
		this.adminYn = adminYn;
		this.state = state;
		this.profileImg = profileImg;
		this.hireDate = hireDate;
		this.recentDate = recentDate;
		this.statusMessage = statusMessage;
		this.alarmPush = alarmPush;
		this.homeTabSetting = homeTabSetting;
		this.projectColorFix = projectColorFix;
		this.agree1 = agree1;
		this.agree2 = agree2;
		this.agree3 = agree3;
		this.benefitAgree = benefitAgree;
		this.favoriteFix = favoriteFix;
	}
	public membersALLdto( int memberIdx, int companyIdx, String name, String email, int pw, String phone,
			String companyPhone, int departmentIdx, String position, char adminYn, String state, String profileImg,
			String hireDate, String recentDate, String statusMessage, char alarmPush, String homeTabSetting,
			char projectColorFix, char agree1, char agree2, char agree3, char benefitAgree) {
		this.memberIdx = memberIdx;
		this.companyIdx = companyIdx;
		this.name = name;
		this.email = email;
		this.pw = pw;
		this.phone = phone;
		this.companyPhone = companyPhone;
		this.departmentIdx = departmentIdx;
		this.position = position;
		this.adminYn = adminYn;
		this.state = state;
		this.profileImg = profileImg;
		this.hireDate = hireDate;
		this.recentDate = recentDate;
		this.statusMessage = statusMessage;
		this.alarmPush = alarmPush;
		this.homeTabSetting = homeTabSetting;
		this.projectColorFix = projectColorFix;
		this.agree1 = agree1;
		this.agree2 = agree2;
		this.agree3 = agree3;
		this.benefitAgree = benefitAgree;
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
	public int getPw() {
		return pw;
	}
	public void setPw(int pw) {
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
	public char getAdminYn() {
		return adminYn;
	}
	public void setAdminYn(char adminYn) {
		this.adminYn = adminYn;
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
	public String getStatusMessage() {
		return statusMessage;
	}
	public void setStatusMessage(String statusMessage) {
		this.statusMessage = statusMessage;
	}
	public char getAlarmPush() {
		return alarmPush;
	}
	public void setAlarmPush(char alarmPush) {
		this.alarmPush = alarmPush;
	}
	public String getHomeTabSetting() {
		return homeTabSetting;
	}
	public void setHomeTabSetting(String homeTabSetting) {
		this.homeTabSetting = homeTabSetting;
	}
	public char getProjectColorFix() {
		return projectColorFix;
	}
	public void setProjectColorFix(char projectColorFix) {
		this.projectColorFix = projectColorFix;
	}
	public char getAgree1() {
		return agree1;
	}
	public void setAgree1(char agree1) {
		this.agree1 = agree1;
	}
	public char getAgree2() {
		return agree2;
	}
	public void setAgree2(char agree2) {
		this.agree2 = agree2;
	}
	public char getAgree3() {
		return agree3;
	}
	public void setAgree3(char agree3) {
		this.agree3 = agree3;
	}
	public char getBenefitAgree() {
		return benefitAgree;
	}
	public void setBenefitAgree(char benefitAgree) {
		this.benefitAgree = benefitAgree;
	}
	
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyNmae) {
		this.companyName = companyName;
	}
	public membersALLdto(int memberIdx) {
        this.memberIdx = memberIdx;
    }

    // Getter와 Setter
    public int getmemberIdx() {
        return memberIdx;
    }

    public void setmemberIdx(int memberIdx) {
        this.memberIdx = memberIdx;
    }
    // 나머지 필드에 대한 Getter와 Setter는 기존대로 유지
    public membersALLdto(String name) {
    	this.name = name;
    	
    }
    public membersALLdto(String name , String companyName, int departmentIdx , String email, String phone, String companyPhone,  String position , String statusMessage) {
    	this.name = name;
    	this.companyName = companyName;
    	this.departmentIdx = departmentIdx;
    	this.email = email;
    	this.phone = phone;
    	this.companyPhone = companyPhone;
    	this.position = position;
    	this.statusMessage = statusMessage;
    }
    public membersALLdto(String companyName , String name , String email ,String phone,  String companyPhone , String statusMessage ) {
    	this.phone = phone;
    	this.companyName = companyName;
    	this.name = name;
    	this.email = email;
    	this.companyPhone = companyPhone;
    	this.statusMessage = statusMessage;
    }
    
	public membersALLdto(char alarmPush, String homeTabSetting, char projectColorFix, char favoriteFix) {
		this.alarmPush = alarmPush;
		this.homeTabSetting = homeTabSetting;
		this.projectColorFix = projectColorFix;
		this.favoriteFix = favoriteFix;
	}
}

