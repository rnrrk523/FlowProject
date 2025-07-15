package dto;

public class MyProjectViewDto {
	private int projectIdx;
	private String projectName;
	private int projectColor;
	private char favoritesYN;
	private int count;
	private int categoryIdx;
	private char companyProjectYN;
	private char approvalYN;
	private String hometab;
	
	
	public MyProjectViewDto(int projectIdx, String projectName, int projectColor, char favoritesYN, int count,
			int categoryIdx, char companyProjectYN, char approvalYN, String hometab) {
		this.projectIdx = projectIdx;
		this.projectName = projectName;
		this.projectColor = projectColor;
		this.favoritesYN = favoritesYN;
		this.count = count;
		this.categoryIdx = categoryIdx;
		this.companyProjectYN = companyProjectYN;
		this.approvalYN = approvalYN;
		this.hometab = hometab;
	}

	public String getHometab() {
		return hometab;
	}

	public void setHometab(String hometab) {
		this.hometab = hometab;
	}

	public int getCategoryIdx() {
		return categoryIdx;
	}

	public void setCategoryIdx(int categoryIdx) {
		this.categoryIdx = categoryIdx;
	}

	public char getCompanyProjectYN() {
		return companyProjectYN;
	}

	public void setCompanyProjectYN(char companyProjectYN) {
		this.companyProjectYN = companyProjectYN;
	}

	public char getApprovalYN() {
		return approvalYN;
	}

	public void setApprovalYN(char approvalYN) {
		this.approvalYN = approvalYN;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}
	public int getProjectIdx() {
		return projectIdx;
	}
	public void setProjectIdx(int projectIdx) {
		this.projectIdx = projectIdx;
	}
	public String getProjectName() {
		return projectName;
	}
	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}
	public int getProjectColor() {
		return projectColor;
	}
	public void setProjectColor(int projectColor) {
		this.projectColor = projectColor;
	}
	public char getFavoritesYN() {
		return favoritesYN;
	}
	public void setFavoritesYN(char favoritesYN) {
		this.favoritesYN = favoritesYN;
	}
	
}
