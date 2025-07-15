package dto;

public class pindto {
	private String email;
	private String phone;
	private int pinNumber;
	private String pinStartDate;
	private String pinEndDate;
	public pindto(String email, String phone, int pinNumber, String pinStartDate, String pinEndDate) {
		this.email = email;
		this.phone = phone;
		this.pinNumber = pinNumber;
		this.pinStartDate = pinStartDate;
		this.pinEndDate = pinEndDate;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public int getPinNumber() {
		return pinNumber;
	}
	public void setPinNumber(int pinNumber) {
		this.pinNumber = pinNumber;
	}
	public String getPinStartDate() {
		return pinStartDate;
	}
	public void setPinStartDate(String pinStartDate) {
		this.pinStartDate = pinStartDate;
	}
	public String getPinEndDate() {
		return pinEndDate;
	}
	public void setPinEndDate(String pinEndDate) {
		this.pinEndDate = pinEndDate;
	}
	
	public pindto(String emailOrPhone, int pinNumber, String pinStartDate, String pinEndDate) {
		this.email = email;
		this.pinNumber = pinNumber;
		this.pinStartDate = pinStartDate;
		this.pinEndDate = pinEndDate;
	}
	
		
	
	
}

