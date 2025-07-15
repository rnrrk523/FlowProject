package dto;

public class LastActivityProjectDto {
	private int projectIdx;
	private String projectName;
	private String lastActivityDate;
	private String projectColor;
	
	public LastActivityProjectDto(int projectIdx, String projectName, String lastActivityDate, String projectColor) {
		super();
		this.projectIdx = projectIdx;
		this.projectName = projectName;
		this.lastActivityDate = lastActivityDate;
		this.projectColor = projectColor;
	}
	
	public int getProjectIdx() {
		return projectIdx;
	}
	public void setProjectIdx(int projectIdx) {
		this.projectIdx = projectIdx;
	}
	public String getProjectName() {
		return projectName;
	}
	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}
	public String getLastActivityDate() {
		return lastActivityDate;
	}
	public void setLastActivityDate(String lastActivityDate) {
		this.lastActivityDate = lastActivityDate;
	}
	public String getProjectColor() {
		return projectColor;
	}
	public void setProjectColor(String projectColor) {
		this.projectColor = projectColor;
	}
}