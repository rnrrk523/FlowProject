package dto;

public class CompanyPublicProjectDto {
	private int projectIdx;
	private String projectName;
	private int categoryIdx;
	private String categoryName;
	private int memberCnt;
	private String participant_yn;
	private String firstAdminName;
	
	public CompanyPublicProjectDto(int projectIdx, String projectName, int categoryIdx, String categoryName,
			int memberCnt, String participant_yn, String firstAdminName) {
		this.projectIdx = projectIdx;
		this.projectName = projectName;
		this.categoryIdx = categoryIdx;
		this.categoryName = categoryName;
		this.memberCnt = memberCnt;
		this.participant_yn = participant_yn;
		this.firstAdminName = firstAdminName;
	}
	
	public int getProjectIdx() {
		return projectIdx;
	}
	public void setProjectIdx(int projectIdx) {
		this.projectIdx = projectIdx;
	}
	public String getProjectName() {
		return projectName;
	}
	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}
	public int getCategoryIdx() {
		return categoryIdx;
	}
	public void setCategoryIdx(int categoryIdx) {
		this.categoryIdx = categoryIdx;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	public int getMemberCnt() {
		return memberCnt;
	}
	public void setMemberCnt(int memberCnt) {
		this.memberCnt = memberCnt;
	}
	public String getParticipant_yn() {
		return participant_yn;
	}
	public void setParticipant_yn(String participant_yn) {
		this.participant_yn = participant_yn;
	}
	public String getFirstAdminName() {
		return firstAdminName;
	}
	public void setFirstAdminName(String firstAdminName) {
		this.firstAdminName = firstAdminName;
	}
}