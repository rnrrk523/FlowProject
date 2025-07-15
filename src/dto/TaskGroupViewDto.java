package dto;

public class TaskGroupViewDto {
	private int taskGroupIdx;
	private String taskGroupName;
	public TaskGroupViewDto(int taskGroupIdx, String taskGroupName) {
		this.taskGroupIdx = taskGroupIdx;
		this.taskGroupName = taskGroupName;
	}
	public int getTaskGroupIdx() {
		return taskGroupIdx;
	}
	public void setTaskGroupIdx(int taskGroupIdx) {
		this.taskGroupIdx = taskGroupIdx;
	}
	public String getTaskGroupName() {
		return taskGroupName;
	}
	public void setTaskGroupName(String taskGroupName) {
		this.taskGroupName = taskGroupName;
	}
	
}
