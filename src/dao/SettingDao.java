package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class SettingDao {
	public Connection getConnection() throws Exception{
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@//114.207.245.107:1521/XE";
		String id = "FLOW";
		String pw = "1234";
		
		Class.forName(driver);
		Connection conn = DriverManager.getConnection(url, id, pw);
		
		return conn;
	}
	
	// 환경설정 - 이름 수정
	public void modifyUserName(int memberIdx, String nameStr) throws Exception {
		String sql = "UPDATE members SET name = ? WHERE member_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, nameStr);
		pstmt.setInt(2, memberIdx);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	
	// 환경설정 - 직책수정
	public void modifyUserPosition(int memberIdx, String positionStr) throws Exception {
		String sql = "UPDATE members SET position = ? WHERE member_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, positionStr);
		pstmt.setInt(2, memberIdx);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	
	// 환경설정 - 휴대폰 번호수정
	public void modifyUserPhone(int memberIdx, String phoneStr) throws Exception {
		String sql = "UPDATE members SET phone = ? WHERE member_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, phoneStr);
		pstmt.setInt(2, memberIdx);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	
	// 환경설정 - 회사연락처수정
	public void modifyUserCompanyPhone(int memberIdx, String companyPhoneStr) throws Exception {
		String sql = "UPDATE members SET company_phone = ? WHERE member_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, companyPhoneStr);
		pstmt.setInt(2, memberIdx);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	
	// 환경설정 - 상태메시지수정
	public void modifyUserStatusMassage(int memberIdx, String statusMassageStr) throws Exception {
		String sql = "UPDATE members SET status_massage = ? WHERE member_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, statusMassageStr);
		pstmt.setInt(2, memberIdx);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	
	// 환경설정 - 알림 - 알람푸쉬
	public String modifyUserAlarmPush(int memberIdx) throws Exception {
		String sql = "UPDATE members SET alarm_push = " + 
				" CASE" + 
				"    WHEN alarm_push = 'Y' THEN 'N'" + 
				"    WHEN alarm_push = 'N' THEN 'Y'" + 
				"    ELSE alarm_push END" + 
				" WHERE member_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, memberIdx);
		pstmt.executeUpdate();
		pstmt.close();
		
		String sql2 = "SELECT alarm_push FROM members WHERE member_idx = ?";
		PreparedStatement pstmt2 = conn.prepareStatement(sql2);
		pstmt2.setInt(1, memberIdx);
		ResultSet rs = pstmt2.executeQuery();
		String ret = null;
		if(rs.next()) {
			ret = rs.getString("alarm_push");
		}
		rs.close();
		pstmt2.close();
		conn.close();
		return ret;
	}
	
	// 환경설정 - 디스플레이 설정 - 프로젝트색상고정
	public String modifyUserProjectColorFix(int memberIdx) throws Exception {
		String sql = "UPDATE members SET project_color_fix = " + 
				" CASE" + 
				"    WHEN project_color_fix = 'Y' THEN 'N'" + 
				"    WHEN project_color_fix = 'N' THEN 'Y'" + 
				"    ELSE project_color_fix END" + 
				" WHERE member_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, memberIdx);
		pstmt.executeUpdate();
		pstmt.close();
		
		String sql2 = "SELECT project_color_fix FROM members WHERE member_idx = ?";
		PreparedStatement pstmt2 = conn.prepareStatement(sql2);
		pstmt2.setInt(1, memberIdx);
		ResultSet rs = pstmt2.executeQuery();
		String ret = null;
		if(rs.next()) {
			ret = rs.getString("project_color_fix");
		}
		rs.close();
		pstmt2.close();
		conn.close();
		return ret;
	}
	
	// 환경설정 - 디스플레이 설정 - 메인 홈 설정
	public String modifyUserMainHomeSetting(int memberIdx) throws Exception {
		String sql = "UPDATE members SET hometab_setting = " + 
				" CASE" + 
				"    WHEN hometab_setting = '대시보드' THEN '내 프로젝트'" + 
				"    WHEN hometab_setting = '내 프로젝트' THEN '대시보드'" + 
				"    ELSE hometab_setting END" + 
				" WHERE member_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, memberIdx);
		pstmt.executeUpdate();
		pstmt.close();
		
		String sql2 = "SELECT hometab_setting FROM members WHERE member_idx = ?";
		PreparedStatement pstmt2 = conn.prepareStatement(sql2);
		pstmt2.setInt(1, memberIdx);
		ResultSet rs = pstmt2.executeQuery();
		String ret = null;
		if(rs.next()) {
			ret = rs.getString("hometab_setting");
		}
		rs.close();
		pstmt2.close();
		conn.close();
		return ret;
	}
	public static void main(String[] args) {
		SettingDao sDao = new SettingDao();
		try {
			sDao.modifyUserName(2, "정성훈");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}