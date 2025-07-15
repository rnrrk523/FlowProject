package dto;

public class ProjectsDto {
	private int pIdx;
	private String pName;
	private int pmCnt;
	private int boardCnt;
	private String lastActivity;
	private String openingDate;
	
	public ProjectsDto(int pIdx, String pName, int pmCnt, int boardCnt, String lastActivity, String openingDate) {
		this.pIdx = pIdx;
		this.pName = pName;
		this.pmCnt = pmCnt;
		this.boardCnt = boardCnt;
		this.lastActivity = lastActivity;
		this.openingDate = openingDate;
	}
	
	public int getpIdx() {
		return pIdx;
	}
	public void setpIdx(int pIdx) {
		this.pIdx = pIdx;
	}
	public String getpName() {
		return pName;
	}
	public void setpName(String pName) {
		this.pName = pName;
	}
	public int getPmCnt() {
		return pmCnt;
	}
	public void setPmCnt(int pmCnt) {
		this.pmCnt = pmCnt;
	}
	public int getBoardCnt() {
		return boardCnt;
	}
	public void setBoardCnt(int boardCnt) {
		this.boardCnt = boardCnt;
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
}
