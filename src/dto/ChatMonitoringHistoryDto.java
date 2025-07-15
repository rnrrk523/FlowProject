package dto;

public class ChatMonitoringHistoryDto {
	private String Affiliation;
	private String writeDate;
	private String nameAndEmail;
	private String content;
	private String type;
	
	public ChatMonitoringHistoryDto(String affiliation, String writeDate, String nameAndEmail, String content,
			String type) {
		Affiliation = affiliation;
		this.writeDate = writeDate;
		this.nameAndEmail = nameAndEmail;
		this.content = content;
		this.type = type;
	}
	
	public String getAffiliation() {
		return Affiliation;
	}
	public void setAffiliation(String affiliation) {
		Affiliation = affiliation;
	}
	public String getWriteDate() {
		return writeDate;
	}
	public void setWriteDate(String writeDate) {
		this.writeDate = writeDate;
	}
	public String getNameAndEmail() {
		return nameAndEmail;
	}
	public void setNameAndEmail(String nameAndEmail) {
		this.nameAndEmail = nameAndEmail;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
}
