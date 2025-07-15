package dto;

public class ProjectAttenderYNDto {
	private int memberIdx;
	private String attendWhether;
	
	public ProjectAttenderYNDto(int memberIdx, String attendWhether) {
		this.memberIdx = memberIdx;
		this.attendWhether = attendWhether;
	}
	
	public int getMemberIdx() {
		return memberIdx;
	}
	public void setMemberIdx(int memberIdx) {
		this.memberIdx = memberIdx;
	}
	public String getAttendWhether() {
		return attendWhether;
	}
	public void setAttendWhether(String attendWhether) {
		this.attendWhether = attendWhether;
	}
}