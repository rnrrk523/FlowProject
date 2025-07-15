package dto;

public class OpenProjectInfoDto {
	private int categoryIdx;
	private String categoryName;
	private String pName;
	private int writingGrant;
	private int commentGrant;
	private int postViewGrant;
	private int fileViewGrant;
	private int fileDownGrant;
	private int editPostGrant;
	
	public OpenProjectInfoDto(int categoryIdx, String categoryName, String pName, int writingGrant, int commentGrant,
			int postViewGrant, int fileViewGrant, int fileDownGrant, int editPostGrant) {
		this.categoryIdx = categoryIdx;
		this.categoryName = categoryName;
		this.pName = pName;
		this.writingGrant = writingGrant;
		this.commentGrant = commentGrant;
		this.postViewGrant = postViewGrant;
		this.fileViewGrant = fileViewGrant;
		this.fileDownGrant = fileDownGrant;
		this.editPostGrant = editPostGrant;
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
	public String getpName() {
		return pName;
	}
	public void setpName(String pName) {
		this.pName = pName;
	}
	public int getWritingGrant() {
		return writingGrant;
	}
	public void setWritingGrant(int writingGrant) {
		this.writingGrant = writingGrant;
	}
	public int getCommentGrant() {
		return commentGrant;
	}
	public void setCommentGrant(int commentGrant) {
		this.commentGrant = commentGrant;
	}
	public int getPostViewGrant() {
		return postViewGrant;
	}
	public void setPostViewGrant(int postViewGrant) {
		this.postViewGrant = postViewGrant;
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
	public int getEditPostGrant() {
		return editPostGrant;
	}
	public void setEditPostGrant(int editPostGrant) {
		this.editPostGrant = editPostGrant;
	}
}
