package dto;

public class BoardPostViewDto {
	private String profileImg;
	private String name;
	private String writeDate;
	private char releaseYN;
	private String title;
	private String content;
	private char topFixed;
	public BoardPostViewDto(String profileImg, String name, String writeDate, char releaseYN, String title,
			String content, char topFixed) {
		this.profileImg = profileImg;
		this.name = name;
		this.writeDate = writeDate;
		this.releaseYN = releaseYN;
		this.title = title;
		this.content = content;
		this.topFixed = topFixed;
	}
	public String getProfileImg() {
		return profileImg;
	}
	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
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
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public char getTopFixed() {
		return topFixed;
	}
	public void setTopFixed(char topFixed) {
		this.topFixed = topFixed;
	}
	
}
