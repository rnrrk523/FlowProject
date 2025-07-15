package dto;

public class loginRecordDateDto {
	private int loginCnt;
	private String loginDate;
	
	public loginRecordDateDto(int loginCnt, String loginDate) {
		this.loginCnt = loginCnt;
		this.loginDate = loginDate;
	}
	
	public int getLoginCnt() {
		return loginCnt;
	}
	public void setLoginCnt(int loginCnt) {
		this.loginCnt = loginCnt;
	}
	public String getLoginDate() {
		return loginDate;
	}
	public void setLoginDate(String loginDate) {
		this.loginDate = loginDate;
	}
}
