package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import dto.AdminChangeHistoryDto;

public class AdminChangeHistoryDao {
	public Connection getConnection() throws Exception{
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@//114.207.245.107:1521/XE";
		String id = "FLOW";
		String pw = "1234";
		
		Class.forName(driver);
		Connection conn = DriverManager.getConnection(url, id, pw);
		
		return conn;
	}
//	[SH-73] - 관리자 변경 이력 검색하기 (p46-1)
//	-input : company_idx(숫자), 검색기준(문자열)[이름, 이메일, 메뉴, 기능], 검색어(문자열), 시작일(문자열), 마지막일(문자열)
//	-output : ArrayList<AdminChangeHistoryDto>
	public ArrayList<AdminChangeHistoryDto> getAdminChangeHistory(int companyIdx, String standard, String str, String startDate, String endDate) throws Exception{
		String m = null;
		if(standard.equals("변경자")) {
			m = "m.name";
		}else if(standard.equals("이메일")) {
			m = "m.email";
		}else if(standard.equals("메뉴")) {
			m = "acr.menu";
		}else if(standard.equals("기능")) {
			m = "acr.function";
		}
		String sql = "SELECT  m.name || chr(10) || '(' || m.email || ')' AS \"변경자(ID)\"," + 
				"        acr.menu AS \"메뉴\"," + 
				"        acr.function AS \"기능\"," + 
				"        acr.target AS \"대상\"," + 
				"        acr.change_content AS \"변경사항\"," + 
				"        acr.change_date AS \"변경날짜\"" + 
				" FROM    members m" + 
				" INNER JOIN admin_change_record acr" + 
				" ON      m.member_idx = acr.changer_idx" + 
				" WHERE   m.company_idx = ?" + 
				" AND     acr.change_date BETWEEN " + 
				"         TO_DATE(?, 'YYYY-MM-DD') " + 
				" AND     TO_DATE(?, 'YYYY-MM-DD HH24:MI:SS')" + 
				" AND     "+m+" LIKE ?" + 
				" ORDER BY acr.change_date DESC";
		ArrayList<AdminChangeHistoryDto> listRet = new ArrayList<AdminChangeHistoryDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, companyIdx);
		pstmt.setString(2, startDate);
		pstmt.setString(3, endDate+" 23:59:59");
		pstmt.setString(4, "%"+str+"%");
		
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			String changerNameAndEmail = rs.getString("변경자(ID)");
			String menu = rs.getString("메뉴");
			String func = rs.getString("기능");
			String target = rs.getString("대상");
			String changeContent = rs.getString("변경사항");
			String changeDate = rs.getString("변경날짜");
			AdminChangeHistoryDto dto = new AdminChangeHistoryDto(changerNameAndEmail, menu, func, target, changeContent, changeDate);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	
//	관리자 변경 이력 테이블에 INSERT
//	input: member_idx(숫자), 메뉴(문자열), 기능(문자열), 대상(문자열), 변경사항(문자열)
	public void addAdminChangeRecord(int memberIdx, String menu, String func, String target, String changeContent) throws Exception {
		String sql = "INSERT INTO admin_change_record(changer_idx, menu, function, target, change_content)" + 
				" VALUES(?, ?, ?, ?, ?)";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, memberIdx);
		pstmt.setString(2, menu);
		pstmt.setString(3, func);
		pstmt.setString(4, target);
		pstmt.setString(5, changeContent);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	public static void main(String[] args) throws Exception{
		AdminChangeHistoryDao adao = new AdminChangeHistoryDao();
		adao.addAdminChangeRecord(1, "메뉴", "기능", "대상", "변경사항");
		
//		ArrayList<AdminChangeHistoryDto> AdminChangeHistoryList = adao.getAdminChangeHistory(1, "메뉴", "회사", "2024-11-20", "2024-12-18");
//		for(AdminChangeHistoryDto dto : AdminChangeHistoryList) {
//			System.out.println("변경자(ID) : "+dto.getChangerNameAndEmail());
//			System.out.println("메뉴 : "+dto.getMenu());
//			System.out.println("기능 : "+dto.getFunc());
//			System.out.println("대상 : "+dto.getTarget());
//			System.out.println("변경사항 : "+dto.getChangeContent());
//			System.out.println("변경날짜 : "+dto.getChangeDate());
//			System.out.println("-------------------------------------------");
//		}
	}
}
