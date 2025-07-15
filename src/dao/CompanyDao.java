package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import dto.CompanyDto;
import dto.FileDownloadRecordDto;
import dto.dto.companyDto;

public class CompanyDao {
	public Connection getConnection() throws Exception{
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@//114.207.245.107:1521/XE";
		String id = "FLOW";
		String pw = "1234";
		
		Class.forName(driver);
		Connection conn = DriverManager.getConnection(url, id, pw);
		
		return conn;
	}
	
//	[SH-1] - 회사 정보 탭열기 (p18-1)
//	-input : company_idx(숫자)
//
//	-output : company_name(문자열),
//		     logo_img(문자열),
//		     company_url(문자열)
	public CompanyDto getCompanyInfo(int companyIdx) throws Exception{
		String sql = "SELECT  company_name AS \"회사명\"," + 
				"        logo_img AS \"로고 이미지\"," + 
				"        company_url AS \"회사url\"," + 
				"        department_func_yn AS \"조직도기능여부\"," + 
				"        audit_chat_date AS \"채팅감사일시\"" + 
				" FROM    companies" + 
				" WHERE  company_idx = ?" + 
				" ORDER BY company_idx";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, companyIdx);
		
		ResultSet rs = pstmt.executeQuery();
		CompanyDto ret = null;
		while(rs.next()) {
			String companyName = rs.getString("회사명");
			String logoImg = rs.getString("로고 이미지");
			String companyUrl = rs.getString("회사url");
			char departmentFuncYN = rs.getString("조직도기능여부").charAt(0);
			String auditChatDate = rs.getString("채팅감사일시");
			ret = new CompanyDto(companyIdx, companyName, logoImg, companyUrl, departmentFuncYN, auditChatDate);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return ret;
	}
	
//	[SH-2] - 회사명 수정하기 (p18-2)
//	-input : company_idx(숫자),
//		 	  바꿀 회사명(문자열)
	public void updateCompanyName(int companyIdx, String updateStr) throws Exception {
		String sql = "UPDATE  companies" + 
				" SET     company_name = ?" + 
				" WHERE   company_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, updateStr);
		pstmt.setInt(2, companyIdx);
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
	}
	public void updateCompanyUrl(int companyIdx, String updateStr) throws Exception {
		String sql = "UPDATE companies SET company_url = ? WHERE company_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, updateStr);
		pstmt.setInt(2, companyIdx);
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
	}
	
//	[SH-3] - 로고 등록 or 재등록하기 (p18-3)
//	-input : company_idx(숫자), 등록할 로고의 파일명(문자열)
	public void updateCompanyLogo(int companyIdx, String updatestr) throws Exception{
		String sql = "UPDATE  companies" + 
				" SET     logo_img = ?" + 
				" WHERE   company_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, updatestr);
		pstmt.setInt(2, companyIdx);
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
	}
	
//	[SH-20] - 구성원 초대 탭열기 (p28)
//	-input : company_idx(숫자)
//	-output : company_url(문자열)
	public String getCompanyUrl(int companyIdx) throws Exception{
		String sql = "SELECT  company_url AS \"전용url\"" + 
				" FROM    companies" + 
				" WHERE   company_idx = ?";
		String companyUrl = null;
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, companyIdx);
		
		ResultSet rs = pstmt.executeQuery();
		
		if(rs.next()) {
			companyUrl = rs.getString("전용url");
		}
		rs.close();
		pstmt.close();
		conn.close();
		return companyUrl;
	}
	
//	[SH-21] - 조직도기능여부 확인 (p29)
//	-input : company_idx(숫자)
//	-output : department_func_yn(문자)
	public char getDepartmentFuncYN(int companyIdx) throws Exception{
		String sql = "SELECT department_func_yn" + 
				" FROM companies" + 
				" WHERE company_idx = ?";
		char ret = 0;
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, companyIdx);
		ResultSet rs = pstmt.executeQuery();
		if(rs.next()) {
			ret = rs.getString("department_func_yn").charAt(0);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return ret;
	}
	
//	[SH-22] - 조직도 기능 켜기/끄기 (p29-1)
//	-input : company_idx(숫자)
	public void setDepartmentFuncYN(int companyIdx) throws Exception{
		String sql = "UPDATE  companies" + 
				" SET     department_func_yn = " + 
				" CASE" + 
				"    WHEN department_func_yn = 'Y' THEN 'N'" + 
				"    WHEN department_func_yn = 'N' THEN 'Y'" + 
				"    END" + 
				" WHERE   company_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, companyIdx);
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
	}
	
//	파일다운로드이력 검색 조회하기
//	input: company_idx(숫자), 검색기준(문자열), 검색어(문자열), 시작날짜(문자열), 마지막날짜(문자열)
//	output: ArrayList<FileDownloadRecordDto>
	public ArrayList<FileDownloadRecordDto> getFileDownloadRecord(int companyIdx, String standard, String str, String startDate, String endDate) throws Exception {
		String m = "";
		if(standard.equals("파일명")) {
			m = "bf.file_name";
		}else if(standard.equals("이름")) {
			m = "m.name";
		}if(standard.equals("아이디")) {
			m = "m.email";
		}
		String sql = "SELECT  fdr.down_date AS \"다운로드 일시\"," + 
				"        bf.file_name AS \"파일명\"," + 
				"        bf.file_capacity AS \"용량\"," + 
				"        m.name||'('||m.email||')' AS \"이름/아이디\"" + 
				" FROM    file_download_record fdr" + 
				" INNER JOIN members m" + 
				" ON      fdr.member_idx = m.member_idx" + 
				" INNER JOIN board_file bf" + 
				" ON      fdr.file_idx = bf.file_idx" + 
				" WHERE   fdr.company_idx = ?" + 
				" AND     "+m+" LIKE ?" + 
				" AND     fdr.down_date BETWEEN TO_DATE(?, 'YYYY-MM-DD') AND TO_DATE(?, 'YYYY-MM-DD')";
		ArrayList<FileDownloadRecordDto> listRet = new ArrayList<FileDownloadRecordDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, companyIdx);
		pstmt.setString(2, "%"+str+"%");
		pstmt.setString(3, startDate);
		pstmt.setString(4, endDate);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			String downDate = rs.getString("다운로드 일시");
			String fileName = rs.getString("파일명");
			String fileCapacity = rs.getString("용량");
			String downloader = rs.getString("이름/아이디");
			FileDownloadRecordDto dto = new FileDownloadRecordDto(downDate, fileName, fileCapacity, downloader);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}

	public static void main(String[] args) throws Exception{
		CompanyDao cdao = new CompanyDao();
		
		CompanyDto companyList = cdao.getCompanyInfo(2);
		System.out.println("회사명 : " + companyList.getCompanyName());
		System.out.println("로고 이미지 주소 : " + companyList.getLogoImg());
		System.out.println("회사 url 주소 : " + companyList.getCompanyUrl());
		
		
//		cdao.updateCompanyInfo(1, "리썰컴퍼니"); // 회사idx = 1의 회사명 수정
//		cdao.updateCompanyLogo(1, "https://team-0aatbo.flow.team"); // 회사idx = 1의 로고 등록or재등록
		
//		System.out.println("전용url : "+cdao.getCompanyUrl(1));;
		
//		DepartmentDao mdao = new DepartmentDao();
//		ArrayList<DepartmentDto> departmentInfoList = mdao.getDepartmentInfo(1);
//		if(cdao.getDepartmentFuncYN(1) == 'Y') {
//			for(DepartmentDto dto : departmentInfoList) {
//				System.out.print("부서명 :" + dto.getName()+", ");
//				System.out.print("부서번호 :" + dto.getDepartmentIdx()+", ");
//				System.out.println("상위부서 :" + dto.getParentIdx());
//				System.out.println("------------------------------------");
//			}
//		}
		
//		cdao.setDepartmentFuncYN(1);
		
	}
}
