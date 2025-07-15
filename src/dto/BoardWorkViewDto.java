package dto;

public class BoardWorkViewDto {
	private int workIdx;
	private int perWorkIdx;
	private String workContent;
	private char workComple;
	private String workDate;
	private String name;
	private String profileImg;
	private int totalCount;
	private int completedCount;
	private int totalPercent;
	public BoardWorkViewDto(int workIdx, int perWorkIdx, String workContent, char workComple, String workDate,
			String name, String profileImg, int totalCount, int completedCount, int totalPercent) {
		this.workIdx = workIdx;
		this.perWorkIdx = perWorkIdx;
		this.workContent = workContent;
		this.workComple = workComple;
		this.workDate = workDate;
		this.name = name;
		this.profileImg = profileImg;
		this.totalCount = totalCount;
		this.completedCount = completedCount;
		this.totalPercent = totalPercent;
	}
	public int getWorkIdx() {
		return workIdx;
	}
	public void setWorkIdx(int workIdx) {
		this.workIdx = workIdx;
	}
	public int getPerWorkIdx() {
		return perWorkIdx;
	}
	public void setPerWorkIdx(int perWorkIdx) {
		this.perWorkIdx = perWorkIdx;
	}
	public String getWorkContent() {
		return workContent;
	}
	public void setWorkContent(String workContent) {
		this.workContent = workContent;
	}
	public char getWorkComple() {
		return workComple;
	}
	public void setWorkComple(char workComple) {
		this.workComple = workComple;
	}
	public String getWorkDate() {
		return workDate;
	}
	public void setWorkDate(String workDate) {
		this.workDate = workDate;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getProfileImg() {
		return profileImg;
	}
	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
	}
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
	public int getCompletedCount() {
		return completedCount;
	}
	public void setCompletedCount(int completedCount) {
		this.completedCount = completedCount;
	}
	public int getTotalPercent() {
		return totalPercent;
	}
	public void setTotalPercent(int totalPercent) {
		this.totalPercent = totalPercent;
	}
	
}
