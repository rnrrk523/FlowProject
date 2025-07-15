package dto;

public class GoToDto2 {
	private int goToIdx;
	private String name;
	private String url;
	private String icon;
	private char stateYN;
	
	public GoToDto2(int goToIdx, String name, String url, String icon, char state) {
		this.goToIdx = goToIdx;
		this.name = name;
		this.url = url;
		this.icon = icon;
		this.stateYN = state;
	}
	
	public int getGoToIdx() {
		return goToIdx;
	}
	public void setGoToIdx(int goToIdx) {
		this.goToIdx = goToIdx;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getIcon() {
		return icon;
	}
	public void setIcon(String icon) {
		this.icon = icon;
	}
	public char getState() {
		return stateYN;
	}
	public void setState(char state) {
		this.stateYN = state;
	}
}
