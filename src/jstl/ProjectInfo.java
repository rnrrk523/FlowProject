package jstl;

public class ProjectInfo {
	private int projectIdx;
	private int adminCnt;
	private String adminName;
	private int memberCnt;
	private int outsiderCnt;
	private int commentCnt;
	private int chatCnt;
	private int scheduleCnt;
	private int taskCnt;
	private int boardCnt;
	private String lastActivity;
	private String openingDate;
	
	public ProjectInfo(int projectIdx, int adminCnt, String adminName, int memberCnt, int outsiderCnt, int commentCnt,
			int chatCnt, int scheduleCnt, int taskCnt, int boardCnt, String lastActivity, String openingDate) {
		this.projectIdx = projectIdx;
		this.adminCnt = adminCnt;
		this.adminName = adminName;
		this.memberCnt = memberCnt;
		this.outsiderCnt = outsiderCnt;
		this.commentCnt = commentCnt;
		this.chatCnt = chatCnt;
		this.scheduleCnt = scheduleCnt;
		this.taskCnt = taskCnt;
		this.boardCnt = boardCnt;
		this.lastActivity = lastActivity;
		this.openingDate = openingDate;
	}
	
	public int getProjectIdx() {
		return projectIdx;
	}
	public void setProjectIdx(int projectIdx) {
		this.projectIdx = projectIdx;
	}
	public int getAdminCnt() {
		return adminCnt;
	}
	public void setAdminCnt(int adminCnt) {
		this.adminCnt = adminCnt;
	}
	public String getAdminName() {
		return adminName;
	}
	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}
	public int getMemberCnt() {
		return memberCnt;
	}
	public void setMemberCnt(int memberCnt) {
		this.memberCnt = memberCnt;
	}
	public int getOutsiderCnt() {
		return outsiderCnt;
	}
	public void setOutsiderCnt(int outsiderCnt) {
		this.outsiderCnt = outsiderCnt;
	}
	public int getCommentCnt() {
		return commentCnt;
	}
	public void setCommentCnt(int commentCnt) {
		this.commentCnt = commentCnt;
	}
	public int getChatCnt() {
		return chatCnt;
	}
	public void setChatCnt(int chatCnt) {
		this.chatCnt = chatCnt;
	}
	public int getScheduleCnt() {
		return scheduleCnt;
	}
	public void setScheduleCnt(int scheduleCnt) {
		this.scheduleCnt = scheduleCnt;
	}
	public int getTaskCnt() {
		return taskCnt;
	}
	public void setTaskCnt(int taskCnt) {
		this.taskCnt = taskCnt;
	}
	public int getBoardCnt() {
		return boardCnt;
	}
	public void setBoardCnt(int boardCnt) {
		this.boardCnt = boardCnt;
	}
	public String getLastActivity() {
		return lastActivity;
	}
	public void setLastActivity(String lastActivity) {
		this.lastActivity = lastActivity;
	}
	public String getOpeningDate() {
		return openingDate;
	}
	public void setOpeningDate(String openingDate) {
		this.openingDate = openingDate;
	}
}
