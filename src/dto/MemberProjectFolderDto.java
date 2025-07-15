package dto;

public class MemberProjectFolderDto {
	private int floderIdx;
	private int memberIdx;
	private String forderName;
	private int projectIdx;
	public MemberProjectFolderDto(int floderIdx, int memberIdx, String forderName, int projectIdx) {
		this.floderIdx = floderIdx;
		this.memberIdx = memberIdx;
		this.forderName = forderName;
		this.projectIdx = projectIdx;
	}
	public int getFloderIdx() {
		return floderIdx;
	}
	public void setFloderIdx(int floderIdx) {
		this.floderIdx = floderIdx;
	}
	public int getMemberIdx() {
		return memberIdx;
	}
	public void setMemberIdx(int memberIdx) {
		this.memberIdx = memberIdx;
	}
	public String getForderName() {
		return forderName;
	}
	public void setForderName(String forderName) {
		this.forderName = forderName;
	}
	public int getProjectIdx() {
		return projectIdx;
	}
	public void setProjectIdx(int projectIdx) {
		this.projectIdx = projectIdx;
	}

}
