package dto;

public class BoardScheduleDto {
	private int scheduleIdx;
	private String location;
	private String yearMonth;
	private String day;
	private String startDate;
	private String endDate;
	private int AlarmType;
	private char allDayYN;
	private String profileImg;
	private String name;
	private int memberIdx;
	private String attendWhether;
	public BoardScheduleDto(int scheduleIdx, String location, String yearMonth,String day ,String startDate, String endDate, char allDayYN,
			String profileImg,String name, int memberIdx, String attendWhether, int AlarmType) {
		this.scheduleIdx = scheduleIdx;
		this.location = location;
		this.yearMonth = yearMonth;
		this.day = day;
		this.startDate = startDate;
		this.endDate = endDate;
		this.allDayYN = allDayYN;
		this.profileImg = profileImg;
		this.name = name;
		this.memberIdx = memberIdx;
		this.attendWhether = attendWhether;
		this.AlarmType = AlarmType;
	}
	
	public int getAlarmType() {
		return AlarmType;
	}

	public void setAlarmType(int alarmType) {
		AlarmType = alarmType;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getYearMonth() {
		return yearMonth;
	}

	public void setYearMonth(String yearMonth) {
		this.yearMonth = yearMonth;
	}

	public String getDay() {
		return day;
	}

	public void setDay(String day) {
		this.day = day;
	}

	public int getScheduleIdx() {
		return scheduleIdx;
	}
	public void setScheduleIdx(int scheduleIdx) {
		this.scheduleIdx = scheduleIdx;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
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
	public String getAttendWhether() {
		return attendWhether;
	}
	public void setAttendWhether(String attendWhether) {
		this.attendWhether = attendWhether;
	}
	
}
