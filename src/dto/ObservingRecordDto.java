package dto;

public class ObservingRecordDto {
	private String modifier;
	private String func;
	private String target;
	private String changeContent;
	private String changeDate;
	
	public ObservingRecordDto(String modifier, String func, String target, String changeContent, String changeDate) {
		this.modifier = modifier;
		this.func = func;
		this.target = target;
		this.changeContent = changeContent;
		this.changeDate = changeDate;
	}
	
	public String getModifier() {
		return modifier;
	}
	public void setModifier(String modifier) {
		this.modifier = modifier;
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
