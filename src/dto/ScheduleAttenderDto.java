package dto;

public class ScheduleAttenderDto {
	private int scheduleIdx;
	private int memberIdx;
	private String name;
	private String profileImg;
	private String attendWhether;
	
	public ScheduleAttenderDto(int scheduleIdx, int memberIdx, String name, String profileImg, String attendWhether) {
		this.scheduleIdx = scheduleIdx;
		this.memberIdx = memberIdx;
		this.name = name;
		this.profileImg = profileImg;
		this.attendWhether = attendWhether;
	}
	
	public int getScheduleIdx() {
		return scheduleIdx;
	}
	public void setScheduleIdx(int scheduleIdx) {
		this.scheduleIdx = scheduleIdx;
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
	public String getProfileImg() {
		return profileImg;
	}
	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
	}
	public String getAttendWhether() {
		return attendWhether;
	}
	public void setAttendWhether(String attendWhether) {
		this.attendWhether = attendWhether;
	}
}
