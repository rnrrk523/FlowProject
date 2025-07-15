package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Types;
import java.util.ArrayList;

import dto.BoardCommentViewDto;
import dto.BoardEmotionDto;
import dto.BoardPostViewDto;
import dto.BoardScheduleDto;
import dto.BoardTopFixedDto;
import dto.BoardWorkViewDto;
import dto.MyProjectViewDto;
import dto.MyboardViewTaskDto;
import dto.ProjectInviteViewDto;
import dto.ProjectfilterDto;
import dto.ScheduleCountDto;
import dto.TaskManagerDto;

public class BoardALLDao {
	public Connection getConnection() throws Exception {
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@//114.207.245.107:1521/XE";
		String id = "FLOW";
		String pw = "1234";
		
		Class.forName(driver);
		Connection conn = DriverManager.getConnection(url, id, pw);
		
		return conn;
	}
//	[Minsuk8] 게시물 상단고정 - (p72)
//	input : int(게시물idx),
//	output : -
	public void boardTopFix(char TopFixed,int boardIdx) throws Exception {
		String sql = "UPDATE BOARD SET Top_fixed = ? WHERE BOARD_IDX = ?";
		
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1,String.valueOf(TopFixed));
		pstmt.setInt(2,boardIdx);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
// 프로젝트 내에 상단고정 게시글 수
	public int TopFixedCount(int projectIdx) throws Exception {
		String sql = " SELECT COUNT(BOARD_IDX)" + 
				" FROM BOARD" + 
				" WHERE PROJECT_IDX = ?" + 
				" AND TOP_FIXED = 'Y'";
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
// 상단고정 게시글 게시글 유형 출력
	public ArrayList<BoardTopFixedDto> BoardTopFixCategory(int projectIdx) throws Exception {
		String sql = " SELECT board_idx AS \"게시글번호\", category AS \"유형\" " + 
				" FROM BOARD" + 
				" WHERE PROJECT_IDX = ?" + 
				" AND TOP_FIXED = 'Y'" + 
				" ORDER BY BOARD_IDX DESC";
		ArrayList<BoardTopFixedDto> listRet = new ArrayList<BoardTopFixedDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, projectIdx);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int boardIdx = rs.getInt("게시글번호");
			String category = rs.getString("유형");
			BoardTopFixedDto dto = new BoardTopFixedDto(category, boardIdx, boardIdx, category, category, boardIdx, boardIdx, boardIdx, '0', category);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	public BoardTopFixedDto BoardTopFixCategoryOne(int boardIdx) throws Exception {
		String sql = " SELECT board_idx AS \"게시글번호\", category AS \"유형\" " + 
				" FROM BOARD" + 
				" WHERE board_IDX = ?" + 
				" AND TOP_FIXED = 'Y'" + 
				" ORDER BY BOARD_IDX DESC";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, boardIdx);
		ResultSet rs = pstmt.executeQuery();
		BoardTopFixedDto dto = null;
		if(rs.next()) {
			boardIdx = rs.getInt("게시글번호");
			String category = rs.getString("유형");
			dto = new BoardTopFixedDto(category, boardIdx, boardIdx, category, category, boardIdx, boardIdx, boardIdx, '0', category);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return dto;
	}
// 상단고정 게시글조회 글/업무/일정/할일/투표
	public BoardTopFixedDto BoardTopFixView(int boardIdx, String category) throws Exception {
		String sql = "";
		if(category.equals("글")) {
			sql = " SELECT TITLE AS \"제목\",BOARD_IDX AS \"게시글 번호\"" + 
					" FROM BOARD " + 
					" WHERE TOP_FIXED = 'Y'" + 
					" AND board_IDX = ?" + 
					" AND category = '글'";
		}
		if(category.equals("업무")) {
			sql = " SELECT B.TITLE AS \"제목\", B.BOARD_IDX AS \"게시글 번호\",T.STATE \"업무상태\"" + 
					" FROM BOARD B" + 
					" JOIN TASK T" + 
					" ON B.BOARD_IDX = T.BOARD_IDX" + 
					" WHERE B.TOP_FIXED = 'Y'" + 
					" AND B.board_IDX = ?" + 
					" AND category = '업무'";
		}
		if(category.equals("일정")) {
			sql = " SELECT B.TITLE AS \"제목\", B.BOARD_IDX AS \"게시글 번호\",START_DATE AS \"시작일\", END_DATE AS \"마감일\"" + 
					" FROM BOARD B" + 
					" JOIN SCHEDULE S" + 
					" ON B.BOARD_IDX = S.BOARD_IDX" + 
					" WHERE B.TOP_FIXED = 'Y'" + 
					" AND B.board_IDX = ?" + 
					" AND category = '일정'";
		}
		if(category.equals("할일")) {
			sql = " WITH BoardWork AS (" + 
					"    SELECT " + 
					"        B.BOARD_IDX, " + 
					"        B.TITLE," + 
					"        W.WORK_IDX, " + 
					"        COUNT(WC.WORK_COMPLE_YN) AS total_count," + 
					"        COUNT(CASE WHEN WC.WORK_COMPLE_YN = 'Y' THEN 1 END) AS completed_count" + 
					"    FROM " + 
					"        BOARD B" + 
					"    JOIN " + 
					"        WORK W ON B.BOARD_IDX = W.BOARD_IDX" + 
					"    LEFT JOIN " + 
					"        WORK_MEMBER_CONTENT WC ON W.WORK_IDX = WC.WORK_IDX" + 
					"    WHERE " + 
					"        B.TOP_FIXED = 'Y'" + 
					"        AND B.board_IDX = ?" + 
					"        AND B.CATEGORY = '할일'" + 
					"    GROUP BY " + 
					"        B.BOARD_IDX, B.TITLE, W.WORK_IDX" + 
					" )" + 
					" " + 
					" SELECT " + 
					"    TITLE AS \"제목\"," + 
					"    BOARD_IDX AS \"게시글 번호\"," + 
					"    total_count AS \"할일수\"," + 
					"    completed_count AS \"완료된 할일수\"," + 
					"    FLOOR(completed_count * 100.0 / total_count) AS \"완료율\"" + 
					" FROM " + 
					"    BoardWork";
		}
		BoardTopFixedDto dto = null;
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, boardIdx);
		ResultSet rs = pstmt.executeQuery();
		if(category.equals("글")) {
			while(rs.next()) {
				String title = rs.getString("제목");
				boardIdx = rs.getInt("게시글 번호");
				dto = new BoardTopFixedDto(title, boardIdx, boardIdx, title, title, boardIdx, boardIdx, boardIdx, '0', title);
				
			}
		}
		if(category.equals("업무")) {
			while(rs.next()) {
				String title = rs.getString("제목");
				boardIdx = rs.getInt("게시글 번호");
				int state = rs.getInt("업무상태");
				dto = new BoardTopFixedDto(title, boardIdx, state, title, title, state, state, state, '0', title);
				
			}
		}
		if(category.equals("일정")) {
			while(rs.next()) {
				String title = rs.getString("제목");
				boardIdx = rs.getInt("게시글 번호");
				String startDate = rs.getString("시작일");
				String endDate = rs.getString("마감일");
				dto = new BoardTopFixedDto(title, boardIdx, boardIdx, startDate, endDate, boardIdx, boardIdx, boardIdx, '0', title);
				
			}
		}
		if(category.equals("할일")) {
			while(rs.next()) {
				String title = rs.getString("제목");
				boardIdx = rs.getInt("게시글 번호");
				int totalCount = rs.getInt("할일수");
				int completedCount = rs.getInt("완료된 할일수");
				int completePercent = rs.getInt("완료율");
				dto = new BoardTopFixedDto(title, boardIdx, completePercent, title, title, totalCount, completedCount, completePercent, '0', title);
			}
		}
		rs.close();
		pstmt.close();
		conn.close();
		return dto;
	}
	public BoardTopFixedDto BoardTopFixViewOne(int boardIdx, String category) throws Exception {
		String sql = "";
		if(category.equals("글")) {
			sql = " SELECT TITLE AS \"제목\",BOARD_IDX AS \"게시글 번호\"" + 
					" FROM BOARD " + 
					" WHERE TOP_FIXED = 'Y'" + 
					" AND BOARD_IDX = ?" + 
					" AND category = '글'";
		}
		if(category.equals("업무")) {
			sql = " SELECT B.TITLE AS \"제목\", B.BOARD_IDX AS \"게시글 번호\",T.STATE \"업무상태\"" + 
					" FROM BOARD B" + 
					" JOIN TASK T" + 
					" ON B.BOARD_IDX = T.BOARD_IDX" + 
					" WHERE B.TOP_FIXED = 'Y'" + 
					" AND B.BOARD_IDX = ?" + 
					" AND category = '업무'";
		}
		if(category.equals("일정")) {
			sql = " SELECT B.TITLE AS \"제목\", B.BOARD_IDX AS \"게시글 번호\",START_DATE AS \"시작일\", END_DATE AS \"마감일\"" + 
					" FROM BOARD B" + 
					" JOIN SCHEDULE S" + 
					" ON B.BOARD_IDX = S.BOARD_IDX" + 
					" WHERE B.TOP_FIXED = 'Y'" + 
					" AND B.BOARD_IDX = ?" + 
					" AND category = '일정'";
		}
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, boardIdx);
		ResultSet rs = pstmt.executeQuery();
		BoardTopFixedDto dto = null;
		if(category.equals("글")) {
			if(rs.next()) {
				String title = rs.getString("제목");
				boardIdx = rs.getInt("게시글 번호");
				dto = new BoardTopFixedDto(title, boardIdx, boardIdx, title, title, boardIdx, boardIdx, boardIdx, '0', title);
			}
		}
		if(category.equals("업무")) {
			if(rs.next()) {
				String title = rs.getString("제목");
				boardIdx = rs.getInt("게시글 번호");
				int state = rs.getInt("업무상태");
				dto = new BoardTopFixedDto(title, boardIdx, state, title, title, state, state, state, '0', title);
			}
		}
		if(category.equals("일정")) {
			if(rs.next()) {
				String title = rs.getString("제목");
				boardIdx = rs.getInt("게시글 번호");
				String startDate = rs.getString("시작일");
				String endDate = rs.getString("마감일");
				dto = new BoardTopFixedDto(title, boardIdx, boardIdx, startDate, endDate, boardIdx, boardIdx, boardIdx, '0', title);
			}
		}
		rs.close();
		pstmt.close();
		conn.close();
		return dto;
	}
	// 프로젝트내의 게시글 수
	public int boardCount(int projectIdx) throws Exception {
		String sql = " SELECT COUNT(BOARD_IDX)" + 
				" FROM BOARD" + 
				" WHERE PROJECT_IDX = ?";
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
//	[Minsuk9] 글 수정 - (p73) (기본 글)
//	input : int(게시물idx) String(게시물 제목) String(게시물 내용) char(공개 여부) 
//	output : -

	public void boardUpdate(int boardIdx, String title, String content, char releaseYN)throws Exception {
		String sql = "UPDATE BOARD SET TITLE = ?, CONTENT = ?, release_yn = ?" + 
				" WHERE BOARD_IDX = ?";
		
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, title);
		pstmt.setString(2, content);
		pstmt.setString(3, String.valueOf(releaseYN));
		pstmt.setInt(4, boardIdx);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
//	[Minsuk12] 게시글 삭제 - (p78)
//	input : int(게시물idx)
//	output : -
	public void boardDelete(int boardIdx) throws Exception {
		String sql = "DELETE FROM BOARD WHERE BOARD_IDX = ?";
		
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, boardIdx);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
//	[Minsuk13] 게시글 필터 - (p79)
//	input : int(프로젝트idx),String(카테고리)
//	output : 입력한 프로젝트 안의 게시물을 입력한 카테고리와 같은 카테고리의 게시물만 출력
//	SELECT * 
//	FROM BOARD
//	WHERE PROJECT_IDX = (입력한 프로젝트IDX) AND CATEGORY = ‘입력한 카테고리명’;
	public ArrayList<ProjectfilterDto>optionProjectFilter(int ProjectIdx, String category) throws Exception {
		String sql = "SELECT * " + 
				"	FROM BOARD" + 
				"	WHERE PROJECT_IDX = ? AND CATEGORY = ?";
		ArrayList<ProjectfilterDto> listRet = new ArrayList<ProjectfilterDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, ProjectIdx);
		pstmt.setString(2, category);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int projectIdx = rs.getInt("project_idx");
			int writerIdx = rs.getInt("writer_idx");
			String title = rs.getString("title");
			String content = rs.getString("content");
			category = rs.getString("category");
			char topFixed = rs.getString("Top_fixed").charAt(0);
			char temporaryStorage = rs.getString("Temporary_Storage").charAt(0);
			String writeDate = rs.getString("write_date");
			ProjectfilterDto dto = new ProjectfilterDto(projectIdx, writerIdx, title, content, category, topFixed, temporaryStorage, writeDate);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}

//	[Minsuk14] 북마크 - (p81)
//	input : int(게시물idx), int(멤버idx)
//	output : -
//	INSERT INTO BOARD_BOOKMARK VALUES((입력한 멤버IDX), (입력한 게시물IDX));
	public void ADDBookmark(int boardIdx, int memberIdx) throws Exception {
		String sql = "INSERT INTO BOARD_BOOKMARK VALUES(?,?)";
		
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, memberIdx);
		pstmt.setInt(2, boardIdx);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
//  북마크 삭제문
	public void RemoveBookmark(int boardIdx, int memberIdx) throws Exception {
		String sql = " DELETE FROM BOARD_BOOKMARK WHERE board_idx = ? AND member_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, boardIdx);
		pstmt.setInt(2, memberIdx);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	//북마크 조회문 
	public int bookmarkView(int boardIdx, int memberIdx) throws Exception {
		String sql = " SELECT count(board_idx)" + 
				" FROM BOARD_BOOKMARK" + 
				" WHERE BOARD_IDX = ?" + 
				" AND MEMBER_IDX = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, boardIdx);
		pstmt.setInt(2, memberIdx);
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
//	[Minsuk15] 좋아요 -(p81)
//	input : int(게시물idx), int(멤버idx), int(게시글 이모티콘 종류)
//	output : - 
	public void boardEmotion(int boardIdx, int memberIdx, int emotionType) throws Exception {
		String sql = "INSERT INTO BOARD_EMOTION VALUES(BOARD_EMOTION_UP.nextval,?,?,?)";
		
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, boardIdx);
		pstmt.setInt(2, emotionType);
		pstmt.setInt(3, memberIdx);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
// 좋아요 삭제문
	public void boardEmotiondel(int boardIdx, int memberIdx) throws Exception {
		String sql = " DELETE FROM BOARD_EMOTION WHERE board_idx=? AND MEMBER_IDX = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, boardIdx);
		pstmt.setInt(2, memberIdx);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	//좋아요 생성시 내가 생성한 좋아요 확인문
	public BoardEmotionDto MyAddEmotionCheck(int boardIdx, int memberIdx) throws Exception {
		String sql = "SELECT M.NAME AS \"이름\", BE.emotion_TYPE AS \"이모티콘종류\"" + 
				"   FROM BOARD_EMOTION BE" + 
				"    JOIN MEMBERS M" + 
				"    ON BE.MEMBER_IDX = M. MEMBER_IDX" + 
				"    WHERE BOARD_IDX = ?" + 
				"    AND M.MEMBER_IDX =?" + 
				"    ORDER BY BOARD_IDX";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, boardIdx);
		pstmt.setInt(2, memberIdx);
		ResultSet rs = pstmt.executeQuery();
		BoardEmotionDto dto = null;
		if(rs.next()) {
			String Name = rs.getString("이름");
			int emotionType = rs.getInt("이모티콘종류");
			dto = new BoardEmotionDto(emotionType, Name, Name, emotionType, emotionType);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return dto;
	}
	//한 게시글의 좋아요 이모션별의 숫자
	public ArrayList<BoardEmotionDto> boardEmotionvalueCount(int boardIdx) throws Exception {
		String sql = " SELECT " + 
				"    e.EMOTION_TYPE AS \"이모션번호\"," + 
				"    COUNT(be.EMOTION_TYPE) AS \"이모션별수\"" + 
				" FROM " + 
				"    (SELECT 1 AS EMOTION_TYPE FROM DUAL UNION ALL" + 
				"     SELECT 2 FROM DUAL UNION ALL" + 
				"     SELECT 3 FROM DUAL UNION ALL" + 
				"     SELECT 4 FROM DUAL UNION ALL" + 
				"     SELECT 5 FROM DUAL) e" + 
				" LEFT JOIN BOARD_EMOTION be" + 
				"    ON e.EMOTION_TYPE = be.EMOTION_TYPE" + 
				"    AND be.BOARD_IDX = ?" + 
				" GROUP BY e.EMOTION_TYPE" + 
				" ORDER BY e.EMOTION_TYPE";
		ArrayList<BoardEmotionDto> listRet = new ArrayList<BoardEmotionDto>(); 
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, boardIdx);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int emotionType = rs.getInt("이모션번호");
			int countemotion = rs.getInt("이모션별수");
			BoardEmotionDto dto = new BoardEmotionDto(0, null, null, emotionType, countemotion);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
//	[Minsuk17] 게시글 읽음 여부 - (p84)
//	input : int(게시물idx), int(멤버idx)
//	output : -
	public void boardReadOrNot(int boardIdx, int memberIdx) throws Exception {
		String sql = "INSERT INTO READ_OR_NOT VALUES (?,?,sysdate)";
		
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setInt(1, boardIdx);
		pstmt.setInt(2, memberIdx);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	// 기본 읽음 조회 
	public ArrayList<ProjectInviteViewDto>ReadMember(int boardIdx) throws Exception {
		String sql = "SELECT DISTINCT  M.MEMBER_IDX AS \"멤버번호\", " + 
				"        M.profile_img AS \"프로필 이미지 주소\", " + 
				"        M.NAME AS \"이름\"," + 
				"        M.position AS \"직책\", " + 
				"        C.company_name AS \"회사명\", " + 
				"        D.department_name AS \"부서명\"," + 
				"        R.READ_DATE AS \"읽은날짜\"" + 
				" FROM MEMBERS M " + 
				" INNER JOIN COMPANIES C" + 
				"    ON M.COMPANY_IDX = C.COMPANY_IDX " + 
				" LEFT JOIN DEPARTMENTS D" + 
				"    ON M.department_idx = D.department_idx " + 
				" INNER JOIN READ_OR_NOT R" + 
				"    ON M.member_idx = R.member_idx " + 
				" INNER JOIN board b" + 
				"    ON R.board_idx = b.board_idx" + 
				" INNER JOIN projects p" + 
				"    ON p.project_idx = b.project_idx" + 
				" INNER JOIN PROJECT_MEMBER PM" + 
				"    ON M.MEMBER_IDX = PM.participant_idx" + 
				" WHERE  b.board_idx = ?";
		ArrayList<ProjectInviteViewDto> listRet = new ArrayList<ProjectInviteViewDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, boardIdx);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int memberIdx = rs.getInt("멤버번호");
			String profileImg = rs.getString("프로필 이미지 주소");
			String name = rs.getString("이름");
			String position = rs.getString("직책");
			String companyName = rs.getString("회사명");
			String departmentName = rs.getString("부서명");
			String readDate = rs.getString("읽은날짜");
			if(departmentName == null) {
				departmentName = "";
			}
			if(position == null) {
				position = "";
			}
			ProjectInviteViewDto dto = new ProjectInviteViewDto(memberIdx, profileImg, name, position, companyName, departmentName, readDate);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	//읽은사람 수 조회
	public int ReadMemberCount(int boardIdx) throws Exception {
		String sql = "SELECT COUNT(BOARD_IDX) " + 
				"     FROM READ_OR_NOT " + 
				"     WHERE BOARD_IDX = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, boardIdx);
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
	//안읽은 사람 수 조회
	public int NonReadMemberCount(int projectIdx, int boardIdx) throws Exception {
		String sql = "SELECT " + 
				"    (SELECT COUNT(PROJECT_IDX) " + 
				"     FROM PROJECT_MEMBER " + 
				"     WHERE PROJECT_IDX = ?) -" + 
				"    (SELECT COUNT(BOARD_IDX) " + 
				"     FROM READ_OR_NOT " + 
				"     WHERE BOARD_IDX = ?) " + 
				"     AS result" + 
				" FROM DUAL";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, projectIdx);
		pstmt.setInt(2, boardIdx);
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
//	[Minsuk17-1] 게시글 읽음 검색 -읽은사람
//	input : int(게시물idx), string(검색어), int(프로젝트idx)
//	output : 해당 게시물에 읽은 인원 검색어에 따라 출력
	public ArrayList<ProjectInviteViewDto>ReadMembersearchview(int boardIdx, String name) throws Exception {
		String sql = "SELECT DISTINCT  M.MEMBER_IDX AS \"멤버번호\", " + 
				"        M.profile_img AS \"프로필 이미지 주소\", " + 
				"        M.NAME AS \"이름\"," + 
				"        M.position AS \"직책\", " + 
				"        C.company_name AS \"회사명\", " + 
				"        D.department_name AS \"부서명\"," + 
				"        R.READ_DATE AS \"읽은날짜\"" + 
				" FROM MEMBERS M " + 
				" INNER JOIN COMPANIES C" + 
				"    ON M.COMPANY_IDX = C.COMPANY_IDX " + 
				" LEFT JOIN DEPARTMENTS D" + 
				"    ON M.department_idx = D.department_idx " + 
				" INNER JOIN READ_OR_NOT R" + 
				"    ON M.member_idx = R.member_idx " + 
				" INNER JOIN board b" + 
				"    ON R.board_idx = b.board_idx" + 
				" INNER JOIN projects p" + 
				"    ON p.project_idx = b.project_idx" + 
				" INNER JOIN PROJECT_MEMBER PM" + 
				"    ON M.MEMBER_IDX = PM.participant_idx" + 
				" WHERE  b.board_idx = ?" + 
				" AND     M.NAME LIKE ?";
		ArrayList<ProjectInviteViewDto> listRet = new ArrayList<ProjectInviteViewDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, boardIdx);
		pstmt.setString(2, "%"+name+"%");
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int memberIdx = rs.getInt("멤버번호");
			String profileImg = rs.getString("프로필 이미지 주소");
			name = rs.getString("이름");
			String position = rs.getString("직책");
			String companyName = rs.getString("회사명");
			String departmentName = rs.getString("부서명");
			String readDate = rs.getString("읽은날짜");
			if(departmentName == null) {
				departmentName = "";
			}
			if(position == null) {
				position = "";
			}
			ProjectInviteViewDto dto = new ProjectInviteViewDto(memberIdx, profileImg, name, position, companyName, departmentName, readDate);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
//	[Minsuk17-2] 게시글 읽음 검색 -안읽은사람
//	input : int(게시물idx), string(검색어), int(프로젝트idx)
//	output : 해당 게시물에 읽은 인원 검색어에 따라 출력
	public ArrayList<ProjectInviteViewDto>ReadMembersearchnonview(int boardIdx, String name, int projectIdx) throws Exception {
		String sql = " SELECT  DISTINCT" + 
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
				"    ON M.MEMBER_IDX = PM.participant_idx " + 
				" WHERE M.NAME LIKE ?" +
				" AND PM.PROJECT_IDX = ?" +
				" AND NOT EXISTS (" + 
				"    SELECT 1" + 
				"    FROM READ_OR_NOT R" + 
				"    WHERE R.member_idx = M.member_idx " + 
				"    AND R.board_idx = ?" + 
				" )";
		ArrayList<ProjectInviteViewDto> listRet = new ArrayList<ProjectInviteViewDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, "%"+name+"%");
		pstmt.setInt(2, projectIdx);
		pstmt.setInt(3, boardIdx);
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
	//안읽은 사람 전체조회
	public ArrayList<ProjectInviteViewDto>ReadMembernonview(int boardIdx, int projectIdx) throws Exception {
		String sql = " SELECT  DISTINCT" + 
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
				"    ON M.MEMBER_IDX = PM.participant_idx " + 
				" WHERE PM.PROJECT_IDX = ?" +
				" AND NOT EXISTS (" + 
				"    SELECT 1" + 
				"    FROM READ_OR_NOT R" + 
				"    WHERE R.member_idx = M.member_idx " + 
				"    AND R.board_idx = ?" + 
				" )";
		ArrayList<ProjectInviteViewDto> listRet = new ArrayList<ProjectInviteViewDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, projectIdx);
		pstmt.setInt(2, boardIdx);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int memberIdx = rs.getInt("멤버번호");
			String profileImg = rs.getString("프로필 이미지 주소");
			String name = rs.getString("이름");
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
	//읽음수 
	public int ReadCount(int boardIdx) throws Exception {
		String sql = " SELECT COUNT(BOARD_IDX)" + 
				" FROM READ_OR_NOT" + 
				" WHERE BOARD_IDX = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, boardIdx);
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
//	[Minsuk18] 댓글 - (p85)
//	input : int(게시물idx),int(작성자),String(작성시간), int(답장 인덱스), String(댓글 내용)
//	output : -
	public void Commentinput(int boardIdx, int writerIdx,String commentContent ,String writeTime, Integer replyIdx)throws Exception {
		String sql = "INSERT INTO Comments values(comments_up.nextval,?, "
				+ "?,?,"+writeTime+",?,1)";  
		
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setInt(1, boardIdx);
		pstmt.setInt(2, writerIdx);
		pstmt.setString(3, commentContent);
		if(replyIdx==null) {
			pstmt.setNull(4, Types.NUMERIC);
		}
		else {
			pstmt.setInt(4, replyIdx);
		}
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	public void CommentUpdate(int commentIdx, String comment) throws Exception {
		String sql = "UPDATE COMMENTS SET COMMENT_CONTENT = ? WHERE COMMENT_IDX = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, comment);
		pstmt.setInt(2, commentIdx);
		
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	public void CommentDelete(int commentIdx) throws Exception {
		String sql = "DELETE FROM COMMENTS WHERE COMMENT_IDX = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setInt(1, commentIdx);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
//	[Minsuk18-1] 댓글조회  - (p85) 
//	input : int(게시글idx)
//	output : 해당 게시글 댓글 출력
	public ArrayList<BoardCommentViewDto>BoardCommentViewer(int BoardIdx, int category)throws Exception {
		String sql = " SELECT " + 
				"    M.PROFILE_IMG AS \"프로필URL\"," + 
				"    M.NAME AS \"작성자\", " + 
				"    COMMENT_CONTENT AS \"게시글 내용\", " + 
				"    write_time AS \"작성일\", " + 
				"    REPLY_IDX AS \"답장IDX\"," + 
				"    COMMENT_CATEGORY AS \"글유형\"," + 
				"    COMMENT_IDX AS \"댓글번호\"" + 
				"    FROM COMMENTS C" + 
				"    JOIN MEMBERS M" + 
				"    ON c.writer_idx = M.MEMBER_IDX" + 
				"    WHERE BOARD_IDX = ?";
		if(category == 1) {
			sql += " AND COMMENT_CATEGORY = 1";
		}
		ArrayList<BoardCommentViewDto> listRet = new ArrayList<BoardCommentViewDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, BoardIdx);
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next()) {
			String profileImg = rs.getString("프로필URL");
			String name = rs.getString("작성자");
			String CommentContent = rs.getString("게시글 내용");
			String writeTime = rs.getString("작성일");
			int ReplyIdx = rs.getInt("답장IDX");
			int commentCategory = rs.getInt("글유형");
			int commentIdx = rs.getInt("댓글번호");
			BoardCommentViewDto dto = new BoardCommentViewDto(profileImg,name,CommentContent, writeTime, ReplyIdx,commentCategory,commentIdx);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	//댓글 전체 수 , 댓글수 구하기
	public int CommentCount(int BoardIdx, int category, int commentCategory) throws Exception {
		String sql = "SELECT COUNT(BOARD_IDX)" + 
				"    FROM COMMENTS" + 
				"    WHERE BOARD_IDX = ?";
		if(category == 1) {
			sql += "AND COMMENT_CATEGORY = ?";
		}
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, BoardIdx);
		if(category == 1) {
			pstmt.setInt(2, commentCategory);
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
//	[Minsuk19] 댓글좋아요 - (p85)
//	input : int(댓글idx), int(멤버idx)
//	output : -
	public void ADDCommentGood(int commentIdx, int memberIdx) throws Exception {
		String sql = "INSERT INTO COMMENT_GOOD values(?,?)";
		
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setInt(1, commentIdx);
		pstmt.setInt(2, memberIdx);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	//게시글 좋아요 이모티콘총 수 조회
	public int BoardEmotionTotalCount(int boardIdx) throws Exception {
		String sql = " SELECT COUNT(MEMBER_IDX)" + 
				" FROM BOARD_EMOTION" + 
				" WHERE BOARD_IDX = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, boardIdx);
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
	//게시글 좋아요 이모티콘 마다 수 조회
	public ArrayList<BoardEmotionDto> BoardEmotionTypeCount(int boardIdx) throws Exception {
		String sql = " SELECT EMOTION_TYPE AS \"해당이모티콘\", COUNT(BOARD_IDX) AS \"해당이모티콘별수\"" + 
				" FROM BOARD_EMOTION" + 
				" WHERE BOARD_IDX = ?" + 
				" GROUP BY EMOTION_TYPE";
		ArrayList<BoardEmotionDto> listRet = new ArrayList<BoardEmotionDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, boardIdx);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int emotionType = rs.getInt("해당이모티콘");
			int countemotion = rs.getInt("해당이모티콘별수");
			BoardEmotionDto dto = new BoardEmotionDto(0,null, null, emotionType, countemotion);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	//게시글 이모티콘 상세조회
	public ArrayList<BoardEmotionDto> BoardEmotionView(int boardIdx, int category) throws Exception {
		String sql = " SELECT M.member_idx AS \"멤버번호\", M.NAME AS \"이름\", M.profile_Img AS \"프로필URL\", BE.EMOTION_TYPE \"사용한이모티콘타입\"" + 
				" FROM MEMBERS M" + 
				" JOIN BOARD_EMOTION BE" + 
				" ON M.MEMBER_IDX = BE.MEMBER_IDX" + 
				" WHERE BOARD_IDX = ?";
		if(category ==1) {
			sql += " AND ROWNUM = 1";
		}
		ArrayList<BoardEmotionDto> listRet = new ArrayList<BoardEmotionDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, boardIdx);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int memberIdx = rs.getInt("멤버번호");
			String name = rs.getString("이름");
			String profileImg = rs.getString("프로필URL");
			int emotionType = rs.getInt("사용한이모티콘타입");
			BoardEmotionDto dto = new BoardEmotionDto(memberIdx, name, profileImg, emotionType, 0);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	//이 게시물에 내가 좋아요를 달았는지 아는 DAO
	public int BoardEmotionMine(int boardIdx, int memberIdx) throws Exception {
		String sql = " SELECT COUNT(MEMBER_IDX)" + 
				" FROM BOARD_EMOTION " + 
				" WHERE BOARD_IDX = ?" + 
				" AND MEMBER_IDX = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, boardIdx);
		pstmt.setInt(2, memberIdx);
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
//	[Minsuk23] 게시글 작성 - 기본 글 (p.89)
//	input : int(작성자idx), int(프로젝트idx), String(게시글 제목), String(게시글 내용), String(유형 : 글), char(임시 저장 여부), char(게시글 공개 여부)
//	output : -
//	INSERT INTO BOARD values ((해당게시물idx), (입력한 프로젝트 idx), (글 작성자 idx), ‘게시글 제목’, ‘게시글 내용’, ‘글’,’n’,’n’,sysdate,’Y’,SYSDATE); 

	public void WriteBoardBasicText(int writerIdx, int projectIdx, String title, String content,String category,char TemporaryStorage,char releaseYN) throws Exception {
		String sql = "INSERT INTO BOARD(board_idx,project_idx,writer_idx,title,content,category,Temporary_storage,release_yn)"
				+ " values(SEQ_BOARD_IDX.nextval,?,?,?,?,?,?,?)";
		
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
         
		pstmt.setInt(1, projectIdx);
		pstmt.setInt(2, writerIdx);
		pstmt.setString(3, title);
		pstmt.setString(4, content);
		pstmt.setString(5, category);
		pstmt.setString(6, String.valueOf(TemporaryStorage));
		pstmt.setString(7, String.valueOf(releaseYN));
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
		
// 방금 작성한 기본글 boardidx출력문
	public int boardIdxsearch() throws Exception {
		String sql = " SELECT last_number" + 
				" FROM user_sequences where sequence_name = 'SEQ_BOARD_IDX'";
		int boardIdx = 0;
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		if(rs.next()) {
			boardIdx = rs.getInt(1);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return boardIdx;
	}
	// 게시글 조회 글 번호 유형 출력
	public ArrayList<BoardTopFixedDto> SearchIdxOrCategory(int projectIdx) throws Exception {
		String sql = " SELECT BOARD_IDX AS \"게시글번호\", CATEGORY AS \"유형\"" + 
				" FROM BOARD" + 
				" WHERE PROJECT_IDX = ?" + 
				" ORDER BY BOARD_IDX DESC";
		ArrayList<BoardTopFixedDto> listRet = new ArrayList<BoardTopFixedDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, projectIdx);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int boardIdx = rs.getInt("게시글번호");
			String category = rs.getString("유형");
			BoardTopFixedDto dto = new BoardTopFixedDto(category, boardIdx, boardIdx, category, category, boardIdx, boardIdx, boardIdx, '0', category);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	// 게시글 조회 기본글 
	public BoardPostViewDto PostViewBoard(int boardIdx) throws Exception {
		String sql = "SELECT " + 
				"				M.PROFILE_IMG AS \"프로필URL\", " + 
				"                M.NAME AS \"이름\", " + 
				"				B.WRITE_DATE AS \"작성시간\", " + 
				"				B.RELEASE_YN AS \"공개여부\"," + 
				"				B.TITLE AS \"제목\", " + 
				"				B.CONTENT AS \"내용\"," + 
				"                B.TOP_FIXED AS \"상단고정여부\"" + 
				"				FROM MEMBERS M " + 
				"				JOIN BOARD B " + 
				"				ON M.MEMBER_IDX = B.WRITER_IDX" + 
				"				WHERE B.BOARD_IDX = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, boardIdx);
		ResultSet rs = pstmt.executeQuery();
		BoardPostViewDto dto = null;
		while(rs.next()) {
			String profileImg = rs.getString("프로필URL");
			String name = rs.getString("이름");
			String writeDate = rs.getString("작성시간");
			char releaseYN = rs.getString("공개여부").charAt(0);
			String title = rs.getString("제목");
			String content = rs.getString("내용");
			char topFixed = rs.getString("상단고정여부").charAt(0);
			dto = new BoardPostViewDto(profileImg, name, writeDate, releaseYN, title, content, topFixed);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return dto;
	}
//	[Minsuk23-1] 게시글 작성 - 업무 글 (p.92)
//	input : int(작성자idx), int(프로젝트idx), String(게시글 제목), String(게시글 내용), 
//	String(유형: 업무), String(작성일) char(임시 저장 여부), char(게시글 공개 여부), int(상태), int(진척도) ,int(우선 순위)
//	사용할 경우 : int(담당자), String(마감일), String(시작일), number(업무 그룹idx)
//	output : -
	
	public void WriteBoardTaskText(int boardIdx,int state, int priority, String startDate, String endDate,int progress,Integer taskGroupIdx) throws Exception {
		String sql = "INSERT " + 
				"INTO TASK(Task_idx,board_idx,state,priority,start_date,end_date,progress,task_group_idx,LAST_MODIFIED_DATE,writer_idx,WRITE_DATE)" + 
				"VALUES (TASK_UP.nextval,?,?,?,to_date(?,'YYYY-MM-DD'),to_date(?,'YYYY-MM-DD'),?,?,sysdate," + 
				"(SELECT writer_idx from board where board_idx = ?)," + 
				"(SELECT WRITE_DATE from board where board_idx = ?))"; 
		
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setInt(1, boardIdx);
		pstmt.setInt(2, state);
		pstmt.setInt(3, priority);
		pstmt.setString(4, startDate);
		pstmt.setString(5, endDate);
		pstmt.setInt(6, progress);
		if(taskGroupIdx==null) {
			pstmt.setNull(7, Types.NUMERIC);
		}
		else {
			pstmt.setInt(7, taskGroupIdx);
		}
		pstmt.setInt(8, boardIdx);
		pstmt.setInt(9, boardIdx);
		
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
//	[Minsuk23-2] 게시글 조회 - 업무 글 (p.92) 
//	input : int(게시글idx), string(category = “업무”)
//	output : 해당 게시글 조회
	public MyboardViewTaskDto ViewTask(int boardIdx) throws Exception {
		String sql = "SELECT " + 
				"    T.TASK_IDX AS \"업무번호\"," + 
				"    T.STATE AS \"상태\"," + 
				"    T.START_DATE AS \"시작일\"," + 
				"    T.END_DATE AS \"마감일\"," + 
				"    T.PRIORITY AS \"우선순위\"," + 
				"    NVL(T.TASK_GROUP_IDX,0) AS \"업무그룹번호\"," + 
				"    TG.TASK_GROUP_NAME AS \"업무그룹이름\"," + 
				"    T.PROGRESS AS \"진행도\"" + 
				" FROM BOARD B  " + 
				" JOIN TASK T ON T.BOARD_IDX = B.BOARD_IDX " + 
				" LEFT JOIN task_group TG ON TG.task_group_idx = T.TASK_GROUP_IDX" + 
				" WHERE B.BOARD_IDX = ? " + 
				" AND TOP_TASK_IDX IS NULL " + 
				" ORDER BY B.BOARD_IDX DESC";
		
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, boardIdx);
		ResultSet rs = pstmt.executeQuery();
		MyboardViewTaskDto dto = null;
		while(rs.next()) {
			int taskIdx = rs.getInt("업무번호");
			int state = rs.getInt("상태");
			String startDate = rs.getString("시작일");
			String endDate = rs.getString("마감일");
			int priority = rs.getInt("우선순위");
			int taskGroupIdx = rs.getInt("업무그룹번호");
			String taskGroupName = rs.getString("업무그룹이름");
			int progress = rs.getInt("진행도");
			dto = new MyboardViewTaskDto(null,null,null,null,null,taskIdx, state, startDate, endDate, priority, taskGroupIdx,taskGroupName, progress);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return dto;
	}
//	[Minsuk23-2] 게시글 조회 - 업무 글 (p.92) 담당자 
//	input : int (업무idx)
//	output : 해당 업무의 담당자들 출력
	public ArrayList<TaskManagerDto>ViewTaskManager(int TaskIdx)throws Exception {
		String sql = "SELECT " + 
				"        M.MEMBER_IDX AS \"직원번호\"," + 
				"        M.PROFILE_IMG AS \"프로필URL\", " + 
				"        M.NAME AS \"이름\"" + 
				"        FROM MEMBERS M" + 
				"        JOIN TASK_MANAGER TM" + 
				"        ON M.MEMBER_IDX = tm.member_idx" + 
				"        WHERE TM.TASK_IDX = ?";
		ArrayList<TaskManagerDto> listRet = new ArrayList<TaskManagerDto>();
		
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, TaskIdx);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int memberIdx = rs.getInt("직원번호");
			String name = rs.getString("이름");
			String profileImg = rs.getString("프로필URL");
			TaskManagerDto dto = new TaskManagerDto(memberIdx, memberIdx, name, profileImg);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
		
	}
	//일정 조회문
	public BoardScheduleDto viewSchedule(int boardIdx) throws Exception {
		String sql = "SELECT " + 
				"                SCHEDULE_IDX AS \"일정번호\", " + 
				"                location AS \"장소\"," + 
				"                TO_CHAR(START_DATE, 'YYYY-MM') AS \"년월\"," + 
				"                TO_CHAR(START_DATE, 'DD') AS \"일\"," + 
				"                START_DATE AS \"시작일\"," + 
				"                END_DATE AS \"마감일\"," + 
				"                ALL_DAY_YN AS \"종일여부\"," +
				"				ALARM_TYPE AS \"알람타입\"" +
				"				FROM SCHEDULE" + 
				"				WHERE BOARD_IDX = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, boardIdx);
		ResultSet rs = pstmt.executeQuery();
		BoardScheduleDto dto = null;
		if(rs.next()) {
			int scheduleIdx = rs.getInt("일정번호");
			String location = rs.getString("장소");
			String yearMonth = rs.getString("년월");
			String day = rs.getString("일");
			String startDate = rs.getString("시작일");
			String endDate = rs.getString("마감일");
			char allDayYN = rs.getString("종일여부").charAt(0);
			int AlarmType = rs.getInt("알람타입");
			dto = new BoardScheduleDto(scheduleIdx, location, yearMonth, day, startDate, endDate, allDayYN,startDate, endDate, scheduleIdx, endDate, AlarmType);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return dto;
	}
	// 일정 참가자 참석자 참석여부 카운트문
	public ScheduleCountDto scheduleCount(int scheduleIdx) throws Exception {
		String sql = "SELECT" + 
				"  COUNT(CASE WHEN ATTEND_WHETHER = '참석' THEN 1 END) AS 참석," + 
				"  COUNT(CASE WHEN ATTEND_WHETHER = '불참' THEN 1 END) AS 불참," + 
				"  COUNT(CASE WHEN ATTEND_WHETHER = '미정' THEN 1 END) AS 미정" + 
				" FROM SCHEDULE_ATTENDER" + 
				" WHERE SCHEDULE_IDX = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, scheduleIdx);
		ResultSet rs = pstmt.executeQuery();
		ScheduleCountDto dto = null;
		if(rs.next()) {
			int count1 = rs.getInt("참석");
			int count2 = rs.getInt("불참");
			int count3 = rs.getInt("미정");
			dto = new ScheduleCountDto(count1,count2,count3);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return dto;
	}
	//일정 참가자문 
	public ArrayList<BoardScheduleDto> viewMemberSchdule(int scheduleIdx, int memberIdx, int category) throws Exception {
		String sql = "SELECT " + 
				" 	 M.member_idx AS \"멤버번호\"," + 
				"    M.NAME AS \"이름\"," + 
				"    M.PROFILE_IMG AS \"프로필URL\"," + 
				"    ATTEND_WHETHER \"참석여부\"" +
				" FROM SCHEDULE_ATTENDER SA" + 
				" JOIN MEMBERS M " + 
				" ON SA.MEMBER_IDX = M.MEMBER_IDX" + 
				" WHERE SA.SCHEDULE_IDX = ?";
		if(category==1) {
			sql += " AND M.MEMBER_IDX = ?";
		}
		ArrayList<BoardScheduleDto> listRet = new ArrayList<BoardScheduleDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, scheduleIdx);
		if(category==1) {
			pstmt.setInt(2, memberIdx);
		}
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			String profileImg = rs.getString("프로필URL");
			String name = rs.getString("이름");
			memberIdx = rs.getInt("멤버번호");
			String attendWhether = rs.getString("참석여부");
			BoardScheduleDto dto = new BoardScheduleDto(category, attendWhether, attendWhether, attendWhether, attendWhether, attendWhether, '0', profileImg, name, memberIdx, attendWhether, 0);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	//할일 조회문
	public BoardWorkViewDto viewWork(int boardIdx) throws Exception {
		String sql = "SELECT " + 
				"                W.WORK_IDX AS \"할일번호\"" + 
				"				FROM WORK W " + 
				"                JOIN WORK_MEMBER_CONTENT WMC" + 
				"                ON W.WORK_IDX = WMC.WORK_IDX" + 
				"                JOIN MEMBERS M" + 
				"                ON WMC.MANAGER_IDX = M.MEMBER_IDX" + 
				"				WHERE BOARD_IDX = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, boardIdx);
		ResultSet rs = pstmt.executeQuery();
		BoardWorkViewDto dto = null;
		if(rs.next()) {
			int workIdx = rs.getInt("할일번호");
			dto = new BoardWorkViewDto(workIdx, workIdx, sql, '0', sql, sql, sql, workIdx, workIdx, workIdx);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return dto;
	}
	public ArrayList<BoardWorkViewDto> viewWorkValue(int workIdx) throws Exception {
		String sql = "SELECT " + 
				"                WMC.PER_WORK_IDX AS \"할일상세번호\"," + 
				"                WMC.WORK_CONTENT AS \"할일내용\"," + 
				"                WMC.WORK_COMPLE_YN AS \"할일완료여부\"," + 
				"                TO_CHAR(WMC.WORK_DATE, 'MM/DD') AS \"할일일정\"," + 
				"                M.NAME AS \"담당자명\"," + 
				"                M.PROFILE_IMG AS \"프로필URL\"" + 
				"				FROM WORK W " + 
				"                JOIN WORK_MEMBER_CONTENT WMC" + 
				"                ON W.WORK_IDX = WMC.WORK_IDX" + 
				"                JOIN MEMBERS M" + 
				"                ON WMC.MANAGER_IDX = M.MEMBER_IDX" + 
				"				 WHERE W.WORK_IDX = ?";
		ArrayList<BoardWorkViewDto> listRet = new ArrayList<BoardWorkViewDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, workIdx);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int perWorkIdx = rs.getInt("할일상세번호");
			String workContent = rs.getString("할일내용");
			char workCompleYN = rs.getString("할일완료여부").charAt(0);
			String workDate = rs.getString("할일일정");
			String name = rs.getString("담당자명");
			String profileImg = rs.getString("프로필URL");
			BoardWorkViewDto dto = new BoardWorkViewDto(workIdx, perWorkIdx, workContent, workCompleYN, workDate, name, profileImg, perWorkIdx, perWorkIdx, perWorkIdx);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	//완료율 구하기
	public BoardWorkViewDto viewWorkPercent(int workIdx) throws Exception {
		String sql = " WITH BoardWork AS (" + 
				"    SELECT " + 
				"        B.BOARD_IDX, " + 
				"        B.TITLE," + 
				"        W.WORK_IDX," + 
				"        COUNT(WC.WORK_COMPLE_YN) AS total_count, " + 
				"        COUNT(CASE WHEN WC.WORK_COMPLE_YN = 'Y' THEN 1 END) AS completed_count " + 
				"    FROM BOARD B " + 
				"    JOIN WORK W ON B.BOARD_IDX = W.BOARD_IDX" + 
				"    LEFT JOIN WORK_MEMBER_CONTENT WC ON W.WORK_IDX = WC.WORK_IDX " + 
				"    WHERE W.WORK_IDX = ?" + 
				"    GROUP BY " + 
				"        B.BOARD_IDX, " + 
				"        B.TITLE, " + 
				"        W.WORK_IDX" + 
				" )" + 
				" SELECT " + 
				"    total_count AS \"할일수\",  " + 
				"    completed_count AS \"완료된할일\", " + 
				"    FLOOR(completed_count * 100.0 / total_count) AS \"완료율\"" + 
				" FROM BoardWork";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, workIdx);
		ResultSet rs = pstmt.executeQuery();
		BoardWorkViewDto dto = null;
		if(rs.next()) {
			int totalCount = rs.getInt("할일수");
			int completedCount = rs.getInt("완료된할일");
			int totalPercent = rs.getInt("완료율");
			dto = new BoardWorkViewDto(totalPercent, totalPercent, sql, '0', sql, sql, sql, totalCount, completedCount, totalPercent);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return dto;
	}
//	[Minsuk23-5] 업무 게시물 기능 변경시 시스템 댓글 (p.92)
//	input : int(상태), int(우선 순위), int(담당자) 추가시
//	output : -
	public void taskSystemComment(int boardIdx, int writerIdx,String commentContent ,String writeTime, Integer replyIdx) {
		String sql = "INSERT INTO Comments values(comments_up.nextval,?, "
				+ "?,?,"+writeTime+",?,0)";  
	}
//	[Minsuk23-6] 글 작성시 프로젝트 검색
//	input : int(상태), int(우선 순위), int(담당자) 추가시
//	output : -
	public ArrayList<MyProjectViewDto>ProjectSearch(String search) throws Exception {
		String sql = " SELECT PROJECT_NAME AS \"프로젝트명\"" + 
				" FROM PROJECTS" + 
				" WHERE PROJECT_NAME LIKE ?";
		ArrayList<MyProjectViewDto> listRet = new ArrayList<MyProjectViewDto>();
		
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, "%"+search+"%");
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			String projectName = rs.getString("프로젝트명");
			MyProjectViewDto dto = new MyProjectViewDto(0, projectName, 0, '0', 0,0,'0','0',null);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	public int ProjectIdxSearch(int boardIdx) throws Exception {
		String sql = "SELECT PROJECT_IDX" + 
				" FROM BOARD" + 
				" WHERE BOARD_IDX = ?";
		int count = 0;
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, boardIdx);
		ResultSet rs = pstmt.executeQuery();
		if(rs.next()) {
			count = rs.getInt(1);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return count;
	}
	public int ScheduleBoardIdx(int scheduleIdx) throws Exception {
		String sql = " SELECT BOARD_IDX AS \"게시글번호\"" + 
				" FROM SCHEDULE" + 
				" WHERE SCHEDULE_IDX = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, scheduleIdx);
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
	public int TaskBoardIdx(int taskIdx) throws Exception {
		String sql = " SELECT BOARD_IDX AS \"게시글번호\"" + 
				" FROM TASK" + 
				" WHERE TASK_IDX = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, taskIdx);
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
	public int CommentBoardIdx(int Comment) throws Exception {
		String sql = " SELECT BOARD_IDX AS \"게시글번호\"" + 
				" FROM Comments" + 
				" WHERE COMMENT_IDX = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Comment);
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
	public int taskIdxsearch() throws Exception {
		String sql = " SELECT MAX(task_idx)" + 
				" FROM task";
		int boardIdx = 0;
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		if(rs.next()) {
			boardIdx = rs.getInt(1);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return boardIdx;
	}
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
	public static void main(String[] args) throws Exception {
		BoardALLDao Dao = new BoardALLDao();
		 
	}

}
