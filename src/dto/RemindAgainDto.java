package dto;

public class RemindAgainDto {
	private int memberIdx;
	private int todayDeadline;
	
	public RemindAgainDto(int memberIdx, int todayDeadline) {
		this.memberIdx = memberIdx;
		this.todayDeadline = todayDeadline;
	}
	
	public int getMemberIdx() {
		return memberIdx;
	}
	public void setMemberIdx(int memberIdx) {
		this.memberIdx = memberIdx;
	}
	public int getTodayDeadline() {
		return todayDeadline;
	}
	public void setTodayDeadline(int todayDeadline) {
		this.todayDeadline = todayDeadline;
	}
}
