package dto;

public class ProjectAlarmListDto {
	private int memberIdx;
	private String memberName;
	private String type;
	private String content;
	private String alarmDate;
	private String title;
	private String prof;
	
	public ProjectAlarmListDto(int memberIdx, String memberName, String type, String content, String alarmDate,
			String title, String prof) {
		this.memberIdx = memberIdx;
		this.memberName = memberName;
		this.type = type;
		this.content = content;
		this.alarmDate = alarmDate;
		this.title = title;
		this.prof = prof;
	}
	
	public int getMemberIdx() {
		return memberIdx;
	}
	public void setMemberIdx(int memberIdx) {
		this.memberIdx = memberIdx;
	}
	public String getMemberName() {
		return memberName;
	}
	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getAlarmDate() {
		return alarmDate;
	}
	public void setAlarmDate(String alarmDate) {
		this.alarmDate = alarmDate;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getProf() {
		return prof;
	}
	public void setProf(String prof) {
		this.prof = prof;
	}
}
