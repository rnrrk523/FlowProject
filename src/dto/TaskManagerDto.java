package dto;

public class TaskManagerDto {
	private int taskIdx;
	private int memberIdx;
	private String name;
	private String profileImg;
	public TaskManagerDto(int taskIdx, int memberIdx, String name, String profileImg) {
		this.taskIdx = taskIdx;
		this.memberIdx = memberIdx;
		this.name = name;
		this.profileImg = profileImg;
	}
	
	public int getTaskIdx() {
		return taskIdx;
	}

	public void setTaskIdx(int taskIdx) {
		this.taskIdx = taskIdx;
	}

	public String getProfileImg() {
		return profileImg;
	}

	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
	}

	public int getMemberIdx() {
		return memberIdx;
	}
	public void setMemberIdx(int memberIdx) {
		this.memberIdx = memberIdx;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	
}
