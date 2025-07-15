package dto;

public class ComProjectAdminListDto {
	private int memberIdx;
	private String name;
	private String email;
	private String departmentName;
	private String phone;
	
	public ComProjectAdminListDto(int memberIdx, String name, String email, String departmentName, String phone) {
		this.memberIdx = memberIdx;
		this.name = name;
		this.email = email;
		this.departmentName = departmentName;
		this.phone = phone;
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
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getDepartmentName() {
		return departmentName;
	}
	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
}
