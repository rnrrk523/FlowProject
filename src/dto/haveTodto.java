package dto;

public class haveTodto {
	private String workContent;
	private String workDate;
	private String writeName;
	private String workCompleYn;
	private String completeYn;
	private String title;
	private String topFixed;
	private String lastModifiedDate;
	private String projectName;
	private String colorCode;
	private String category;
	private String temporayStorage;
	private int memberIdx;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public String getProfileImg() {
		return profileImg;
	}
	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
	}
	private String releaseYn;
	private int workCount;
	private int workCompleteCount;
	private int workCompletePercent;
	private int perWorkIdx;
	private String name;
	private String companyName;
	private String profileImg;
	public haveTodto(String name , String companyName , String profileImg, int memberIdx) {
		this.name = name;
		this.companyName = companyName;
		this.profileImg = profileImg;
		this.memberIdx = memberIdx;
	}
	public int getMemberIdx() {
		return memberIdx;
	}
	public void setMemberIdx(int memberIdx) {
		this.memberIdx = memberIdx;
	}
	public haveTodto(int perWorkIdx , String workContent , String workDate , String workCompleYn) {
		this.perWorkIdx = perWorkIdx;
		this.workContent = workContent;
		this.workDate = workDate;
		this.workCompleYn = workCompleYn;
	}
	
	public int getPerWorkIdx() {
		return perWorkIdx;
	}

	public void setPerWorkIdx(int perWorkIdx) {
		this.perWorkIdx = perWorkIdx;
	}

	public haveTodto(String workContent, String workDate, String writeName, String workCompleYn, String completeYn,
			String title, String topFixed, String lastModifiedDate , String projectName ,String colorCode , String category , String temporayStorage, String releaseYn) {
		this.workContent = workContent;
		this.workDate = workDate;
		this.writeName = writeName;
		this.workCompleYn = workCompleYn;
		this.completeYn = completeYn;
		this.title = title;
		this.topFixed = topFixed;
		this.lastModifiedDate = lastModifiedDate;
		this.projectName = projectName;
		this.colorCode = colorCode;
		this.category = category;
		this.temporayStorage = temporayStorage;
		this.releaseYn = releaseYn;
	}
	public int getWorkCount() {
		return workCount;
	}
	public void setWorkCount(int workCount) {
		this.workCount = workCount;
	}
	public int getWorkCompleteCount() {
		return workCompleteCount;
	}
	public void setWorkCompleteCount(int workCompleteCount) {
		this.workCompleteCount = workCompleteCount;
	}
	public int getWorkCompletePercent() {
		return workCompletePercent;
	}
	public void setWorkCompletePercent(int workCompletePercent) {
		this.workCompletePercent = workCompletePercent;
	}
	public haveTodto(int workCount , int workCompleteCount , int workCompletePercent) {
		this.workCount = workCount;
		this.workCompleteCount = workCompleteCount;
		this.workCompletePercent = workCompletePercent;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getTemporayStorage() {
		return temporayStorage;
	}
	public void setTemporayStorage(String temporayStorage) {
		this.temporayStorage = temporayStorage;
	}
	public String getReleaseYn() {
		return releaseYn;
	}
	public void setReleaseYn(String releaseYn) {
		this.releaseYn = releaseYn;
	}
	public String getProjectName() {
		return projectName;
	}
	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}
	public String getColorCode() {
		return colorCode;
	}
	public void setColorCode(String colorCode) {
		this.colorCode = colorCode;
	}
	public void setCompleteYn(String completeYn) {
		this.completeYn = completeYn;
	}
	public String getWorkContent() {
		return workContent;
	}
	public void setWorkContent(String workContent) {
		this.workContent = workContent;
	}
	public String getWorkDate() {
		return workDate;
	}
	public void setWorkDate(String workDate) {
		this.workDate = workDate;
	}
	public String getWriteName() {
		return writeName;
	}
	public void setWriteName(String writeName) {
		this.writeName = writeName;
	}
	public String getWorkCompleYn() {
		return workCompleYn;
	}
	public void setWorkCompleYn(String workCompleYn) {
		this.workCompleYn = workCompleYn;
	}
	public String getCompleteYn() {
		return completeYn;
	}
	public void setCompleYn(String completeYn) {
		this.completeYn = completeYn;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getTopFixed() {
		return topFixed;
	}
	public void setTopFixed(String topFixed) {
		this.topFixed = topFixed;
	}
	public String getLastModifiedDate() {
		return lastModifiedDate;
	}
	public void setLastModifiedDate(String lastModifiedDate) {
		this.lastModifiedDate = lastModifiedDate;
	}
	
}
