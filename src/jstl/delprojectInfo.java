package jstl;

public class delprojectInfo {
	private int projectIdx;
    private String adminName;
    private int adminCnt;
    private int outsiderCnt;
    private String writer;
    private int taskCnt;
    private int boardCnt;
    private int commentCnt;
    private String lastActivity;
    
	public delprojectInfo(int projectIdx, String adminName, int adminCnt, int outsiderCnt, String writer, int taskCnt,
			int boardCnt, int commentCnt, String lastActivity) {
		this.projectIdx = projectIdx;
		this.adminName = adminName;
		this.adminCnt = adminCnt;
		this.outsiderCnt = outsiderCnt;
		this.writer = writer;
		this.taskCnt = taskCnt;
		this.boardCnt = boardCnt;
		this.commentCnt = commentCnt;
		this.lastActivity = lastActivity;
	}
	
	public int getProjectIdx() {
		return projectIdx;
	}
	public void setProjectIdx(int projectIdx) {
		this.projectIdx = projectIdx;
	}
	public String getAdminName() {
		return adminName;
	}
	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}
	public int getAdminCnt() {
		return adminCnt;
	}
	public void setAdminCnt(int adminCnt) {
		this.adminCnt = adminCnt;
	}
	public int getOutsiderCnt() {
		return outsiderCnt;
	}
	public void setOutsiderCnt(int outsiderCnt) {
		this.outsiderCnt = outsiderCnt;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
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
}