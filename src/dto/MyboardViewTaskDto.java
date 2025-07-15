package dto;

public class MyboardViewTaskDto {
	private String profileIMG;
	private String name;
	private String writeDate;
	private String title;
	private String content;
	private int taskIdx;
	private int state;
	private String startDate;
	private String endDate;
	private int priority;
	private int taskGroupIdx;
	private String taskGroupName;
	private int progress;
	public MyboardViewTaskDto(String profileIMG,String name, String writeDate, String title, String content, int taskIdx, int state,
			String startDate, String endDate, int priority, int taskGroupIdx,String taskGroupName, int progress) {
		this.profileIMG = profileIMG;
		this.name = name;
		this.writeDate = writeDate;
		this.title = title;
		this.content = content;
		this.taskIdx = taskIdx;
		this.state = state;
		this.startDate = startDate;
		this.endDate = endDate;
		this.priority = priority;
		this.taskGroupIdx = taskGroupIdx;
		this.taskGroupName = taskGroupName;
		this.progress = progress;
	}
	
	public int getTaskGroupIdx() {
		return taskGroupIdx;
	}

	public void setTaskGroupIdx(int taskGroupIdx) {
		this.taskGroupIdx = taskGroupIdx;
	}

	public String getProfileIMG() {
		return profileIMG;
	}

	public void setProfileIMG(String profileIMG) {
		this.profileIMG = profileIMG;
	}

	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getWriteDate() {
		return writeDate;
	}
	public void setWriteDate(String writeDate) {
		this.writeDate = writeDate;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
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
	public int getPriority() {
		return priority;
	}
	public void setPriority(int priority) {
		this.priority = priority;
	}
	public String getTaskGroupName() {
		return taskGroupName;
	}
	public void setTaskGroupName(String taskGroupName) {
		this.taskGroupName = taskGroupName;
	}
	public int getProgress() {
		return progress;
	}
	public void setProgress(int progress) {
		this.progress = progress;
	}
	
}
