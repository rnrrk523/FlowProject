package dto;

public class DelProjectInfoDto {
	private String name;
	private String email;
	private String departmentName;
	private String phone;
	private char adminYN;
	
	public DelProjectInfoDto(String name, String email, String departmentName, String phone, char adminYN) {
		this.name = name;
		this.email = email;
		this.departmentName = departmentName;
		this.phone = phone;
		this.adminYN = adminYN;
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
	public char getAdminYN() {
		return adminYN;
	}
	public void setAdminYN(char adminYN) {
		this.adminYN = adminYN;
	}
}
