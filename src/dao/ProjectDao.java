package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import dto.ComProjectAdminListDto;
import dto.CompanyProjectDto;
import dto.CompanyPublicProjectDto;
import dto.DeactivProjectDto;
import dto.DelProjectDto;
import dto.DelProjectInfoDto;
import dto.LastActivityProjectDto;
import dto.OpenProjectCategoryDto;
import dto.OpenProjectDto;
import dto.OpenProjectInfoDto;
import dto.PermissionSettingDto;
import dto.ProjectAdminDto;
import dto.ProjectAdminDto2;
import dto.ProjectColorDto;
import dto.ProjectMemberDto;
import dto.ProjectMemberListDto;
import dto.ProjectsDto;

public class ProjectDao {
	public Connection getConnection() throws Exception{
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@//114.207.245.107:1521/XE";
		String id = "FLOW";
		String pw = "1234";
		
		Class.forName(driver);
		Connection conn = DriverManager.getConnection(url, id, pw);
		
		return conn;
	}
	
//	프로젝트 간단정보 가져오기
	public ProjectsDto getProjectSimpleInfo(int projectIdx) throws Exception {
		String sql = "SELECT  DISTINCT p.project_idx," + 
				"        p.project_name AS \"프로젝트명\"," + 
				"        COUNT(DISTINCT pm.participant_idx) OVER(PARTITION BY pm.project_idx) AS \"참여자 수\"," + 
				"        COUNT(DISTINCT b.board_idx) OVER(PARTITION BY b.project_idx) AS \"게시물 수\"," + 
				"        p.last_activity AS \"최근 활동일\"," + 
				"        p.opening_date AS \"개설일\"" + 
				" FROM    projects p" + 
				" FULL OUTER JOIN project_member pm" + 
				" ON      p.project_idx = pm.project_idx" + 
				" FULL OUTER JOIN board b" + 
				" ON      p.project_idx = b.project_idx" + 
				" WHERE   p.project_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, projectIdx);
		ResultSet rs = pstmt.executeQuery();
		ProjectsDto ret = null;
		if(rs.next()) {
			int pIdx = rs.getInt("project_idx");
			String pName = rs.getString("프로젝트명");
			int pmCnt = rs.getInt("참여자 수");
			int boardCnt = rs.getInt("게시물 수");
			String lastActivity = rs.getString("최근 활동일");
			String openingDate = rs.getString("개설일");
			ret = new ProjectsDto(pIdx, pName, pmCnt, boardCnt, lastActivity, openingDate);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return ret;
	}
	
//	프로젝트참가자들 가져오기 
	public ArrayList<ProjectMemberListDto> getProjectMemberList(int projectIdx) throws Exception {
		String sql = "SELECT  m.member_idx," + 
				"        c.company_name AS \"회사명\"," + 
				"        m.name AS \"이름\"," + 
				"        m.profile_img AS \"프로필주소\"," + 
				"        c.company_name AS \"회사명\"," + 
				"        m.position AS \"직책\"," + 
				"        d.department_name AS \"부서명\"" + 
				" FROM    project_member pm" + 
				" INNER JOIN members m" + 
				" ON      pm.participant_idx = m.member_idx" + 
				" INNER JOIN companies c" + 
				" ON      c.company_idx = m.company_idx" + 
				" INNER JOIN departments d" + 
				" ON      d.department_idx = m.department_idx" + 
				" WHERE   pm.project_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, projectIdx);
		ResultSet rs = pstmt.executeQuery();
		ArrayList<ProjectMemberListDto> listRet = new ArrayList<ProjectMemberListDto>();
		while(rs.next()) {
			int memberIdx = rs.getInt("member_idx");
			String companyName = rs.getString("회사명");
			String memberName = rs.getString("이름");
			String position = rs.getString("직책");
			String departmentName = rs.getString("부서명");
			String prof = rs.getString("프로필주소");
			char attendYN = 'O';// 참가여부변수는 무시하면됨
			ProjectMemberListDto dto = new ProjectMemberListDto(memberIdx, companyName, memberName, position, departmentName, prof, attendYN);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	public ArrayList<ProjectMemberListDto> getCompanyAdminMemberList(int companyIdx) throws Exception {
		String sql = "SELECT  m.member_idx," + 
				"        c.company_name AS \"회사명\"," + 
				"        m.name AS \"이름\"," + 
				"        m.profile_img AS \"프로필주소\"," + 
				"        c.company_name AS \"회사명\"," + 
				"        m.position AS \"직책\"," + 
				"        d.department_name AS \"부서명\"" + 
				" FROM    members m" + 
				" INNER JOIN companies c" + 
				" ON      c.company_idx = m.company_idx" + 
				" INNER JOIN departments d" + 
				" ON      d.department_idx = m.department_idx" + 
				" WHERE   c.company_idx = ?"+
				" AND m.ADMIN_YN = 'Y'";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, companyIdx);
		ResultSet rs = pstmt.executeQuery();
		ArrayList<ProjectMemberListDto> listRet = new ArrayList<ProjectMemberListDto>();
		while(rs.next()) {
			int memberIdx = rs.getInt("member_idx");
			String companyName = rs.getString("회사명");
			String memberName = rs.getString("이름");
			String position = rs.getString("직책");
			String departmentName = rs.getString("부서명");
			String prof = rs.getString("프로필주소");
			char attendYN = 'O';// 참가여부변수는 무시하면됨
			ProjectMemberListDto dto = new ProjectMemberListDto(memberIdx, companyName, memberName, position, departmentName, prof, attendYN);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	
//	해당 회사의 프로젝트들의 idx, 색상, 이름들을 가져옴
//	input: member_idx(숫자), project_idx(숫자)
//	output: ArrayList<ProjectColor>
	public ArrayList<ProjectColorDto> getProjectColor(int companyIdx, int memberIdx) throws Exception {
		String sql = "SELECT  p.project_idx," + 
				"		p.project_name AS \"프로젝트명\"," + 
				"		c.color_code AS \"프로젝트색상\"" + 
				" FROM    projects p" + 
				" INNER JOIN project_member pm" + 
				" ON      p.project_idx = pm.project_idx " + 
				" INNER JOIN color c" + 
				" ON      pm.project_color = c.color_idx" + 
				" WHERE   pm.participant_idx = ?" + 
				" AND     p.company_idx = ?" + 
				" ORDER BY project_idx";
		ArrayList<ProjectColorDto> listRet = new ArrayList<ProjectColorDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, memberIdx);
		pstmt.setInt(2, companyIdx);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int projectIdx = rs.getInt("project_idx");
			String projectName = rs.getString("프로젝트명");
			String colorCode = rs.getString("프로젝트색상");
			ProjectColorDto dto = new ProjectColorDto(projectIdx, projectName, colorCode);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	
	
//	[SH-36] - 정상 상태인 프로젝트들의 정보 가져오기(p32)
//	-input : company_idx(숫자)
//	-output : ArrayList<ProjectDto>
	public ArrayList<ProjectsDto> getProjectInfo(int companyIdx) throws Exception{
		String sql = "SELECT  DISTINCT p.project_idx," + 
				"        p.project_name AS \"프로젝트명\"," + 
				"        COUNT(DISTINCT pm.participant_idx) OVER(PARTITION BY pm.project_idx) AS \"참여자 수\"," + 
				"        COUNT(DISTINCT b.board_idx) OVER(PARTITION BY b.project_idx) AS \"게시물 수\"," + 
				"        p.last_activity AS \"최근 활동일\"," + 
				"        p.opening_date AS \"개설일\"" + 
				" FROM    projects p" + 
				" FULL OUTER JOIN project_member pm" + 
				" ON      p.project_idx = pm.project_idx" + 
				" FULL OUTER JOIN board b" + 
				" ON      p.project_idx = b.project_idx" + 
				" WHERE   p.company_idx = ?" + 
				" AND     p.delete_date IS NULL" + 
				" ORDER BY p.project_idx";
		ArrayList<ProjectsDto> listRet = new ArrayList<ProjectsDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, companyIdx);
		
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int pIdx = rs.getInt("project_idx");
			String pName = rs.getString("프로젝트명");
			int pmCnt = rs.getInt("참여자 수");
			int boardCnt = rs.getInt("게시물 수");
			String lastActivity = rs.getString("최근 활동일");
			String openingDate = rs.getString("개설일");
			ProjectsDto dto = new ProjectsDto(pIdx, pName, pmCnt, boardCnt, lastActivity, openingDate);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	
//	[SH-37] - 해당 프로젝트에 관리자들의 정보 가져오기 (p32)
//	-input : company_idx(숫자), projectIdx(숫자)
//	-output : ArrayList<ProjectAdminDto>
	public ArrayList<ProjectAdminDto2> getProjectAdminInfo(int companyIdx, int projectIdx) throws Exception{
		String sql = "SELECT  DISTINCT pm.participant_idx AS \"참가자IDX\"," + 
				"        (CASE WHEN m.company_idx = ? THEN '임직원'" + 
				"        ELSE '외부인' END) AS \"임직원/외부인\"," + 
				"        m.name AS \"이름\"," + 
				"        m.email AS \"이메일\"," + 
				"        m.phone AS \"전화번호\"," + 
				"        d.department_name AS \"부서\"" + 
				" FROM    project_member pm" + 
				" INNER JOIN members m" + 
				" ON      pm.participant_idx = m.member_idx" + 
				" INNER JOIN departments d" + 
				" ON      m.department_idx = d.department_idx" + 
				" INNER JOIN projects p" + 
				" ON      p.project_idx = pm.project_idx" + 
				" WHERE   pm.project_idx = ?" + 
				" AND     pm.admin_yn = 'Y'" + 
				" ORDER BY pm.participant_idx";
		ArrayList<ProjectAdminDto2> listRet = new ArrayList<ProjectAdminDto2>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, companyIdx);
		pstmt.setInt(2, projectIdx);
		
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int participantIdx = rs.getInt("참가자IDX");
			String affiliation = rs.getString("임직원/외부인");
			String name = rs.getString("이름");
			String email = rs.getString("이메일");
			String departmentName = rs.getString("부서");
			String phone = rs.getString("전화번호");
			ProjectAdminDto2 dto = new ProjectAdminDto2(participantIdx, affiliation, name, email, departmentName, phone);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	
	
//	[SH-38] - 프로젝트들의 임직원 수 가져오기 (p32)
//	-input : company_idx(숫자)
//	-output : ArrayList<ProjectEmployeeCntDto>
	public int getEmployeeCnt(int companyIdx, int projectIdx) throws Exception{
		String sql = "SELECT  DISTINCT p.project_idx AS \"프로젝트IDX\"," + 
				"	p.project_name AS \"프로젝트명\"," + 
				"        COUNT(DISTINCT m.member_idx) OVER(PARTITION BY m.company_idx) AS \"임직원 수\"" + 
				" FROM    project_member pm" + 
				" INNER JOIN projects p" + 
				" ON      pm.project_idx = p.project_idx" + 
				" INNER JOIN members m" + 
				" ON      pm.participant_idx = m.member_idx" + 
				" WHERE   m.company_idx = ?" + 
				" AND   p.project_idx = ?" + 
				" ORDER BY p.project_idx";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, companyIdx);
		pstmt.setInt(2, projectIdx);
		ResultSet rs = pstmt.executeQuery();
		int ret = 0;
		if(rs.next()) {
			ret = rs.getInt("임직원 수");
		}
		rs.close();
		pstmt.close();
		conn.close();
		return ret;
	}
	
//	[SH-39] - 해당 프로젝트의 외부인 수 가져오기 (p32)
//	-input : company_idx(숫자)
//	-output : ArrayList<ProjectOutsiderCntDto>
	public int getOutsiderCnt(int companyIdx, int projectIdx) throws Exception{
		String sql = "SELECT  COUNT(pm.participant_idx) AS \"외부인 수\"" + 
				" FROM    project_member pm" + 
				" INNER JOIN members m" + 
				" ON      pm.participant_idx = m.member_idx" + 
				" WHERE   pm.project_idx = ?" + 
				" AND     m.company_idx != ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, projectIdx);
		pstmt.setInt(2, companyIdx);
		ResultSet rs = pstmt.executeQuery();
		int outsiderCnt = 0;
		if(rs.next()) {
			outsiderCnt = rs.getInt("외부인 수");
		}
		rs.close();
		pstmt.close();
		conn.close();
		return outsiderCnt;
	}
	
//	[SH-40] - 해당 프로젝트의 게시물 수 가져오기
//	-input : company_idx(숫자),
//		   project_idx(숫자)
//	-output : 게시물 수(숫자)
	public int getBoardCnt(int companyIdx, int projectIdx) throws Exception{
		String sql = "SELECT  COUNT(b.board_idx) AS \"게시물 수\"" + 
				" FROM    projects p" + 
				" INNER JOIN board b" + 
				" ON      p.project_idx = b.project_idx" + 
				" WHERE   p.company_idx = ?" + 
				" AND     p.project_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, companyIdx);
		pstmt.setInt(2, projectIdx);
		ResultSet rs = pstmt.executeQuery();
		int ret = 0;
		while(rs.next()) {
			ret = rs.getInt("게시물 수");
		}
		rs.close();
		pstmt.close();
		conn.close();
		return ret;
	}
	
//	[SH-40] - 프로젝트들의 댓글 수 가져오기 (p32)
//	-input : company_idx(숫자)
//	-output : ArrayList<ProjectCommentCntDto>
	public int getCommentCnt(int companyIdx, int projectIdx) throws Exception{
		String sql = "SELECT  DISTINCT p.project_idx AS \"프로젝트IDX\"," + 
				"        COUNT(c.comment_idx) AS \"댓글 수\"" + 
				" FROM    projects p" + 
				" FULL OUTER JOIN board b" + 
				" ON      p.project_idx = b.project_idx" + 
				" FULL OUTER JOIN comments c" + 
				" ON      b.board_idx = c.board_idx" + 
				" WHERE   p.company_idx = ?" + 
				" AND   p.project_idx = ?" + 
				" GROUP BY p.project_idx" + 
				" ORDER BY p.project_idx";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, companyIdx);
		pstmt.setInt(2, projectIdx);
		ResultSet rs = pstmt.executeQuery();
		int commentCnt = 0;
		if(rs.next()) {
			commentCnt = rs.getInt("댓글 수");
		}
		rs.close();
		pstmt.close();
		conn.close();
		return commentCnt;
	}
	
//	[SH-41] - 프로젝트들의 채팅 수 가져오기 (p32)
//	-input : company_idx(숫자)
//	-output : ArrayList<ProjectChatCntDto>
	public int getChatCnt(int companyIdx, int projectIdx) throws Exception{
		String sql = "SELECT  DISTINCT p.project_idx AS \"프로젝트IDX\"," + 
				"        COUNT(cc.chat_idx) AS \"채팅 수\"" + 
				" FROM    projects p" + 
				" FULL OUTER JOIN chat_room cr" + 
				" ON      p.project_idx = cr.project_idx" + 
				" FULL OUTER JOIN chat_conversation cc" + 
				" ON      cr.chat_room_idx = cc.chat_room_idx" + 
				" WHERE   p.company_idx = ?" + 
				" AND   p.project_idx = ?" + 
				" GROUP BY p.project_idx" + 
				" ORDER BY p.project_idx";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, companyIdx);
		pstmt.setInt(2, projectIdx);
		ResultSet rs = pstmt.executeQuery();
		int chatCnt = 0;
		if(rs.next()) {
			chatCnt = rs.getInt("채팅 수");
		}
		rs.close();
		pstmt.close();
		conn.close();
		return chatCnt;
	}
	
//	[SH-42] - 프로젝트들의 일정 수 가져오기 (p32)
//	-input : company_idx(숫자)
//	-output : ArrayList<ProjectScheduleCntDto>
	public int getScheduleCnt(int companyIdx, int projectIdx) throws Exception{
		String sql = "SELECT  COUNT(b.category) AS \"일정 수\"" + 
				" FROM    projects p" + 
				" FULL OUTER JOIN board b" + 
				" ON      p.project_idx = b.project_idx" + 
				" WHERE   b.category = '일정'" + 
				" AND     p.company_idx = ?" + 
				" AND     p.project_idx = ? " + 
				" ORDER BY p.project_idx";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, companyIdx);
		pstmt.setInt(2, projectIdx);
		ResultSet rs = pstmt.executeQuery();
		int ret = 0;
		if(rs.next()) {
			ret = rs.getInt("일정 수");
		}
		rs.close();
		pstmt.close();
		conn.close();
		return ret;
	}
	
//	[SH-43] - 프로젝트의 업무 수 가져오기 (p32)
//	-input : company_idx(숫자)
//	-output : ArrayList<ProjectTaskCntDto>
	public int getTaskCnt(int companyIdx, int projectIdx) throws Exception{
		String sql = "SELECT  COUNT(b.category) AS \"업무 수\"" + 
				" FROM    projects p " + 
				" FULL OUTER JOIN board b" + 
				" ON      p.project_idx = b.project_idx" + 
				" WHERE   b.category = '업무'" + 
				" AND     p.company_idx = ?" + 
				" AND     p.project_idx = ?" + 
				" ORDER BY p.project_idx";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, companyIdx);
		pstmt.setInt(2, projectIdx);
		ResultSet rs = pstmt.executeQuery();
		int taskCnt = 0;
		if(rs.next()) {
			taskCnt = rs.getInt("업무 수");
		}
		rs.close();
		pstmt.close();
		conn.close();
		return taskCnt;
	}
	
//	[SH-44] - 정상상태인 프로젝트명 검색하기 (p32-1)
//	-input : company_idx(숫자), 검색할 프로젝트명(문자열)
//	-output : ArrayList<ProjectDto>
	public ArrayList<ProjectsDto> getProjectInfosearch(int companyIdx, String str) throws Exception{
		String sql = "SELECT  DISTINCT p.project_idx," + 
				"		p.project_name AS \"프로젝트명\"," + 
				"		COUNT(DISTINCT pm.participant_idx) OVER(PARTITION BY pm.project_idx) AS \"참여자 수\"," + 
				"		COUNT(DISTINCT b.board_idx) OVER(PARTITION BY b.project_idx) AS \"게시물 수\", " + 
				"		p.last_activity AS \"최근 활동일\"," + 
				"		p.opening_date AS \"개설일\"" + 
				" FROM    projects p" + 
				" FULL OUTER JOIN project_member pm" + 
				" ON      p.project_idx = pm.project_idx" + 
				" FULL OUTER JOIN board b" + 
				" ON      p.project_idx = b.project_idx" + 
				" WHERE   p.company_idx = ?" + 
				" AND     p.delete_date IS NULL" + 
				" AND     p.project_name LIKE ?" + 
				" ORDER BY p.project_idx";
		ArrayList<ProjectsDto> listRet = new ArrayList<ProjectsDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, companyIdx);
		pstmt.setString(2, "%"+str+"%");
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int pIdx = rs.getInt("project_idx");
			String pName = rs.getString("프로젝트명");
			int pmCnt = rs.getInt("참여자 수");
			int boardCnt = rs.getInt("게시물 수");
			String lastActivity = rs.getString("최근 활동일");
			String openingDate = rs.getString("개설일");
			ProjectsDto dto = new ProjectsDto(pIdx, pName, pmCnt, boardCnt, lastActivity, openingDate);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	
//	[SH-45] - 해당 프로젝트의 권한정보 가져오기 (p32-2)
//	-input : project_idx(숫자)
//	-output : ArrayList<PermissionSettingDto>
	public PermissionSettingDto getPermissionSetting(int projectIdx) throws Exception{
		String sql = "SELECT  project_idx," + 
				"        project_name," + 
				"        writing_grant," + 
				"        comment_grant," + 
				"        post_view_grant," + 
				"        edit_post_grant" + 
				" FROM    projects" + 
				" WHERE   project_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, projectIdx);
		ResultSet rs = pstmt.executeQuery();
		PermissionSettingDto ret = null;
		if(rs.next()) {
			int pIdx = rs.getInt("project_idx");
			String pName = rs.getString("project_name");
			int editPostGrant = rs.getInt("edit_post_grant");
			int writingGrant = rs.getInt("writing_grant");
			int postViewGrant = rs.getInt("post_view_grant");
			int commentGrant = rs.getInt("comment_grant");
			ret = new PermissionSettingDto(pIdx, pName, editPostGrant, writingGrant, postViewGrant, commentGrant, 0, 0);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return ret;
	}
	
//	[SH-46] - 프로젝트 관리자 선택창 띄우기 (p33-1)
//	-input : project_idx(숫자)
//	-output : ArrayList<ProjectMemberDto>
	public ArrayList<ProjectMemberDto> getProjectMemberInfo(int projectIdx) throws Exception{
		String sql = "SELECT  m.member_idx AS \"회원IDX\"," + 
				"        m.name AS \"이름\"," + 
				"        m.email AS \"이메일\"," + 
				"        pm.admin_yn AS \"관리자\"" + 
				" FROM    members m" + 
				" INNER JOIN project_member pm" + 
				" ON      m.member_idx = pm.participant_idx" + 
				" WHERE   pm.project_idx = ?" + 
				" ORDER BY m.member_idx";
		ArrayList<ProjectMemberDto> listRet = new ArrayList<ProjectMemberDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, projectIdx);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int pIdx = rs.getInt("회원IDX");
			String name = rs.getString("이름");
			String email = rs.getString("이메일");
			char adminYN = rs.getString("관리자").charAt(0);
			ProjectMemberDto dto = new ProjectMemberDto(pIdx, name, email, adminYN);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	
//	[SH-47] - 선택할 프로젝트 관리자 검색하기 (p33-2)
//	-input : proejct_idx(숫자), 검색기준(문자열)[이름,이메일], 검색할 이름(문자열)
//	-output : ArrayList<ProjectMemberDto>
	public ArrayList<ProjectMemberDto> getProjectMemberInfoSearch(int projectIdx, String standard, String str) throws Exception{
		String m = null;
		if(standard.equals("이름")) {
			m = "m.name";
		}else if(standard.equals("이메일")){
			m = "m.email";
		}
		String sql = "SELECT  m.member_idx AS \"회원IDX\"," + 
				"        m.name AS \"이름\"," + 
				"        m.email AS \"이메일\"," + 
				"        pm.admin_yn AS \"관리자\"" + 
				" FROM    members m" + 
				" INNER JOIN project_member pm" + 
				" ON      m.member_idx = pm.participant_idx" + 
				" WHERE   pm.project_idx = ?" + 
				" AND     "+ m +" LIKE ?" + 
				" ORDER BY m.member_idx";
		ArrayList<ProjectMemberDto> listRet = new ArrayList<ProjectMemberDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, projectIdx);
		pstmt.setString(2, "%"+str+"%");
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int pIdx = rs.getInt("회원IDX");
			String name = rs.getString("이름");
			String email = rs.getString("이메일");
			char adminYN = rs.getString("관리자").charAt(0);
			ProjectMemberDto dto = new ProjectMemberDto(pIdx, name, email, adminYN);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	
//	[SH-48] - 프로젝트 관리자 권한 변경하기 (p32-5)
//	-input : member_idx(숫자), project_idx(숫자)
	public void setAdminYN(int projectIdx, int memberIdx) throws Exception{
		String sql = "UPDATE  project_member" + 
				" SET admin_yn = CASE " + 
				"        WHEN admin_yn = 'N' THEN 'Y'" + 
				"        WHEN admin_yn = 'Y' THEN 'N' END" + 
				" WHERE   participant_idx = ?" + 
				" AND     project_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, memberIdx);
		pstmt.setInt(2, projectIdx);
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
	}
	
//	해당 프로젝트의 관리자 수 뽑아오기
//	-input: project_idx(숫자)
//	-ouput: count(숫자)
	public int getProjectAdminCount(int projectIdx) throws Exception{
		String sql = "SELECT  COUNT(participant_idx) AS \"관리자 수\"" + 
				" FROM    project_member" + 
				" WHERE   project_idx = ?" +
				" AND   admin_yn = 'Y'";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, projectIdx);
		ResultSet rs = pstmt.executeQuery();
		int ret = 0;
		if(rs.next()) {
			ret = rs.getInt("관리자 수");
		}
		rs.close();
		pstmt.close();
		conn.close();
		return ret;
	}
	
//	[SH-49] - 프로젝트 삭제하기 (p32-7)
//	-input : project_idx(숫자),
//		   member_idx(숫자)
	public void setProjectDel(int projectIdx, int memberIdx) throws Exception{
		String sql = "UPDATE projects " + 
				" SET 	delete_date = SYSDATE, " + 
				"	delete_member_idx = ?" + 
				" WHERE project_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, memberIdx);
		pstmt.setInt(2, projectIdx);
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
	}
	
//	[SH-50] - 프로젝트 정보 변경하기 (p32-8)
//	-input : project_idx(숫자),
//		   변경할 프로젝트명(문자열),
//		   edit_post_grant(숫자),
//		   writing_grant(숫자),
//		   post_view_grant(숫자),
//		   comment_grant(숫자),
//		   file_view_grant(숫자),
//		   file_down_grant(숫자),
	public void setProjectInfo(int projectIdx, String pName, int writingGrant, int commentGrant, int postViewGrant, int editPostGrant) throws Exception{
		String sql = "UPDATE projects " + 
				" SET     project_name = ?," + 
				"        writing_grant = ?," + 
				"        comment_grant = ?," + 
				"        post_view_grant = ?," + 
				"        edit_post_grant = ?" + 
				" WHERE   project_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, pName);
		pstmt.setInt(2, writingGrant);
		pstmt.setInt(3, commentGrant);
		pstmt.setInt(4, postViewGrant);
		pstmt.setInt(5, editPostGrant);
		pstmt.setInt(6, projectIdx);
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
	}
//	우선 모든 프로젝트 참가자의 어드민여부를 'N'으로바꿈
	public void resetProjectAdmin(int projectIdx) throws Exception{
		String sql = "UPDATE  project_member" + 
				" SET     admin_yn = 'N'" + 
				" WHERE   project_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, projectIdx);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
//	그리고 관리자로 추가할 멤버들을 'Y'로 바꿈
//	-input : project_idx(숫자),
//	   	관리자  member_idx(숫자 배열),
	public void setProjectAdmin(int projectIdx, int[] memberIdx) throws Exception{
		Connection conn = getConnection();
		for(int i=0; i<=memberIdx.length-1; i++) {
			String sql = "UPDATE  project_member" + 
					" SET     admin_yn = 'Y'" + 
					" WHERE   participant_idx = ?" + 
					" AND     project_idx = ?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, memberIdx[i]);
			pstmt.setInt(2, projectIdx);
			pstmt.executeUpdate();
			pstmt.close();
		}
		conn.close();
	}
	
//	[SH-51] - 프로젝트 관리 삭제 목록 보기 (p35)
//	-input : company_idx(숫자)
//	-output: ArrayList<DelProjectDto>
	public ArrayList<DelProjectDto> getDelProjects(int companyIdx) throws Exception{
		String sql = "SELECT  p.project_idx," + 
				"        p.project_name AS \"프로젝트명\"," + 
				"        (SELECT COUNT(*)" + 
				"         FROM project_member pm " + 
				"         WHERE pm.project_idx = p.project_idx) AS \"전체 참여자 수\"," + 
				"        p.last_activity AS \"최근 활동일\"," + 
				"        p.opening_date AS \"개설일\"," + 
				"        p.delete_date AS \"삭제일\"," + 
				"        p.delete_member_idx AS \"삭제한 직원\"" + 
				" FROM    projects p" + 
				" WHERE   p.company_idx = ?" + 
				" AND     p.delete_date IS NOT NULL" + 
				" AND     p.delete_member_idx IS NOT NULL" + 
				" ORDER BY p.project_idx";
		ArrayList<DelProjectDto> listRet = new ArrayList<DelProjectDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, companyIdx);
		
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int projectIdx = rs.getInt("project_idx");
			String pName = rs.getString("프로젝트명");
			int participantCnt = rs.getInt("전체 참여자 수");
			String lastActivity = rs.getString("최근 활동일");
			String openingDate = rs.getString("개설일");
			String deleteDate = rs.getString("삭제일");
			int delMemberIdx = rs.getInt("삭제한 직원");
			DelProjectDto dto = new DelProjectDto(projectIdx, pName, participantCnt, lastActivity, openingDate, deleteDate, delMemberIdx);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	
//	[SH-52] - 삭제상태 프로젝트명 검색하기 (p35)
//	-input : company_idx(숫자)
//		   검색할 프로젝트명(문자열)
//	-output : ArrayList<DelProjectDto>
	public ArrayList<DelProjectDto> getDelProjectSearch(int companyIdx, String str) throws Exception{
		String sql = "SELECT  DISTINCT p.project_idx," + 
				"        project_name AS \"프로젝트명\"," + 
				"        COUNT(pm.participant_idx) OVER(PARTITION BY pm.project_idx) AS \"전체 참여자 수\"," + 
				"        last_activity AS \"최근 활동일\"," + 
				"        opening_date AS \"개설일\"," + 
				"        delete_date AS \"삭제일\"," + 
				"        delete_member_idx AS \"삭제한 직원\"" + 
				" FROM    projects p" + 
				" INNER JOIN project_member pm" + 
				" ON      p.project_idx = pm.project_idx" + 
				" WHERE   p.company_idx = ?" + 
				" AND     p.project_name LIKE ?" + 
				" AND     delete_date IS NOT NULL" + 
				" AND     delete_member_idx IS NOT NULL" + 
				" ORDER BY p.project_idx";
		ArrayList<DelProjectDto> listRet = new ArrayList<DelProjectDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, companyIdx);
		pstmt.setString(2, "%"+str+"%");
		
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int projectIdx = rs.getInt("project_idx");
			String pName = rs.getString("프로젝트명");
			int participantCnt = rs.getInt("전체 참여자 수");
			String lastActivity = rs.getString("최근 활동일");
			String openingDate = rs.getString("개설일");
			String deleteDate = rs.getString("삭제일");
			int delMemberIdx = rs.getInt("삭제한 직원");
			DelProjectDto dto = new DelProjectDto(projectIdx, pName, participantCnt, lastActivity, openingDate, deleteDate, delMemberIdx);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	
//	삭제상태 프로젝트정보 보기
//	input: project_idx(숫자)
//	output: ArrayList<DelProjectInfo>
	public ArrayList<DelProjectInfoDto> getDelProjectInfo(int projectIdx) throws Exception{
		String sql = "SELECT  m.name AS \"이름\"," + 
				"        m.email AS \"이메일\"," + 
				"        d.department_name AS \"부서명\"," + 
				"        m.phone AS \"전화번호\"," + 
				"        pm.admin_yn AS \"관리자 여부\"" + 
				" FROM    project_member pm" + 
				" INNER JOIN members m" + 
				" ON      pm.participant_idx = m.member_idx" + 
				" INNER JOIN departments d" + 
				" ON      m.department_idx = d.department_idx" + 
				" WHERE   pm.project_idx = ?" + 
				" ORDER BY m.member_idx";
		ArrayList<DelProjectInfoDto> listRet = new ArrayList<DelProjectInfoDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, projectIdx);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			String name = rs.getString("이름");
			String email = rs.getString("이메일");
			String departmentName = rs.getString("부서명");
			String phone = rs.getString("전화번호");
			char adminYN = rs.getString("관리자 여부").charAt(0);
			DelProjectInfoDto dto = new DelProjectInfoDto(name, email, departmentName, phone, adminYN);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	
//	[SH-53] - 선택한 프로젝트 완전 삭제하기 (p35-1)
//	-input : project_idx(숫자)
	public void absoluteDeleteProject(int projectIdx) throws Exception{
		String sql = "DELETE projects WHERE project_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, projectIdx);
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
	}
	
//	[SH-54] - 프로젝트 복구 하기 (p35-2)
//	-input : project_idx(숫자)
	public void setProjectRestore(int projectIdx) throws Exception{
		String sql = "UPDATE projects " + 
				" SET 	delete_date = NULL, " + 
				"	delete_member_idx = NULL " + 
				" WHERE project_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, projectIdx);
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
	}
	
//	[SH-55] - 회사 프로젝트 관리 목록 보기 (p36)
//	-input : company_idx(숫자)
//	-output : ArrayList<CompanyProjectDto>
	public ArrayList<CompanyProjectDto> getCompanyProjects(int companyIdx) throws Exception{
		String sql = "SELECT  DISTINCT p.project_idx," + 
				"		p.last_activity AS \"최근 활동일\"," + 
				"		p.opening_date AS \"개설일\"," + 
				"		p.project_name AS \"프로젝트명\"," + 
				"		COUNT(b.board_idx) OVER(PARTITION BY b.project_idx) AS \"게시물 수\", " + 
				"		COUNT(c.comment_idx) OVER(PARTITION BY b.project_idx) AS \"댓글 수\", " + 
				"		m.name||'('||m.email||')' AS \"작성자\"" + 
				" FROM    projects p" + 
				" FULL OUTER JOIN board b" + 
				" ON      p.project_idx = b.project_idx" + 
				" FULL OUTER JOIN comments c" + 
				" ON      b.board_idx = c.board_idx" + 
				" FULL OUTER JOIN members m" + 
				" ON      p.writer_idx = m.member_idx" + 
				" WHERE   p.company_project_yn = 'Y'" + 
				" AND     p.company_idx = ?" + 
				" AND     p.delete_date IS NULL" + 
				" AND     p.delete_member_idx IS NULL";
		ArrayList<CompanyProjectDto> listRet = new ArrayList<CompanyProjectDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, companyIdx);
		
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int projectIdx = rs.getInt("project_idx");
			String pName = rs.getString("프로젝트명");
			int boardCnt = rs.getInt("게시물 수");
			int commentCnt = rs.getInt("댓글 수");
			String lastActivity = rs.getString("최근 활동일");
			String openingDate = rs.getString("개설일");
			String writer = rs.getString("작성자");
			CompanyProjectDto dto = new CompanyProjectDto(projectIdx, pName, boardCnt, commentCnt, lastActivity, openingDate, writer);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	
//	[SH-56] - 회사 프로젝트 검색하기 (p36-1)
//	-input : 검색할 프로젝트명(문자열)
//		   company_idx(숫자)
//	-output : ArrayList<CompanyProjectDto>
	public ArrayList<CompanyProjectDto> getCompanyProjectSearch(int companyIdx, String str) throws Exception{
		String sql = "SELECT  DISTINCT p.project_idx," + 
				"        p.last_activity AS \"최근 활동일\"," + 
				"        p.opening_date AS \"개설일\"," + 
				"        p.project_name AS \"프로젝트명\"," + 
				"        COUNT(b.board_idx) OVER(PARTITION BY b.project_idx) AS \"게시물 수\"," + 
				"        COUNT(c.comment_idx) OVER(PARTITION BY b.project_idx) AS \"댓글 수\"," + 
				"        m.name||'('||m.email||')' AS \"작성자\"" + 
				" FROM    projects p" + 
				" FULL OUTER JOIN board b" + 
				" ON      p.project_idx = b.project_idx" + 
				" FULL OUTER JOIN comments c" + 
				" ON      b.board_idx = c.board_idx" + 
				" FULL OUTER JOIN members m" + 
				" ON      m.member_idx = p.writer_idx" + 
				" WHERE   p.company_project_yn = 'Y'" + 
				" AND     p.company_idx = ?" + 
				" AND    p.project_name LIKE ?";
		ArrayList<CompanyProjectDto> listRet = new ArrayList<CompanyProjectDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, companyIdx);
		pstmt.setString(2, "%"+str+"%");
		
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int projectIdx = rs.getInt("project_idx");
			String pName = rs.getString("프로젝트명");
			int boardCnt = rs.getInt("게시물 수");
			int commentCnt = rs.getInt("댓글 수");
			String lastActivity = rs.getString("최근 활동일");
			String openingDate = rs.getString("개설일");
			String writer = rs.getString("작성자");
			CompanyProjectDto dto = new CompanyProjectDto(projectIdx, pName, boardCnt, commentCnt, lastActivity, openingDate, writer);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
//	회사프로젝트의 관리자들 정보가져오기
//	input: projectIdx(숫자)
//	output: ArrayList<ComProjectAdminListDto>
	public ArrayList<ComProjectAdminListDto> getComProjectAdminList(int projectIdx) throws Exception{
		String sql = "SELECT m.member_idx, " +
				"		 m.name AS \"이름\"," + 
				"        m.email AS \"이메일\"," + 
				"        m.phone AS \"휴대폰번호\"," + 
				"        d.department_name AS \"부서명\"" + 
				" FROM    members m" + 
				" INNER JOIN departments d" + 
				" ON      m.department_idx = d.department_idx" + 
				" INNER JOIN project_member pm" + 
				" ON      pm.participant_idx = m.member_idx" + 
				" WHERE   pm.project_idx = ?" + 
				" AND     pm.admin_yn = 'Y'";
		ArrayList<ComProjectAdminListDto> listRet = new ArrayList<ComProjectAdminListDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, projectIdx);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int memberIdx = rs.getInt("member_idx");
			String name = rs.getString("이름");
			String email = rs.getString("이메일");
			String departmentName = rs.getString("부서명");
			String phone = rs.getString("휴대폰번호");
			ComProjectAdminListDto dto = new ComProjectAdminListDto(memberIdx, name, email, departmentName, phone);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	
//	회사프로젝트 관리자추가창열기
//	input: projectIdx(숫자)
//	out: ArrayList<ComProjectAdminListDto>
	public ArrayList<ComProjectAdminListDto> getComProjectMemberList(int projectIdx) throws Exception{
		String sql = "SELECT  m.member_idx," +
				"		 m.name AS \"이름\"," + 
				"        m.email AS \"이메일\"," + 
				"        m.phone AS \"휴대폰번호\"," + 
				"        d.department_name AS \"부서명\"" + 
				" FROM    members m" + 
				" INNER JOIN departments d" + 
				" ON      m.department_idx = d.department_idx" + 
				" INNER JOIN project_member pm" + 
				" ON      pm.participant_idx = m.member_idx" + 
				" WHERE   pm.project_idx = ?" + 
				" AND     pm.admin_yn = 'N'";
		ArrayList<ComProjectAdminListDto> listRet = new ArrayList<ComProjectAdminListDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, projectIdx);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int memberIdx = rs.getInt("member_idx");
			String name = rs.getString("이름");
			String email = rs.getString("이메일");
			String departmentName = rs.getString("부서명");
			String phone = rs.getString("휴대폰번호");
			ComProjectAdminListDto dto = new ComProjectAdminListDto(memberIdx, name, email, departmentName, phone);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	
//	공개프로젝트 관리자선택창에서 검색하기
//	input: project_idx(숫자), 검색기준(문자열), 검색어(문자열)
//	output: ArrayList<ComProjectAdminListDto>
	public ArrayList<ComProjectAdminListDto> getNotAdminProjectMember(int projectIdx, String standard, String str) throws Exception{
		String m = "";
		if(standard.equals("이름")) {
			m = "m.name";
		}else if(standard.equals("이메일")) {
			m = "m.email";
		}
		String sql = "SELECT  m.member_idx," +
				"		 m.name AS \"이름\"," + 
				"        m.email AS \"이메일\"," + 
				"        m.phone AS \"휴대폰번호\"," + 
				"        d.department_name AS \"부서명\"" + 
				" FROM    members m" + 
				" INNER JOIN departments d" + 
				" ON      m.department_idx = d.department_idx" + 
				" INNER JOIN project_member pm" + 
				" ON      pm.participant_idx = m.member_idx" + 
				" WHERE   pm.project_idx = ?" + 
				" AND     pm.admin_yn = 'N'" +
				" AND     "+m+" LIKE ?";
		ArrayList<ComProjectAdminListDto> listRet = new ArrayList<ComProjectAdminListDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, projectIdx);
		pstmt.setString(2, "%"+str+"%");
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int memberIdx = rs.getInt("member_idx");
			String name = rs.getString("이름");
			String email = rs.getString("이메일");
			String departmentName = rs.getString("부서명");
			String phone = rs.getString("휴대폰번호");
			ComProjectAdminListDto dto = new ComProjectAdminListDto(memberIdx, name, email, departmentName, phone);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	
	
//	[SH-57] - 회사 프로젝트 추가(생성)하기 (p36-2)
//	-input : 추가할 프로젝트명(문자열), 글 작성 권한(숫자)[ 0 , 1], 댓글 작성 권한(숫자)[0, 1],
//		   글 조회 권한(숫자)[0, 1], 파일조회 권한(숫자)[0, 1], 파일 다운로드 권한(숫자)[0, 1], 글 수정 권한(숫자)[0, 1, 2],
//		   member_idx(숫자),
//		   company_idx(숫자)
	public int addCompanyProject(int companyIdx, int writerIdx, String str, int writingGrant, int commentGrant, int postViewGrant,  int editPostGrant) throws Exception{
		String sql = "INSERT INTO" + 
				" projects(company_project_yn, project_idx, company_idx, writer_idx, project_name, writing_grant, comment_grant, post_view_grant, edit_post_grant)" + 
				" VALUES('Y', SEQ_PROJECTS.nextval, ?, ?, ?, ?, ?, ?,?)";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, companyIdx);
		pstmt.setInt(2, writerIdx);
		pstmt.setString(3, str);
		pstmt.setInt(4, writingGrant);
		pstmt.setInt(5, commentGrant);
		pstmt.setInt(6, postViewGrant);
		pstmt.setInt(7, editPostGrant);
		pstmt.executeUpdate();
		
		String sql2 = "SELECT  MAX(project_idx) AS \"최근 프로젝트IDX\"" + 
				" FROM    projects\r\n" + 
				" WHERE   company_idx = ?";
		PreparedStatement pstmt2 = conn.prepareStatement(sql2);
		pstmt2.setInt(1, companyIdx);
		ResultSet rs = pstmt2.executeQuery();
		int projectIdx = -1;
		if(rs.next()) {
			projectIdx = rs.getInt("최근 프로젝트IDX");
		}
		
		pstmt.close();
		conn.close();
		return projectIdx;
	}
	// 회사 프로젝트 생성과 동시에 해당 회사에 속한 멤버들이 프로젝트에 참가됨
	public void addCompanyProjectMembers(int companyIdx, int projectIdx) throws Exception{
		String sql = "SELECT member_idx FROM members WHERE company_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, companyIdx);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int memberIdx = rs.getInt("member_idx");
			String sql2 = "INSERT INTO project_member(project_idx, participant_idx, project_color, Entry_date)" + 
					" VALUES (?, ?, 1, SYSDATE)";
			System.out.println("memberIdx"+memberIdx);
			PreparedStatement pstmt2 = conn.prepareStatement(sql2);
			pstmt2.setInt(1, projectIdx);
			pstmt2.setInt(2, memberIdx);
			pstmt2.executeUpdate();
			pstmt2.close();
		}
		rs.close();
		pstmt.close();
		conn.close();
	}
	// 만든이를 회사프로젝트에 관리자로 설정
	public void setCompanyProjectAdmin(int projectIdx, int memberIdx) throws Exception{
		String sql = "UPDATE  project_member" + 
				" SET     admin_yn = 'Y'" + 
				" WHERE   participant_idx = ?" + 
				" AND     project_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, memberIdx);
		pstmt.setInt(2, projectIdx);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	
//	[SH-58] - 일반 프로젝트로 변경하기 (p37-6)
//	-input : project_idx(숫자)
	public void setCompanyProjectChange(int projectIdx) throws Exception{
		String sql = "UPDATE  projects" + 
				" SET     company_project_yn = 'N'" + 
				" WHERE   project_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, projectIdx);
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
	}
	
//	[SH-59] - 공개 프로젝트 관리 탭열기 (p38)
//	-input : company_idx(숫자)
//	-output : ArrayList<OpenProejctDto>
	public ArrayList<OpenProjectDto> getOpenProjects(int companyIdx) throws Exception{
		String sql = "SELECT  DISTINCT p.project_idx," + 
				"		pc.category_name AS \"카테고리명\"," + 
				"		p.project_name AS \"프로젝트명\"," + 
				"		COUNT(pm.participant_idx) OVER(PARTITION BY p.project_idx) AS \"참여자 수\"," + 
				"		p.last_activity AS \"최근 활동일\", " + 
				"		p.opening_date AS \"개설일\"" + 
				" FROM    projects p " + 
				" FULL OUTER JOIN project_category pc" + 
				" ON      p.category_idx = pc.category_idx" + 
				" FULL OUTER JOIN project_member pm" + 
				" ON      p.project_idx = pm.project_idx" + 
				" WHERE   p.company_idx = ?" + 
				" AND     p.category_idx IS NOT NULL" + 
				" AND     p.delete_date IS NULL" + 
				" AND     p.delete_member_idx IS NULL";
		ArrayList<OpenProjectDto> listRet = new ArrayList<OpenProjectDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, companyIdx);
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next()) {
			int projectIdx = rs.getInt("project_idx");
			String pName = rs.getString("프로젝트명");
			String categoryName = rs.getString("카테고리명");
			int memberCnt = rs.getInt("참여자 수");
			String lastActivity = rs.getString("최근 활동일");
			String opDate = rs.getString("개설일");
			
			String sql2 = "SELECT  p.project_idx," + 
					"        NVL(b.board_count, 0) AS \"게시물 수\"," + 
					"        NVL(c.comment_count, 0) AS \"댓글 수\"" + 
					" FROM    (SELECT ? AS project_idx FROM dual) p" + 
					" LEFT JOIN (" + 
					"    SELECT project_idx, COUNT(board_idx) AS board_count" + 
					"    FROM board" + 
					"    WHERE project_idx = ?" + 
					"    GROUP BY project_idx) b " + 
					" ON p.project_idx = b.project_idx" + 
					" LEFT JOIN (" + 
					"    SELECT b.project_idx, COUNT(c.comment_idx) AS comment_count" + 
					"    FROM board b" + 
					"    LEFT JOIN comments c ON b.board_idx = c.board_idx" + 
					"    WHERE b.project_idx = ?" + 
					"    GROUP BY b.project_idx) c " + 
					" ON p.project_idx = c.project_idx";
			PreparedStatement pstmt2 = conn.prepareStatement(sql2);
			pstmt2.setInt(1, projectIdx);
			pstmt2.setInt(2, projectIdx);
			pstmt2.setInt(3, projectIdx);
			
			ResultSet rs2 = pstmt2.executeQuery();
			
			if(rs2.next()) {
				int boardCnt = rs2.getInt("게시물 수");
				int commentCnt = rs2.getInt("댓글 수");
				OpenProjectDto dto = new OpenProjectDto(projectIdx, pName, categoryName, memberCnt, boardCnt, commentCnt, lastActivity, opDate);
				listRet.add(dto);
			}
			rs2.close();
			pstmt2.close();
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	
//	[SH-60] - 공개 프로젝트 검색하기 (p38-1)
//	-input : company_idx(숫자),
//		   검색할 프로젝트명(문자열)
//	-output : ArrayList<OpProject>
	public ArrayList<OpenProjectDto> getOpenProjectsSearch(int companyIdx, String str) throws Exception{
		String sql = "SELECT  DISTINCT p.project_idx," + 
				"		pc.category_name AS \"카테고리명\"," + 
				"		p.project_name AS \"프로젝트명\"," + 
				"		COUNT(pm.participant_idx) OVER(PARTITION BY pm.project_idx) AS \"참여자 수\", " + 
				"		p.last_activity AS \"최근 활동일\"," + 
				"		p.opening_date AS \"개설일\"" + 
				" FROM    projects p" + 
				" FULL OUTER JOIN project_category pc" + 
				" ON      p.category_idx = pc.category_idx" + 
				" FULL OUTER JOIN project_member pm" + 
				" ON      p.project_idx = pm.project_idx" + 
				" WHERE   p.company_idx = ?" + 
				" AND     p.category_idx IS NOT NULL" + 
				" AND     p.project_name LIKE ?" + 
				" ORDER BY project_idx";
		ArrayList<OpenProjectDto> listRet = new ArrayList<OpenProjectDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, companyIdx);
		pstmt.setString(2, "%"+str+"%");
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int projectIdx = rs.getInt("project_idx");
			String pName = rs.getString("프로젝트명");
			String categoryName = rs.getString("카테고리명");
			int memberCnt = rs.getInt("참여자 수");
			String lastActivity = rs.getString("최근 활동일");
			String opDate = rs.getString("개설일");
			
			String sql2 = "SELECT  p.project_idx," + 
					"        NVL(b.board_count, 0) AS \"게시물 수\"," + 
					"        NVL(c.comment_count, 0) AS \"댓글 수\"" + 
					" FROM    (SELECT ? AS project_idx FROM dual) p" + 
					" LEFT JOIN (" + 
					"    SELECT project_idx, COUNT(board_idx) AS board_count" + 
					"    FROM board" + 
					"    WHERE project_idx = ?" + 
					"    GROUP BY project_idx) b " + 
					" ON p.project_idx = b.project_idx" + 
					" LEFT JOIN (" + 
					"    SELECT b.project_idx, COUNT(c.comment_idx) AS comment_count" + 
					"    FROM board b" + 
					"    LEFT JOIN comments c ON b.board_idx = c.board_idx" + 
					"    WHERE b.project_idx = ?" + 
					"    GROUP BY b.project_idx) c " + 
					" ON p.project_idx = c.project_idx";
			PreparedStatement pstmt2 = conn.prepareStatement(sql2);
			pstmt2.setInt(1, projectIdx);
			pstmt2.setInt(2, projectIdx);
			pstmt2.setInt(3, projectIdx);
			
			ResultSet rs2 = pstmt2.executeQuery();
			if(rs2.next()) {
				int boardCnt = rs2.getInt("게시물 수");
				int commentCnt = rs2.getInt("댓글 수");
				OpenProjectDto dto = new OpenProjectDto(projectIdx, pName, categoryName, memberCnt, boardCnt, commentCnt, lastActivity, opDate);
				listRet.add(dto);
			}
			rs2.close();
			pstmt2.close();
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	
//	[SH-61] - 공개 프로젝트 정보 수정 창띄우기 (p38-2)
//	-input : project_idx(숫자)
//	-output : ArrayList<OpenProjectInfoDto>
	public OpenProjectInfoDto getOpenProjectInfo(int projectIdx) throws Exception{
		String sql = "SELECT  pc.category_name AS \"카테고리명\"," + 
				"        pc.category_idx AS \"카테고리IDX\"," + 
				"        p.project_name AS \"프로젝트명\"," + 
				"        p.writing_grant AS \"글 작성 권한\"," + 
				"        p.comment_grant AS \"댓글 작성 권한\"," + 
				"        p.post_view_grant AS \"글 조회 권한\"," + 
				"        p.edit_post_grant AS \"글 수정 권한\"" + 
				" FROM    projects p" + 
				" INNER JOIN project_category pc" + 
				" ON      p.category_idx = pc.category_idx" + 
				" WHERE     p.project_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, projectIdx);
		
		ResultSet rs = pstmt.executeQuery();
		OpenProjectInfoDto ret = null;
		while(rs.next()) {
			int categoryIdx = rs.getInt("카테고리IDX");
			String categoryName = rs.getString("카테고리명");
			String pName = rs.getString("프로젝트명");
			int writingGrant = rs.getInt("글 작성 권한");
			int commentGrant = rs.getInt("댓글 작성 권한");
			int postViewGrant = rs.getInt("글 조회 권한");
			int editPostGrant = rs.getInt("글 수정 권한");
			ret = new OpenProjectInfoDto(categoryIdx, categoryName, pName, writingGrant, commentGrant, postViewGrant, 0, 0, editPostGrant);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return ret;
	}
	
//	[SH-62] - 공개 프로젝트 정보 수정하기 (p38-7)
//	-input : project_idx(숫자), category_idx(숫자), 수정할 프로젝트명(문자열),
//		   edit_post_grant(숫자)[0, 1, 2],
//		   writing_grant(숫자)[0, 1],
//		   post_view_grant(숫자)[0, 1],
//		   comment_grant(숫자)[0, 1],
//		   file_view_grant(숫자)[0, 1],
//		   file_down_grant(숫자)[0, 1]
	public void setOpenProjectInfo(int categoryIdx, int projectIdx, String pName, int writingGrant, int commentGrant, int postViewGrant, int editPostGrant) throws Exception{
		String sql = "UPDATE  projects" + 
				" SET     category_idx = ?," + 
				"        project_name = ?," + 
				"        writing_grant = ?," + 
				"        comment_grant = ?," + 
				"        post_view_grant = ?," + 
				"        edit_post_grant = ?" + 
				" WHERE   project_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, categoryIdx);
		pstmt.setString(2, pName);
		pstmt.setInt(3, writingGrant);
		pstmt.setInt(4, commentGrant);
		pstmt.setInt(5, postViewGrant);
		pstmt.setInt(6, editPostGrant);
		pstmt.setInt(7, projectIdx);
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
	}
	
//	[SH-63] - 공개 프로젝트 카테고리 탭열기 (p39)
//	-input : company_idx(숫자)
//	-output : ArrayList<OpenProjectCategoryDto>
	public ArrayList<OpenProjectCategoryDto> getOpenProjectCategory(int companyIdx) throws Exception{
		String sql = "SELECT  category_idx," + 
				"        category_name AS \"카테고리명\"," + 
				"        category_state AS \"상태\"" + 
				" FROM    project_category" + 
				" WHERE   company_idx = ?" +
				" ORDER BY category_idx";
		ArrayList<OpenProjectCategoryDto> listRet = new ArrayList<OpenProjectCategoryDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, companyIdx);
		
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int categoryIdx = rs.getInt("category_idx");
			String name = rs.getString("카테고리명");
			char state = rs.getString("상태").charAt(0);
			
			String sql2 = "SELECT  p.project_idx," + 
					"        COUNT(pc.category_idx)AS \"프로젝트 수\"" + 
					" FROM    project_category pc" + 
					" INNER JOIN projects p" + 
					" ON      pc.category_idx = p.category_idx" + 
					" WHERE   pc.category_idx = "+categoryIdx+"" + 
					" GROUP BY p.project_idx";
			PreparedStatement pstmt2 = conn.prepareStatement(sql2);
			ResultSet rs2 = pstmt2.executeQuery();
			if(rs2.next()) {
				int projectCnt = rs2.getInt("프로젝트 수");
				OpenProjectCategoryDto dto = new OpenProjectCategoryDto(categoryIdx, name, projectCnt, state);
				listRet.add(dto);
			}else {
				int projectCnt = 0;
				OpenProjectCategoryDto dto = new OpenProjectCategoryDto(categoryIdx, name, projectCnt, state);
				listRet.add(dto);
			}
			rs2.close();
			pstmt2.close();
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	
//	[SH-64] - 공개 프로젝트 카테고리 정보 수정하기 (p39-3)
//	-input : company_idx(숫자),
//		   수정할 category_idx(숫자),
//		   수정할 카테고리명(문자열),
//		   수정할 카테고리상태(char(1))
	public void setOpenProjectCategoryInfo(int companyIdx, int categoryIdx, String str, char state) throws Exception{
		String sql = "UPDATE  project_category" + 
				" SET     category_name = ?," + 
				"        category_state = ?" + 
				" WHERE   company_idx = ?" + 
				" AND     category_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, str);
		pstmt.setString(2, state+"");
		pstmt.setInt(3, companyIdx);
		pstmt.setInt(4, categoryIdx);
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
	}
	
//	[SH-65] - 공개 프로젝트 카테고리 추가하기 (p39-3)
//	-input : company_idx(숫자),
//		   category_idx(숫자),
//		   카테고리명(문자열),
//		   카테고리상태(char(1))
	public void addOpenProjectCategoryInfo(int companyIdx, String str, char state) throws Exception{
		String sql = "INSERT INTO " + 
				" project_category(category_idx, company_idx, category_name, category_state)" + 
				" VALUES(SEQ_PROJECT_CATEGORY.nextval, ?, ?, ?)";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, companyIdx);
		pstmt.setString(2, str);
		pstmt.setString(3, state+"");
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
	}
	
//	[SH-66] - 공개 프로젝트 카테고리 삭제하기 (p39-3)
//	-input : company_idx(숫자),
//		   삭제할 category_idx(숫자)
	public void delOpenProjectCategoryInfo(int companyIdx, int categoryIdx) throws Exception{
		String sql = "DELETE  project_category" + 
				" WHERE   company_idx = ?" + 
				" AND     category_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, companyIdx);
		pstmt.setInt(2, categoryIdx);
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
	}
	
//	[SH-67] - 비활성화 프로젝트 관리 탭열기 (p40)
//	-input : company_idx(숫자)
//	-output : ArrayList<DeactivProjectDto>
	public ArrayList<DeactivProjectDto> getDeactivProject(int companyIdx) throws Exception{
		String sql = "SELECT  p.project_idx," + 
				"        p.project_name AS \"프로젝트명\"," + 
				"		m.name||'('||m.email||')' AS \"작성자\"," + 
				"		p.last_activity AS \"최근 활동일\"" + 
				" FROM projects p" + 
				" INNER JOIN project_member pm" + 
				" ON p.project_idx = pm.project_idx" + 
				" INNER JOIN members m" + 
				" ON m.member_idx = p.writer_idx" + 
				" WHERE p.project_idx IN (SELECT p.project_idx" + 
				"                        FROM members m" + 
				"                        INNER JOIN project_member pm" + 
				"                        ON m.member_idx = pm.participant_idx" + 
				"                        INNER JOIN projects p" + 
				"                        ON p.project_idx = pm.project_idx" + 
				"                        GROUP BY p.project_idx" + 
				"                        HAVING COUNT(pm.participant_idx) = 1)" + 
				" AND m.state = '이용중지'" + 
				" AND m.company_idx = ?" + 
				" UNION" + 
				" SELECT  pm.project_idx," + 
				"        p.project_name AS \"프로젝트명\"," + 
				"		m.name||'('||m.email||')' AS \"작성자\"," + 
				"		p.last_activity AS \"최근 활동일\"" + 
				" FROM companies c " + 
				" INNER JOIN projects p " + 
				" ON c.company_idx = p.company_idx " + 
				" INNER JOIN project_member pm " + 
				" ON pm.project_idx = p.project_idx" + 
				" INNER JOIN members m" + 
				" ON m.member_idx = pm.participant_idx" + 
				" WHERE p.company_idx = ? " + 
				" AND NOT EXISTS(SELECT 1" + 
				"                FROM members m_sub " + 
				"                INNER JOIN project_member pm_sub" + 
				"                ON m_sub.member_idx = pm_sub.participant_idx" + 
				"                WHERE m_sub.company_idx  = ?)";
		ArrayList<DeactivProjectDto> listRet = new ArrayList<DeactivProjectDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, companyIdx);
		pstmt.setInt(2, companyIdx);
		pstmt.setInt(3, companyIdx);
		
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next()) {
			int projectIdx = rs.getInt("project_idx");
			String pName = rs.getString("프로젝트명");
			String writer = rs.getString("작성자");
			String lastActivity = rs.getString("최근 활동일");
			DeactivProjectDto dto = new DeactivProjectDto(projectIdx, pName, writer, lastActivity);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	

//	[SH-68] - 비활성화 프로젝트 검색하기 (p40-1)
//	-input : 	company_idx(숫자),
//				검색기준(문자열)[프로젝트명, 프로젝트 만든이],
//	   			검색어(문자열)
//	-output : ArrayList<DeactivProjectDto>
	public ArrayList<DeactivProjectDto> getDeactivProjectSearch(int companyIdx, String standard, String str) throws Exception {
		String m = null;
		if(standard == "프로젝트명") {
			m = "p.project_name";
		}else if(standard == "프로젝트 만든이") {
			m = "m.name";
		}
		String sql = "SELECT  DISTINCT p.project_idx," + 
				"        p.project_name AS \"프로젝트명\"," + 
				"        m.name||'('||m.email||')' AS \"작성자\"," + 
				"        p.last_activity AS \"최근 활동일\"" + 
				" FROM    projects p" + 
				" INNER JOIN project_member pm" + 
				" ON      p.project_idx = pm.project_idx" + 
				" INNER JOIN members m" + 
				" ON      m.member_idx = p.writer_idx" + 
				" WHERE   p.company_idx = ?" + 
				" AND     "+m+" LIKE ?" + 
				" AND     p.inactive_yn = 'Y'" + 
				" ORDER BY p.project_idx";
		ArrayList<DeactivProjectDto> listRet = new ArrayList<DeactivProjectDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, companyIdx);
		pstmt.setString(2, "%"+str+"%");
		
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next()) {
			int projectIdx = rs.getInt("project_idx");
			String pName = rs.getString("프로젝트명");
			String writer = rs.getString("작성자");
			String lastActivity = rs.getString("최근 활동일");
			DeactivProjectDto dto = new DeactivProjectDto(projectIdx, pName, writer, lastActivity);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	
//	해당 프로젝트의 게시물 수를 가져옴
	public int getProjectBoardCnt(int projectIdx) throws Exception{
		String sql = "SELECT  COUNT(b.board_idx) AS \"게시물 수\"" + 
				" FROM    projects p" + 
				" INNER JOIN board b" + 
				" ON      p.project_idx = b.project_idx" + 
				" WHERE   p.project_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, projectIdx);
		
		ResultSet rs = pstmt.executeQuery();
		int boardCnt = 0;
		if(rs.next()) {
			boardCnt = rs.getInt("게시물 수");
		}
		rs.close();
		pstmt.close();
		conn.close();
		return boardCnt;
	}
//	해당 프로젝트의 파일 수를 가져옴
	public int getProjectFileCnt(int projectIdx) throws Exception{
		String sql = "SELECT  COUNT(bf.file_idx) AS \"파일 수\"" + 
				" FROM    projects p" + 
				" INNER JOIN board b" + 
				" ON      p.project_idx = b.project_idx" + 
				" INNER JOIN board_file bf" + 
				" ON      b.board_idx = bf.board_idx" + 
				" WHERE   p.project_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, projectIdx);
		ResultSet rs = pstmt.executeQuery();
		int fileCnt = 0;
		if(rs.next()) {
			fileCnt = rs.getInt("파일 수");
		}
		rs.close();
		pstmt.close();
		conn.close();
		return fileCnt;
	}
//	해당 프로젝트의 파일 수를 가져옴
	public int getProjectTaskCnt(int projectIdx) throws Exception{
		String sql = "SELECT  COUNT(t.task_idx) AS \"업무 수\"" + 
				" FROM    projects p" + 
				" INNER JOIN board b" + 
				" ON      p.project_idx = b.project_idx" + 
				" INNER JOIN task t" + 
				" ON      b.board_idx = t.board_idx" + 
				" WHERE   p.project_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, projectIdx);
		
		ResultSet rs = pstmt.executeQuery();
		int taskCnt = 0;
		if(rs.next()) {
			taskCnt = rs.getInt("업무 수");
		}
		rs.close();
		pstmt.close();
		conn.close();
		return taskCnt;
	}
//	해당 프로젝트의 댓글 수를 가져옴
	public int getProjectCommentCnt(int projectIdx) throws Exception{
		String sql = "SELECT  COUNT(c.comment_idx) AS \"댓글 수\"" + 
				" FROM    projects p" + 
				" INNER JOIN board b" + 
				" ON      p.project_idx = b.project_idx" + 
				" INNER JOIN comments c" + 
				" ON      b.board_idx = c.board_idx" + 
				" WHERE   p.project_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, projectIdx);
		
		ResultSet rs = pstmt.executeQuery();
		int commentCnt = 0;
		if(rs.next()) {
			commentCnt = rs.getInt("댓글 수");
		}
		rs.close();
		pstmt.close();
		conn.close();
		return commentCnt;
	}
//	해당 프로젝트의 외부인 수를 가져옴
	public int getProjectOutsiderCnt(int projectIdx) throws Exception{
		String sql = "SELECT  COUNT(m.member_idx) AS \"외부인 수\"" + 
				" FROM    projects p" + 
				" INNER JOIN project_member pm" + 
				" ON      p.project_idx = pm.project_idx" + 
				" INNER JOIN members m" + 
				" ON      pm.participant_idx = m.member_idx" + 
				" WHERE   p.project_idx = ?" + 
				" AND     m.company_idx != p.company_idx";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, projectIdx);
		
		ResultSet rs = pstmt.executeQuery();
		int outsiderCnt = 0;
		if(rs.next()) {
			outsiderCnt = rs.getInt("외부인 수");
		}
		rs.close();
		pstmt.close();
		conn.close();
		return outsiderCnt;
	}
	
//	[SH-69] - 선택한 비활성화 프로젝트 관리자 추가하기 (p40-2)
//	-input : project_idx(숫자),
//		   member_idx(숫자)
	public void addDeactivProjectAdmin(int projectIdx, int memberIdx) throws Exception{
		String sql = "UPDATE  project_member" + 
				" SET     admin_yn = 'Y'" + 
				" WHERE   participant_idx = ?" + 
				" AND     project_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, memberIdx);
		pstmt.setInt(2, projectIdx);
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
	}
//	관리자 추가와 함께 비활성화가 풀림
	public void setInActiveYN(int projectIdx) throws Exception{
		String sql = "UPDATE  projects" + 
				" SET     inactive_yn = 'N'" + 
				" WHERE   project_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, projectIdx);
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
	}
	
	// 최근업데이트순 프로젝트리스트 뽑기
	public ArrayList<LastActivityProjectDto> getLastActivityProjectList(int memberIdx) throws Exception {
		String sql = "SELECT  p.project_idx," + 
				"        p.project_name," + 
				"        p.last_activity," + 
				"        pm.project_color," + 
				"        c.color_code" + 
				" FROM    projects p" + 
				" INNER JOIN project_member pm" + 
				" ON      p.project_idx = pm.project_idx" + 
				" INNER JOIN members m" + 
				" ON      m.member_idx = pm.participant_idx" + 
				" INNER JOIN color c" + 
				" ON      pm.project_color = c.color_idx" + 
				" WHERE   pm.participant_idx = ?" + 
				" ORDER BY p.last_activity DESC";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, memberIdx);
		ResultSet rs = pstmt.executeQuery();
		ArrayList<LastActivityProjectDto> listRet = new ArrayList<LastActivityProjectDto>();
		while(rs.next()) {
			int projectIdx = rs.getInt("project_idx");
			String projectName = rs.getString("project_name");
			String lastActivityDate = rs.getString("last_activity");
			String projectColor = rs.getString("color_code");
			LastActivityProjectDto dto = new LastActivityProjectDto(projectIdx, projectName, lastActivityDate, projectColor);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	
	// 회사 공개프로잭트탭 리스트 검색하기
	public ArrayList<CompanyPublicProjectDto> getPublicProjectList(int memberIdx, String str) throws Exception {
		String sql = "SELECT  DISTINCT p.project_idx AS \"프로젝트IDX\"," + 
				"        p.project_name AS \"프로젝트이름\"," + 
				"        p.category_idx AS \"카테고리IDX\"," + 
				"        pc.category_name AS \"카테고리이름\"," + 
				"        (SELECT COUNT(*) " + 
				"            FROM project_member pm " + 
				"            WHERE pm.project_idx = p.project_idx) AS \"참여자 수\"," + 
				"        CASE " + 
				"        WHEN EXISTS (" + 
				"            SELECT 1 " + 
				"            FROM project_member pm " + 
				"            WHERE pm.project_idx = p.project_idx" + 
				"            AND pm.participant_idx = ?" + 
				"        ) THEN 'Y' ELSE 'N' END AS \"참여 여부\"" + 
				" FROM    companies c" + 
				" INNER JOIN projects p" + 
				" ON      p.company_idx = c.company_idx" + 
				" INNER JOIN project_member pm" + 
				" ON      p.project_idx = pm.project_idx" + 
				" INNER JOIN project_category pc" + 
				" ON      p.category_idx = pc.category_idx" + 
				" INNER JOIN members m" + 
				" ON      pm.participant_idx = m.member_idx" + 
				" WHERE   pc.category_state = 'Y'" + 
				" AND     p.project_name LIKE ?  " + 
				" ORDER BY p.project_idx";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, memberIdx);
		pstmt.setString(2, "%"+str+"%");
		ResultSet rs = pstmt.executeQuery();
		ArrayList<CompanyPublicProjectDto> listRet = new ArrayList<CompanyPublicProjectDto>();
		while(rs.next()) {
			int projectIdx = rs.getInt("프로젝트IDX");
			String projectName = rs.getString("프로젝트이름");
			int categoryIdx = rs.getInt("카테고리IDX");
			String categoryName = rs.getString("카테고리이름");
			int memberCnt = rs.getInt("참여자 수");
			String participant_yn = rs.getString("참여 여부");
			
			String sql2 = "SELECT  m.name" + 
					" FROM    project_member pm" + 
					" INNER JOIN members m" + 
					" ON      pm.participant_idx = m.member_idx" + 
					" WHERE   pm.project_idx = ?" + 
					" AND     pm.admin_yn = 'Y'" + 
					" ORDER BY pm.entry_date";
			PreparedStatement pstmt2 = conn.prepareStatement(sql2);
			pstmt2.setInt(1, projectIdx);
			ResultSet rs2 = pstmt2.executeQuery();
			String firstAdminName = "";
			if(rs2.next()) {
				firstAdminName = rs2.getString("name");
			}
			rs2.close();
			pstmt2.close();
			CompanyPublicProjectDto dto = new CompanyPublicProjectDto(projectIdx, projectName, categoryIdx, categoryName, memberCnt, participant_yn, firstAdminName);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	
	// 프로젝트 카테고리 목록가져오기
	public ArrayList<String> getProjectCategoryList(int memberIdx) throws Exception {
		String sql = "SELECT  pc.category_name" + 
				" FROM    project_category pc" + 
				" INNER JOIN companies c" + 
				" ON      pc.company_idx = c.company_idx" + 
				" INNER JOIN members m" + 
				" ON      c.company_idx = m.company_idx" + 
				" WHERE   m.member_idx = ?" + 
				" ORDER BY pc.category_idx";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, memberIdx);
		ResultSet rs = pstmt.executeQuery();
		ArrayList<String> listRet = new ArrayList<String>();
		while(rs.next()) {
			String str = rs.getString("category_name");
			listRet.add(str);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	
	public static void main(String[] args) throws Exception{
		ProjectDao pdao = new ProjectDao();
		
		ArrayList<String> list = null;
		list = pdao.getProjectCategoryList(2);
		for(String str : list) {
			System.out.println(str);
		}
		
//		ArrayList<CompanyPublicProjectDto> list = null;
//		list = pdao.getPublicProjectList(2, "");
//		for(CompanyPublicProjectDto dto : list) {
//			System.out.println(dto.getProjectName());
//		}
		
//		ArrayList<OpenProjectDto> list = new ArrayList<OpenProjectDto>();
//		list = pdao.getOpenProjectsSearch(1, "");
//		for(OpenProjectDto dto : list) {
//			System.out.println("프로젝트명 : " + dto.getpName());
//		}
	}
}
