package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import dto.GoToDto;
import dto.GoToDto2;

public class GoToDao {
	public Connection getConnection() throws Exception{
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@//114.207.245.107:1521/XE";
		String id = "FLOW";
		String pw = "1234";
		
		Class.forName(driver);
		Connection conn = DriverManager.getConnection(url, id, pw);
		
		return conn;
	}
	
//	[SH-27] - 회사 바로가기 관리 탭열기 (p31)
//	-intput : company_idx(숫자)
//	-output : ArrayList<GoToDto>
	public ArrayList<GoToDto2> getGoTo(int companyIdx) throws Exception{
		String sql = "SELECT  icon AS \"아이콘\"," + 
				"        go_to_idx AS \"바로가기IDX\"," + 
				"        name AS \"이름\"," + 
				"        url AS \"링크\"," + 
				"        state_yn AS \"상태\"" + 
				" FROM    go_to" + 
				" WHERE   company_idx = ?";
		ArrayList<GoToDto2> listRet = new ArrayList<GoToDto2>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, companyIdx);
		
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next()) {
			String icon = rs.getString("아이콘");
			int goToIdx = rs.getInt("바로가기IDX");
			String name = rs.getString("이름");
			String url = rs.getString("링크");
			char stateYN = rs.getString("상태").charAt(0);
			GoToDto2 dto = new GoToDto2(goToIdx, name, url, icon, stateYN);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	
//	[SH-28] - 바로가기 추가하기 (p31-1)
//	-input : company_idx(숫자),
//		   추가할 바로가기 이름(문자열),
//		   추가할 바로가기 링크(문자열),
//		   추가할 바로가기 상태(char(1))
	public void addGoTo(int companyIdx, String nameStr, String urlStr, String stateSet) throws Exception {
		String sql = "INSERT INTO go_to(go_to_idx, company_idx, name, state_yn, url)" + 
				" VALUES(SEQ_GO_TO.nextval, ?, ?, ?, ?)";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, companyIdx);
		pstmt.setString(2, nameStr);
		pstmt.setString(3, stateSet);
		pstmt.setString(4, urlStr);
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
	}
	
//	[SH-29] - 바로가기 상태 변경하기 (p31)
//	-input : go_to_idx(숫자)
	public void setGoTo(int goToIdx) throws Exception{
		String sql = "UPDATE  go_to " + 
				" SET     state_yn = " + 
				" CASE" + 
				"    WHEN state_yn = 'Y' THEN 'N'" + 
				"    WHEN state_yn = 'N' THEN 'Y'" + 
				"    END" + 
				" WHERE   go_to_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, goToIdx);
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
	}
	
//	바로가기 삭제하기
//	-input : go_to_idx(숫자)
	public void delGoTo(int goToIdx) throws Exception{
		String sql = "DELETE FROM go_to WHERE go_to_idx=?";
		
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, goToIdx);
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
	}
	public static void main(String[] args) throws Exception{
		GoToDao gdao = new GoToDao();
		
		
		
		
	}

}
