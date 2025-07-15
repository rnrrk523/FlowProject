package dto;

public class CompanyDto2 {
	private String companyName;
	private int industryIdx;
	private int planIdx;
	private String logoImg;
	private String companyUrl;
	private char departmentFuncYn;
	
	public CompanyDto2(String companyName, int industryIdx, int planIdx, String logoImg, String companyUrl,
			char departmentFuncYn) {
		this.companyName = companyName;
		this.industryIdx = industryIdx;
		this.planIdx = planIdx;
		this.logoImg = logoImg;
		this.companyUrl = companyUrl;
		this.departmentFuncYn = departmentFuncYn;
	}
	
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public int getIndustryIdx() {
		return industryIdx;
	}
	public void setIndustryIdx(int industryIdx) {
		this.industryIdx = industryIdx;
	}
	public int getPlanIdx() {
		return planIdx;
	}
	public void setPlanIdx(int planIdx) {
		this.planIdx = planIdx;
	}
	public String getLogoImg() {
		return logoImg;
	}
	public void setLogoImg(String logoImg) {
		this.logoImg = logoImg;
	}
	public String getCompanyUrl() {
		return companyUrl;
	}
	public void setCompanyUrl(String companyUrl) {
		this.companyUrl = companyUrl;
	}
	public char getDepartmentFuncYn() {
		return departmentFuncYn;
	}
	public void setDepartmentFuncYn(char departmentFuncYn) {
		this.departmentFuncYn = departmentFuncYn;
	}
}