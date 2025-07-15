package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import dto.BoardCommentsInfoDto;
import dto.ProjectAttenderYNDto;
import dto.ProjectMemberListDto;
import dto.RemindAgainDto;
import dto.ScheduleAttenderDto;
import dto.ScheduleBoardInfoDto;
import dto.ScheduleCalendarDto;
import dto.ScheduleGoodInfoDto;

public class ScheduleDao {
	public Connection getConnection() throws Exception{
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@//114.207.245.107:1521/XE";
		String id = "FLOW";
		String pw = "1234";
		
		Class.forName(driver);
		Connection conn = DriverManager.getConnection(url, id, pw);
		
		return conn;
	}
	
//	[SH-78] - 일정 게시물 작성하기 (p96-1)
//	-input : project_idx(숫자), writer_idx(숫자), 작성할 일정의 제목(문자열),
//		   작성할 일정의 시작날짜(문자열), 작성할 일정의 끝날짜(문자열), 지정할 참석자idx(숫자),
//		   지정할 장소(문자열),  지정할 알림유형(문자열), 작성할 일정의 내용(문자열)
	public int addBoard(int projectIdx, int writerIdx, String title, String content, String category, char releaseYn) throws Exception{
		String sql = "INSERT INTO board(board_idx, project_idx, writer_idx, title, content, category, release_yn) " + 
				" VALUES(SEQ_BOARD_IDX.nextval, ?, ?, ?, ?, ?, ?)";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, projectIdx);
		pstmt.setInt(2, writerIdx);
		pstmt.setString(3, title);
		pstmt.setString(4, content);
		pstmt.setString(5, category);
		pstmt.setString(6, releaseYn+"");
		pstmt.executeUpdate();
		pstmt.close();
		
		String sql2 = "SELECT  MAX(board_idx)" + 
				" FROM    board" + 
				" WHERE   project_idx = ?";
		PreparedStatement pstmt2 = conn.prepareStatement(sql2);
		pstmt2.setInt(1, projectIdx);
		
		ResultSet rs = pstmt2.executeQuery();
		int ret = 0;
		if(rs.next()) {
			ret = rs.getInt("MAX(board_idx)");
		}
		rs.close();
		pstmt2.close();
		conn.close();
		return ret;
	}
	public int addSchedule(int boardIdx, String location, String startDate, String endDate, int alarmType, char AllDayYN) throws Exception{
		String sql = "INSERT INTO schedule(schedule_idx, board_idx, location, start_date, end_date, alarm_type, all_day_yn)" + 
				" VALUES(SEQ_SCHEDULE.nextval, ?, ?, TO_DATE(?, 'YYYY-MM-DD HH24:MI'), TO_DATE(?, 'YYYY-MM-DD HH24:MI'), ?, ?)";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, boardIdx);
		pstmt.setString(2, location);
		pstmt.setString(3, startDate);
		pstmt.setString(4, endDate);
		pstmt.setInt(5, alarmType);
		pstmt.setString(6, AllDayYN+"");
		pstmt.executeUpdate();
		pstmt.close();
		
		String sql2 = "SELECT  MAX(schedule_idx)" + 
				" FROM    schedule" + 
				" WHERE   board_idx = ?";
		PreparedStatement pstmt2 = conn.prepareStatement(sql2);
		pstmt2.setInt(1, boardIdx);
		ResultSet rs = pstmt2.executeQuery();
		int ret = 0;
		if(rs.next()) {
			ret = rs.getInt("MAX(schedule_idx)");
		}
		rs.close();
		pstmt2.close();
		conn.close();
		return ret;
	}
	//일정 게시글 수정
	public void UpdateSchedule(String location, int alarmType, char allDayYN, String startDate, String endDate,  int scheduleIdx) throws Exception {
		String sql = " Update schedule SET LOCATION = ?, START_DATE = TO_DATE(?, 'YYYY-MM-DD HH24:MI'), END_DATE = TO_DATE(?, 'YYYY-MM-DD HH24:MI'), ALARM_TYPE = ?, ALL_DAY_YN = ?" + 
				" WHERE SCHEDULE_IDX = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, location);
		pstmt.setString(2, startDate);
		pstmt.setString(3, endDate);
		pstmt.setInt(4, alarmType);
		pstmt.setString(5, allDayYN+"");
		pstmt.setInt(6, scheduleIdx);
		pstmt.executeUpdate();
		pstmt.close();
	}
	
//	[SH-79] - 등록된 일정의 참석자 변경창띄우기 (p98-1)
//	-input : project_idx(숫자), 검색어(문자열)
//	-output : ArrayList<MemberCompanyDepartmentDto>
	public ArrayList<ProjectMemberListDto> getScheduleMemberList(int projectIdx, int scheduleIdx, String str) throws Exception{
		String sql = "SELECT  DISTINCT m.member_idx, " + 
				"        c.company_name AS \"회사명\"," + 
				"        m.name AS \"이름\"," + 
				"        m.position AS \"직책\"," + 
				"        d.department_name AS \"부서명\", " + 
				"        m.profile_img AS \"프로필 주소\"," + 
				"        CASE " + 
				"            WHEN sa.member_idx IS NOT NULL THEN 'Y'" + 
				"            ELSE 'N'" + 
				"        END AS \"참여여부\"" + 
				" FROM    project_member pm" + 
				" FULL OUTER JOIN members m" + 
				" ON      pm.participant_idx = m.member_idx" + 
				" FULL OUTER JOIN  companies c" + 
				" ON      m.company_idx = c.company_idx " + 
				" FULL OUTER JOIN departments d" + 
				" ON      m.department_idx = d.department_idx" + 
				" FULL OUTER JOIN schedule_attender sa" + 
				" ON      m.member_idx = sa.member_idx AND sa.schedule_idx = ?" + 
				" WHERE   pm.project_idx = ?" + 
				" AND     m.name LIKE ?" + 
				" ORDER BY m.member_idx";
		ArrayList<ProjectMemberListDto> listRet = new ArrayList<ProjectMemberListDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, scheduleIdx);
		pstmt.setInt(2, projectIdx);
		pstmt.setString(3, "%"+str+"%");
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int memberIdx = rs.getInt("member_idx");
			String companyName = rs.getString("회사명");
			String memberName = rs.getString("이름");
			String position = rs.getString("직책");
			String departmentName = rs.getString("부서명");
			String prof = rs.getString("프로필 주소");
			char attendYN = rs.getString("참여여부").charAt(0);
			ProjectMemberListDto dto = new ProjectMemberListDto(memberIdx, companyName, memberName, position, departmentName, prof, attendYN);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	
//	[SH-80] - 일정의 참석자 추가하기 (p98-2)
//	-input : schedule_idx(숫자), member_idx(숫자)
	public void addScheduleMember(int scheduleIdx, int memberIdx, String attendWhether) throws Exception{
		String sql = "INSERT INTO schedule_attender(schedule_idx, member_idx, attend_whether) VALUES(?, ?, ?)";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, scheduleIdx);
		pstmt.setInt(2, memberIdx);
		pstmt.setString(3, attendWhether);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	
//	일정 참석자의 참석여부 가져오기
	public ArrayList<ProjectAttenderYNDto> getScheduleAttendYN(int scheduleIdx) throws Exception {
		String sql = "SELECT  member_idx," + 
				"        sa.attend_whether AS \"참석여부\"" + 
				" FROM    schedule_attender sa" + 
				" WHERE   sa.schedule_idx = ?" +
				" ORDER BY sa.member_idx";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, scheduleIdx);
		ResultSet rs = pstmt.executeQuery();
		ArrayList<ProjectAttenderYNDto> listRet = new ArrayList<ProjectAttenderYNDto>();
		while(rs.next()) {
			int memberIdx = rs.getInt("member_idx");
			String attendWhether = rs.getString("참석여부");
			ProjectAttenderYNDto dto = new ProjectAttenderYNDto(memberIdx, attendWhether);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	
//	[SH-81] - 일정 게시물의 모든 참석자 해제하기 (p98-2)
//	-input : schedule_idx(숫자)
	public void delScheduleMember(int scheduleIdx) throws Exception{
		String sql = "DELETE  schedule_attender WHERE schedule_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, scheduleIdx);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	
//	[SH-82] - 참석 여부 지정(선택)하기 (p98-4)
//	-input : schedule_idx(숫자), member_idx(숫자), attend_Whether(문자열) = 참석여부
	public void setScheduleParticipant(int scheduleIdx, int memberIdx, String str) throws Exception{
		String sql = "UPDATE  schedule_attender" + 
				" SET     attend_Whether = ?" + 
				" WHERE   member_idx = ?" + 
				" AND     schedule_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, str);
		pstmt.setInt(2, memberIdx);
		pstmt.setInt(3, scheduleIdx);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	
// 	멤버의 참석여부가져오기
//	input: member_idx(숫자), schedule_idx(숫자)
	public String getMemberAttend(int memberIdx, int scheduleIdx) throws Exception {
		String sql = "SELECT  NVL(attend_whether, 0) AS \"참석여부\"" + 
				" FROM    schedule_attender" + 
				" WHERE   member_idx = ?" + 
				" AND     schedule_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, memberIdx);
		pstmt.setInt(2, scheduleIdx);
		ResultSet rs = pstmt.executeQuery();
		String ret = null;
		if(rs.next()) {
			ret = rs.getString("참석여부");
		}
		rs.close();
		pstmt.close();
		conn.close();
		return ret;
	}
	
//	[SH-84] - 캘린더 일정 검색 조회하기 (p118)
//	-input : project_idx(숫자), member_idx(숫자), 검색기준(문자열), 검색할 일정명(문자열)
//	-output : ArrayList<ScheduleCalendarDto>
	public ArrayList<ScheduleCalendarDto> getProjectCalendar(int projectIdx, int memberIdx, String standard, String str) throws Exception {
		String m = "";
		if(standard.equals("내 일정")) {
			m = "AND     sa.member_idx = ?";
		}else if(standard.equals("등록한 일정")) {
			m = "AND     b.writer_idx = ?";
		}else if(standard.equals("선택안함")) {
			m = "AND     s.schedule_idx = 0";
		}
		String sql = "SELECT  DISTINCT s.schedule_idx," + 
				"        s.board_idx," + 
				"        s.start_date AS \"시작 날짜\"," + 
				"        s.end_date AS \"마무리 날짜\"," + 
				"        s.all_day_yn AS \"종일 여부\"," + 
				"        b.title AS \"제목\"" + 
				" FROM    schedule s" + 
				" INNER JOIN board b" + 
				" ON      s.board_idx = b.board_idx" + 
				" INNER JOIN projects p" + 
				" ON      p.project_idx = b.project_idx" + 
				" INNER JOIN schedule_attender sa" + 
				" ON      s.schedule_idx = sa.schedule_idx" + 
				" INNER JOIN members m" + 
				" ON      b.writer_idx = m.member_idx" + 
				" WHERE   p.project_idx = ?" + 
				" AND     b.title LIKE ?" +
				" "+m;
		ArrayList<ScheduleCalendarDto> listRet = new ArrayList<ScheduleCalendarDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, projectIdx);
		pstmt.setString(2, "%"+str+"%");
		if(!standard.equals("전체") && !standard.equals("선택안함")) {
			pstmt.setInt(3, memberIdx);
		}
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int boardIdx = rs.getInt("board_idx");
			int scheduleIdx = rs.getInt("schedule_idx");
			String title = rs.getString("제목");
			String startDate = rs.getString("시작 날짜");
			String endDate = rs.getString("마무리 날짜");
			char allDayYN = rs.getString("종일 여부").charAt(0);
			ScheduleCalendarDto dto = new ScheduleCalendarDto(boardIdx, scheduleIdx, title, startDate, endDate, allDayYN);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	
//	[SH-85] - 일정 게시물의 정보 가져오기 (p122-1)
//	-input : board_idx(숫자),	 member_idx(숫자)
//	-output : ArrayList<ScheduleBoardInfoDto>
	public ScheduleBoardInfoDto getScheduleBoardInfo(int boardIdx) throws Exception{
		String sql = "SELECT  DISTINCT b.writer_idx AS \"작성자IDX\"," + 
				"        b.project_idx \"프로젝트IDX\"," + 
				"        p.project_name \"프로젝트 이름\"," + 
				"		s.schedule_idx, " + 
				"		b.write_date AS \"작성일\"," + 
				"		b.release_yn AS \"공개 여부\"," + 
				"		b.title AS \"제목\", " + 
				"		s.start_date AS \"시작 날짜\"," + 
				"		s.end_date AS \"마무리 날짜\"," + 
				"		s.all_day_yn AS \"종일 여부\"," + 
				"		s.location AS \"장소\"," + 
				"        b.content AS \"내용\" " + 
				" FROM    board b" + 
				" INNER JOIN schedule s" + 
				" ON      b.board_idx = s.board_idx" + 
				" INNER JOIN schedule_attender sa" + 
				" ON      sa.schedule_idx = s.schedule_idx" + 
				" INNER JOIN projects p" + 
				" ON      p.project_idx = b.project_idx" + 
				" WHERE   b.board_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, boardIdx);
		ResultSet rs = pstmt.executeQuery();
		ScheduleBoardInfoDto ret = null;
		if(rs.next()) {
			int scheduleIdx = rs.getInt("schedule_idx");
			int projectIdx = rs.getInt("프로젝트IDX");
			String projectName = rs.getString("프로젝트 이름");
			int writerIdx = rs.getInt("작성자IDX");
			String writeDate = rs.getString("작성일");
			char releaseYN = rs.getString("공개 여부").charAt(0);
			String title = rs.getString("제목");
			String startDate = rs.getString("시작 날짜");
			String endDate = rs.getString("마무리 날짜");
			char allDayYN = rs.getString("종일 여부").charAt(0);
			String location = rs.getString("장소");
			String content = rs.getString("내용");
			ret = new ScheduleBoardInfoDto(scheduleIdx, projectIdx, projectName, writerIdx, writeDate, releaseYN, title, startDate, endDate, allDayYN, location, content);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return ret;
	}
	
//	[SH-86] - 일정 게시물의 참석자들 가져오기 (p122-1)
//	-input : schedule_idx(숫자)
//	-output : ArrayList<ScheduleAttenderDto>
	public ArrayList<ScheduleAttenderDto> getScheduleAttenderList(int scheduleIdx) throws Exception{
		String sql = "SELECT  DISTINCT s.schedule_idx AS \"일정IDX\"," + 
				"        sa.member_idx AS \"참석자IDX\"," + 
				"        m.name AS \"이름\"," + 
				"        m.profile_img AS \"프로필\"," + 
				"        sa.attend_whether AS \"참석 여부\"" + 
				" FROM    schedule s" + 
				" INNER JOIN schedule_attender sa" + 
				" ON      s.schedule_idx = sa.schedule_idx" + 
				" INNER JOIN members m" + 
				" ON      sa.member_idx = m.member_idx" + 
				" WHERE   s.schedule_idx = ?" +
				" ORDER BY sa.member_idx";
		ArrayList<ScheduleAttenderDto> listRet = new ArrayList<ScheduleAttenderDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, scheduleIdx);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int memberIdx = rs.getInt("참석자IDX");
			String name = rs.getNString("이름");
			String profileImg = rs.getNString("프로필");
			String attendWhether = rs.getNString("참석 여부");
			ScheduleAttenderDto dto = new ScheduleAttenderDto(scheduleIdx, memberIdx, name, profileImg, attendWhether);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	
//	일정게시물 참석자의 정보 가져오기
	public ScheduleAttenderDto getScheduleAttender(int scheduleIdx, int memberIdx) throws Exception{
		String sql = "SELECT  DISTINCT s.schedule_idx AS \"일정IDX\"," + 
				"        sa.member_idx AS \"참석자IDX\"," + 
				"        m.name AS \"이름\"," + 
				"        m.profile_img AS \"프로필\"," + 
				"        sa.attend_whether AS \"참석 여부\"" + 
				" FROM    schedule s" + 
				" INNER JOIN schedule_attender sa" + 
				" ON      s.schedule_idx = sa.schedule_idx" + 
				" INNER JOIN members m" + 
				" ON      sa.member_idx = m.member_idx" + 
				" WHERE   s.schedule_idx = ?" +
				" AND     sa.member_idx = ?" +
				" ORDER BY sa.member_idx";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, scheduleIdx);
		pstmt.setInt(2, memberIdx);
		ResultSet rs = pstmt.executeQuery();
		ScheduleAttenderDto ret = null;
		if(rs.next()) {
			String name = rs.getNString("이름");
			String profileImg = rs.getNString("프로필");
			String attendWhether = rs.getNString("참석 여부");
			ret = new ScheduleAttenderDto(scheduleIdx, memberIdx, name, profileImg, attendWhether);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return ret;
	}
	
//	[SH-87] - 일정 게시물의 좋아요정보들 가져오기 (p122-1)
//	-input : board_idx(숫자)
//	-output : ArrayList<ScheduleGoodInfoDto>
	public ArrayList<ScheduleGoodInfoDto> getScheduleGoodInfoList(int boardIdx) throws Exception{
		String sql = "SELECT  DISTINCT be.member_idx," + 
				"        et.emotion_type," + 
				"        et.emotion_file" + 
				" FROM    board_emotion be" + 
				" INNER JOIN emotion_type et" + 
				" ON      be.emotion_type = et.emotion_type" + 
				" WHERE   be.board_idx = ?";
		ArrayList<ScheduleGoodInfoDto> listRet = new ArrayList<ScheduleGoodInfoDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, boardIdx);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int memberIdx = rs.getInt("member_idx");
			int emotionType = rs.getInt("emotion_type");
			String emotionFile = rs.getString("emotion_file");
			ScheduleGoodInfoDto dto = new ScheduleGoodInfoDto(memberIdx, emotionType, emotionFile);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	
//	[SH-88] - 일정게시물의 북마크 정보들 가져오기 (p122-1)
//	-input : board_idx(숫자)
//	-output : member_idx(숫자)
	public ArrayList<Integer> getBoardBookmarkingMembers(int boardIdx) throws Exception{
		String sql = "SELECT  member_idx" + 
				" FROM    board_bookmark" + 
				" WHERE   board_idx = ?";
		ArrayList<Integer> ret = new ArrayList<Integer>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, boardIdx);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			ret.add(rs.getInt("member_idx"));
		}
		rs.close();
		pstmt.close();
		conn.close();
		return ret;
	}
	
//	[SH-89] - 일정 게시물의 다시 알림정보들 가져오기 (p122-1)
//	-input : board_idx(숫자)
//	-output : ArrayList<RemindAgainDto>
	public ArrayList<RemindAgainDto> getBoardRemindAgainList(int boardIdx) throws Exception{
		String sql = "SELECT  member_idx," + 
				"        today_deadline" + 
				" FROM    remind_again" + 
				" WHERE   board_idx = ?";
		ArrayList<RemindAgainDto> listRet = new ArrayList<RemindAgainDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, boardIdx);
		
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int memberIdx = rs.getInt("member_idx");
			int todayDeadline = rs.getInt("today_deadline");
			RemindAgainDto dto = new RemindAgainDto(memberIdx, todayDeadline);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	
//	[SH-90] - 일정 게시물의 댓글정보들 가져오기 (p122-1)
//	-input : board_idx(숫자)
//	-output : ArrayList<BoardCommentsInfoDto>
	public ArrayList<BoardCommentsInfoDto> getBoardCommentsInfoList(int boardIdx) throws Exception{
		String sql = "SELECT  c.comment_idx AS \"댓글IDX\"," + 
				"        c.writer_idx AS \"작성자IDX\"," + 
				"        c.comment_content AS \"댓글 내용\"," + 
				"        c.write_time AS \"작성 시간\"," + 
				"        c.reply_idx AS \"답글IDX\"," + 
				"        c.comment_category AS \"댓글 카테고리\"" + 
				" FROM    comments c" + 
				" WHERE   c.board_idx = ?";
		ArrayList<BoardCommentsInfoDto> listRet = new ArrayList<BoardCommentsInfoDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, boardIdx);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int commentIdx = rs.getInt("");
			int writerIdx = rs.getInt("");
			String commentContent = rs.getString("");
			String writeTime = rs.getString("");
			int replyIdx = rs.getInt("");
			int commentCategory = rs.getInt("");
			BoardCommentsInfoDto dto = new BoardCommentsInfoDto(commentIdx, writerIdx, commentContent, writeTime, replyIdx, commentCategory);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	
//	[SH-91] - 일정게시물의 읽음여부정보들 가져오기 (p122-1)
//	-input : board_idx(숫자)
//	-output : member_idx(숫자)
	public ArrayList<Integer> getBoardReadORNot(int boardIdx) throws Exception{
		String sql = "SELECT  member_idx" + 
				" FROM    read_or_not" + 
				" WHERE   board_idx = ?";
		ArrayList<Integer> listRet = new ArrayList<Integer>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, boardIdx);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int memberIdx = rs.getInt("member_idx");
			listRet.add(memberIdx);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	
	// (사이드탭 캘린더)멤버의 모든(프로젝트) 일정가져오기
	public ArrayList<ScheduleCalendarDto> getAllCalrendarList(int memberIdx, String standard, String str) throws Exception {
		String m = "";
		if(standard.equals("내 일정")) {
			m = "AND     sa.member_idx = ?";
		}else if(standard.equals("등록한 일정")) {
			m = "AND     b.writer_idx = ?";
		}else if(standard.equals("선택안함")) {
			m = "AND     s.schedule_idx = 0";
		}
		String sql = "SELECT  DISTINCT s.schedule_idx," + 
				"        s.board_idx," + 
				"        s.start_date AS \"시작 날짜\"," + 
				"        s.end_date AS \"마무리 날짜\"," + 
				"        s.all_day_yn AS \"종일 여부\"," + 
				"        b.title AS \"제목\"" + 
				" FROM    schedule s" + 
				" INNER JOIN board b" + 
				" ON      s.board_idx = b.board_idx" + 
				" INNER JOIN projects p" + 
				" ON      p.project_idx = b.project_idx" + 
				" INNER JOIN schedule_attender sa" + 
				" ON      s.schedule_idx = sa.schedule_idx" + 
				" INNER JOIN members m" + 
				" ON      b.writer_idx = m.member_idx" + 
				" WHERE     b.title LIKE ?" +
				" "+m;
		ArrayList<ScheduleCalendarDto> listRet = new ArrayList<ScheduleCalendarDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, "%"+str+"%");
		if(!standard.equals("전체") && !standard.equals("선택안함")) {
			pstmt.setInt(2, memberIdx);
		}
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int boardIdx = rs.getInt("board_idx");
			int scheduleIdx = rs.getInt("schedule_idx");
			String title = rs.getString("제목");
			String startDate = rs.getString("시작 날짜");
			String endDate = rs.getString("마무리 날짜");
			char allDayYN = rs.getString("종일 여부").charAt(0);
			ScheduleCalendarDto dto = new ScheduleCalendarDto(boardIdx, scheduleIdx, title, startDate, endDate, allDayYN);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	
	public static void main(String[] args) throws Exception{
		ScheduleDao sdao = new ScheduleDao();
		
		sdao.delScheduleMember(8);
		
//		String attend = sdao.getMemberAttend(1, 3);
//		System.out.println(attend);
		
//		ArrayList<ScheduleCalendarDto> scheduleList = sdao.getProjectCalendar(1, 2, "전체", "");
//		for(ScheduleCalendarDto dto : scheduleList) {
//			System.out.println(dto.getScheduleIdx());
//			System.out.println(dto.getTitle());
//			System.out.println(dto.getStartDate());
//			System.out.println(dto.getEndDate());
//			System.out.println("------------------------------------------");
//		}
	}
}
