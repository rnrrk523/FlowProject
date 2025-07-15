package dto;

public class ProjectChatCntDto {
	private int projectIdx;
	private int chatCnt;
	
	public ProjectChatCntDto(int projectIdx, int chatCnt) {
		this.projectIdx = projectIdx;
		this.chatCnt = chatCnt;
	}
	
	public int getProjectIdx() {
		return projectIdx;
	}
	public void setProjectIdx(int projectIdx) {
		this.projectIdx = projectIdx;
	}
	public int getChatCnt() {
		return chatCnt;
	}
	public void setChatCnt(int chatCnt) {
		this.chatCnt = chatCnt;
	}
}
