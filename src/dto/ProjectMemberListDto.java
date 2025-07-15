package dto;

public class ProjectMemberListDto {
	private int memberIdx;
	private String companyName;
	private String memberName;
	private String position;
	private String departmentName;
	private String prof;
	private char attendYN;
	
	public ProjectMemberListDto(int memberIdx, String companyName, String memberName, String position,
			String departmentName, String prof, char attendYN) {
		this.memberIdx = memberIdx;
		this.companyName = companyName;
		this.memberName = memberName;
		this.position = position;
		this.departmentName = departmentName;
		this.prof = prof;
		this.attendYN = attendYN;
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
	public String getMemberName() {
		return memberName;
	}
	public void setMemberName(String memberName) {
		this.memberName = memberName;
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
	public String getProf() {
		return prof;
	}
	public void setProf(String prof) {
		this.prof = prof;
	}
	public char getAttendYN() {
		return attendYN;
	}
	public void setAttendYN(char attendYN) {
		this.attendYN = attendYN;
	}
}