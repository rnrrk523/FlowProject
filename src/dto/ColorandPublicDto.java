package dto;

public class ColorandPublicDto {
	char projectColorFix;
	char approvalYN;
	public ColorandPublicDto(char projectColorFix, char approvalYN) {
		super();
		this.projectColorFix = projectColorFix;
		this.approvalYN = approvalYN;
	}
	public char getProjectColorFix() {
		return projectColorFix;
	}
	public void setProjectColorFix(char projectColorFix) {
		this.projectColorFix = projectColorFix;
	}
	public char getApprovalYN() {
		return approvalYN;
	}
	public void setApprovalYN(char approvalYN) {
		this.approvalYN = approvalYN;
	}
	
	
}
