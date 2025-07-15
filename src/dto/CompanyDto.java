package dto;

public class CompanyDto {
	private int companyIdx;
	private String companyName;
	private String logoImg;
	private String companyUrl;
	private char departmentFuncYN;
	private String auditChatDate;
	
	public CompanyDto(int companyIdx, String companyName, String logoImg, String companyUrl, char departmentFuncYN,
			String auditChatDate) {
		this.companyIdx = companyIdx;
		this.companyName = companyName;
		this.logoImg = logoImg;
		this.companyUrl = companyUrl;
		this.departmentFuncYN = departmentFuncYN;
		this.auditChatDate = auditChatDate;
	}
	
	public int getCompanyIdx() {
		return companyIdx;
	}
	public void setCompanyIdx(int companyIdx) {
		this.companyIdx = companyIdx;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
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
	public char getDepartmentFuncYN() {
		return departmentFuncYN;
	}
	public void setDepartmentFuncYN(char departmentFuncYN) {
		this.departmentFuncYN = departmentFuncYN;
	}
	public String getAuditChatDate() {
		return auditChatDate;
	}
	public void setAuditChatDate(String auditChatDate) {
		this.auditChatDate = auditChatDate;
	}
}