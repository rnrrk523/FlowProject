package dto;

public class ProjectBoardCntDto {
	private int projectIdx;
	private int boardCnt;
	
	public ProjectBoardCntDto(int projectIdx, int boardCnt) {
		this.projectIdx = projectIdx;
		this.boardCnt = boardCnt;
	}
	
	public int getProjectIdx() {
		return projectIdx;
	}
	public void setProjectIdx(int projectIdx) {
		this.projectIdx = projectIdx;
	}
	public int getBoardCnt() {
		return boardCnt;
	}
	public void setBoardCnt(int boardCnt) {
		this.boardCnt = boardCnt;
	}
}
