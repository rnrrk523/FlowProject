package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Types;
import java.util.ArrayList;

import dto.ColorandPublicDto;
import dto.MemberDto;
import dto.MemberProjectFolderDto;
import dto.MyProjectViewDto;
import dto.ProjectAdminDto;
import dto.ProjectInviteViewDto;
import dto.ProjectMemberListDto;
import dto.ProjectMemberViewDto;
import dto.ProjectViewProjecIdxDto;
import dto.dto.ProjectUserFolder;
 

public class ProjectALLDao {
	public Connection getConnection() throws Exception {
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@//114.207.245.107:1521/XE";
		String id = "FLOW";
		String pw = "1234";
		
		Class.forName(driver);
		Connection conn = DriverManager.getConnection(url, id, pw);
		return conn;
	}
//	[Minsuk1] 새 프로젝트 생성-(p52),
//	input : String(제목), String(설명), String(홈탭), char(관리자 승인)
//		int(게시글작성권한), int(게시글수정권한), int(게시글조회권한), int(댓글작성권한), 
//		int(파일조회권한), int(파일다운로드권한)
//		int(공개 프로젝트 카테고리 설정, 공개 프로젝트가 아닐땐 null)
//	output : -

	public void Createproject(int memberIdx, String projectName, String projectExplanation, int writerIdx,  
			String homeTab, char approvalYN, int editPostGrant, int writingGrant,
			int postViewGrant, int commentGrant, int categoryIdx
			) throws Exception {
		String sql= "";
		if(categoryIdx == 0) {
			sql = "INSERT INTO projects(project_idx,company_idx,project_name,project_explanation,writer_idx,home_tab," + 
					"    approval_yn,edit_post_grant,writing_grant,post_view_grant,comment_grant" + 
					"    ,category_idx)" + 
					"    values (projectUp.nextval,(select COMPANY_IDX from members WHERE member_idx = ?)," + 
					"    ?,?,?,?," + 
					"    ?,?,?,?,?,null)";
		} else {
			sql = "INSERT INTO projects(project_idx,company_idx,project_name,project_explanation,writer_idx,home_tab," + 
					"    approval_yn,edit_post_grant,writing_grant,post_view_grant,comment_grant" + 
					"    ,category_idx)" + 
					"    values (projectUp.nextval,(select COMPANY_IDX from members WHERE member_idx = ?)," + 
					"    ?,?,?,?," + 
					"    ?,?,?,?,?,?)";
		}
		
		
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, memberIdx);
		pstmt.setString(2,projectName);
		pstmt.setString(3,projectExplanation);
		pstmt.setInt(4,writerIdx);
		pstmt.setString(5,homeTab);
		pstmt.setString(6,String.valueOf(approvalYN));
		pstmt.setInt(7,editPostGrant);
		pstmt.setInt(8,writingGrant);
		pstmt.setInt(9,postViewGrant);
		pstmt.setInt(10,commentGrant);
		if(categoryIdx == 0) {
		} else {
			pstmt.setInt(11,categoryIdx);
		}
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	//생성한 프로젝트의 작성자를 프로젝트 멤버로 넣기위해 생성한 projectidx를 뽑는 dao
	public int ProjectIdxView() throws Exception {
		String sql = "SELECT MAX(project_idx)" + 
				"  FROM projects";
		int projectIdx = 0;
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		if(rs.next()) {
			projectIdx = rs.getInt(1);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return projectIdx;
	}
	//생성한 프로젝트의 작성자를 프로젝트 멤버로 넣는 DAO
	public void CreateProjectMember(int projectIdx, int memberIdx, int projectColor) throws Exception {
		String sql = "INSERT INTO PROJECT_MEMBER(PROJECT_IDX, PARTICIPANT_IDX, ADMIN_YN, PROJECT_COLOR, STATE_YN, ENTRY_DATE)" + 
				"VALUES(?,?,'Y',?,'Y',sysdate)";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, projectIdx);
		pstmt.setInt(2, memberIdx);
		pstmt.setInt(3,  projectColor);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	public void InviteProjectMember(int projectIdx, int memberIdx, int projectColor) throws Exception {
		String sql = "INSERT INTO PROJECT_MEMBER(PROJECT_IDX, PARTICIPANT_IDX, ADMIN_YN, PROJECT_COLOR, STATE_YN, ENTRY_DATE)" + 
				"VALUES(?,?,'N',?,'Y',sysdate)";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, projectIdx);
		pstmt.setInt(2, memberIdx);
		pstmt.setInt(3, projectColor);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	//프로젝트 홈탭 출력
	public MyProjectViewDto ProjectCategory(int projectIdx)throws Exception {
		String sql = " SELECT home_tab" + 
				" FROM PROJECTS" + 
				" WHERE PROJECT_IDX = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, projectIdx);
		ResultSet rs = pstmt.executeQuery();
		MyProjectViewDto dto = null;
		if(rs.next()) {
			String homeTab = rs.getString("home_tab");
			dto = new MyProjectViewDto(projectIdx, homeTab, projectIdx, ' ', projectIdx, projectIdx, ' ', ' ', homeTab);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return dto;
	}
	//입력한 projectidx의 프로젝트 전체 출력
	public ProjectViewProjecIdxDto ProjectViewProjecIdx(int projectIdx) throws Exception {
		String sql = " SELECT  PROJECT_NAME AS \"프로젝트명\", PROJECT_EXPLANATION AS \"프로젝트설명\"," + 
				"        HOME_TAB AS \"홈탭\", APPROVAL_YN AS \"관리자승인\", EDIT_POST_GRANT AS \"게시글수정권한\"," + 
				"        writing_grant AS \"게시글작성권한\", post_view_grant AS \"게시글조회권한\", comment_grant AS \"댓글작성권한\"," + 
				"        file_view_grant AS \"파일조회권한\", file_down_grant AS \"파일다운권한\", category_idx AS \"공개프로젝트\", COMPANY_PROJECT_YN AS \"회사프로젝트\", COMPANY_IDX AS \"회사번호\"" + 
				" FROM PROJECTS" + 
				" WHERE PROJECT_IDX = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, projectIdx);
		ResultSet rs = pstmt.executeQuery();
		ProjectViewProjecIdxDto dto = null;
		if(rs.next()) {
			String projectName = rs.getString("프로젝트명");
			String projectExplanation = rs.getString("프로젝트설명");
			String homeTab = rs.getString("홈탭");
			char approvalYN = rs.getString("관리자승인").charAt(0);
			int editPostGrant = rs.getInt("게시글수정권한");
			int writingGrant = rs.getInt("게시글작성권한");
			int postViewGrant = rs.getInt("게시글조회권한");
			int commentGrant = rs.getInt("댓글작성권한");
			int fileViewGrant = rs.getInt("파일조회권한");
			int fileDownGrant = rs.getInt("파일다운권한");
			int categoryIdx = rs.getInt("공개프로젝트");
			char companyProjectYN = rs.getString("회사프로젝트").charAt(0);
			int companyIdx = rs.getInt("회사번호");
			dto = new ProjectViewProjecIdxDto(projectName, projectExplanation, homeTab, approvalYN, editPostGrant, writingGrant, postViewGrant, commentGrant, fileViewGrant, fileDownGrant, categoryIdx, companyProjectYN,companyIdx);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return dto;
	}
//	[Minsuk1-1] 참여중인 프로젝트 조회-(p58)
//	input : int(참가자idx)
//	output : 해당 멤버가 참여중인 프로젝트 필터별로 출력
	public ArrayList<MyProjectViewDto> MyProjectView(int participantIdx, int array, int filter) throws Exception {
		String sql = "";
		String filtercode = "";
			if(filter == 1) {
			   filtercode = "AND pm.admin_yn = 'Y'";
			}
		if(array == 0) {
			   sql = " SELECT " + 
			   		"    sb.project_idx AS \"프로젝트 번호\"," + 
			   		"    sb.project_name AS \"프로젝트 이름\"," + 
			   		"    sb.project_color AS \"색상\"," + 
			   		"    sb.favorites_yn AS \"즐겨찾기 여부\"," + 
			   		"    sb.APPROVAL_YN AS \"관리자승인\"," + 
			   		"    sb.COMPANY_PROJECT_YN AS \"회사프로젝트\"," + 
			   		"    sb.CATEGORY_IDX AS \"공개프로젝트\"," + 
			   		"    MAX(B_latest.LAST_MODIFIED_DATE) AS \"최종 수정일\"" + 
			   		" FROM (" + 
			   		"    SELECT " + 
			   		"        p.project_idx AS project_idx," + 
			   		"        p.project_name AS project_name," + 
			   		"        pm.project_color AS project_color," + 
			   		"        pm.favorites_yn AS favorites_yn," + 
			   		"        p.APPROVAL_YN AS APPROVAL_YN," + 
			   		"        p.COMPANY_PROJECT_YN AS COMPANY_PROJECT_YN," + 
			   		"        p.CATEGORY_IDX AS CATEGORY_IDX" + 
			   		"    FROM projects p" + 
			   		"    JOIN project_member pm ON p.project_idx = pm.project_idx" + 
			   		"    WHERE pm.participant_idx = ?" + 
			   		"    AND p.DELETE_YN = 'N' " +						
			   		"    AND pm.State_yn = 'Y'"+ filtercode +
			   		" ) sb" + 
			   		" LEFT JOIN BOARD B_latest" + 
			   		"    ON sb.project_idx = B_latest.project_idx" + 
			   		" GROUP BY " + 
			   		"    sb.project_idx, " + 
			   		"    sb.project_name, " + 
			   		"    sb.project_color, " + 
			   		"    sb.favorites_yn, " + 
			   		"    sb.APPROVAL_YN, " + 
			   		"    sb.COMPANY_PROJECT_YN, " + 
			   		"    sb.CATEGORY_IDX" + 
			   		" ORDER BY" + 
			   		"    CASE" + 
			   		"        WHEN MAX(B_latest.LAST_MODIFIED_DATE) IS NOT NULL THEN 0" + 
			   		"        ELSE 1" + 
			   		"    END," + 
			   		"    MAX(B_latest.LAST_MODIFIED_DATE) DESC";
		}
		if(array == 1) {
			sql = " SELECT              sb.project_idx AS\"프로젝트 번호\"," + 
			   		"					sb.project_name AS \"프로젝트 이름\", " + 
			   		"                    sb.project_color AS \"색상\", " + 
			   		"                    sb.favorites_yn AS \"즐겨찾기 여부\" ," + 
			   		"                    sb.APPROVAL_YN AS \"관리자승인\"," + 
			   		"                    sb.COMPANY_PROJECT_YN AS \"회사프로젝트\"," + 
			   		"                    sb.CATEGORY_IDX AS \"공개프로젝트\"" + 
					" FROM (" + 
					"					    SELECT p.project_idx AS project_idx," + 
			   		"					           p.project_name AS project_name," + 
			   		"					           pm.project_color AS project_color, " + 
			   		"					           pm.favorites_yn AS favorites_yn," + 
			   		"                               p.APPROVAL_YN AS APPROVAL_YN," + 
			   		"                               p.COMPANY_PROJECT_YN AS COMPANY_PROJECT_YN," + 
			   		"                               p.CATEGORY_IDX AS CATEGORY_IDX" + 
					"    FROM projects p" + 
					"    JOIN project_member pm ON p.project_idx = pm.project_idx" + 
					"    WHERE pm.participant_idx = ? " + 
					"    AND p.DELETE_YN = 'N' " +
					"      AND pm.State_yn = 'Y'" + filtercode +
					" ) sb" + 
					" LEFT JOIN BOARD B_latest " + 
					"  ON sb.project_idx = B_latest.project_idx " + 
					"  AND B_latest.WRITER_IDX = ?" + 
					"					 GROUP BY sb.project_idx, sb.project_name, sb.project_color, sb.favorites_yn,  " + 
			   		"                     sb.APPROVAL_YN,sb.COMPANY_PROJECT_YN,sb.CATEGORY_IDX" + 
					" ORDER BY " + 
					"    CASE " + 
					"        WHEN MAX(B_latest.LAST_MODIFIED_DATE) IS NOT NULL THEN 0" + 
					"        ELSE 1 " + 
					"    END," + 
					"    MAX(B_latest.LAST_MODIFIED_DATE) DESC";
		}
		if(array == 2) {
			sql = " SELECT  p.project_idx AS \"프로젝트 번호\", p.project_name AS \"프로젝트 이름\"," + 
					"				pm.project_color AS \"색상\", pm.favorites_yn AS \"즐겨찾기 여부\", " + 
					"                    p.APPROVAL_YN AS \"관리자승인\"," + 
			   		"                    p.COMPANY_PROJECT_YN AS \"회사프로젝트\"," + 
			   		"                    p.CATEGORY_IDX AS \"공개프로젝트\"" + 
					"				FROM    projects p" + 
					"				JOIN    project_member pm" + 
					"				ON      p.project_idx = pm.project_idx " + 
					"				where   pm.participant_idx = ? AND pm.State_yn = 'Y'" + filtercode +
					"    AND p.DELETE_YN = 'N' " +
					"				ORDER BY PROJECT_NAME";
		}
		if(array == 3) {
			sql = "SELECT  p.project_idx AS \"프로젝트 번호\", p.project_name AS \"프로젝트 이름\"," + 
					"				pm.project_color AS \"색상\", pm.favorites_yn AS \"즐겨찾기 여부\", " + 
					"                    p.APPROVAL_YN AS \"관리자승인\"," + 
			   		"                    p.COMPANY_PROJECT_YN AS \"회사프로젝트\"," + 
			   		"                    p.CATEGORY_IDX AS \"공개프로젝트\"" + 
					"				FROM    projects p" + 
					"				JOIN    project_member pm" + 
					"				ON      p.project_idx = pm.project_idx " + 
					"				where   pm.participant_idx = ? AND pm.State_yn = 'Y'" + filtercode +
					"    AND p.DELETE_YN = 'N' " +
					"				ORDER BY PROJECT_NAME desc";
		}
		
		ArrayList<MyProjectViewDto> listRet = new ArrayList<MyProjectViewDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		if(array == 1) {
			pstmt.setInt(1, participantIdx);
			pstmt.setInt(2, participantIdx);
		} else {
			pstmt.setInt(1, participantIdx);
		} 
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int projectIdx = rs.getInt("프로젝트 번호");
			String projectName = rs.getString("프로젝트 이름");
			int projectColor = rs.getInt("색상");
			char favoritesYN = rs.getString("즐겨찾기 여부").charAt(0);
			char companyProjectYN = rs.getString("회사프로젝트").charAt(0);
			char approvalYN = rs.getString("관리자승인").charAt(0);
			int categoryIdx = rs.getInt("공개프로젝트");
			MyProjectViewDto dto = new MyProjectViewDto(projectIdx, projectName, projectColor, favoritesYN, categoryIdx, categoryIdx, companyProjectYN, approvalYN,null);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	public ArrayList<MyProjectViewDto> MyProjectViewFolderView(int participantIdx, int array, int filter,int folderIdx) throws Exception {
		String sql = "";
		String filtercode = "";
			if(filter == 0) {
			   filtercode = "";
			}
			if(filter == 1) {
			   filtercode = "AND pm.admin_yn = 'Y'";
			}
			if (filter == 2) {
				filtercode = "AND pm.FAVORITES_YN = 'Y'";
			}
		if(array == 0) {
			   sql = " SELECT " + 
			   		"    sb.project_idx AS \"프로젝트 번호\"," + 
			   		"    sb.project_name AS \"프로젝트 이름\"," + 
			   		"    sb.project_color AS \"색상\"," + 
			   		"    sb.favorites_yn AS \"즐겨찾기 여부\"," + 
			   		"    sb.APPROVAL_YN AS \"관리자승인\"," + 
			   		"    sb.COMPANY_PROJECT_YN AS \"회사프로젝트\"," + 
			   		"    sb.CATEGORY_IDX AS \"공개프로젝트\"," + 
			   		"    MAX(B_latest.LAST_MODIFIED_DATE) AS \"최종 수정일\"" + 
			   		" FROM (" + 
			   		"    SELECT " + 
			   		"        p.project_idx AS project_idx," + 
			   		"        p.project_name AS project_name," + 
			   		"        pm.project_color AS project_color," + 
			   		"        pm.favorites_yn AS favorites_yn," + 
			   		"        p.APPROVAL_YN AS APPROVAL_YN," + 
			   		"        p.COMPANY_PROJECT_YN AS COMPANY_PROJECT_YN," + 
			   		"        p.CATEGORY_IDX AS CATEGORY_IDX" + 
			   		"    FROM projects p" + 
			   		"    JOIN project_member pm ON p.project_idx = pm.project_idx" +
			   		"				JOIN	PROJECT_FOLDER_SETTING pfs" +
					" 				ON		p.project_idx = pfs.project_idx" +
			   		"    WHERE pm.participant_idx = ?" + 
			   		"    AND p.DELETE_YN = 'N' " +	
			   		"	AND pfs.folder_idx = ?						"+
			   		"    AND pm.State_yn = 'Y'"+ filtercode +
			   		" ) sb" + 
			   		" LEFT JOIN BOARD B_latest" + 
			   		"    ON sb.project_idx = B_latest.project_idx" + 
			   		" GROUP BY " + 
			   		"    sb.project_idx, " + 
			   		"    sb.project_name, " + 
			   		"    sb.project_color, " + 
			   		"    sb.favorites_yn, " + 
			   		"    sb.APPROVAL_YN, " + 
			   		"    sb.COMPANY_PROJECT_YN, " + 
			   		"    sb.CATEGORY_IDX" + 
			   		" ORDER BY" + 
			   		"    CASE" + 
			   		"        WHEN MAX(B_latest.LAST_MODIFIED_DATE) IS NOT NULL THEN 0" + 
			   		"        ELSE 1" + 
			   		"    END," + 
			   		"    MAX(B_latest.LAST_MODIFIED_DATE) DESC";
		}
		if(array == 1) {
			sql = " SELECT              sb.project_idx AS\"프로젝트 번호\"," + 
			   		"					sb.project_name AS \"프로젝트 이름\", " + 
			   		"                    sb.project_color AS \"색상\", " + 
			   		"                    sb.favorites_yn AS \"즐겨찾기 여부\" ," + 
			   		"                    sb.APPROVAL_YN AS \"관리자승인\"," + 
			   		"                    sb.COMPANY_PROJECT_YN AS \"회사프로젝트\"," + 
			   		"                    sb.CATEGORY_IDX AS \"공개프로젝트\"" + 
					" FROM (" + 
					"					    SELECT p.project_idx AS project_idx," + 
			   		"					           p.project_name AS project_name," + 
			   		"					           pm.project_color AS project_color, " + 
			   		"					           pm.favorites_yn AS favorites_yn," + 
			   		"                               p.APPROVAL_YN AS APPROVAL_YN," + 
			   		"                               p.COMPANY_PROJECT_YN AS COMPANY_PROJECT_YN," + 
			   		"                               p.CATEGORY_IDX AS CATEGORY_IDX" + 
					"    FROM projects p" + 
					"    JOIN project_member pm ON p.project_idx = pm.project_idx" +
					"				JOIN	PROJECT_FOLDER_SETTING pfs" +
					" 				ON		p.project_idx = pfs.project_idx" +
					"    WHERE pm.participant_idx = ? " + 
					"    AND p.DELETE_YN = 'N' " +
					"      AND pm.State_yn = 'Y'" + filtercode +
					"	AND pfs.folder_idx = ?						"+
					" ) sb" + 
					" LEFT JOIN BOARD B_latest " + 
					"  ON sb.project_idx = B_latest.project_idx " + 
					"  AND B_latest.WRITER_IDX = ?" + 
					"					 GROUP BY sb.project_idx, sb.project_name, sb.project_color, sb.favorites_yn,  " + 
			   		"                     sb.APPROVAL_YN,sb.COMPANY_PROJECT_YN,sb.CATEGORY_IDX" + 
					" ORDER BY " + 
					"    CASE " + 
					"        WHEN MAX(B_latest.LAST_MODIFIED_DATE) IS NOT NULL THEN 0" + 
					"        ELSE 1 " + 
					"    END," + 
					"    MAX(B_latest.LAST_MODIFIED_DATE) DESC";
		}
		if(array == 2) {
			sql = " SELECT  p.project_idx AS \"프로젝트 번호\", p.project_name AS \"프로젝트 이름\"," + 
					"				pm.project_color AS \"색상\", pm.favorites_yn AS \"즐겨찾기 여부\", " + 
					"                    p.APPROVAL_YN AS \"관리자승인\"," + 
			   		"                    p.COMPANY_PROJECT_YN AS \"회사프로젝트\"," + 
			   		"                    p.CATEGORY_IDX AS \"공개프로젝트\"" + 
					"				FROM    projects p" + 
					"				JOIN    project_member pm" + 
					"				ON      p.project_idx = pm.project_idx " + 
					"				JOIN	PROJECT_FOLDER_SETTING pfs" +
					" 				ON		p.project_idx = pfs.project_idx" +
					"				where   pm.participant_idx = ? AND pm.State_yn = 'Y'" + filtercode +
					"    AND p.DELETE_YN = 'N' " +
					"	AND pfs.folder_idx = ?						"+
					"				ORDER BY PROJECT_NAME";
		}
		if(array == 3) {
			sql = "SELECT  p.project_idx AS \"프로젝트 번호\", p.project_name AS \"프로젝트 이름\"," + 
					"				pm.project_color AS \"색상\", pm.favorites_yn AS \"즐겨찾기 여부\", " + 
					"                    p.APPROVAL_YN AS \"관리자승인\"," + 
			   		"                    p.COMPANY_PROJECT_YN AS \"회사프로젝트\"," + 
			   		"                    p.CATEGORY_IDX AS \"공개프로젝트\"" + 
					"				FROM    projects p" + 
					"				JOIN    project_member pm" + 
					"				ON      p.project_idx = pm.project_idx " + 
					"				JOIN	PROJECT_FOLDER_SETTING pfs" +
					" 				ON		p.project_idx = pfs.project_idx" +
					"				where   pm.participant_idx = ? AND pm.State_yn = 'Y'" + filtercode +
					"    AND p.DELETE_YN = 'N' " +
					"	AND pfs.folder_idx = ?						"+
					"				ORDER BY PROJECT_NAME desc";
		}
		
		ArrayList<MyProjectViewDto> listRet = new ArrayList<MyProjectViewDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		if(array == 1) {
			pstmt.setInt(1, participantIdx);
			pstmt.setInt(2, folderIdx);
			pstmt.setInt(3, participantIdx);
		} else {
			pstmt.setInt(1, participantIdx);
			pstmt.setInt(2, folderIdx);
		} 
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int projectIdx = rs.getInt("프로젝트 번호");
			String projectName = rs.getString("프로젝트 이름");
			int projectColor = rs.getInt("색상");
			char favoritesYN = rs.getString("즐겨찾기 여부").charAt(0);
			char companyProjectYN = rs.getString("회사프로젝트").charAt(0);
			char approvalYN = rs.getString("관리자승인").charAt(0);
			int categoryIdx = rs.getInt("공개프로젝트");
			MyProjectViewDto dto = new MyProjectViewDto(projectIdx, projectName, projectColor, favoritesYN, categoryIdx, categoryIdx, companyProjectYN, approvalYN,null);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	// 참여중인 프로젝트 검색
	public ArrayList<MyProjectViewDto> MyProjectSearch(int memberIdx, String search) throws Exception {
		String sql = " SELECT P.project_NAME AS \"이름\",project_color AS \"색상\", P.project_Idx AS \"프로젝트번호\"" + 
				" FROM PROJECT_MEMBER PM" + 
				" JOIN PROJECTS P" + 
				" ON P.PROJECT_IDX = PM.project_idx" + 
				" WHERE pm.participant_idx = ?" + 
				" AND P.PROJECT_NAME LIKE ?";
		ArrayList<MyProjectViewDto> listRet = new ArrayList<MyProjectViewDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, memberIdx);
		pstmt.setString(2, "%"+search+"%");
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int projectIdx = rs.getInt("프로젝트번호");
			String projectName = rs.getString("이름");
			int projectColor = rs.getInt("색상");
			MyProjectViewDto dto = new MyProjectViewDto(projectIdx, projectName, projectColor, '0', projectColor, projectColor, '0', '0', projectName);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	//참여중인 프로젝트 최근 활동순서 별로 출력
	public ArrayList<MyProjectViewDto> MyProjectSearch(int memberIdx) throws Exception {
		String sql = " SELECT P.project_NAME AS \"이름\", project_color AS \"색상\", P.project_Idx AS \"프로젝트번호\"" + 
				" FROM PROJECT_MEMBER PM" + 
				" JOIN PROJECTS P" + 
				" ON P.PROJECT_IDX = PM.project_idx" + 
				" WHERE pm.participant_idx = ?" +
				" AND P.DELETE_YN = 'N' " +
				" ORDER BY P.LAST_ACTIVITY DESC";
		ArrayList<MyProjectViewDto> listRet = new ArrayList<MyProjectViewDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, memberIdx);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int projectIdx = rs.getInt("프로젝트번호");
			String projectName = rs.getString("이름");
			int projectColor = rs.getInt("색상");
			MyProjectViewDto dto = new MyProjectViewDto(projectIdx, projectName, projectColor, '0', projectColor, projectColor, '0', '0', projectName);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	//즐겨찾기찾는 문
	public char ProjectFavoritesYN(int projectIdx, int memberIdx) throws Exception {
		String sql = " SELECT FAVORITES_YN" + 
				" FROM PROJECT_MEMBER" + 
				" WHERE project_idx = ?" + 
				" AND participant_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, projectIdx);
		pstmt.setInt(2, memberIdx);
		ResultSet rs = pstmt.executeQuery();
		char favorites_YN = 'N';
		if(rs.next()) {
			favorites_YN = rs.getString(1).charAt(0);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return favorites_YN;
	}
	//프로젝트의 해당멤버의 색상을 찾는 문
	public int ProjectMemberColorView(int memberIdx, int projectIdx) throws Exception {
		String sql = " SELECT PROJECT_COLOR " + 
				" FROM project_member" + 
				" WHERE project_idx = ?" + 
				" AND PARTICIPANT_IDX = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, projectIdx);
		pstmt.setInt(2, memberIdx);
		ResultSet rs = pstmt.executeQuery();
		int color_idx = 0;
		if(rs.next()) {
			color_idx = rs.getInt(1);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return color_idx;
	}
	//해당프로젝트의 참가자 수를 찾는 dao
	public int ProjectParticipantsNum(int projectIdx) throws Exception {
		String sql =" SELECT count(project_idx)" + 
				" from project_member" + 
				" where project_idx = ?" + 
				" group by project_idx";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, projectIdx);
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
	//해당 프로젝트의 수의 종류를 찾는 dao
	public int ProjectAdminCount(int projectIdx,int companyIdx, int category) throws Exception {
		String sql = "";
		if(category == 1) {
			sql = " SELECT COUNT(PROJECT_IDX)" + 
					" FROM PROJECT_MEMBER PM" + 
					" JOIN MEMBERS M" + 
					" ON PM.PARTICIPANT_IDX = M.MEMBER_IDX" + 
					" WHERE PROJECT_IDX =?" + 
					" AND PM.ADMIN_YN = 'Y'";
		}  else if (category == 2) {
			sql = " SELECT COUNT(PROJECT_IDX)" + 
					" FROM PROJECT_MEMBER PM" + 
					" JOIN MEMBERS M" + 
					" ON PM.PARTICIPANT_IDX = M.MEMBER_IDX" + 
					" WHERE PROJECT_IDX =?" + 
					" AND COMPANY_IDX =?" + 
					" AND PM.ADMIN_YN = 'N'";
		} else if (category == 3) {
			sql = " SELECT COUNT(PROJECT_IDX)" + 
					" FROM PROJECT_MEMBER PM" + 
					" JOIN MEMBERS M" + 
					" ON PM.PARTICIPANT_IDX = M.MEMBER_IDX" + 
					" WHERE PROJECT_IDX =?" + 
					" AND COMPANY_IDX !=?" + 
					" AND PM.ADMIN_YN = 'N'";
		}
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, projectIdx);
		if(category == 2 ||category == 3) {
			pstmt.setInt(2, companyIdx);
		} 
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
	public int projectvalue(int participantIdx) throws Exception {
		String sql = "SELECT COUNT(project_idx)" + 
				" from project_member" + 
				" where PARTICIPANT_IDX = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, participantIdx);
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
//	SELECT [MInsuk2] 프로젝트 색상 설정 - (p59)
//	input : int(색상), int(프로젝트idx), int(참가자idx)
//	output : -
	public void colorSetting(int projectColor, int projectIdx, int participantIdx) throws Exception {
		String sql = " UPDATE project_member set project_color = ?"
				+ " WHERE participant_idx = ? AND project_idx = ?";
		
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setInt(1, projectColor);
		pstmt.setInt(2, participantIdx);
		pstmt.setInt(3, projectIdx);
		int num = pstmt.executeUpdate();
		System.out.println(num);
		pstmt.close();
		conn.close();
		
	}

//	[Minsuk3] 프로젝트 폴더 설정 - (p59)
//	input : int(해당 멤버에 일치한 프로젝트 폴더 idx),  int(해당 멤버가 참가한 프로젝트idx)

	public void folderSetting(int folderIdx, int participantIdx, int projectIdx) throws Exception {
		String sql = " INSERT INTO project_folder_Setting values ((select folder_idx from project_folder where member_idx = ? AND folder_idx=?)," + 
				"            (SELECT project_idx from project_member where participant_idx = ? AND project_idx =?))";
		
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
			pstmt.setInt(1, participantIdx);
			pstmt.setInt(2, folderIdx);
			pstmt.setInt(3, participantIdx);
			pstmt.setInt(4, projectIdx);
			pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	//프로젝트 폴더 설정 해제
	public void folderDeleteSetting(int folderIdx, int participantIdx, int projectIdx) throws Exception {
		String sql = " DELETE FROM project_folder_Setting" + 
				" WHERE folder_idx = (SELECT folder_idx " + 
				"                      FROM project_folder " + 
				"                      WHERE member_idx = ? AND folder_idx = ?)" + 
				" AND project_idx = (SELECT project_idx " + 
				"                     FROM project_member " + 
				"                     WHERE participant_idx = ? AND project_idx = ?)";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, participantIdx);
			pstmt.setInt(2, folderIdx);
			pstmt.setInt(3, participantIdx);
			pstmt.setInt(4, projectIdx);
			pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	//개인 프로젝트 폴더 설정 보기
	public ArrayList<MemberProjectFolderDto>folderview(int memberIdx) throws Exception {
		String sql = "SELECT " + 
				"    FOLDER_IDX AS \"폴더IDX\", " + 
				"    MEMBER_IDX AS \"멤버IDX\", " + 
				"    FOLDER_NAME AS \"폴더명\"" + 
				" FROM PROJECT_FOLDER" + 
				" WHERE MEMBER_IDX = ?";
		ArrayList<MemberProjectFolderDto> listRet = new ArrayList<MemberProjectFolderDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, memberIdx);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int folderIdx = rs.getInt("폴더IDX");
			memberIdx = rs.getInt("멤버IDX");
			String folderName = rs.getString("폴더명");
			MemberProjectFolderDto dto = new MemberProjectFolderDto(folderIdx, memberIdx, folderName, 0);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	//폴더중복 안되게 설정상태보기
	public ArrayList<MemberProjectFolderDto>folderviewCheck(int memberIdx, int projectIdx) throws Exception {
		String sql = "SELECT " + 
				"    PFS.PROJECT_IDX AS \"프로젝트IDX\"," + 
				"    PFS.FOLDER_IDX AS \"폴더IDX\"" + 
				" FROM PROJECT_FOLDER_SETTING PFS" + 
				" JOIN PROJECT_FOLDER PF" + 
				" ON PFS.folder_idx = PF.FOLDER_IDX" + 
				" WHERE PF.MEMBER_IDX = ?" + 
				" AND PFS.project_idx = ?";
		ArrayList<MemberProjectFolderDto> listRet = new ArrayList<MemberProjectFolderDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, memberIdx);
		pstmt.setInt(2, projectIdx);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int folderIdx = rs.getInt("폴더IDX");
			projectIdx = rs.getInt("프로젝트IDX");
			MemberProjectFolderDto dto = new MemberProjectFolderDto(folderIdx, memberIdx, "", projectIdx);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	//프로젝트당 폴더 설정상태 보기
	public ArrayList<MemberProjectFolderDto>folderviewChecks(int memberIdx, int projectIdx, int folderIdx) throws Exception {
		String sql = "SELECT " + 
				"    PFS.PROJECT_IDX AS \"프로젝트IDX\"," + 
				"    PFS.FOLDER_IDX AS \"폴더IDX\"" + 
				" FROM PROJECT_FOLDER_SETTING PFS" + 
				" JOIN PROJECT_FOLDER PF" + 
				" ON PFS.folder_idx = PF.FOLDER_IDX" + 
				" WHERE PF.MEMBER_IDX = ?" + 
				" AND PFS.project_idx = ?" + 
				" AND PFS.FOLDER_IDX = ?";
		ArrayList<MemberProjectFolderDto> listRet = new ArrayList<MemberProjectFolderDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, memberIdx);
		pstmt.setInt(2, projectIdx);
		pstmt.setInt(3, folderIdx);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			folderIdx = rs.getInt("폴더IDX");
			projectIdx = rs.getInt("프로젝트IDX");
			MemberProjectFolderDto dto = new MemberProjectFolderDto(folderIdx, memberIdx, "", projectIdx);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
// 프로젝트 인원 검색
	public ArrayList<MemberDto>TaskMemberSearch(int projectIdx, String search) throws Exception {
		String sql = " SELECT DISTINCT M.MEMBER_IDX AS \"멤버IDX\", M.NAME AS \"이름\"" + 
				" FROM MEMBERS M INNER JOIN PROJECT_MEMBER PM" + 
				" ON M.MEMBER_IDX = PM.participant_idx" + 
				" WHERE PM.PROJECT_IDX = ?" + 
				" AND M.NAME LIKE ?";
		ArrayList<MemberDto> listRet = new ArrayList<MemberDto>();
		
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setInt(1,projectIdx);
		pstmt.setString(2, "%"+search+"%");
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int memberIdx = rs.getInt("멤버IDX");
			String name = rs.getString("이름");
			MemberDto dto = new MemberDto(memberIdx,memberIdx, name, name, name, name, name, name, name, name, '1', name, '0' , name, "");
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	public int searchMemberProject(int projectIdx, int memberIdx) throws Exception {
		String sql = " SELECT participant_idx AS \"멤버번호\"" + 
				" FROM PROJECT_MEMBER" + 
				" WHERE project_idx = ?" + 
				" AND participant_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1,projectIdx);
		pstmt.setInt(2,memberIdx);
		ResultSet rs = pstmt.executeQuery();
		int count = 0;
		if(rs.next()) {
			count = rs.getInt("멤버번호");
		}
		rs.close();
		pstmt.close();
		conn.close();
		return count;
	}
//	[Minsuk4] 프로젝트 나가기및 내보내기 - (p66)(p87)
//	input : int(프로젝트_idx), int(참가자idx)
//	output : -
	public void ExitProject(int projectIdx, int participantIdx) throws Exception {
		String sql = "DELETE FROM project_member WHERE project_idx = ? AND participant_idx = ?";
	
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setInt(1, projectIdx);
		pstmt.setInt(2, participantIdx);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
//	[Minsuk5] 프로젝트 수정 - (p67)
//	input : int(프로젝트idx), (수정할 컬럼) (컬럼내용)
//	output : -
	public void ProjectUpdate(String projectName, String projectExplanation, String homeTab, Integer categoryIdx, char approvalYN, int editPostGrant, int writingGrant,
			int commentGrant, int projectIdx, int memberIdx) throws Exception {
	String sql = " UPDATE projects" + 
			" SET project_name = ?, project_explanation = ?," + 
			"    home_tab = ?, category_idx = ?, approval_yn = ?, edit_post_grant = ?, " + 
			"    writing_grant = ?, comment_grant = ? " + 
			" WHERE project_idx = ?" + 
			"    AND EXISTS (" + 
			"        SELECT 1" + 
			"        FROM PROJECT_MEMBER" + 
			"        WHERE project_idx = ?" + 
			"            AND admin_yn = 'Y'" + 
			"            AND PARTICIPANT_IDX = ?" + 
			"    )";
	
			Connection conn = getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, projectName);
			pstmt.setString(2, projectExplanation);
			pstmt.setString(3, homeTab);
			if(categoryIdx==null || categoryIdx==0) {
				pstmt.setNull(4, Types.NUMERIC);
			}
			else {
				pstmt.setInt(4, categoryIdx);
			}
			pstmt.setString(5,String.valueOf(approvalYN));
			pstmt.setInt(6,editPostGrant);
			pstmt.setInt(7,writingGrant);
			pstmt.setInt(8,commentGrant);
			pstmt.setInt(9,projectIdx);
			pstmt.setInt(10,projectIdx);
			pstmt.setInt(11,memberIdx);
			pstmt.executeUpdate();
			pstmt.close();
			conn.close();
	}
//	[Minsuk46] 프로젝트 삭제 - (p66)
//	input : int(프로젝트_idx), int(참가자idx)
//	output : -
	public void DeleteProject(int projectIdx) throws Exception {
		String sql = "UPDATE PROJECTS SET DELETE_YN = 'Y' WHERE PROJECT_IDX = ?";
	
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, projectIdx);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
//	[Minsuk7] 프로젝트 초대 - (p69)
//	input : int(프로젝트idx), int(멤버idx)
//	output : - 
	public ArrayList<ColorandPublicDto> searchColorAndCategory(int memberIdx, int projectIdx) throws Exception {
		String sql = " SELECT m.project_color_fix AS \"색상 설정\", p.approval_yn AS \"관리자승인\"" + 
				" FROM   members m, projects p" + 
				" WHERE  member_idx = ? and project_idx = ?";
		ArrayList<ColorandPublicDto> listRet = new ArrayList<ColorandPublicDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, memberIdx);
		pstmt.setInt(2, projectIdx);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			char projectColorFix = rs.getString("색상 설정").charAt(0);
			char approvalYN = rs.getString("관리자승인").charAt(0);
			ColorandPublicDto dto = new ColorandPublicDto(projectColorFix,approvalYN);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
//	[Minsuk7-1] 프로젝트 초대할 멤버 검색 - 임직원
//	input : int(회사idx), String(검색어)
//	output : - 
	public ArrayList<ProjectInviteViewDto>ProjectInviteViewEmployees(int companyIdx, String name) throws Exception {
		String sql = "SELECT  " + 
				"        M.MEMBER_IDX AS \"멤버번호\", " + 
				"        M.profile_img AS \"프로필 이미지 주소\", " + 
				"        M.NAME AS \"이름\"," + 
				"        M.position AS \"직책\", " + 
				"        C.company_name AS \"회사명\", " + 
				"        d.department_name AS \"부서명\"" + 
				" FROM MEMBERS M " + 
				" INNER JOIN COMPANIES C" + 
				" ON M.COMPANY_IDX = C.COMPANY_IDX " + 
				" INNER JOIN departments d" + 
				" ON M.department_idx = d.department_idx" + 
				" WHERE   c.company_idx = ?" + 
				" AND     M.NAME LIKE ?";
		ArrayList<ProjectInviteViewDto> listRet = new ArrayList<ProjectInviteViewDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, companyIdx);
		pstmt.setString(2, "%"+name+"%");
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int memberIdx = rs.getInt("멤버번호");
			String profileImg = rs.getString("프로필 이미지 주소");
			name = rs.getString("이름");
			String position = rs.getString("직책");
			String companyName = rs.getString("회사명");
			String departmentName = rs.getString("부서명");
			ProjectInviteViewDto dto = new ProjectInviteViewDto(memberIdx, profileImg, name, position, companyName, departmentName, departmentName);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
//	[Minsuk7-2] 프로젝트 초대할 멤버  - 외부인
//	input : int(회사idx), String(검색어)
//	output : - 
	public ArrayList<ProjectInviteViewDto>ProjectInviteViewOutsider(int companyIdx, String name) throws Exception {
		String sql = "SELECT DISTINCT  " + 
				"        M.MEMBER_IDX AS \"멤버번호\", " + 
				"        M.profile_img AS \"프로필 이미지 주소\", " + 
				"        M.NAME AS \"이름\"," + 
				"        M.position AS \"직책\", " + 
				"        C.company_name AS \"회사명\", " + 
				"        D.department_name AS \"부서명\"" + 
				" FROM MEMBERS M " + 
				" INNER JOIN COMPANIES C" + 
				"    ON M.COMPANY_IDX = C.COMPANY_IDX " + 
				" LEFT JOIN DEPARTMENTS D" + 
				"    ON M.department_idx = D.department_idx " + 
				" INNER JOIN PROJECT_MEMBER PM" + 
				"    ON M.MEMBER_IDX = PM.participant_idx" + 
				" INNER JOIN PROJECTS P" + 
				"    ON PM.project_idx = P.project_idx" + 
				" WHERE M.company_idx != ? " + 
				" AND M.NAME LIKE ?" + 
				" AND EXISTS (" + 
				"    SELECT 1" + 
				"    FROM PROJECTS P_SUB" + 
				"    INNER JOIN PROJECT_MEMBER PM_SUB" + 
				"        ON P_SUB.project_idx = PM_SUB.project_idx" + 
				"    WHERE P_SUB.company_idx = ?" + 
				"    AND PM_SUB.participant_idx = M.MEMBER_IDX" + 
				" )";
		ArrayList<ProjectInviteViewDto> listRet = new ArrayList<ProjectInviteViewDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, companyIdx);
		pstmt.setString(2, "%"+name+"%");
		pstmt.setInt(3, companyIdx);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int memberIdx = rs.getInt("멤버번호");
			String profileImg = rs.getString("프로필 이미지 주소");
			name = rs.getString("이름");
			String position = rs.getString("직책");
			String companyName = rs.getString("회사명");
			String departmentName = rs.getString("부서명");
			if(departmentName == null) {
				departmentName = "";
			}
			if(position == null) {
				position = "";
			}
			ProjectInviteViewDto dto = new ProjectInviteViewDto(memberIdx, profileImg, name, position, companyName, departmentName, departmentName);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	public void inviteProject(int projectIdx, int participantIdx, int projectColor, char stateYN, String entryDate ) throws Exception {
		
		
		String sql = "INSERT INTO project_member(project_idx,participant_idx,project_color,state_yn,entry_date)" + 
				" values (?,?,?,?,"+entryDate+")";
		
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setInt(1, projectIdx);
		pstmt.setInt(2, participantIdx);
		pstmt.setInt(3, projectColor);
		pstmt.setString(4, String.valueOf(stateYN));
		//pstmt.setString(5, entryDate);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
//	[Minsuk20] 프로젝트 참가 멤버 - (p86)- 어드민
//	input : int(프로젝트idx)
//	output : project_member테이블에서 입력한 프로젝트idx와 같고 프로젝트 참가 상태가 y인 인원만 출력.
//	SELECT * FROM project_member
	public ArrayList<ProjectMemberViewDto>ProjectMemberViewAdmin(int projectIdx) throws Exception {
			String sql = " SELECT " + 
					"    m.member_idx AS 멤버IDX," + 
					"    m.name AS 이름," + 
					"    m.profile_img AS \"프로필\"," + 
					"    c.company_idx AS 회사번호," + 
					"    c.company_name AS 회사명," + 
					"    m.position AS 직책," + 
					"    d.department_name AS 부서명," + 
					"    pm.admin_yn AS 어드민여부" + 
					" FROM " + 
					"    members m" + 
					" JOIN " + 
					"    companies c ON m.company_idx = c.company_idx" + 
					" LEFT JOIN " + 
					"    departments d ON m.department_idx = d.department_idx" + 
					" JOIN " + 
					"    project_member pm ON pm.participant_idx = m.member_idx" + 
					" WHERE " + 
					"    pm.project_idx = ?" + 
					"    AND pm.admin_yn = 'Y'" + 
					"    AND pm.state_yn = 'Y'";
		ArrayList<ProjectMemberViewDto> listRet = new ArrayList<ProjectMemberViewDto>();
		
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, projectIdx);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			String profile = rs.getString("프로필");
			String name = rs.getString("이름");
			String companyName = rs.getString("회사명");
			String position = rs.getString("직책");
			String departmentName = rs.getString("부서명");
			if(departmentName == null) {
				departmentName = "";
			}
			if(position == null) {
				position = "";
			}
			ProjectMemberViewDto dto = new ProjectMemberViewDto(0,name,0, companyName, position, departmentName, '0',profile);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	//어드민 여부찾기 
	public ArrayList<ProjectMemberViewDto>participantselect(int projectIdx) throws Exception {
		String sql = " SELECT " + 
				"    m.member_idx AS 멤버IDX," + 
				"    m.name AS 이름, " + 
				"        m.profile_img AS \"프로필\"," + 
				"    c.company_idx AS 회사번호, " + 
				"    c.company_name AS 회사명, " + 
				"    m.position AS 직책, " + 
				"    d.department_name AS 부서명," + 
				"    pm.admin_yn AS 어드민여부" + 
				"	FROM members m" + 
				"	JOIN companies c ON m.company_idx = c.company_idx" + 
				"	LEFT JOIN departments d ON m.department_idx = d.department_idx" + 
				"	JOIN project_member pm ON pm.participant_idx = m.member_idx" + 
				"	WHERE pm.project_idx = ?";
		ArrayList<ProjectMemberViewDto> listRet = new ArrayList<ProjectMemberViewDto>();
		
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, projectIdx);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			String profile = rs.getString("프로필");
			int memberIdx = rs.getInt("멤버IDX");
			String name = rs.getString("이름");
			String companyName = rs.getString("회사명");
			String position = rs.getString("직책");
			String departmentName = rs.getString("부서명");
			char adminYN = rs.getString("어드민여부").charAt(0);
			if(departmentName == null) {
				departmentName = "";
			}
			if(position == null) {
				position = "";
			}
			ProjectMemberViewDto dto = new ProjectMemberViewDto(memberIdx,name,0, companyName, position, departmentName, adminYN,profile);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	public ProjectMemberViewDto participantselectMY(int projectIdx, int memberIdx) throws Exception {
		String sql = " SELECT " + 
				"    m.member_idx AS 멤버IDX," + 
				"    m.name AS 이름, " + 
				"    c.company_idx AS 회사번호, " + 
				"    c.company_name AS 회사명, " + 
				"    m.position AS 직책, " + 
				"    d.department_name AS 부서명," + 
				"    pm.admin_yn AS 어드민여부" + 
				"	FROM members m" + 
				"	JOIN companies c ON m.company_idx = c.company_idx" + 
				"	LEFT JOIN departments d ON m.department_idx = d.department_idx" + 
				"	JOIN project_member pm ON pm.participant_idx = m.member_idx" + 
				"	WHERE pm.project_idx = ?" + 
				"    AND m.member_idx = ?";
		ProjectMemberViewDto dto = null;
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, projectIdx);
		pstmt.setInt(2, memberIdx);
		ResultSet rs = pstmt.executeQuery();
		if(rs.next()) {
			memberIdx = rs.getInt("멤버IDX");
			String name = rs.getString("이름");
			int companyIdx = rs.getInt("회사번호");
			String companyName = rs.getString("회사명");
			String position = rs.getString("직책");
			String departmentName = rs.getString("부서명");
			char adminYN = rs.getString("어드민여부").charAt(0);
			dto = new ProjectMemberViewDto(memberIdx,name,companyIdx, companyName, position, departmentName, adminYN,departmentName);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return dto;
	}
//	[Minsuk20] 프로젝트 참가 멤버 - (p86)- 어드민X
	public ArrayList<ProjectMemberViewDto>ProjectMemberViewNonAdmin(int projectIdx) throws Exception {
		String sql = " SELECT m.name AS \"이름\", c.company_name AS \"회사명\", m.position AS \"직책\", d.department_name AS \"부서명\"" + 
				" FROM members m , companies c, departments d, project_member pm" + 
				" where m.company_idx= c.company_idx" + 
				" AND m.department_idx = d.department_idx" + 
				" AND pm.participant_idx = m.member_idx" + 
				" AND pm.project_idx = ?" + 
				" AND pm.admin_yn = 'N'" + 
				" AND pm.state_yn = 'Y'";
		ArrayList<ProjectMemberViewDto> listRet = new ArrayList<ProjectMemberViewDto>();
		
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, projectIdx);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			String name = rs.getString("이름");
			String companyName = rs.getString("회사명");
			String position = rs.getString("직책");
			String departmentName = rs.getString("부서명");
			
			ProjectMemberViewDto dto = new ProjectMemberViewDto(0,name,0, companyName, position, departmentName, '0',departmentName);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
//	[Minsuk21] 프로젝트 어드민 - (p87)
//	input : int(멤버idx), char(어드민 여부), int(프로젝트idx)
//	output : -
	public void UPDATEProjectAdmin(char adminYN,int projectIdx,int participantIdx) throws Exception {
		String sql = "UPDATE project_member set admin_yn = ? WHERE project_idx = ? "
				+ " AND participant_idx = ?"; 
		
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, String.valueOf(adminYN));
		pstmt.setInt(2, projectIdx);
		pstmt.setInt(3, participantIdx);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	//즐겨찾기 업데이트문
	public void UPDATEprojectFavorites(char favoritesYN, int participantIdx, int projectIdx) throws Exception {
		String sql = " UPDATE project_member set FAVORITES_YN = ?" + 
				" WHERE PARTICIPANT_IDX = ?" + 
				" AND PROJECT_IDX = ?";
		
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, String.valueOf(favoritesYN));
		pstmt.setInt(2, participantIdx);
		pstmt.setInt(3, projectIdx);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
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
				" LEFT JOIN departments d" + 
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
			if(departmentName == null) {
				departmentName = "";
			}
			if(position == null) {
				position = "";
			}
			ProjectMemberListDto dto = new ProjectMemberListDto(memberIdx, companyName, memberName, position, departmentName, prof, attendYN);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	public ArrayList<ProjectUserFolder> ProjectUserFolderList(int memberIdx) throws Exception {
		String sql = " SELECT FOLDER_IDX AS \"폴더번호\",FOLDER_NAME AS \"폴더이름\"" + 
				" FROM PROJECT_FOLDER" + 
				" WHERE MEMBER_IDX = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, memberIdx);
		ResultSet rs = pstmt.executeQuery();
		ArrayList<ProjectUserFolder> listRet = new ArrayList<ProjectUserFolder>();
		while(rs.next()) {
			int folderIdx = rs.getInt("폴더번호");
			String name = rs.getString("폴더이름");
			ProjectUserFolder dto = new ProjectUserFolder(folderIdx,name);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	public ProjectUserFolder ProjectUserFolderOne(int folderIdx) throws Exception {
		String sql = " SELECT FOLDER_IDX AS \"폴더번호\",FOLDER_NAME AS \"폴더이름\"" + 
				" FROM PROJECT_FOLDER" + 
				" WHERE FOLDER_IDX = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, folderIdx);
		ResultSet rs = pstmt.executeQuery();
		ProjectUserFolder dto = null;
		if(rs.next()) {
			folderIdx = rs.getInt("폴더번호");
			String name = rs.getString("폴더이름");
			dto = new ProjectUserFolder(folderIdx,name);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return dto;
	}
	public void ProjectUpdate(int projectIdx) throws Exception {
		String sql = "UPDATE PROJECTS SET last_activity = SYSDATE WHERE PROJECT_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, projectIdx);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	public void ProjectFolder(String title, int memberIdx) throws Exception {
		String sql = "INSERT INTO PROJECT_FOLDER VALUES(SEQ_PROJECT_FOLDER_IDX.nextval,?,?)";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, memberIdx);
		pstmt.setString(2, title);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	public int ProjectFolderIdx() throws Exception {
		String sql = "SELECT LAST_NUMBER FROM user_sequences WHERE sequence_name = 'SEQ_PROJECT_FOLDER_IDX'";
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
	public void ProjectFolderUpdate(int folderIdx, String title) throws Exception {
		String sql = "UPDATE PROJECT_FOLDER SET folder_name = ? WHERE folder_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, title);
		pstmt.setInt(2, folderIdx);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	public void ProjectFolderDelete(int folderIdx) throws Exception {
		String sql = "DELETE FROM PROJECT_FOLDER WHERE folder_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, folderIdx);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	public int ProjectFolderCount(int folderIdx) throws Exception {
		String sql = " SELECT COUNT(project_idx)" + 
				" FROM PROJECT_FOLDER_SETTING" + 
				" where folder_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, folderIdx);
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
	public int MyProjectCount(int memberIdx) throws Exception {
		String sql = " SELECT COUNT(participant_idx)" + 
				" FROM PROJECT_MEMBER" + 
				" WHERE participant_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, memberIdx);
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
	public static void main(String[] args) throws Exception{
			ProjectALLDao Dao = new ProjectALLDao();
			ArrayList<ProjectMemberListDto> list2 =  Dao.getProjectMemberList(1);
//			Dao.UPDATEprojectFavorites('Y', 1, 1);
//			MyProjectViewDto dto = Dao.ProjectCategory(1);
//			System.out.println(dto.getHometab());
		
	}
}

