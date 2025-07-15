package dto;

public class voteBoardDto {
	private String title;
	private int writerIdx;
	private String topFixed;
	private String writerDate;
	private String releaseYn;
	private String lastModifiedDate;
	private String explanation;
	private String textOrDate;
	private String voteDeadLine;
	private String multipleVoteYn;
	private String anonymousVoteYn;
	private String anyoneAddVoteYn;
	private String resultVoteMe;
	private String voteResultsDate;
	private String voteIsClosedYn;
	private String voteContent;
	private String voteUrlImage;
	public voteBoardDto(String title, int writerIdx, String topFixed, String writerDate, String releaseYn,
			String lastModifiedDate, String explanation, String textOrDate, String voteDeadLine, String multipleVoteYn,
			String anonymousVoteYn, String anyoneAddVoteYn, String resultVoteMe, String voteResultsDate,
			String voteIsClosedYn, String voteContent, String voteUrlImage) {
		this.title = title;
		this.writerIdx = writerIdx;
		this.topFixed = topFixed;
		this.writerDate = writerDate;
		this.releaseYn = releaseYn;
		this.lastModifiedDate = lastModifiedDate;
		this.explanation = explanation;
		this.textOrDate = textOrDate;
		this.voteDeadLine = voteDeadLine;
		this.multipleVoteYn = multipleVoteYn;
		this.anonymousVoteYn = anonymousVoteYn;
		this.anyoneAddVoteYn = anyoneAddVoteYn;
		this.resultVoteMe = resultVoteMe;
		this.voteResultsDate = voteResultsDate;
		this.voteIsClosedYn = voteIsClosedYn;
		this.voteContent = voteContent;
		this.voteUrlImage = voteUrlImage;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getWriterIdx() {
		return writerIdx;
	}
	public void setWriterIdx(int writerIdx) {
		this.writerIdx = writerIdx;
	}
	public String getTopFixed() {
		return topFixed;
	}
	public void setTopFixed(String topFixed) {
		this.topFixed = topFixed;
	}
	public String getWriterDate() {
		return writerDate;
	}
	public void setWriterDate(String writerDate) {
		this.writerDate = writerDate;
	}
	public String getReleaseYn() {
		return releaseYn;
	}
	public void setReleaseYn(String releaseYn) {
		this.releaseYn = releaseYn;
	}
	public String getLastModifiedDate() {
		return lastModifiedDate;
	}
	public void setLastModifiedDate(String lastModifiedDate) {
		this.lastModifiedDate = lastModifiedDate;
	}
	public String getExplanation() {
		return explanation;
	}
	public void setExplanation(String explanation) {
		this.explanation = explanation;
	}
	public String getTextOrDate() {
		return textOrDate;
	}
	public void setTextOrDate(String textOrDate) {
		this.textOrDate = textOrDate;
	}
	public String getVoteDeadLine() {
		return voteDeadLine;
	}
	public void setVoteDeadLine(String voteDeadLine) {
		this.voteDeadLine = voteDeadLine;
	}
	public String getMultipleVoteYn() {
		return multipleVoteYn;
	}
	public void setMultipleVoteYn(String multipleVoteYn) {
		this.multipleVoteYn = multipleVoteYn;
	}
	public String getAnonymousVoteYn() {
		return anonymousVoteYn;
	}
	public void setAnonymousVoteYn(String anonymousVoteYn) {
		this.anonymousVoteYn = anonymousVoteYn;
	}
	public String getAnyoneAddVoteYn() {
		return anyoneAddVoteYn;
	}
	public void setAnyoneAddVoteYn(String anyoneAddVoteYn) {
		this.anyoneAddVoteYn = anyoneAddVoteYn;
	}
	public String getResultVoteMe() {
		return resultVoteMe;
	}
	public void setResultVoteMe(String resultVoteMe) {
		this.resultVoteMe = resultVoteMe;
	}
	public String getVoteResultsDate() {
		return voteResultsDate;
	}
	public void setVoteResultsDate(String voteResultsDate) {
		this.voteResultsDate = voteResultsDate;
	}
	public String getVoteIsClosedYn() {
		return voteIsClosedYn;
	}
	public void setVoteIsClosedYn(String voteIsClosedYn) {
		this.voteIsClosedYn = voteIsClosedYn;
	}
	public String getVoteContent() {
		return voteContent;
	}
	public void setVoteContent(String voteContent) {
		this.voteContent = voteContent;
	}
	public String getVoteUrlImage() {
		return voteUrlImage;
	}
	public void setVoteUrlImage(String voteUrlImage) {
		this.voteUrlImage = voteUrlImage;
	}
	
}
