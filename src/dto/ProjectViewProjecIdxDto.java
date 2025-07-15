package dto;

public class ProjectViewProjecIdxDto {
	private String projectName;
	private String projectExplanation;
	private String homeTab;
	private char approvalYN;
	private int editPostGrant;
	private int writingGrant;
	private int postViewGrant;
	private int commentGrant;
	private int fileViewGrant;
	private int fileDownGrant;
	private int categoryIdx;
	private char companyProjectYN;
	private int companyIdx;
	public ProjectViewProjecIdxDto(String projectName, String projectExplanation, String homeTab, char approvalYN,
			int editPostGrant, int writingGrant, int postViewGrant, int commentGrant, int fileViewGrant,
			int fileDownGrant, int categoryIdx, char companyProjectYN,int companyIdx) {
		this.projectName = projectName;
		this.projectExplanation = projectExplanation;
		this.homeTab = homeTab;
		this.approvalYN = approvalYN;
		this.editPostGrant = editPostGrant;
		this.writingGrant = writingGrant;
		this.postViewGrant = postViewGrant;
		this.commentGrant = commentGrant;
		this.fileViewGrant = fileViewGrant;
		this.fileDownGrant = fileDownGrant;
		this.categoryIdx = categoryIdx;
		this.companyProjectYN = companyProjectYN;
		this.companyIdx = companyIdx;
	}
	
	public int getCompanyIdx() {
		return companyIdx;
	}

	public void setCompanyIdx(int companyIdx) {
		this.companyIdx = companyIdx;
	}

	public char getCompanyProjectYN() {
		return companyProjectYN;
	}

	public void setCompanyProjectYN(char companyProjectYN) {
		this.companyProjectYN = companyProjectYN;
	}

	public int getCategoryIdx() {
		return categoryIdx;
	}

	public void setCategoryIdx(int categoryIdx) {
		this.categoryIdx = categoryIdx;
	}

	public String getProjectName() {
		return projectName;
	}
	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}
	public String getProjectExplanation() {
		return projectExplanation;
	}
	public void setProjectExplanation(String projectExplanation) {
		this.projectExplanation = projectExplanation;
	}
	public String getHomeTab() {
		return homeTab;
	}
	public void setHomeTab(String homeTab) {
		this.homeTab = homeTab;
	}
	public char getApprovalYN() {
		return approvalYN;
	}
	public void setApprovalYN(char approvalYN) {
		this.approvalYN = approvalYN;
	}
	public int getEditPostGrant() {
		return editPostGrant;
	}
	public void setEditPostGrant(int editPostGrant) {
		this.editPostGrant = editPostGrant;
	}
	public int getWritingGrant() {
		return writingGrant;
	}
	public void setWritingGrant(int writingGrant) {
		this.writingGrant = writingGrant;
	}
	public int getPostViewGrant() {
		return postViewGrant;
	}
	public void setPostViewGrant(int postViewGrant) {
		this.postViewGrant = postViewGrant;
	}
	public int getCommentGrant() {
		return commentGrant;
	}
	public void setCommentGrant(int commentGrant) {
		this.commentGrant = commentGrant;
	}
	public int getFileViewGrant() {
		return fileViewGrant;
	}
	public void setFileViewGrant(int fileViewGrant) {
		this.fileViewGrant = fileViewGrant;
	}
	public int getFileDownGrant() {
		return fileDownGrant;
	}
	public void setFileDownGrant(int fileDownGrant) {
		this.fileDownGrant = fileDownGrant;
	}
	

}
