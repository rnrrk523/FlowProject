package dto;

public class BoardTopFixedDto {
	public String category;
	public String title;
	public int boardIdx;
	public int state;
	public String startDate;
	public String endDate;
	public int totalCount;
	public int completedCount;
	public int completePercent;
	public char votingIsClosedYN;
	public BoardTopFixedDto(String title, int boardIdx, int state, String startDate, String endDate, int totalCount,
			int completedCount, int completePercent, char votingIsClosedYN, String category) {
		this.title = title;
		this.boardIdx = boardIdx;
		this.state = state;
		this.startDate = startDate;
		this.endDate = endDate;
		this.totalCount = totalCount;
		this.completedCount = completedCount;
		this.completePercent = completePercent;
		this.votingIsClosedYN = votingIsClosedYN;
		this.category = category;
	}
	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getBoardIdx() {
		return boardIdx;
	}
	public void setBoardIdx(int boardIdx) {
		this.boardIdx = boardIdx;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
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
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
	public int getCompletedCount() {
		return completedCount;
	}
	public void setCompletedCount(int completedCount) {
		this.completedCount = completedCount;
	}
	public int getCompletePercent() {
		return completePercent;
	}
	public void setCompletePercent(int completePercent) {
		this.completePercent = completePercent;
	}
	public char getVotingIsClosedYN() {
		return votingIsClosedYN;
	}
	public void setVotingIsClosedYN(char votingIsClosedYN) {
		this.votingIsClosedYN = votingIsClosedYN;
	}
}
