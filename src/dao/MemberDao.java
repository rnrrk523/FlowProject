package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Types;
import java.util.ArrayList;

import dto.MemberCompanyDepartmentDto;
import dto.MemberDto;
import dto.OnlyMemberDto;
import dto.ProjectMemberViewDto;

public class MemberDao {
	public Connection getConnection() throws Exception {
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@//114.207.245.107:1521/XE";
		String id = "FLOW";
		String pw = "1234";
		
		Class.forName(driver);
		Connection conn = DriverManager.getConnection(url, id, pw);
		return conn;
		}
	public ProjectMemberViewDto projectMemberValueMemberIdx(int memberIdx, int projectIdx) throws Exception {
		String sql = " SELECT " + 
				"   m.PROFILE_IMG AS 프로필URL," + 
				"    m.member_idx AS 멤버IDX," + 
				"    m.name AS 이름, " + 
				"    c.company_idx AS 회사번호, " + 
				"    c.company_name AS 회사명, " + 
				"    m.position AS 직책, " + 
				"    d.department_name AS 부서명," + 
				"    pm.admin_yn AS 어드민여부" + 
				" FROM members m" + 
				" JOIN companies c ON m.company_idx = c.company_idx" + 
				" LEFT JOIN departments d ON m.department_idx = d.department_idx" + 
				" JOIN project_member pm ON pm.participant_idx = m.member_idx" + 
				" WHERE pm.project_idx = ?" + 
				" AND m.member_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1,projectIdx);
		pstmt.setInt(2,memberIdx);
		ResultSet rs = pstmt.executeQuery();
		ProjectMemberViewDto dto = null;
		if(rs.next()) {
			memberIdx = rs.getInt("멤버IDX");
			String name = rs.getString("이름");
			String companyName = rs.getString("회사명");
			String position = rs.getString("직책");
			String departmentName = rs.getString("부서명");
			char adminYN = rs.getString("어드민여부").charAt(0);
			String profileImg = rs.getString("프로필URL");
			if(departmentName == null) {
				departmentName = "";
			}
			if(position == null) {
				position = "";
			}
			dto = new ProjectMemberViewDto(memberIdx, name,0, companyName, position, departmentName, adminYN, profileImg);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return dto;
	}
	public ArrayList<MemberDto>GetUserEmail()throws Exception {
		String sql = " SELECT email AS \"이메일\"" + 
				" FROM MEMBERS";
		ArrayList<MemberDto> listRet = new ArrayList<MemberDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			String email = rs.getString("이메일");
			MemberDto dto = new MemberDto(0, 0, email, email, email, email, email, email, email, email, '0', email, '0', email, email);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	public MemberDto GetMyProfile(int memberIdx)throws Exception {
		String sql = " SELECT COMPANY_IDX AS \"회사IDX\", Profile_img AS \"프로필\", MEMBER_IDX AS \"멤버IDX\", NAME AS \"이름\", status_message AS \"상태메시지\", project_color_fix AS \"색상고정\"," + 
				" HOMETAB_SETTING AS \"홈탭설정\", ADMIN_YN AS \"어드민여부\" " +
				" FROM MEMBERS" + 
				" WHERE MEMBER_IDX = ?";
		MemberDto dto = null;
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1,memberIdx);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int companyIdx = rs.getInt("회사IDX");
			memberIdx = rs.getInt("멤버IDX");
			String profileImg = rs.getString("프로필"); 
			String name = rs.getString("이름"); 
			String statusMessage = rs.getString("상태메시지");
			String hometabSetting = rs.getString("홈탭설정");
			char projectColorFix = rs.getString("색상고정").charAt(0);
			char adminYN = rs.getString("어드민여부").charAt(0);
			dto = new MemberDto(memberIdx,companyIdx, name, name, name, name, name, name, name, name, adminYN, statusMessage, projectColorFix, profileImg,hometabSetting);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return dto;
	}
	public MemberDto GetProfile(int memberIdx)throws Exception {
		String sql = " SELECT COMPANY_IDX AS \"회사IDX\", Profile_img AS \"프로필\", MEMBER_IDX AS \"멤버IDX\", NAME AS \"이름\", status_message AS \"상태메시지\", project_color_fix AS \"색상고정\"" + 
				" FROM MEMBERS" + 
				" WHERE MEMBER_IDX = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1,memberIdx);
		ResultSet rs = pstmt.executeQuery();
		MemberDto dto = null;
		while(rs.next()) {
			int companyIdx = rs.getInt("회사IDX");
			memberIdx = rs.getInt("멤버IDX");
			String profileImg = rs.getString("프로필"); 
			String name = rs.getString("이름"); 
			String statusMessage = rs.getString("상태메시지");
			char projectColorFix = rs.getString("색상고정").charAt(0);
			dto = new MemberDto(memberIdx,companyIdx, name, name, name, name, name, name, name, name, '1', statusMessage, projectColorFix, profileImg,"");
		}
		rs.close();
		pstmt.close();
		conn.close();
		return dto;
	}
	public ArrayList<MemberDto>GetProjectMemberProfile(int projectIdx,int type ,int companyIdx)throws Exception {
		String sql = "";
		if(type == 1) {
			sql = "SELECT  MEMBER_IDX AS \"멤버IDX\", " + 
					"		Profile_img AS \"프로필\"," +
					"        NAME AS \"이름\", " + 
					"        DEPARTMENT_NAME AS \"부서명\", " + 
					"        POSITION AS \"직책\", " + 
					"        COMPANY_NAME AS \"회사명\"" + 
					" FROM MEMBERS M" + 
					" JOIN COMPANIES C" + 
					" ON M.COMPANY_IDX = C.COMPANY_IDX" + 
					" LEFT JOIN DEPARTMENTS D" + 
					" ON m.department_idx = d.department_idx" + 
					" JOIN PROJECT_MEMBER PM" + 
					" ON M.MEMBER_IDX = pm.participant_idx" + 
					" WHERE pm.project_idx = ?" + 
					" AND pm.admin_yn = 'Y'" +
					" AND pm.state_yn = 'Y'"; 
		}
		if(type == 2) {
			sql = "SELECT  MEMBER_IDX AS \"멤버IDX\", " + 
					"		Profile_img AS \"프로필\"," +
					"        NAME AS \"이름\", " + 
					"        DEPARTMENT_NAME AS \"부서명\", " + 
					"        POSITION AS \"직책\", " + 
					"        COMPANY_NAME AS \"회사명\"" + 
					" FROM MEMBERS M" + 
					" JOIN COMPANIES C" + 
					" ON M.COMPANY_IDX = C.COMPANY_IDX" + 
					" LEFT JOIN DEPARTMENTS D" + 
					" ON m.department_idx = d.department_idx" + 
					" JOIN PROJECT_MEMBER PM" + 
					" ON M.MEMBER_IDX = pm.participant_idx" + 
					" WHERE pm.project_idx = ?" + 
					" AND M.company_Idx = ?" + 
					" AND pm.admin_yn = 'N'" +
					" AND pm.state_yn = 'Y'"; 
		}
		if(type == 3) {
			sql = "SELECT  MEMBER_IDX AS \"멤버IDX\", " + 
					"		Profile_img AS \"프로필\"," +
					"        NAME AS \"이름\", " + 
					"        DEPARTMENT_NAME AS \"부서명\", " + 
					"        POSITION AS \"직책\", " + 
					"        COMPANY_NAME AS \"회사명\"" + 
					" FROM MEMBERS M" + 
					" JOIN COMPANIES C" + 
					" ON M.COMPANY_IDX = C.COMPANY_IDX" + 
					" LEFT JOIN DEPARTMENTS D" + 
					" ON m.department_idx = d.department_idx" + 
					" JOIN PROJECT_MEMBER PM" + 
					" ON M.MEMBER_IDX = pm.participant_idx" + 
					" WHERE pm.project_idx = ?" + 
					" AND M.company_Idx != ?" + 
					" AND pm.admin_yn = 'N'" +
					" AND pm.state_yn = 'Y'"; 
			
		}
		ArrayList<MemberDto> listRet = new ArrayList<MemberDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1,projectIdx);
		if(type!=1) {
			pstmt.setInt(2,companyIdx);
		}
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			String profileImg = rs.getString("프로필");
			int memberIdx = rs.getInt("멤버IDX");
			String name = rs.getString("이름"); 
			String departmentName = rs.getString("부서명"); 
			String position = rs.getString("직책"); 
			String companyName = rs.getString("회사명"); 
			if(departmentName == null) {
				departmentName = "";
			}
			if(position == null) {
				position = "";
			}
			MemberDto dto = new MemberDto(memberIdx,0,companyName, name, departmentName, position, companyName, companyName, companyName, companyName, '0', companyName, '0' , profileImg,"");
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	public void StatementMessageUpdate(String statement, int MemberIdx) throws Exception{
		String sql = "UPDATE Members SET STATUS_MESSAGE = ? WHERE MEMBER_IDX = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,statement);
		pstmt.setInt(2, MemberIdx);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	//멤버 출력문
	public ArrayList<MemberDto> ChatMember(int companyIdx, int memberIdx, String search) throws Exception {
		String sql = "SELECT DISTINCT " + 
				"        m.profile_img AS \"프로필\"," + 
				"        M.MEMBER_IDX AS \"멤버IDX\", " + 
				"        M.NAME AS \"이름\"," + 
				"        M.POSITION AS \"직책\"," + 
				"        C.COMPANY_NAME AS \"회사명\"," + 
				"        D.DEPARTMENT_NAME AS \"부서명\"" + 
				" FROM MEMBERS M" + 
				" LEFT JOIN PROJECT_MEMBER PM ON M.MEMBER_IDX = PM.PARTICIPANT_IDX" + 
				" INNER JOIN COMPANIES C ON M.COMPANY_IDX = c.company_idx" + 
				" LEFT JOIN DEPARTMENTS D ON m.department_idx = d.department_idx" + 
				" WHERE (M.COMPANY_IDX = ?" + 
				"       OR PM.PROJECT_IDX IN (" + 
				"           SELECT PROJECT_IDX" + 
				"           FROM PROJECT_MEMBER" + 
				"           WHERE PARTICIPANT_IDX = ?" + 
				"       ))" + 
				" AND M.NAME Like ?"+
				" ORDER BY MEMBER_IDX";
		ArrayList<MemberDto> listRet = new ArrayList<MemberDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1,companyIdx);
		pstmt.setInt(2,memberIdx);
		pstmt.setString(3,"%"+search+"%");
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			String profile = rs.getString("프로필");
			memberIdx = rs.getInt("멤버IDX");
			String name = rs.getString("이름"); 
			String departmentName = rs.getString("부서명"); 
			String position = rs.getString("직책"); 
			String companyName = rs.getString("회사명"); 
			if(departmentName == null) {
				departmentName = "";
			}
			if(position == null) {
				position = "";
			}
			MemberDto dto = new MemberDto(memberIdx,0,companyName, name, departmentName, position, companyName, companyName, companyName, companyName, '0', companyName, '0' , profile,"");
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	//회사 멤버 출력문
	public ArrayList<MemberDto> CompanyMember(int companyIdx) throws Exception {
		String sql = "SELECT DISTINCT  " + 
				"				       m.profile_img AS \"프로필\" ," + 
				"				        M.MEMBER_IDX AS \"멤버IDX\" ," + 
				"				        M.NAME AS \"이름\"," + 
				"				        M.POSITION AS \"직책\" ," + 
				"				        C.COMPANY_NAME AS \"회사명\"," + 
				"				        D.DEPARTMENT_NAME AS \"부서명\"" + 
				"				 FROM MEMBERS M " + 
				"				 INNER JOIN COMPANIES C ON M.COMPANY_IDX = c.company_idx" + 
				"				 LEFT JOIN DEPARTMENTS D ON m.department_idx = d.department_idx " + 
				"				 WHERE M.COMPANY_IDX = ?    " + 
				"				 ORDER BY MEMBER_IDX";
		ArrayList<MemberDto> listRet = new ArrayList<MemberDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1,companyIdx);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			String profile = rs.getString("프로필");
			int memberIdx = rs.getInt("멤버IDX");
			String name = rs.getString("이름"); 
			String departmentName = rs.getString("부서명"); 
			String position = rs.getString("직책"); 
			String companyName = rs.getString("회사명"); 
			if(departmentName == null) {
				departmentName = "";
			}
			if(position == null) {
				position = "";
			}
			MemberDto dto = new MemberDto(memberIdx,0,companyName, name, departmentName, position, companyName, companyName, companyName, companyName, '0', companyName, '0' , profile,"");
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	//외부인 출력문
	public ArrayList<MemberDto> OutSiderMember(int companyIdx , int memberIdx) throws Exception {
		String sql = "SELECT DISTINCT  " + 
				"       m.profile_img AS \"프로필\" ," + 
				"        M.MEMBER_IDX AS \"멤버IDX\" ," + 
				"        M.NAME AS \"이름\"," + 
				"        M.POSITION AS \"직책\" ," + 
				"        C.COMPANY_NAME AS \"회사명\"," + 
				"        D.DEPARTMENT_NAME AS \"부서명\"" + 
				" FROM MEMBERS M " + 
				" INNER JOIN PROJECT_MEMBER PM ON M.MEMBER_IDX = PM.PARTICIPANT_IDX " + 
				" INNER JOIN COMPANIES C ON M.COMPANY_IDX = c.company_idx" + 
				" LEFT JOIN DEPARTMENTS D ON m.department_idx = d.department_idx " + 
				" WHERE (M.COMPANY_IDX != ?" + 
				"       AND PM.PROJECT_IDX IN ( " + 
				"           SELECT PROJECT_IDX" + 
				"           FROM PROJECT_MEMBER " + 
				"           WHERE PARTICIPANT_IDX = ? " + 
				"       )) " + 
				" ORDER BY MEMBER_IDX";
		ArrayList<MemberDto> listRet = new ArrayList<MemberDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1,companyIdx);
		pstmt.setInt(2,memberIdx);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			String profile = rs.getString("프로필");
			memberIdx = rs.getInt("멤버IDX");
			String name = rs.getString("이름"); 
			String departmentName = rs.getString("부서명"); 
			String position = rs.getString("직책"); 
			String companyName = rs.getString("회사명"); 
			if(departmentName == null) {
				departmentName = "";
			}
			if(position == null) {
				position = "";
			}
			MemberDto dto = new MemberDto(memberIdx,0,companyName, name, departmentName, position, companyName, companyName, companyName, companyName, '0', companyName, '0' , profile,"");
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	//회사 멤버 검색문
	public ArrayList<MemberDto> CompanyMemberSearch(int companyIdx, String text) throws Exception {
		String sql = "SELECT DISTINCT  " + 
				"				       m.profile_img AS \"프로필\" ," + 
				"				        M.MEMBER_IDX AS \"멤버IDX\" ," + 
				"				        M.NAME AS \"이름\"," + 
				"				        M.POSITION AS \"직책\" ," + 
				"				        C.COMPANY_NAME AS \"회사명\"," + 
				"				        D.DEPARTMENT_NAME AS \"부서명\"" + 
				"				 FROM MEMBERS M " + 
				"				 INNER JOIN PROJECT_MEMBER PM ON M.MEMBER_IDX = PM.PARTICIPANT_IDX " + 
				"				 INNER JOIN COMPANIES C ON M.COMPANY_IDX = c.company_idx" + 
				"				 LEFT JOIN DEPARTMENTS D ON m.department_idx = d.department_idx " + 
				"				 WHERE M.COMPANY_IDX = ?    " + 
				"				 AND M.NAME like ? " +
				"				 ORDER BY MEMBER_IDX";
		ArrayList<MemberDto> listRet = new ArrayList<MemberDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1,companyIdx);
		pstmt.setString(2,"%"+text+"%");
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			String profile = rs.getString("프로필");
			int memberIdx = rs.getInt("멤버IDX");
			String name = rs.getString("이름"); 
			String departmentName = rs.getString("부서명"); 
			String position = rs.getString("직책"); 
			String companyName = rs.getString("회사명"); 
			if(departmentName == null) {
				departmentName = "";
			}
			if(position == null) {
				position = "";
			}
			MemberDto dto = new MemberDto(memberIdx,0,companyName, name, departmentName, position, companyName, companyName, companyName, companyName, '0', companyName, '0' , profile,"");
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	//외부인 출력문
	public ArrayList<MemberDto> OutSiderMemberSearch(int companyIdx , int memberIdx , String text) throws Exception {
		String sql = "SELECT DISTINCT  " + 
				"       m.profile_img AS \"프로필\" ," + 
				"        M.MEMBER_IDX AS \"멤버IDX\" ," + 
				"        M.NAME AS \"이름\"," + 
				"        M.POSITION AS \"직책\" ," + 
				"        C.COMPANY_NAME AS \"회사명\"," + 
				"        D.DEPARTMENT_NAME AS \"부서명\"" + 
				" FROM MEMBERS M " + 
				" INNER JOIN PROJECT_MEMBER PM ON M.MEMBER_IDX = PM.PARTICIPANT_IDX " + 
				" INNER JOIN COMPANIES C ON M.COMPANY_IDX = c.company_idx" + 
				" LEFT JOIN DEPARTMENTS D ON m.department_idx = d.department_idx " + 
				" WHERE (M.COMPANY_IDX != ?" + 
				"       AND PM.PROJECT_IDX IN ( " + 
				"           SELECT PROJECT_IDX" + 
				"           FROM PROJECT_MEMBER " + 
				"           WHERE PARTICIPANT_IDX = ? " + 
				"       )) " + 
				"		AND M.NAME like ? " +
				" ORDER BY MEMBER_IDX";
		ArrayList<MemberDto> listRet = new ArrayList<MemberDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1,companyIdx);
		pstmt.setInt(2,memberIdx);
		pstmt.setString(3,"%"+text+"%");
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			String profile = rs.getString("프로필");
			memberIdx = rs.getInt("멤버IDX");
			String name = rs.getString("이름"); 
			String departmentName = rs.getString("부서명"); 
			String position = rs.getString("직책"); 
			String companyName = rs.getString("회사명"); 
			if(departmentName == null) {
				departmentName = "";
			}
			if(position == null) {
				position = "";
			}
			MemberDto dto = new MemberDto(memberIdx,0,companyName, name, departmentName, position, companyName, companyName, companyName, companyName, '0', companyName, '0' , profile,"");
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
//  맴버 이름과 프로필이미지 가져오기
//  input: member_idx(숫자)
  public OnlyMemberDto getMemberInfoAll(int memberIdx) throws Exception {
	  String sql = " SELECT company_idx, name, email, pw, phone, company_phone, department_idx, position, " +
              " admin_yn, state, profile_img, hire_date, recent_date, STATUS_MESSAGE, alarm_push, hometab_setting, project_color_fix " +
              " FROM members WHERE member_idx = ?";
     Connection conn = getConnection();
     PreparedStatement pstmt = conn.prepareStatement(sql);
     pstmt.setInt(1, memberIdx);
     ResultSet rs = pstmt.executeQuery();
     OnlyMemberDto ret = null;
     if(rs.next()) {
        int companyIdx = rs.getInt("company_idx");
        String name = rs.getString("name");
        String email = rs.getString("email");
        String pw = rs.getString("pw");
        String phone = rs.getString("phone");
        String companyPhone = rs.getString("company_phone");
        int departmentIdx = rs.getInt("department_idx");
        String position = rs.getString("position");
        char adminYN = rs.getString("admin_yn").charAt(0);
        String state = rs.getString("state");
        String profileImg = rs.getString("profile_img");
        String hireDate = rs.getString("hire_date");
        String recentDate = rs.getString("recent_date");
        String statusMessage = rs.getString("status_message");
        String alarmPush = rs.getString("alarm_push");
        String homeTab = rs.getString("hometab_setting");
        String projectColorFix = rs.getString("project_color_fix");
        ret = new OnlyMemberDto(memberIdx, companyIdx, name, email, pw, phone, companyPhone, departmentIdx, position, adminYN, state, profileImg, hireDate, recentDate, statusMessage, alarmPush, homeTab, projectColorFix);
     }
     rs.close();
     pstmt.close();
     conn.close();
     return ret;
  }
//	[SH-4] - 정상 상태인 구성원 보기 (p19-1)
//	-input : company_idx(숫자)
//	-output : ArrayList<MemberCompanyDepartmentDto>
	public ArrayList<MemberCompanyDepartmentDto> getAllMembersAvailable(int companyIdx) throws Exception{
		String sql = "SELECT DISTINCT c.company_name AS \"회사\"," + 
				"        m.member_idx AS \"회원IDX\"," + 
				"        m.name AS \"이름\"," + 
				"        m.position AS \"직책\"," + 
				"        m.email AS \"이메일\"," + 
				"        m.phone AS \"휴대폰 번호\"," + 
				"        m.hire_date AS \"가입일\"," + 
				"        m.state AS \"상태\"," + 
				"        m.admin_yn AS \"관리자\"," + 
				"        d.department_name AS \"부서\"," + 
				"        d.department_idx AS \"부서번호\"" + 
				" FROM    companies c" + 
				" FULL OUTER JOIN members m" + 
				" ON      c.company_idx = m.company_idx" + 
				" FULL OUTER JOIN departments d" + 
				" ON      m.department_idx = d.department_idx" + 
				" WHERE   c.company_idx = ?" + 
				" AND     m.state = '이용가능'" + 
				" ORDER BY member_idx";
		ArrayList<MemberCompanyDepartmentDto> listRet = new ArrayList<MemberCompanyDepartmentDto>();
		Connection conn =  getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, companyIdx);
		
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next()) {
			String companyName = rs.getString("회사");
			int memberIdx = rs.getInt("회원IDX");
			String name = rs.getString("이름");
			String position = rs.getString("직책");
			String email = rs.getString("이메일");
			String phone = rs.getString("휴대폰 번호");
			String hireDate = rs.getString("가입일");
			String state = rs.getString("상태");
			char adminYN = rs.getString("관리자").charAt(0);
			String departmentName = rs.getString("부서");
			int departmentIdx = rs.getInt("부서번호");
			MemberCompanyDepartmentDto dto = new MemberCompanyDepartmentDto(memberIdx, companyName, name, departmentName, departmentIdx, position, email, phone, hireDate, state, adminYN);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	
//	[SH-5] - 구성원 검색하기 (p19-2)
//	-input : company_idx(숫자),
//		   검색기준(문자열),
//		   검색어(문자열)
//		   검색기준 = 이름, 부서, 직책, 이메일, 휴대폰
//	-output : ArrayList<MemberCompanyDepartmentDto>
	public ArrayList<MemberCompanyDepartmentDto> getMemberSearch(int companyIdx, String standard, String str, String stateStr) throws Exception{
		String m = null;
		if(standard.equals("이름")) {
			m = "m.name";
		}else if(standard.equals("부서")) {
			m = "d.department_name";
		}else if(standard.equals("직책")) {
			m = "m.position";
		}else if(standard.equals("이메일")) {
			m = "m.email";
		}else if(standard.equals("휴대폰")) {
			m = "m.phone";
		}
		String sql = "SELECT  DISTINCT c.company_name AS \"회사\"," + 
				"		 m.member_idx AS \"회원IDX\"," + 
				"        m.name AS \"이름\"," + 
				"        m.position AS \"직책\"," + 
				"        m.email AS \"이메일\"," + 
				"        m.phone AS \"휴대폰 번호\"," + 
				"        m.hire_date AS \"가입일\"," + 
				"        m.state AS \"상태\"," + 
				"        m.admin_yn AS \"관리자\"," + 
				"        d.department_name AS \"부서\"," + 
				"        d.department_idx AS \"부서번호\"" + 
				" FROM    companies c" + 
				" FULL OUTER JOIN members m" + 
				" ON      c.company_idx = m.company_idx" + 
				" FULL OUTER JOIN departments d" + 
				" ON      m.department_idx = d.department_idx" + 
				" WHERE   c.company_idx = ?" + 
				" AND     m.state = ?" + 
				" AND     "+ m +" LIKE ?" + 
				" ORDER BY member_idx";
		ArrayList<MemberCompanyDepartmentDto> listRet = new ArrayList<MemberCompanyDepartmentDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, companyIdx);
		pstmt.setString(2, stateStr);
		pstmt.setString(3, "%"+str+"%");
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next()) {
			String companyName = rs.getString("회사");
			int memberIdx = rs.getInt("회원IDX");
			String name = rs.getString("이름");
			String position = rs.getString("직책");
			String email = rs.getString("이메일");
			String phone = rs.getString("휴대폰 번호");
			String hireDate = rs.getString("가입일");
			String state = rs.getString("상태");
			char adminYN = rs.getString("관리자").charAt(0);
			String departmentName = rs.getString("부서");
			int departmentIdx = rs.getInt("부서번호");
			MemberCompanyDepartmentDto dto = new MemberCompanyDepartmentDto(memberIdx, companyName, name, departmentName, departmentIdx, position, email, phone, hireDate, state, adminYN);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	
//	[SH-7] - 선택한 부서로 변경하기 (p19-7)
//	-input : member_idx(숫자),
//		   department_idx(숫자)
	public void setMemberDepartment(int memberIdx, int departmentIdx) throws Exception{
		String sql = "UPDATE  members" + 
				" SET     department_idx = ?" + 
				" WHERE   member_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, departmentIdx);
		pstmt.setInt(2, memberIdx);
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
	}
	
//	[SH-9] - 관리자(어드민) 여부 변경하기 (p19-9)
//	-input : member_idx(숫자)
	public void setMemberAdmin(int memberIdx) throws Exception{
		String sql = "UPDATE  members" + 
				" SET     admin_yn = " + 
				" CASE " + 
				"    WHEN admin_yn = 'N' THEN 'Y'" + 
				"    WHEN admin_yn = 'Y' THEN 'N'" + 
				"    END" + 
				" WHERE   member_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, memberIdx);
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
	}
	
//	[SH-10] - 구성원 정보수정창 띄우기 (p20-1)
//	-input : member_idx(숫자)
//	-output : member_name(문자열), email(문자열), company_name(문자열), department_name(문자열),
//		     position(문자열), phone(문자열), company_phone(문자열)
	public MemberCompanyDepartmentDto getMemberInfo(int memberIdx) throws Exception{
		String sql = "SELECT  DISTINCT m.name AS \"이름\"," + 
				"        m.email AS \"이메일\"," + 
				"        c.company_name AS \"회사명\"," + 
				"        d.department_name AS \"부서명\"," + 
				"        m.department_idx AS \"부서번호\"," + 
				"        m.position AS \"직책\"," + 
				"        m.phone AS \"휴대폰 번호\"," + 
				"        m.company_phone AS \"회사 연락처\"," + 
				"        m.hire_date AS \"가입일\"," + 
				"        m.state AS \"상태\"," + 
				"        m.admin_yn AS \"관리자\"" + 
				" FROM    companies c" + 
				" FULL OUTER JOIN members m" + 
				" ON      c.company_idx = m.company_idx" + 
				" FULL OUTER JOIN departments d" + 
				" ON      m.department_idx = d.department_idx" + 
				" WHERE   m.member_idx = ?";
		MemberCompanyDepartmentDto ret = null;
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, memberIdx);
		ResultSet rs = pstmt.executeQuery();
		if(rs.next()) {
			String name = rs.getString("이름");
			String email = rs.getString("이메일");
			String companyName = rs.getString("회사명");
			String departmentName = rs.getString("부서명");
			int departmentIdx = rs.getInt("부서번호");
			String position = rs.getString("직책");
			String phone = rs.getString("휴대폰 번호");
			//String companyPhone = rs.getString("회사 연락처");
			String hireDate = rs.getString("가입일");
			String state = rs.getString("상태");
			char adminYN = rs.getString("관리자").charAt(0);
			ret = new MemberCompanyDepartmentDto(memberIdx, companyName, name, departmentName, departmentIdx, position, email, phone, hireDate, state, adminYN);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return ret;
	}
	
//	[SH-11] - 구성원 정보수정하기 (p20-8)
//	-input : member_idx(숫자),
//		   변경할 이름(문자열),
//		   변경할 이메일(문자열),
//		   비밀번호 초기화 여부(boolean), 
//		   변경할 부서번호(숫자), 
//		   변경할 직책명(문자열), 
//		   변경할 휴대폰번호(문자열),
//		   변경할 회사연락처(문자열)
	public void setMemberInfo(int memberIdx, String nameStr, Integer setDepartmentIdx, String positionStr, String phoneStr) throws Exception{
		String sql = "UPDATE  members" + 
				" SET     name = ?," + 
				"        department_idx = ?," + 
				"        position = ?," + 
				"        phone = ?" + 
				" WHERE   member_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, nameStr);
		if(setDepartmentIdx == null) {
			pstmt.setNull(2, Types.NUMERIC);
		}else {
			pstmt.setInt(2, setDepartmentIdx);
		}
		pstmt.setString(3, positionStr);
		pstmt.setString(4, phoneStr);
		pstmt.setInt(5, memberIdx);
		pstmt.executeUpdate();
	}
	public void resetMemberPw(int memberIdx) throws Exception{
		String sql = "UPDATE members" + 
				" SET	pw = 'team123~!'" + 
				" WHERE	member_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, memberIdx);
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
	}
	
//	[SH-12] - 구성원 개별 등록하기 (p22-4)
//	-input :  company_idx(숫자),
//		   등록할 이름(문자열),
//		   등록할 이메일(문자열),
//		   등록할 비밀번호(문자열),
//		   등록할 부서번호(숫자),
//		   등록할 직책명(문자열),
//		   등록할 휴대폰번호(문자열),
//		   등록할 회사연락처(문자열)
	public void addMember(int companyIdx, String nameStr, String emailStr, String pwStr, Integer depIdx, String positionStr, String phoneStr) throws Exception{
		String sql = "INSERT INTO members(company_idx, member_idx, name, email, pw, department_idx, " + 
				" position, phone, state) " + 
				" VALUES(?, SEQ_MEMBERS.nextval, ?, ?, ?, ?, " + 
				" ?, ?, '이용가능')";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, companyIdx);
		pstmt.setString(2, nameStr);
		pstmt.setString(3, emailStr);
		pstmt.setString(4, pwStr);
		if(depIdx == null) {
			pstmt.setNull(5, Types.NUMERIC);
		}else {
			pstmt.setInt(5, depIdx);
		}
		pstmt.setString(6, positionStr);
		pstmt.setString(7, phoneStr);
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
	}
	
//	[SH-13] - 이용중지 상태인 구성원 보기 (p26)
//	-input : company_idx(숫자)
//	-output : ArrayList<MemberCompanyDepartmentDto>
	public ArrayList<MemberCompanyDepartmentDto> getStopUseMember(int companyIdx) throws Exception{
		String sql = "SELECT  DISTINCT c.company_name AS \"회사\"," + 
				"        m.member_idx AS \"회원IDX\"," + 
				"        m.name AS \"이름\"," + 
				"        m.position AS \"직책\"," + 
				"        m.email AS \"이메일\"," + 
				"        m.phone AS \"휴대폰 번호\"," + 
				"        m.hire_date AS \"가입일\"," + 
				"        m.state AS \"상태\"," + 
				"        m.admin_yn AS \"관리자\"," + 
				"        d.department_name AS \"부서\"," + 
				"        d.department_idx AS \"부서번호\"" + 
				" FROM    companies c" + 
				" FULL OUTER JOIN members m" + 
				" ON      c.company_idx = m.company_idx" + 
				" FULL OUTER JOIN departments d" + 
				" ON      m.department_idx = d.department_idx" + 
				" WHERE   c.company_idx = ?" + 
				" AND     m.state = '이용중지'" + 
				" ORDER BY member_idx";
		ArrayList<MemberCompanyDepartmentDto> listRet = new ArrayList<MemberCompanyDepartmentDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, companyIdx);
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next()) {
			String companyName = rs.getString("회사");
			int memberIdx = rs.getInt("회원IDX");
			String name = rs.getString("이름");
			String position = rs.getString("직책");
			String email = rs.getString("이메일");
			String phone = rs.getString("휴대폰 번호");
			String hireDate = rs.getString("가입일");
			String state = rs.getString("상태");
			char adminYN = rs.getString("관리자").charAt(0);
			String departmentName = rs.getString("부서");
			int departmentIdx = rs.getInt("부서번호");
			MemberCompanyDepartmentDto dto = new MemberCompanyDepartmentDto(memberIdx, companyName, name, departmentName, departmentIdx, position, email, phone, hireDate, state, adminYN);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	
//	[SH-14] - 구성원 상태(이용중지, 이용가능) 변경하기 (p24)
//	-input : member_idx(숫자)
	public void setMemberState(int memberIdx) throws Exception{
		String sql = "UPDATE  members" + 
				" SET state = " + 
				" CASE" + 
				"    WHEN state = '이용가능' THEN '이용중지'" + 
				"    WHEN state = '이용중지' THEN '이용가능'" + 
				"    END" + 
				" WHERE member_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, memberIdx);
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
	}
	
//	[SH-15] - 구성원 삭제하기(계정 삭제) (p26-2)
//	-input : member_idx(숫자)
	public void deleteMember(int memberIdx) throws Exception{
		String sql = "DELETE  members WHERE member_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, memberIdx);
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
	}
	
//	[SH-16] - 가입대기 상태인 구성원 보기 (p27-1)
//	-input : company_idx(숫자)
//	-output : ArrayList<Member>
	public ArrayList<MemberCompanyDepartmentDto> getWaitJoinStateMember(int companyIdx) throws Exception{
		String sql = "SELECT  DISTINCT c.company_name AS \"회사\"," + 
				"        m.member_idx AS \"회원IDX\"," + 
				"        m.name AS \"이름\"," + 
				"        m.position AS \"직책\"," + 
				"        m.email AS \"이메일\"," + 
				"        m.phone AS \"휴대폰 번호\"," + 
				"        m.hire_date AS \"가입일\"," + 
				"        m.state AS \"상태\"," + 
				"        m.admin_yn AS \"관리자\"," + 
				"        d.department_idx AS \"부서번호\"," + 
				"        d.department_name AS \"부서\"" + 
				" FROM    companies c" + 
				" FULL OUTER JOIN members m" + 
				" ON      c.company_idx = m.company_idx" + 
				" FULL OUTER JOIN departments d" + 
				" ON      m.department_idx = d.department_idx" + 
				" WHERE   c.company_idx = ?" + 
				" AND     m.state = '가입대기'" + 
				" ORDER BY member_idx";
		ArrayList<MemberCompanyDepartmentDto> listRet = new ArrayList<MemberCompanyDepartmentDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, companyIdx);
		
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next()) {
			String companyName = rs.getString("회사");
			int memberIdx = rs.getInt("회원IDX");
			String name = rs.getString("이름");
			String position = rs.getString("직책");
			String email = rs.getString("이메일");
			String phone = rs.getString("휴대폰 번호");
			String hireDate = rs.getString("가입일");
			String state = rs.getString("상태");
			char adminYN = rs.getString("관리자").charAt(0);
			int departmentIdx = rs.getInt("부서번호");
			String departmentName = rs.getString("부서");
			MemberCompanyDepartmentDto dto = new MemberCompanyDepartmentDto(memberIdx, companyName, name, departmentName, departmentIdx, position, email, phone, hireDate, state, adminYN);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	
//	[SH-17] - 가입대기 중인 구성원 검색하기 (p27)
//	-input : company_idx(숫자),
//		   검색할 구성원이름(문자열)
//	-output : ArrayList<Member>
	public ArrayList<OnlyMemberDto> getWaitJoinStateMemberSearch(int companyIdx, String str) throws Exception{
		String sql = "SELECT  m.name AS \"이름\"," + 
				"        m.member_idx AS \"회원IDX\"," + 
				"        m.email AS \"이메일\"," + 
				"        m.pw AS \"비밀번호\"," + 
				"        m.phone AS \"휴대폰 번호\"," + 
				"        m.company_phone AS \"회사 연락처\"," + 
				"        m.department_idx AS \"부서번호\"," + 
				"        m.position AS \"직책\"," + 
				"        m.admin_yn AS \"관리자\"," + 
				"        m.state AS \"상태\"," + 
				"        m.profile_img AS \"프로필\"," + 
				"        m.recent_date AS \"최근 활동일\"," + 
				"        m.hire_date AS \"가입 요청일\"," + 
				"        m.hometab_setting AS \"홈탭\"," + 
				"        m.alarm_push AS \"푸시 여부\"," + 
				"        m.project_color_fix AS \"프로젝트 색상\"," + 
				"        m.status_massage AS \"상태 메시지\"" + 
				" FROM    members m" + 
				" INNER JOIN companies c" + 
				" ON      c.company_idx = m.company_idx" + 
				" WHERE   m.company_idx = ?" + 
				" AND     m.state = '가입대기'" + 
				" AND	    m.name LIKE ?";
		ArrayList<OnlyMemberDto> listRet = new ArrayList<OnlyMemberDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, companyIdx);
		pstmt.setString(2, "%"+str+"%");
		
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int memberIdx = rs.getInt("회원IDX");
			String name = rs.getString("이름");
			String email = rs.getString("이메일");
			String pw = rs.getString("비밀번호");
			String phone = rs.getString("휴대폰 번호");
			String companyPhone = rs.getString("회사 연락처");
			int departmentIdx = rs.getInt("부서번호");
			String position = rs.getString("직책");
			char adminYN = rs.getString("관리자").charAt(0);
			String state = rs.getString("상태");
			String profileImg = rs.getString("프로필");
			String hireDate = rs.getString("가입 요청일");
			String recentDate = rs.getString("최근 활동일");
			String statusMassage = rs.getString("상태 메시지");
			String alarmPush = rs.getString("푸시 여부");
			String homeTab = rs.getString("홈탭");
			String projectColorFix = rs.getString("프로젝트 색상");
			OnlyMemberDto dto = new OnlyMemberDto(memberIdx, companyIdx, name, email, pw, phone, companyPhone, departmentIdx, position, adminYN, state, profileImg, hireDate, recentDate, statusMassage, alarmPush, homeTab, projectColorFix);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	
//	[SH-18] - 가입 승인하기 (p27-2)
//	-input : member_idx(숫자)
	public void setMemberApproval(int memberIdx) throws Exception{
		String sql = "UPDATE  members" + 
				" SET     state = '이용가능'," + 
				" hire_date = SYSDATE" + 
				" WHERE   member_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, memberIdx);
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
	}
	
//	[SH-19] - 가입 거절하기 (p27-2)
//	-input : member_idx(숫자)
	public void deleteMemberRefusal(int memberIdx) throws Exception{
		String sql = "DELETE members WHERE member_idx = ?";
		
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, memberIdx);
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
	}
	
//	최근 멤버idx 가져오기
//	input: company_idx(숫자)
//	output: member_idx(숫자)
	public int getRecentMemberIdx(int companyIdx) throws Exception{
		String sql = "SELECT  MAX(member_idx)" + 
				" FROM    members" + 
				" WHERE   company_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, companyIdx);
		ResultSet rs = pstmt.executeQuery();
		int ret = 0;
		if(rs.next()) {
			ret = rs.getInt("MAX(member_idx)");
		}
		rs.close();
		pstmt.close();
		conn.close();
		return ret;
	}
	
	public static void main(String[] args) throws Exception {
		MemberDao dao = new MemberDao();
		ArrayList<MemberDto> list = dao.ChatMember(1,1,"");
		for(MemberDto dto2 : list) {
			System.out.println(dto2.getName());
		}

	}

}
