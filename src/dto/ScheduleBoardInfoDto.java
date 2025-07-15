package dto;

public class ScheduleBoardInfoDto {
	private int scheduleIdx;
	private int projectIdx;
	private String projectName;
	private int writerIdx;
	private String writeDate;
	private char releaseYN;
	private String title;
	private String startDate;
	private String endDate;
    private char allDayYN;
    private String location;
    private String content;
    
	public ScheduleBoardInfoDto(int scheduleIdx, int projectIdx, String projectName, int writerIdx, String writeDate,
			char releaseYN, String title, String startDate, String endDate, char allDayYN, String location,
			String content) {
		this.scheduleIdx = scheduleIdx;
		this.projectIdx = projectIdx;
		this.projectName = projectName;
		this.writerIdx = writerIdx;
		this.writeDate = writeDate;
		this.releaseYN = releaseYN;
		this.title = title;
		this.startDate = startDate;
		this.endDate = endDate;
		this.allDayYN = allDayYN;
		this.location = location;
		this.content = content;
	}
	
	public int getScheduleIdx() {
		return scheduleIdx;
	}
	public void setScheduleIdx(int scheduleIdx) {
		this.scheduleIdx = scheduleIdx;
	}
	public int getProjectIdx() {
		return projectIdx;
	}
	public void setProjectIdx(int projectIdx) {
		this.projectIdx = projectIdx;
	}
	public String getProjectName() {
		return projectName;
	}
	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}
	public int getWriterIdx() {
		return writerIdx;
	}
	public void setWriterIdx(int writerIdx) {
		this.writerIdx = writerIdx;
	}
	public String getWriteDate() {
		return writeDate;
	}
	public void setWriteDate(String writeDate) {
		this.writeDate = writeDate;
	}
	public char getReleaseYN() {
		return releaseYN;
	}
	public void setReleaseYN(char releaseYN) {
		this.releaseYN = releaseYN;
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
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
}