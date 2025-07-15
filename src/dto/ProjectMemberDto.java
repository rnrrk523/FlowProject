package dto;

public class ProjectMemberDto {
	private int pIdx;
	private String name;
	private String email;
	private char adminYN;
	
	public ProjectMemberDto(int pIdx, String name, String email, char adminYN) {
		this.pIdx = pIdx;
		this.name = name;
		this.email = email;
		this.adminYN = adminYN;
	}
	
	public int getpIdx() {
		return pIdx;
	}
	public void setpIdx(int pIdx) {
		this.pIdx = pIdx;
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
	public char getAdminYN() {
		return adminYN;
	}
	public void setAdminYN(char adminYN) {
		this.adminYN = adminYN;
	}
}
