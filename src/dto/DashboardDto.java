package dto;

public class DashboardDto {
	private int widgetCategory;
	private int boardSize;
	private int dashBoardIdx;
	public DashboardDto(int widgetCategory, int boardSize, int dashBoardIdx) {
		this.widgetCategory = widgetCategory;
		this.boardSize = boardSize;
		this.dashBoardIdx = dashBoardIdx;
	}
	public int getDashBoardIdx() {
		return dashBoardIdx;
	}
	public void setDashBoardIdx(int dashBoardIdx) {
		this.dashBoardIdx = dashBoardIdx;
	}
	public int getWidgetCategory() {
		return widgetCategory;
	}
	public void setWidgetCategory(int widgetCategory) {
		this.widgetCategory = widgetCategory;
	}
	public int getBoardSize() {
		return boardSize;
	}
	public void setBoardSize(int boardSize) {
		this.boardSize = boardSize;
	}
	
}
