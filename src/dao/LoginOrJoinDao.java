package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import dto.CompanyNameDto;
import dto.membersALLdto;

public class LoginOrJoinDao {
	public Connection getConnection() throws Exception{
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@//114.207.245.107:1521/XE";
		String id = "FLOW";
		String pw = "1234";
		
		Class.forName(driver);
		Connection conn = DriverManager.getConnection(url, id, pw);
		
		return conn;
	}
	//	인증번호를 전화번호로 요청시
	public void cartificationPhone(String phone , int pinNumber) throws Exception{
		Connection conn = getConnection();
		String sql = "INSERT INTO pin(phone, pin_number) VALUES(?, ?)";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, phone);
		pstmt.setInt(2, pinNumber);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}	
	//	인증번호를  email로 요청시
	public void cartificationEmail( String email, int pinNumber){
		try {
		Connection conn = getConnection();
		String sql = " INSERT INTO pin(email, pin_number) VALUES(?, ?)";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, email);
		pstmt.setInt(2, pinNumber);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
		}catch(Exception e) {}
	}
	//	로그인 확인
	public String clickLogin(String email ,  String pw) throws Exception{
		Connection conn = getConnection();
		String sql = "SELECT state "+ 
				" FROM members" + 
				" WHERE email = ? AND pw = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,email);
		pstmt.setString(2, pw);
		ResultSet rs = pstmt.executeQuery();
		String state = "";
		if(rs.next()) {
			state = rs.getString(1);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return state;
	}
	public void deleteUpdate() throws Exception{
		String sql = "DELETE pin WHERE pin_end_date < SYSDATE";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	//	인증번호 유효및 시간 검사
	public boolean checkCertification(String email, String phone, Integer pinNumber) throws Exception {
	    String sql = "SELECT 1 FROM pin WHERE pin_number = ? AND pin_end_date > SYSDATE AND (email = ? OR phone = ?)";
	    try (Connection conn = getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {

	        // SQL 파라미터 설정
	        pstmt.setInt(1, pinNumber);

	        if (email != null) {
	            pstmt.setString(2, email);
	            pstmt.setString(3, null);
	        } else if (phone != null) {
	            pstmt.setString(2, null);
	            pstmt.setString(3, phone);
	        } else {
	            return false;
	        }

	        // 쿼리 실행 및 결과 처리
	        try (ResultSet rs = pstmt.executeQuery()) {
	            return rs.next(); // 결과가 있으면 true, 없으면 false
	        }
	    }
	}
	public void updatePassword( String pw, int memberIdx) throws Exception{
		
//	UPDATE members SET pw = ? WHERE member_idx = ?	비밀번호 변경
		String sql = "UPDATE members SET pw = ? WHERE member_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,pw);
		pstmt.setInt(2, memberIdx);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	public boolean checkingPass(String pw, int memberIdx) throws Exception{
		String sql = "SELECT 1" + 
				" FROM members" + 
				" WHERE pw = ? AND member_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, pw);
		pstmt.setInt(2, memberIdx);
		ResultSet rs = pstmt.executeQuery();
		return rs.next();
	}
//	delete FROM members WHERE member_idx = 1; 	해당 멤버 지우기, 가입요청 거절시 , 또는 member 탈퇴시
	public void DelMemberstate(int memberIdx) throws Exception{
		String sql = "delete FROM members WHERE member_idx = 1";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, memberIdx);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	//회사 생성
	public void CreateCompany(String name, int indust, int plan, String url) throws Exception {
		String sql = "INSERT INTO COMPANIES(COMPANY_IDX,company_name,industry_idx,plan_idx,company_url)" + 
				"VALUES (SEQ_COMPANY_IDX.NEXTVAL,?,?,?,?)";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,name );
		pstmt.setInt(2, indust);
		pstmt.setInt(3, plan);
		pstmt.setString(4, url);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	//회사 생성된 IDX 가져오기
	public int CreateCompanyIdx() throws Exception{
		String sql = "Select last_number from user_sequences where sequence_name = 'SEQ_COMPANY_IDX'";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		int count = 0;
		if(rs.next()) {
			count = rs.getInt(1);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return count;
	}
	//회사 생성된 IDX 가져오기
	public int CreateMemberIdx() throws Exception{
		String sql = "Select last_number from user_sequences where sequence_name = 'SEQ_MEMBER_IDX'";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		int count = 0;
		if(rs.next()) {
			count = rs.getInt(1);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return count;
	}
	// 회사 어드민 필요없이 바로 이용가능으로 		즉 가입 요청 없는
	public void insertMember (  int companyIdx, String name , String email, String pw,String phone, String agree1)  throws Exception{
//	INSERT INTO members (member_idx, company_idx, name, email, pw, agree1, agree2, agree3) VALUES (seq_member_idx.nextVal, 1, '김하나', 'widhtk@gmail.com', 'eej2345', 'Y', 'Y','Y');
		String sql = "INSERT INTO members (member_idx, company_idx, name, email, pw,phone,ADMIN_YN,state,BENEFIT_AGREE) VALUES (seq_member_idx.nextVal,?, ?, ?, ?, ?,'Y','이용가능',?)";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, companyIdx);
		pstmt.setString(2,name );
		pstmt.setString(3,email);
		pstmt.setString(4, pw);
		pstmt.setString(5, phone);
		pstmt.setString(6, agree1);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	// 	회사 어드민이 수락시에 이용대기에서 사용가능으로 되는 가입 요청형 회원가입
	public void waitStateMemberINSERT( int companyIdx, String name , String email, String pw, String benefitYn) throws Exception{
		//INSERT INTO members (member_idx, company_idx, name,state, email, pw) VALUES (seq_member_idx.nextVal, 1, '김하나','이용가능','widhtk@gmail.com', 'eej2345', 'Y', 'Y','Y');
		String sql = "INSERT INTO members (member_idx, company_idx, name, email, pw,BENEFIT_AGREE) VALUES (seq_member_idx.nextVal,?, ?,?, ?, ?)";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, companyIdx);
		pstmt.setString(2, name);
		pstmt.setString(3,email);
		pstmt.setString(4, pw);
		pstmt.setString(5, benefitYn);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	public void ProjectFolderAccount(int memberIdx, String projectCategory) throws Exception {
		String sql = "INSERT INTO PROJECT_FOLDER VALUES(SEQ_PROJECT_FOLDER_IDX.NEXTVAL,?,?)";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, memberIdx);
		pstmt.setString(2, projectCategory);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	public void DashBoardAccount(int memberIdx, int Category, int size) throws Exception {
		String sql = "INSERT INTO DASH_BOARD VALUES (SEQ_DASHBOARD_IDX.NEXTVAL,?,?,null,?)";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, memberIdx);
		pstmt.setInt(2, Category);
		pstmt.setInt(3, size);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	public void ViewSettingAccount(int memberIdx) throws Exception {
		String sql = "INSERT INTO VIEW_SETTING (member_IDX) VALUES (?)";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, memberIdx);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	public void ProjectCategoryAccount(int companyIdx, String name) throws Exception {
		String sql = "INSERT INTO PROJECT_CATEGORY VALUES(SEQ_PROJECT_CATEGORY_IDX.NEXTVAL,?,?,'Y')";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, companyIdx);
		pstmt.setString(2, name);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	public void GOTOAccount(int companyIdx,String url,String YN, String name, String icon) throws Exception {
		String sql = "INSERT INTO GO_TO VALUES(SEQ_GO_tO_IDX.NEXTVAL,?,?,?,?,?)";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, companyIdx);
		pstmt.setString(2, url);
		pstmt.setString(3, YN);
		pstmt.setString(4, name);
		pstmt.setString(5, icon);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	public ArrayList <membersALLdto> companyMember (int companyIdx) throws Exception{
		Connection conn = getConnection();
		String sql = "SELECT name " + 
				"	FROM members " + 
				"	WHERE company_idx = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1,companyIdx);
		ArrayList <membersALLdto> dtolist = new ArrayList<membersALLdto>();
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			String name = rs.getString("name");
			membersALLdto list = new membersALLdto(name);
			dtolist.add(list);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return dtolist;
	}	
//	public ArrayList<CompanyDto2> CompanyName(int companyIdx) throws Exception{
////		SELECT company_nameFROM companies	WHERE company_idx = 1;
//		String sql = "SELECT company_name FROM companies	WHERE company_idx = ?";
//		Connection conn = getConnection();
//		PreparedStatement pstmt = conn.prepareStatement(sql);
//		pstmt.setInt(1, companyIdx);
//		ArrayList<CompanyDto2> list = new ArrayList<CompanyDto2>();
//		ResultSet rs = pstmt.executeQuery();
//		while(rs.next()) {
//			String companyName = rs.getString("company_name");
//			CompanyDto2 dtolist = new CompanyDto2(companyName);
//			list.add(dtolist);
//		}
//		rs.close();
//		pstmt.close();
//		conn.close();
//		return list;
//		
//	}
	
//		SELECT company_nameFROM companies	WHERE company_idx = 1;
		
//	SELECT name FROM members WHERE company_idx = 1;

//	SELECT company_nameFROM companies	WHERE company_idx = 1;
	
//											환경설정에서 이름 바꾸기
	
	//colorFixed
	public void colorFixed(int memberIdx , String yn) throws Exception{
		Connection conn = getConnection();
		String sql = "UPDATE members SET project_color_fix = ? WHERE member_idx =?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, yn);
		pstmt.setInt(2, memberIdx);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	public void updateAlarm(int memberIdx , String yn) throws Exception{
		Connection conn = getConnection();
		String sql = "UPDATE members SET alarm_push = ? WHERE member_idx = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, yn);
		pstmt.setInt(2,  memberIdx);
		pstmt.executeLargeUpdate();
		pstmt.close();
		conn.close();
	}
	public void preferName (String name ,int memberIdx) throws Exception{
		Connection conn = getConnection();
		String sql = "UPDATE members SET name = ? WHERE member_idx = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, name);
		pstmt.setInt(2, memberIdx);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	public void preferphone (int memberIdx , String phone) throws Exception{
		Connection conn = getConnection();
		String sql = "UPDATE members SET phone = ? WHERE member_idx = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1,  memberIdx);
		pstmt.setString(2, phone);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
//	환경설정에서 직책설정
	public void preferPosition (int memberIdx , String position) throws Exception{
		Connection conn = getConnection();
		String sql = "UPDATE members SET position = ? WHERE member_idx = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, position);
		pstmt.setInt(2, memberIdx);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	public void statusMessage (int memberIdx , String statusMessage) throws Exception{
		Connection conn = getConnection();
		String sql = "UPDATE members SET status_message = ? WHERE member_idx = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(2, memberIdx);
		pstmt.setString(1,statusMessage);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	
	public void companyPhone (int memberIdx , String phoneNumber) throws Exception{
		Connection conn = getConnection();
		String sql = "UPDATE members SET company_phone = ? WHERE member_idx = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, phoneNumber);
		pstmt.setInt(2, memberIdx);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
//	환경설정에서 프로필 이미지 바꾸기
	public void perferProfileImg(int memberIdx) throws Exception{		
		Connection conn = getConnection();
		String sql = "UPDATE members SET profile_img = 'url' WHERE member_idx = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, memberIdx);
		pstmt.close();
		conn.close();
	}
//	환경설정에서 자신의 정보 보여주기
	public ArrayList<membersALLdto>preferMine (int memberIdx) throws Exception{
		Connection conn = getConnection();
		String sql = "SELECT name ,  company_name, department_idx,  email, phone, company_phone, position, status_message  " + 
				" FROM members m INNER JOIN companies c " + 
				"  ON m.company_idx = c.company_idx  " + 
				" WHERE member_idx = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, memberIdx);
		ArrayList<membersALLdto> list = new ArrayList<membersALLdto>();
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			String name = rs.getString("name");
			String companyName  = rs.getString("company_name");
			int departmentIdx = rs.getInt("department_idx");
			String email = rs.getString("email");
			String phone = rs.getString("phone");
			String companyPhone = rs.getString("company_phone");
			String position = rs.getString("position");
			String statusMessage = rs.getString("status_message");
			membersALLdto dtolist = new membersALLdto(name, companyName, departmentIdx, email,phone,  companyPhone, position, statusMessage);
			list.add(dtolist);
			System.out.println(companyName + email +  phone + companyPhone + position + statusMessage);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return list;
	}
	//	디스플레이 및 알림 설정창
	public ArrayList<membersALLdto> displayprefer(int memberIdx) throws Exception{
		Connection conn = getConnection();
		String sql = " SELECT project_color_fix, hometab_setting, favorite_fix ,alarm_push" + 
				"FROM members_table" + 
				"WHERE member_idx = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, memberIdx);
		ArrayList<membersALLdto> list = new ArrayList<membersALLdto>();
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			char alarmPush = rs.getString("alarm_push").charAt(0);
			String homeTabSetting = rs.getString("hometab_setting");
			char projectColorFix = rs.getString("project_color_fix").charAt(2);
			char favoriteFix = rs.getString("favorite_fix").charAt(3);
			membersALLdto dtolist = new membersALLdto(alarmPush, homeTabSetting, projectColorFix, favoriteFix);
			list.add(dtolist);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return list;
		
	}
	public void updateDisplaySet(int memberIdx , String homeTab) throws Exception{
		String sql = "UPDATE members SET hometab_setting = ? WHERE member_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(2, memberIdx);
		pstmt.setString(1, homeTab);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	//부서이름 . 
	public String depart(int departIdx) throws Exception{
		String sql = "SELECT department_name" + 
				" FROM departments" + 
				" WHERE department_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, departIdx);
		ResultSet rs = pstmt.executeQuery();
		String departmentName = "";
		while(rs.next()){
			 departmentName = rs.getString("department_name");
		}
		rs.close();
		pstmt.close();
		conn.close();
		return departmentName;
	}
	public ArrayList<membersALLdto> littlePro(int memberIdx) throws Exception{
		String sql = " SELECT company_name , name , email,  phone, company_phone , status_message" + 
				" FROM members m INNER JOIN" + 
				" companies c " + 
				" ON m.company_idx = c.company_idx" + 
				" WHERE member_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, memberIdx);
		ResultSet rs = pstmt.executeQuery();
		ArrayList<membersALLdto> list = new ArrayList<membersALLdto>();
		while(rs.next()) {
			String companyName = rs.getString("company_name");
			String name = rs.getString("name");
			String email = rs.getString("email");
			String phone = rs.getString("phone");
			String companyPhone = rs.getString("company_phone");
			String statusMessage = rs.getString("status_message");
			membersALLdto dto = new membersALLdto(companyName, name, email, phone, companyPhone, statusMessage);
			System.out.println(companyName + name + email + phone + companyPhone + statusMessage);
			list.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return list;
	}
	
	// 멤버Idx 가져오기
	public int getMemberIdx(String email) throws Exception {
		String sql = "SELECT  member_idx" + 
				" FROM    members" + 
				" WHERE   email = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, email);
		ResultSet rs = pstmt.executeQuery();
		int ret = 0;
		if(rs.next()) {
			ret = rs.getInt("member_idx");
		}
		rs.close();
		pstmt.close();
		conn.close();
		return ret;
	}
	
	// 회사Idx 가져오기
	public int getCompanyIdx(String email) throws Exception {
		String sql = "SELECT  company_idx" + 
				" FROM    members" + 
				" WHERE   email = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, email);
		ResultSet rs = pstmt.executeQuery();
		int ret = 0;
		if(rs.next()) {
			ret = rs.getInt("company_idx");
		}
		rs.close();
		pstmt.close();
		conn.close();
		return ret;
	}
	// 정성훈 - 사용자 접속 테이블에 INSERT
		public void setLoginRecord(int memberIdx) throws Exception {
			String sql = "INSERT INTO member_login_record(member_idx) VALUES(?)";
			Connection conn = getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, memberIdx);
			pstmt.executeUpdate();
			pstmt.close();
			conn.close();
		}
		public CompanyNameDto CompanyName(int companyIdx) throws Exception {
			String sql = "SELECT " + 
					"    COMPANY_NAME AS \"회사명\"," + 
					"    COMPANY_URL AS \"회사URL\"," +
					"    LOGO_IMG AS \"회사로고\"" +
					" FROM COMPANIES" + 
					" WHERE company_idx = ?";
			Connection conn = getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, companyIdx);
			ResultSet rs = pstmt.executeQuery();
			CompanyNameDto dto = null;
			if(rs.next()) {
				String companyName = rs.getString("회사명");
				String companyUrl = rs.getString("회사URL");
				String logo = rs.getString("회사로고");
				dto = new CompanyNameDto(companyName, companyUrl,logo);
			}
			rs.close();
			pstmt.close();
			conn.close();
			return dto;
		}
	public static void main(String[] args) throws Exception{
		        LoginOrJoinDao dto = new LoginOrJoinDao();
		        System.out.println(dto.clickLogin("lms44561000@gmail.com", "8Q5xh"));
		        
	}

}

