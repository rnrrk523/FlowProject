package dto;

public class TaskSearchDto {
	private String title;
	private int state;
	private int priority;
	private String startDate;
	private String endDate;
	private String writeDate;
	private int taskIdx;
	private String name;
	private String lastModifiedDate;
	private int progress;
	private Integer taskGroupIdx;
	public TaskSearchDto(String title, int state, int priority, String startDate, String endDate, String writeDate,
			int taskIdx, String name, String lastModifiedDate, int progress, Integer taskGroupIdx) {
		this.title = title;
		this.state = state;
		this.priority = priority;
		this.startDate = startDate;
		this.endDate = endDate;
		this.writeDate = writeDate;
		this.taskIdx = taskIdx;
		this.name = name;
		this.lastModifiedDate = lastModifiedDate;
		this.progress = progress;
		this.taskGroupIdx = taskGroupIdx;
	}
	

	public Integer getTaskGroupIdx() {
		return taskGroupIdx;
	}
	public void setTaskGroupIdx(Integer taskGroupIdx) {
		this.taskGroupIdx = taskGroupIdx;
	}

	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public int getPriority() {
		return priority;
	}
	public void setPriority(int priority) {
		this.priority = priority;
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
	public String getWriteDate() {
		return writeDate;
	}
	public void setWriteDate(String writeDate) {
		this.writeDate = writeDate;
	}
	public int getTaskIdx() {
		return taskIdx;
	}
	public void setTaskIdx(int taskIdx) {
		this.taskIdx = taskIdx;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getLastModifiedDate() {
		return lastModifiedDate;
	}
	public void setLastModifiedDate(String lastModifiedDate) {
		this.lastModifiedDate = lastModifiedDate;
	}
	public int getProgress() {
		return progress;
	}
	public void setProgress(int progress) {
		this.progress = progress;
	}

}
