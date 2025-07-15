package dto;

public class DepartmentDto {
	private String name;
	private int departmentIdx;
	private int parentIdx;
	
	public DepartmentDto(String name, int departmentIdx, int parentIdx) {
		this.name = name;
		this.departmentIdx = departmentIdx;
		this.parentIdx = parentIdx;
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getDepartmentIdx() {
		return departmentIdx;
	}
	public void setDepartmentIdx(int departmentIdx) {
		this.departmentIdx = departmentIdx;
	}
	public int getParentIdx() {
		return parentIdx;
	}
	public void setParentIdx(int parentIdx) {
		this.parentIdx = parentIdx;
	}
}
