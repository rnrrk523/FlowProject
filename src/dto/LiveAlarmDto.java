package dto;

public class LiveAlarmDto {
	private int liveAlarmIdx;
	private int boardIdx;
	private int companyIdx;
	private int commentIdx;
	private char mentionMeYn;
	private char myBoardYn;
	private char workYn;
	private String title;
	private String alarmDate;
	private String simpleContent;
	private String fullContent;
	private char checkYN;
	private String writerName;
	private String writerProf;
	private String alarmInfoDate;
	private int writerIdx;
	private String coordinate;
	
	public LiveAlarmDto(int liveAlarmIdx, int boardIdx, int companyIdx, int commentIdx, char mentionMeYn,
			char myBoardYn, char workYn, String title, String alarmDate, String simpleContent, String fullContent,
			char checkYN, String writerName, String writerProf, String alarmInfoDate, int writerIdx,
			String coordinate) {
		this.liveAlarmIdx = liveAlarmIdx;
		this.boardIdx = boardIdx;
		this.companyIdx = companyIdx;
		this.commentIdx = commentIdx;
		this.mentionMeYn = mentionMeYn;
		this.myBoardYn = myBoardYn;
		this.workYn = workYn;
		this.title = title;
		this.alarmDate = alarmDate;
		this.simpleContent = simpleContent;
		this.fullContent = fullContent;
		this.checkYN = checkYN;
		this.writerName = writerName;
		this.writerProf = writerProf;
		this.alarmInfoDate = alarmInfoDate;
		this.writerIdx = writerIdx;
		this.coordinate = coordinate;
	}
	
	public int getLiveAlarmIdx() {
		return liveAlarmIdx;
	}
	public void setLiveAlarmIdx(int liveAlarmIdx) {
		this.liveAlarmIdx = liveAlarmIdx;
	}
	public int getBoardIdx() {
		return boardIdx;
	}
	public void setBoardIdx(int boardIdx) {
		this.boardIdx = boardIdx;
	}
	public int getCompanyIdx() {
		return companyIdx;
	}
	public void setCompanyIdx(int companyIdx) {
		this.companyIdx = companyIdx;
	}
	public int getCommentIdx() {
		return commentIdx;
	}
	public void setCommentIdx(int commentIdx) {
		this.commentIdx = commentIdx;
	}
	public char getMentionMeYn() {
		return mentionMeYn;
	}
	public void setMentionMeYn(char mentionMeYn) {
		this.mentionMeYn = mentionMeYn;
	}
	public char getMyBoardYn() {
		return myBoardYn;
	}
	public void setMyBoardYn(char myBoardYn) {
		this.myBoardYn = myBoardYn;
	}
	public char getWorkYn() {
		return workYn;
	}
	public void setWorkYn(char workYn) {
		this.workYn = workYn;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getAlarmDate() {
		return alarmDate;
	}
	public void setAlarmDate(String alarmDate) {
		this.alarmDate = alarmDate;
	}
	public String getSimpleContent() {
		return simpleContent;
	}
	public void setSimpleContent(String simpleContent) {
		this.simpleContent = simpleContent;
	}
	public String getFullContent() {
		return fullContent;
	}
	public void setFullContent(String fullContent) {
		this.fullContent = fullContent;
	}
	public char getCheckYN() {
		return checkYN;
	}
	public void setCheckYN(char checkYN) {
		this.checkYN = checkYN;
	}
	public String getWriterName() {
		return writerName;
	}
	public void setWriterName(String writerName) {
		this.writerName = writerName;
	}
	public String getWriterProf() {
		return writerProf;
	}
	public void setWriterProf(String writerProf) {
		this.writerProf = writerProf;
	}
	public String getAlarmInfoDate() {
		return alarmInfoDate;
	}
	public void setAlarmInfoDate(String alarmInfoDate) {
		this.alarmInfoDate = alarmInfoDate;
	}
	public int getWriterIdx() {
		return writerIdx;
	}
	public void setWriterIdx(int writerIdx) {
		this.writerIdx = writerIdx;
	}
	public String getCoordinate() {
		return coordinate;
	}
	public void setCoordinate(String coordinate) {
		this.coordinate = coordinate;
	}
}