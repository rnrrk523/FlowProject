package dto;

public class mychatListTimedto {
	private int baseChatroomIdx;
	private String baseChatroomName;
	private String customChatroomName;
	private String permaxInputDateTime;
	public mychatListTimedto(int baseChatroomIdx, String baseChatroomName, String customChatroomName,
			String permaxInputDateTime) {
		super();
		this.baseChatroomIdx = baseChatroomIdx;
		this.baseChatroomName = baseChatroomName;
		this.customChatroomName = customChatroomName;
		this.permaxInputDateTime = permaxInputDateTime;
	}
	public int getBaseChatroomIdx() {
		return baseChatroomIdx;
	}
	public void setBaseChatroomIdx(int baseChatroomIdx) {
		this.baseChatroomIdx = baseChatroomIdx;
	}
	public String getBaseChatroomName() {
		return baseChatroomName;
	}
	public void setBaseChatroomName(String baseChatroomName) {
		this.baseChatroomName = baseChatroomName;
	}
	public String getCustomChatroomName() {
		return customChatroomName;
	}
	public void setCustomChatroomName(String customChatroomName) {
		this.customChatroomName = customChatroomName;
	}
	public String getPermaxInputDateTime() {
		return permaxInputDateTime;
	}
	public void setPermaxInputDateTime(String permaxInputDateTime) {
		this.permaxInputDateTime = permaxInputDateTime;
	}
	
}
