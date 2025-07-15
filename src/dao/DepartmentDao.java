package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Types;
import java.util.ArrayList;

import dto.DepartmentDto;

public class DepartmentDao {
	public Connection getConnection() throws Exception{
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@//114.207.245.107:1521/XE";
		String id = "FLOW";
		String pw = "1234";
		
		Class.forName(driver);
		Connection conn = DriverManager.getConnection(url, id, pw);
		
		return conn;
	}
	
//	[SH-6] - 부서 선택창 띄우기 (p19-6),
//	[SH-21] - 조직도 관리 탭열기 (p29)
//	-input : company_idx(숫자)
//	-output : ArrayList<Department>
	public ArrayList<DepartmentDto> getDepartmentInfo(int companyIdx) throws Exception{
		String sql = "SELECT  department_name AS \"부서명\"," + 
				"        department_idx AS \"부서번호\", " + 
				"        parent_idx AS \"상위부서번호\"" + 
				" FROM    departments d" + 
				" WHERE   company_idx = ?" + 
				" START WITH parent_idx IS NULL" + 
				" CONNECT BY PRIOR department_idx = parent_idx" + 
				" ORDER BY department_idx";
		ArrayList<DepartmentDto> listRet = new ArrayList<DepartmentDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, companyIdx);
		
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next()) {
			String name = rs.getString("부서명");
			int departmentIdx = rs.getInt("부서번호");
			int parentIdx = rs.getInt("상위부서번호");
			DepartmentDto dto = new DepartmentDto(name, departmentIdx, parentIdx);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	
//	[SH-8] - 부서명으로 검색하기 (p19-8)
//	-input : company_idx(숫자),
//		   검색어(문자열)
	public ArrayList<DepartmentDto> getDepartmentSearch(int companyIdx, String str) throws Exception{
		String sql = "SELECT  department_name AS \"부서명\"," + 
				"        department_idx AS \"부서번호\"," + 
				"        parent_idx AS \"상위부서번호\"" + 
				" FROM    departments" + 
				" WHERE   company_idx = ?" + 
				" AND     department_name LIKE ?" + 
				" START WITH parent_idx IS NULL" + 
				" CONNECT BY PRIOR department_idx = parent_idx";
		ArrayList<DepartmentDto> listRet = new ArrayList<DepartmentDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, companyIdx);
		pstmt.setString(2, "%"+str+"%");
		
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next()) {
			String name = rs.getString("부서명");
			int departmentIdx = rs.getInt("부서번호");
			int parentIdx = rs.getInt("상위부서번호");
			DepartmentDto dto = new DepartmentDto(name, departmentIdx, parentIdx);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	
//	[SH-23] - 부서 추가하기 (p29-3)
//	-intput : company_idx(숫자),
//		    parent_idx(숫자),
//		    추가할 부서명(문자열)
	public void addDepartment(int companyIdx, Integer parentIdx, String depNameStr) throws Exception{
		String sql = "INSERT INTO departments(company_idx, parent_idx, " + 
				" department_name, department_idx) " + 
				" values(?, ?, ?, SEQ_DEPARTMENTS.nextval)";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, companyIdx);
		if(parentIdx == null) {
			pstmt.setNull(2, Types.NUMERIC);
		}else {
			pstmt.setInt(2, parentIdx);
		}
		pstmt.setString(3, depNameStr);
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
	}
	
//	[SH-24] - 부서 수정하기 (p29-4)
//	-input : department_idx(숫자)
//		   수정할 부서명(문자열)
	public void setDepartment(int departmentIdx, String depNameStr) throws Exception{
		String sql = "UPDATE  departments" + 
				" SET     department_name = ?" + 
				" WHERE   department_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, depNameStr);
		pstmt.setInt(2, departmentIdx);
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
	}
	
//	[SH-25] - 부서 삭제하기 (p29-5)
//	-input : department_idx(숫자)
	public void delDepartment(int departmentIdx) throws Exception{
		String sql = "DELETE departments WHERE department_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, departmentIdx);
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
	}
	
//	[SH-26] - 조직도 초기화하기 (p29-6)
//	-input : company_idx(숫자)
	public void resetDepartment(int companyIdx) throws Exception{
		String sql = "DELETE departments WHERE company_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, companyIdx);
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
	}
	
	// 부서명 가져오기
	public String getDepartmentName(int departmentIdx) throws Exception{
		String sql = "SELECT  department_name AS \"부서명\"" + 
				" FROM    departments" + 
				" WHERE   department_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, departmentIdx);
		ResultSet rs = pstmt.executeQuery();
		String ret = null;
		if(rs.next()) {
			ret = rs.getString("부서명");
		}
		rs.close();
		pstmt.close();
		conn.close();
		return ret;
	}
	public static void main(String[] args) throws Exception{
		DepartmentDao ddao = new DepartmentDao();
		
		System.out.println(ddao.getDepartmentName(1));
		
//		ArrayList<DepartmentDto> departmentList = ddao.getDepartmentInfo(1);
//		for(DepartmentDto dto : departmentList) {
//			System.out.print("부서명:" + dto.getName()+", ");
//			System.out.print("부서번호:" + dto.getDepartmentIdx()+", ");
//			System.out.println("상위부서:" + dto.getParentIdx());
//			System.out.println("-------------------------");
//		}
		
//		ArrayList<DepartmentDto> searchDepartmentList = ddao.getDepartmentSearch(1, "부");
//		for(DepartmentDto dto : searchDepartmentList) {
//			System.out.print("부서명 :" + dto.getName()+", ");
//			System.out.print("부서번호 :" + dto.getDepartmentIdx()+", ");
//			System.out.println("상위부서 :" + dto.getParentIdx());
//			System.out.println("------------------------------------");
//		}
		
//		ddao.addDepartment(1, null, "마케팅부");
//		ddao.setDepartment(7, "기획부");
//		ddao.delDepartment(7);
		
//		ddao.resetDepartment(2);
		
		
	}
}