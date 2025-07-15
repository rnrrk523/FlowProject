package dto;

public class RequestTaskDto {
	private int taskIdx;
	private int state;
	private String title;
	private int priority;
	private String endDate;
	public RequestTaskDto(int taskIdx, int state, String title, int priority, String endDate) {
		this.taskIdx = taskIdx;
		this.state = state;
		this.title = title;
		this.priority = priority;
		this.endDate = endDate;
	}
	public int getTaskIdx() {
		return taskIdx;
	}
	public void setTaskIdx(int taskIdx) {
		this.taskIdx = taskIdx;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getPriority() {
		return priority;
	}
	public void setPriority(int priority) {
		this.priority = priority;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	
}
