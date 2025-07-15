package dto;

import java.util.ArrayList;

public class DelProjectDto {
	private int projectIdx;
	private String pName;
	private int participantCnt;
	private String lastActivity;
	private String openingDate;
	private String deleteDate;
	private int delMemberIdx;
	
	public DelProjectDto(int projectIdx, String pName, int participantCnt, String lastActivity, String openingDate,
			String deleteDate, int delMemberIdx) {
		this.projectIdx = projectIdx;
		this.pName = pName;
		this.participantCnt = participantCnt;
		this.lastActivity = lastActivity;
		this.openingDate = openingDate;
		this.deleteDate = deleteDate;
		this.delMemberIdx = delMemberIdx;
	}
	
	public int getProjectIdx() {
		return projectIdx;
	}
	public void setProjectIdx(int projectIdx) {
		this.projectIdx = projectIdx;
	}
	public String getpName() {
		return pName;
	}
	public void setpName(String pName) {
		this.pName = pName;
	}
	public int getParticipantCnt() {
		return participantCnt;
	}
	public void setParticipantCnt(int participantCnt) {
		this.participantCnt = participantCnt;
	}
	public String getLastActivity() {
		return lastActivity;
	}
	public void setLastActivity(String lastActivity) {
		this.lastActivity = lastActivity;
	}
	public String getOpeningDate() {
		return openingDate;
	}
	public void setOpeningDate(String openingDate) {
		this.openingDate = openingDate;
	}
	public String getDeleteDate() {
		return deleteDate;
	}
	public void setDeleteDate(String deleteDate) {
		this.deleteDate = deleteDate;
	}
	public int getDelMemberIdx() {
		return delMemberIdx;
	}
	public void setDelMemberIdx(int delMemberIdx) {
		this.delMemberIdx = delMemberIdx;
	}
}
