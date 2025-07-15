package dto;

public class fileDto {
	int fileIdx;
	private String projectName;
	private String fileName;
	private String fileType;
	private String fileUrl;
	private String fileCapacity;
	private String fileDate;
	private String writer;
	private int projectIdx;
	private int projectColor;
	private String colorPrint;
	public String getColorPrint() {
		return colorPrint;
	}
	public void setColorPrint(String colorPrint) {
		this.colorPrint = colorPrint;
	}
	public fileDto(int fileIdx, String projectName, String fileName, String fileType, String fileUrl,
			String fileCapacity, String fileDate , String writer , int projectIdx) {
		this.fileIdx = fileIdx;
		this.projectName = projectName;
		this.fileName = fileName;
		this.fileType = fileType;
		this.fileUrl = fileUrl;
		this.fileCapacity = fileCapacity;
		this.fileDate = fileDate;
		this.writer = writer;
		this.projectIdx = projectIdx;
	}
	public fileDto(String colorPrint) {
		this.colorPrint = colorPrint;
	}
	public int getProjectColor() {
		return projectColor;
	}
	public void setProjectColor(int projectColor) {
		this.projectColor = projectColor;
	}
	public fileDto(int projectIdx , String projectName , int projectColor) {
		this.projectIdx = projectIdx;
		this.projectName = projectName;
		this.projectColor = projectColor;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getFileDate() {
		return fileDate;
	}
	public void setFileDate(String fileDate) {
		this.fileDate = fileDate;
	}
	public int getProjectIdx() {
		return projectIdx;
	}
	public void setProjectIdx(int projectIdx) {
		this.projectIdx = projectIdx;
	}
	public int getFileIdx() {
		return fileIdx;
	}
	public void setFileIdx(int fileIdx) {
		this.fileIdx = fileIdx;
	}
	public String getProjectName() {
		return projectName;
	}
	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getFileType() {
		return fileType;
	}
	public void setFileType(String fileType) {
		this.fileType = fileType;
	}
	public String getFileUrl() {
		return fileUrl;
	}
	public void setFileUrl(String fileUrl) {
		this.fileUrl = fileUrl;
	}
	public String getFileCapacity() {
		return fileCapacity;
	}
	public void setFileCapacity(String fileCapacity) {
		this.fileCapacity = fileCapacity;
	}
}
