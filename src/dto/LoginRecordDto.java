package dto;

public class LoginRecordDto {
	private String cName;
	private String mName;
	private String dName;
	private String position;
	private String email;
	private int loginCnt;
	
	public LoginRecordDto(String cName, String mName, String dName, String position, String email, int loginCnt) {
		this.cName = cName;
		this.mName = mName;
		this.dName = dName;
		this.position = position;
		this.email = email;
		this.loginCnt = loginCnt;
	}
	
	public String getcName() {
		return cName;
	}
	public void setcName(String cName) {
		this.cName = cName;
	}
	public String getmName() {
		return mName;
	}
	public void setmName(String mName) {
		this.mName = mName;
	}
	public String getdName() {
		return dName;
	}
	public void setdName(String dName) {
		this.dName = dName;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getLoginCnt() {
		return loginCnt;
	}
	public void setLoginCnt(int loginCnt) {
		this.loginCnt = loginCnt;
	}
}