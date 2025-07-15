package dto;

public class TaskCalendarDto {
	private int taskIdx;
	private String title;
	private String startDate;
	private String endDate;
	private String state;
	
	public TaskCalendarDto(int taskIdx, String title, String startDate, String endDate, String state) {
		this.taskIdx = taskIdx;
		this.title = title;
		this.startDate = startDate;
		this.endDate = endDate;
		this.state = state;
	}
	
	public int getTaskIdx() {
		return taskIdx;
	}
	public void setTaskIdx(int taskIdx) {
		this.taskIdx = taskIdx;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
}
