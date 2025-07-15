package dto;

public class TaskViewOptionDto {
	private int memberIdx;
    private char workNameYN;
    private char stateYN;
    private char priorityYN;
    private char managerYN;
    private char startDateYN;
    private char deadLineYN;
    private char registrationDateYN;
    private char taskIdxYN;
    private char writerYN;
    private char lastModifiedDateYN;
    private char progressYN;
	public TaskViewOptionDto(int memberIdx, char workNameYN, char stateYN, char priorityYN, char managerYN,
			char startDateYN, char deadLineYN, char registrationDateYN, char taskIdxYN, char writerYN,
			char lastModifiedDateYN, char progressYN) {
		this.memberIdx = memberIdx;
		this.workNameYN = workNameYN;
		this.stateYN = stateYN;
		this.priorityYN = priorityYN;
		this.managerYN = managerYN;
		this.startDateYN = startDateYN;
		this.deadLineYN = deadLineYN;
		this.registrationDateYN = registrationDateYN;
		this.taskIdxYN = taskIdxYN;
		this.writerYN = writerYN;
		this.lastModifiedDateYN = lastModifiedDateYN;
		this.progressYN = progressYN;
	}
	public int getMemberIdx() {
		return memberIdx;
	}
	public void setMemberIdx(int memberIdx) {
		this.memberIdx = memberIdx;
	}
	public char getWorkNameYN() {
		return workNameYN;
	}
	public void setWorkNameYN(char workNameYN) {
		this.workNameYN = workNameYN;
	}
	public char getStateYN() {
		return stateYN;
	}
	public void setStateYN(char stateYN) {
		this.stateYN = stateYN;
	}
	public char getPriorityYN() {
		return priorityYN;
	}
	public void setPriorityYN(char priorityYN) {
		this.priorityYN = priorityYN;
	}
	public char getManagerYN() {
		return managerYN;
	}
	public void setManagerYN(char managerYN) {
		this.managerYN = managerYN;
	}
	public char getStartDateYN() {
		return startDateYN;
	}
	public void setStartDateYN(char startDateYN) {
		this.startDateYN = startDateYN;
	}
	public char getDeadLineYN() {
		return deadLineYN;
	}
	public void setDeadLineYN(char deadLineYN) {
		this.deadLineYN = deadLineYN;
	}
	public char getRegistrationDateYN() {
		return registrationDateYN;
	}
	public void setRegistrationDateYN(char registrationDateYN) {
		this.registrationDateYN = registrationDateYN;
	}
	public char getTaskIdxYN() {
		return taskIdxYN;
	}
	public void setTaskIdxYN(char taskIdxYN) {
		this.taskIdxYN = taskIdxYN;
	}
	public char getWriterYN() {
		return writerYN;
	}
	public void setWriterYN(char writerYN) {
		this.writerYN = writerYN;
	}
	public char getLastModifiedDateYN() {
		return lastModifiedDateYN;
	}
	public void setLastModifiedDateYN(char lastModifiedDateYN) {
		this.lastModifiedDateYN = lastModifiedDateYN;
	}
	public char getProgressYN() {
		return progressYN;
	}
	public void setProgressYN(char progressYN) {
		this.progressYN = progressYN;
	}
    
}
