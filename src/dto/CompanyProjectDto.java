package dto;

public class CompanyProjectDto {
	private int projectIdx;
	private String pName;
	private int boardCnt;
	private int commentCnt;
	private String lastActivity;
	private String openingDate;
	private String writer;
	
	public CompanyProjectDto(int projectIdx, String pName, int boardCnt, int commentCnt, String lastActivity,
			String openingDate, String writer) {
		this.projectIdx = projectIdx;
		this.pName = pName;
		this.boardCnt = boardCnt;
		this.commentCnt = commentCnt;
		this.lastActivity = lastActivity;
		this.openingDate = openingDate;
		this.writer = writer;
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
	public String getOpeningDate() {
		return openingDate;
	}
	public void setOpeningDate(String openingDate) {
		this.openingDate = openingDate;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
}
