package dto;

public class ScheduleGoodInfoDto {
	private int memberIdx;
    private int emotionType;
    private String emotionFile;
    
	public ScheduleGoodInfoDto(int memberIdx, int emotionType, String emotionFile) {
		this.memberIdx = memberIdx;
		this.emotionType = emotionType;
		this.emotionFile = emotionFile;
	}
	
	public int getMemberIdx() {
		return memberIdx;
	}
	public void setMemberIdx(int memberIdx) {
		this.memberIdx = memberIdx;
	}
	public int getEmotionType() {
		return emotionType;
	}
	public void setEmotionType(int emotionType) {
		this.emotionType = emotionType;
	}
	public String getEmotionFile() {
		return emotionFile;
	}
	public void setEmotionFile(String emotionFile) {
		this.emotionFile = emotionFile;
	}
}
