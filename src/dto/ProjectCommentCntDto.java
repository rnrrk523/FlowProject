package dto;

public class ProjectCommentCntDto {
	private int projectIdx;
	private int commentCnt;
	
	public ProjectCommentCntDto(int projectIdx, int commentCnt) {
		this.projectIdx = projectIdx;
		this.commentCnt = commentCnt;
	}
	
	public int getProjectIdx() {
		return projectIdx;
	}
	public void setProjectIdx(int projectIdx) {
		this.projectIdx = projectIdx;
	}
	public int getCommentCnt() {
		return commentCnt;
	}
	public void setCommentCnt(int commentCnt) {
		this.commentCnt = commentCnt;
	}
}
