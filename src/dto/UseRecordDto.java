package dto;

public class UseRecordDto {
	private int companyIdx;
	private int memberIdx;
	private String cName;
	private String mName;
	private String dName;
	private String position;
	private String email;
	private int boardUseCnt;
	private int commentUseCnt;
	private int chatRoomUseCnt;
	private int chatUseCnt;
	
	public UseRecordDto(int companyIdx, int memberIdx, String cName, String mName, String dName, String position,
			String email, int boardUseCnt, int commentUseCnt, int chatRoomUseCnt, int chatUseCnt) {
		this.companyIdx = companyIdx;
		this.memberIdx = memberIdx;
		this.cName = cName;
		this.mName = mName;
		this.dName = dName;
		this.position = position;
		this.email = email;
		this.boardUseCnt = boardUseCnt;
		this.commentUseCnt = commentUseCnt;
		this.chatRoomUseCnt = chatRoomUseCnt;
		this.chatUseCnt = chatUseCnt;
	}
	
	public int getCompanyIdx() {
		return companyIdx;
	}
	public void setCompanyIdx(int companyIdx) {
		this.companyIdx = companyIdx;
	}
	public int getMemberIdx() {
		return memberIdx;
	}
	public void setMemberIdx(int memberIdx) {
		this.memberIdx = memberIdx;
	}
	public String getcName() {
		return cName;
	}
	public void setcName(String cName) {
		this.cName = cName;
	}
	public String getmName() {
		return mName;
	}
	public void setmName(String mName) {
		this.mName = mName;
	}
	public String getdName() {
		return dName;
	}
	public void setdName(String dName) {
		this.dName = dName;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getBoardUseCnt() {
		return boardUseCnt;
	}
	public void setBoardUseCnt(int boardUseCnt) {
		this.boardUseCnt = boardUseCnt;
	}
	public int getCommentUseCnt() {
		return commentUseCnt;
	}
	public void setCommentUseCnt(int commentUseCnt) {
		this.commentUseCnt = commentUseCnt;
	}
	public int getChatRoomUseCnt() {
		return chatRoomUseCnt;
	}
	public void setChatRoomUseCnt(int chatRoomUseCnt) {
		this.chatRoomUseCnt = chatRoomUseCnt;
	}
	public int getChatUseCnt() {
		return chatUseCnt;
	}
	public void setChatUseCnt(int chatUseCnt) {
		this.chatUseCnt = chatUseCnt;
	}
}
