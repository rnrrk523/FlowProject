package dto;

public class DeactivProjectDto {
	private int projectIdx;
	private String pName;
	private String writer;
	private String lastActivity;
	
	public DeactivProjectDto(int projectIdx, String pName, String writer, String lastActivity) {
		this.projectIdx = projectIdx;
		this.pName = pName;
		this.writer = writer;
		this.lastActivity = lastActivity;
	}
	
	public int getProjectIdx() {
		return projectIdx;
	}
	public void setProjectIdx(int projectIdx) {
		this.projectIdx = projectIdx;
	}
	public String getpName() {
		return pName;
	}
	public void setpName(String pName) {
		this.pName = pName;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getLastActivity() {
		return lastActivity;
	}
	public void setLastActivity(String lastActivity) {
		this.lastActivity = lastActivity;
	}
}
