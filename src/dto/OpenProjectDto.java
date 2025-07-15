package dto;

public class OpenProjectDto {
	private int projectIdx;
	private String pName;
	private String categoryName;
	private int memberCnt;
	private int boardCnt;
	private int commentCnt;
	private String lastActivity;
	private String opDate;
	
	public OpenProjectDto(int projectIdx, String pName, String categoryName, int memberCnt, int boardCnt,
			int commentCnt, String lastActivity, String opDate) {
		this.projectIdx = projectIdx;
		this.pName = pName;
		this.categoryName = categoryName;
		this.memberCnt = memberCnt;
		this.boardCnt = boardCnt;
		this.commentCnt = commentCnt;
		this.lastActivity = lastActivity;
		this.opDate = opDate;
	}
	
	public int getProjectIdx() {
		return projectIdx;
	}
	public void setProjectIdx(int projectIdx) {
		this.projectIdx = projectIdx;
	}
	public String getpName() {
		return pName;
	}
	public void setpName(String pName) {
		this.pName = pName;
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
	public int getBoardCnt() {
		return boardCnt;
	}
	public void setBoardCnt(int boardCnt) {
		this.boardCnt = boardCnt;
	}
	public int getCommentCnt() {
		return commentCnt;
	}
	public void setCommentCnt(int commentCnt) {
		this.commentCnt = commentCnt;
	}
	public String getLastActivity() {
		return lastActivity;
	}
	public void setLastActivity(String lastActivity) {
		this.lastActivity = lastActivity;
	}
	public String getOpDate() {
		return opDate;
	}
	public void setOpDate(String opDate) {
		this.opDate = opDate;
	}
}
