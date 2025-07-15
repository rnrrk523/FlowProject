package dto;

public class ProjectAdminDto {
	public char adminYN;
	public int memberIdx;
	
	public ProjectAdminDto(char adminYN, int memberIdx) {
		this.adminYN = adminYN;
		this.memberIdx = memberIdx;
	}

	public int getMemberIdx() {
		return memberIdx;
	}

	public void setMemberIdx(int memberIdx) {
		this.memberIdx = memberIdx;
	}

	public char getAdminYN() {
		return adminYN;
	}

	public void setAdminYN(char adminYN) {
		this.adminYN = adminYN;
	}


}
