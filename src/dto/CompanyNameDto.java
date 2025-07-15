package dto;

public class CompanyNameDto {
	private String CompanyName;
	private String CompanyURL;
	private String logo;
	public CompanyNameDto(String companyName, String companyURL, String logo) {
		CompanyName = companyName;
		CompanyURL = companyURL;
		this.logo = logo;
	}
	
	public String getLogo() {
		return logo;
	}

	public void setLogo(String logo) {
		this.logo = logo;
	}

	public String getCompanyName() {
		return CompanyName;
	}
	public void setCompanyName(String companyName) {
		CompanyName = companyName;
	}
	public String getCompanyURL() {
		return CompanyURL;
	}
	public void setCompanyURL(String companyURL) {
		CompanyURL = companyURL;
	}
	
}
