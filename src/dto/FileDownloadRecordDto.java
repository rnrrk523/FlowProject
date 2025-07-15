package dto;

public class FileDownloadRecordDto {
	private String downDate;
	private String fileName;
	private String fileCapacity;
	private String downloader;
	
	public FileDownloadRecordDto(String downDate, String fileName, String fileCapacity, String downloader) {
		this.downDate = downDate;
		this.fileName = fileName;
		this.fileCapacity = fileCapacity;
		this.downloader = downloader;
	}
	
	public String getDownDate() {
		return downDate;
	}
	public void setDownDate(String downDate) {
		this.downDate = downDate;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getFileCapacity() {
		return fileCapacity;
	}
	public void setFileCapacity(String fileCapacity) {
		this.fileCapacity = fileCapacity;
	}
	public String getDownloader() {
		return downloader;
	}
	public void setDownloader(String downloader) {
		this.downloader = downloader;
	}
}