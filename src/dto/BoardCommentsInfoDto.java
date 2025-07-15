package dto;

public class BoardCommentsInfoDto {
	private int commentIdx;
	private int writerIdx;
	private String commentContent;
	private String writeTime;
	private int replyIdx;
	private int commentCategory;
	
	public BoardCommentsInfoDto(int commentIdx, int writerIdx, String commentContent, String writeTime, int replyIdx,
			int commentCategory) {
		this.commentIdx = commentIdx;
		this.writerIdx = writerIdx;
		this.commentContent = commentContent;
		this.writeTime = writeTime;
		this.replyIdx = replyIdx;
		this.commentCategory = commentCategory;
	}
	
	public int getCommentIdx() {
		return commentIdx;
	}
	public void setCommentIdx(int commentIdx) {
		this.commentIdx = commentIdx;
	}
	public int getWriterIdx() {
		return writerIdx;
	}
	public void setWriterIdx(int writerIdx) {
		this.writerIdx = writerIdx;
	}
	public String getCommentContent() {
		return commentContent;
	}
	public void setCommentContent(String commentContent) {
		this.commentContent = commentContent;
	}
	public String getWriteTime() {
		return writeTime;
	}
	public void setWriteTime(String writeTime) {
		this.writeTime = writeTime;
	}
	public int getReplyIdx() {
		return replyIdx;
	}
	public void setReplyIdx(int replyIdx) {
		this.replyIdx = replyIdx;
	}
	public int getCommentCategory() {
		return commentCategory;
	}
	public void setCommentCategory(int commentCategory) {
		this.commentCategory = commentCategory;
	}
}
