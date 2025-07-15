package dto;

public class bookMarkDto {
	private String title;
	private int boardIdx;
	private String boardName;
	private int chatCnt;
	private String writer;
	private String writeDate;
	private String content;
	private String name;
	private String category;
	private String projectName;
	private String lastModifiedDate;
	private int memberIdx;
	public String getLastModifiedDate() {
		return lastModifiedDate;
	}
	public void setLastModifiedDate(String lastModifiedDate) {
		this.lastModifiedDate = lastModifiedDate;
	}
	public int getMemberIdx() {
		return memberIdx;
	}
	public void setMemberIdx(int memberIdx) {
		this.memberIdx = memberIdx;
	}
	public String getProjectName() {
		return projectName;
	}
	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public bookMarkDto(int boardIdx) {
		this.boardIdx = boardIdx;
	}
	public bookMarkDto(int memberIdx , String category, String lastModifiedDate , String title , String projectName , String name) {
		this.memberIdx = memberIdx;
		this.category = category;
		this.lastModifiedDate = lastModifiedDate;
		this.title = title;
		this.projectName = projectName;
		this.name = name;
	}
	public bookMarkDto(String writeDate , String title , String content , String name , String category , String projectName) {
		this.writeDate = writeDate;
		this.title = title;
		this.content = content;
		this.name = name;
		this.category = category;
		this.projectName = projectName;
	}
	
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getBoardIdx() {
		return boardIdx;
	}
	public void setBoardIdx(int boardIdx) {
		this.boardIdx = boardIdx;
	}
	public String getBoardName() {
		return boardName;
	}
	public void setBoardName(String boardName) {
		this.boardName = boardName;
	}
	public int getChatCnt() {
		return chatCnt;
	}
	public void setChatCnt(int chatCnt) {
		this.chatCnt = chatCnt;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getWriteDate() {
		return writeDate;
	}
	public void setWriteDate(String writeDate) {
		this.writeDate = writeDate;
	}
}
