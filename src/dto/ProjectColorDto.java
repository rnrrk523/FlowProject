package dto;

public class ProjectColorDto {
	private int projectIdx;
	private String projectName;
	private String colorCode;
	
	public ProjectColorDto(int projectIdx, String projectName, String colorCode) {
		this.projectIdx = projectIdx;
		this.projectName = projectName;
		this.colorCode = colorCode;
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
	public String getColorCode() {
		return colorCode;
	}
	public void setColorCode(String colorCode) {
		this.colorCode = colorCode;
	}
}