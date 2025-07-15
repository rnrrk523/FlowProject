package dto;

public class PermissionSettingDto {
	private int pIdx;
	private String pName;
	private int editPostGrant;
	private int writingGrant;
	private int postViewGrant;
	private int commentGrant;
	private int fileViewGrant;
	private int fileDownGrant;
	public PermissionSettingDto(int pIdx, String pName, int editPostGrant, int writingGrant, int postViewGrant,
			int commentGrant, int fileViewGrant, int fileDownGrant) {
		this.pIdx = pIdx;
		this.pName = pName;
		this.editPostGrant = editPostGrant;
		this.writingGrant = writingGrant;
		this.postViewGrant = postViewGrant;
		this.commentGrant = commentGrant;
		this.fileViewGrant = fileViewGrant;
		this.fileDownGrant = fileDownGrant;
	}
	
	public int getpIdx() {
		return pIdx;
	}
	public void setpIdx(int pIdx) {
		this.pIdx = pIdx;
	}
	public String getpName() {
		return pName;
	}
	public void setpName(String pName) {
		this.pName = pName;
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
