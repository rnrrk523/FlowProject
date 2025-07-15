package dto;

public class BookmarkSideTabDto {
	private int boardIdx;
	private int projectIdx;
	private String boardTitle;
	private String projectName;
	private String boardCategory;
	private int writerIdx;
	private String writerName;
	private String writeDate;
	
	public BookmarkSideTabDto(int boardIdx, int projectIdx, String boardTitle, String projectName, String boardCategory,
			int writerIdx, String writerName, String writeDate) {
		this.boardIdx = boardIdx;
		this.projectIdx = projectIdx;
		this.boardTitle = boardTitle;
		this.projectName = projectName;
		this.boardCategory = boardCategory;
		this.writerIdx = writerIdx;
		this.writerName = writerName;
		this.writeDate = writeDate;
	}
	
	public int getBoardIdx() {
		return boardIdx;
	}
	public void setBoardIdx(int boardIdx) {
		this.boardIdx = boardIdx;
	}
	public int getProjectIdx() {
		return projectIdx;
	}
	public void setProjectIdx(int projectIdx) {
		this.projectIdx = projectIdx;
	}
	public String getBoardTitle() {
		return boardTitle;
	}
	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}
	public String getProjectName() {
		return projectName;
	}
	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}
	public String getBoardCategory() {
		return boardCategory;
	}
	public void setBoardCategory(String boardCategory) {
		this.boardCategory = boardCategory;
	}
	public int getWriterIdx() {
		return writerIdx;
	}
	public void setWriterIdx(int writerIdx) {
		this.writerIdx = writerIdx;
	}
	public String getWriterName() {
		return writerName;
	}
	public void setWriterName(String writerName) {
		this.writerName = writerName;
	}
	public String getWriteDate() {
		return writeDate;
	}
	public void setWriteDate(String writeDate) {
		this.writeDate = writeDate;
	}
}
