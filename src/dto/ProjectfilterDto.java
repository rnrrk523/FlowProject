package dto;

public class ProjectfilterDto {
	private int projectIdx;
	private int writerIdx;
	private String title;
	private String content;
	private String category;
	private char TopFixed;
	private char TemporaryStorage;
	private String writeDate;
	
	public ProjectfilterDto(int projectIdx, int writerIdx, String title, String content, String category, char topFixed,
			char temporaryStorage, String writeDate) {
		this.projectIdx = projectIdx;
		this.writerIdx = writerIdx;
		this.title = title;
		this.content = content;
		this.category = category;
		TopFixed = topFixed;
		TemporaryStorage = temporaryStorage;
		this.writeDate = writeDate;
	}
	public int getProjectIdx() {
		return projectIdx;
	}
	public void setProjectIdx(int projectIdx) {
		this.projectIdx = projectIdx;
	}
	public int getWriterIdx() {
		return writerIdx;
	}
	public void setWriterIdx(int writerIdx) {
		this.writerIdx = writerIdx;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public char getTopFixed() {
		return TopFixed;
	}
	public void setTopFixed(char topFixed) {
		TopFixed = topFixed;
	}
	public char getTemporaryStorage() {
		return TemporaryStorage;
	}
	public void setTemporaryStorage(char temporaryStorage) {
		TemporaryStorage = temporaryStorage;
	}
	public String getWriteDate() {
		return writeDate;
	}
	public void setWriteDate(String writeDate) {
		this.writeDate = writeDate;
	}
	

}
