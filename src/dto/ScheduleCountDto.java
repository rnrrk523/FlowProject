package dto;

public class ScheduleCountDto {

	private int count1;
	private int count2;
	private int count3;
	public ScheduleCountDto(int count1, int count2, int count3) {
		this.count1 = count1;
		this.count2 = count2;
		this.count3 = count3;
	}
	public int getCount1() {
		return count1;
	}
	public void setCount1(int count1) {
		this.count1 = count1;
	}
	public int getCount2() {
		return count2;
	}
	public void setCount2(int count2) {
		this.count2 = count2;
	}
	public int getCount3() {
		return count3;
	}
	public void setCount3(int count3) {
		this.count3 = count3;
	}
	
}
