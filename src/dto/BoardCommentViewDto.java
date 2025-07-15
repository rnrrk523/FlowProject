package dto;

public class BoardCommentViewDto {
	private int commentIdx;
	private String profileImg;
	private String name;
	private String CommentContent;
	private String writeTime;
	private int ReplyIdx;
	private int commentCategory;
	public BoardCommentViewDto(String profileImg, String name, String commentContent, String writeTime, int replyIdx,
			int commentCategory, int commentIdx) {
		this.profileImg = profileImg;
		this.name = name;
		CommentContent = commentContent;
		this.writeTime = writeTime;
		ReplyIdx = replyIdx;
		this.commentCategory = commentCategory;
		this.commentIdx = commentIdx;
	}
	
	public int getCommentIdx() {
		return commentIdx;
	}
	public void setCommentIdx(int commentIdx) {
		this.commentIdx = commentIdx;
	}

	public String getProfileImg() {
		return profileImg;
	}
	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCommentContent() {
		return CommentContent;
	}
	public void setCommentContent(String commentContent) {
		CommentContent = commentContent;
	}
	public String getWriteTime() {
		return writeTime;
	}
	public void setWriteTime(String writeTime) {
		this.writeTime = writeTime;
	}
	public int getReplyIdx() {
		return ReplyIdx;
	}
	public void setReplyIdx(int replyIdx) {
		ReplyIdx = replyIdx;
	}
	public int getCommentCategory() {
		return commentCategory;
	}
	public void setCommentCategory(int commentCategory) {
		this.commentCategory = commentCategory;
	}
	
	
}
