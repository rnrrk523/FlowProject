package dto;

public class ProjectAdminDto2 {
	private int participantIdx;
	private String affiliation;
	private String name;
	private String email;
	private String departmentName;
	private String phone;
	
	public ProjectAdminDto2(int participantIdx, String affiliation, String name, String email, String departmentName,
			String phone) {
		this.participantIdx = participantIdx;
		this.affiliation = affiliation;
		this.name = name;
		this.email = email;
		this.departmentName = departmentName;
		this.phone = phone;
	}
	
	public int getParticipantIdx() {
		return participantIdx;
	}
	public void setParticipantIdx(int participantIdx) {
		this.participantIdx = participantIdx;
	}
	public String getAffiliation() {
		return affiliation;
	}
	public void setAffiliation(String affiliation) {
		this.affiliation = affiliation;
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
