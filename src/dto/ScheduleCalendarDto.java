package dto;

public class ScheduleCalendarDto {
	private int boardIdx;
	private int scheduleIdx;
	private String title;
	private String startDate;
	private String endDate;
	private char allDayYN;
	
	public ScheduleCalendarDto(int boardIdx, int scheduleIdx, String title, String startDate, String endDate,
			char allDayYN) {
		this.boardIdx = boardIdx;
		this.scheduleIdx = scheduleIdx;
		this.title = title;
		this.startDate = startDate;
		this.endDate = endDate;
		this.allDayYN = allDayYN;
	}
	
	public int getBoardIdx() {
		return boardIdx;
	}
	public void setBoardIdx(int boardIdx) {
		this.boardIdx = boardIdx;
	}
	public int getScheduleIdx() {
		return scheduleIdx;
	}
	public void setScheduleIdx(int scheduleIdx) {
		this.scheduleIdx = scheduleIdx;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public char getAllDayYN() {
		return allDayYN;
	}
	public void setAllDayYN(char allDayYN) {
		this.allDayYN = allDayYN;
	}
}
