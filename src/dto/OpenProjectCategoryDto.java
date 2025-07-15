package dto;

public class OpenProjectCategoryDto {
	private int categoryIdx;
	private String name;
	private int projectCnt;
	private char state;
	
	public OpenProjectCategoryDto(int categoryIdx, String name, int projectCnt, char state) {
		this.categoryIdx = categoryIdx;
		this.name = name;
		this.projectCnt = projectCnt;
		this.state = state;
	}
	
	public int getCategoryIdx() {
		return categoryIdx;
	}
	public void setCategoryIdx(int categoryIdx) {
		this.categoryIdx = categoryIdx;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getProjectCnt() {
		return projectCnt;
	}
	public void setProjectCnt(int projectCnt) {
		this.projectCnt = projectCnt;
	}
	public char getState() {
		return state;
	}
	public void setState(char state) {
		this.state = state;
	}
}
