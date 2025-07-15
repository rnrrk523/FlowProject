package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import dto.LoginRecordDto;
import dto.loginRecordDateDto;

public class LoginRecordDao {
	public Connection getConnection() throws Exception{
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@//114.207.245.107:1521/XE";
		String id = "FLOW";
		String pw = "1234";
		
		Class.forName(driver);
		Connection conn = DriverManager.getConnection(url, id, pw);
		
		return conn;
	}
//	[SH-70] - 접속 기록 검색하기 (p41-2, p41-4)
//	-input : company_idx(숫자),  검색 기준(문자열),
//		    검색할 텍스트(문자열), 시작 날짜(문자열), 마지막 날짜(문자열)
//	-output : ArrayList<LoginRecordDto>
	public ArrayList<LoginRecordDto> getLoginRecordSearchDto(int companyIdx, String standard, String str, String startDate, String endDate) throws Exception{
		String m = null;
		if(standard.equals("이름")) {
			m = "m.name";
		}else if(standard.equals("부서")) {
			m = "d.department_name";
		}else if(standard.equals("직책")) {
			m = "m.position";
		}
		String sql = "SELECT c.company_name AS \"회사명\"," + 
				"       m.name AS \"이름\"," + 
				"       d.department_name AS \"부서\"," + 
				"       m.position AS \"직책\"," + 
				"       m.email AS \"이메일\"," + 
				"       NVL(sub.total_logins, 0) AS \"총 접속 수\"" + 
				" FROM companies c" + 
				" FULL OUTER JOIN members m ON c.company_idx = m.company_idx" + 
				" FULL OUTER JOIN departments d ON m.department_idx = d.department_idx" + 
				" LEFT JOIN (" + 
				"    SELECT mlr.member_idx, COUNT(mlr.login_date) AS total_logins" + 
				"    FROM member_login_record mlr" + 
				"    WHERE mlr.login_date BETWEEN TO_DATE(?, 'YYYY-MM-DD HH24:MI:SS') " + 
				"                             AND TO_DATE(?, 'YYYY-MM-DD HH24:MI:SS')" + 
				"    GROUP BY mlr.member_idx" + 
				" ) sub ON m.member_idx = sub.member_idx" + 
				" WHERE c.company_idx = ?" + 
				" AND "+m+" LIKE ?";
		
		ArrayList<LoginRecordDto> listRet = new ArrayList<LoginRecordDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, startDate+" 00:00:00");
		pstmt.setString(2, endDate+" 23:59:59");
		pstmt.setInt(3, companyIdx);
		pstmt.setString(4, "%"+str+"%");
		
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			String cName = rs.getString("회사명");
			String mName = rs.getString("이름");
			String dName = rs.getString("부서");
			String position = rs.getString("직책");
			String email = rs.getString("이메일");
			int loginCnt = rs.getInt("총 접속 수");
			LoginRecordDto dto = new LoginRecordDto(cName, mName, dName, position, email, loginCnt);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	
//	해당 회사에 월마다 총 접속수 구하기
	public loginRecordDateDto getRecordCntMonth(int companyIdx, String startDate, String endDate) throws Exception {
		String sql = "SELECT  SUM(접속수) AS \"총 접속 수\"," + 
				"        SUBSTR(접속일, 1, LENGTH(접속일) - 3) AS \"접속한 월\"" + 
				" FROM    (SELECT  COUNT(m.company_idx) AS \"접속수\"," + 
				"                mlr.login_date AS \"접속일\"" + 
				"        FROM    member_login_record mlr" + 
				"        INNER JOIN members m" + 
				"        ON      m.member_idx = mlr.member_idx" + 
				"        WHERE   m.company_idx = ?" + 
				"        AND     mlr.login_date BETWEEN TO_DATE(?, 'YYYYMM') AND LAST_DAY(TO_DATE(?, 'YYYYMM')) + INTERVAL '23:59:59' HOUR TO SECOND" + 
				"        GROUP BY login_date) sb" + 
				" GROUP BY SUBSTR(접속일, 1, LENGTH(접속일) - 3)";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, companyIdx);
		pstmt.setString(2, startDate);
		pstmt.setString(3, endDate);
		
		ResultSet rs = pstmt.executeQuery();
		loginRecordDateDto ret = null;
		if(rs.next()) {
			int loginCnt = rs.getInt("총 접속 수");
			String loginDate = rs.getString("접속한 월");
			ret = new loginRecordDateDto(loginCnt, loginDate);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return ret;
	}
	
	public static void main(String[] args) throws Exception{
		LoginRecordDao ldao = new LoginRecordDao();
		
		ArrayList<LoginRecordDto> loginRecordList = ldao.getLoginRecordSearchDto(1, "이름", "", "2024-11-01", "2024-11-01");
		for(LoginRecordDto dto : loginRecordList) {
			System.out.println("회사명 : "+dto.getcName());
			System.out.println("이름 : "+dto.getmName());
			System.out.println("부서 : "+dto.getdName());
			System.out.println("직책 : "+dto.getPosition());
			System.out.println("이메일 : "+dto.getEmail());
			System.out.println("총 접속 수 : "+dto.getLoginCnt());
			System.out.println("-------------------------------------");
		}
	}
}