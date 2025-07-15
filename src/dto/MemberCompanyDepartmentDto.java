package dto;

public class MemberCompanyDepartmentDto {
	private int memberIdx;
	private String companyName;
	private String name;
	private String departmentName;
	private int departmentIdx;
	private String position;
	private String email;
	private String phone;
	private String hireDate;
	private String state;
	private char adminYN;
	
	public MemberCompanyDepartmentDto(int memberIdx, String companyName, String name, String departmentName,
			int departmentIdx, String position, String email, String phone, String hireDate, String state,
			char adminYN) {
		this.memberIdx = memberIdx;
		this.companyName = companyName;
		this.name = name;
		this.departmentName = departmentName;
		this.departmentIdx = departmentIdx;
		this.position = position;
		this.email = email;
		this.phone = phone;
		this.hireDate = hireDate;
		this.state = state;
		this.adminYN = adminYN;
	}
	
	public MemberCompanyDepartmentDto(int memberIdx, String name, String departmentName, String email, String phone) {
		this.memberIdx = memberIdx;
		this.name = name;
		this.departmentName = departmentName;
		this.email = email;
		this.phone = phone;
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
}