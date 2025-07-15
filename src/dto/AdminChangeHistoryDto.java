package dto;

public class AdminChangeHistoryDto {
	private String changerNameAndEmail;
	private String menu;
	private String func;
	private String target;
	private String changeContent;
	private String changeDate;
	
	public AdminChangeHistoryDto(String changerNameAndEmail, String menu, String func, String target,
			String changeContent, String changeDate) {
		this.changerNameAndEmail = changerNameAndEmail;
		this.menu = menu;
		this.func = func;
		this.target = target;
		this.changeContent = changeContent;
		this.changeDate = changeDate;
	}
	
	public String getChangerNameAndEmail() {
		return changerNameAndEmail;
	}
	public void setChangerNameAndEmail(String changerNameAndEmail) {
		this.changerNameAndEmail = changerNameAndEmail;
	}
	public String getMenu() {
		return menu;
	}
	public void setMenu(String menu) {
		this.menu = menu;
	}
	public String getFunc() {
		return func;
	}
	public void setFunc(String func) {
		this.func = func;
	}
	public String getTarget() {
		return target;
	}
	public void setTarget(String target) {
		this.target = target;
	}
	public String getChangeContent() {
		return changeContent;
	}
	public void setChangeContent(String changeContent) {
		this.changeContent = changeContent;
	}
	public String getChangeDate() {
		return changeDate;
	}
	public void setChangeDate(String changeDate) {
		this.changeDate = changeDate;
	}
}
