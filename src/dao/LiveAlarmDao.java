package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Types;
import java.util.ArrayList;

import dto.LiveAlarmDto;

public class LiveAlarmDao {
	public Connection getConnection() throws Exception{
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@//114.207.245.107:1521/XE";
		String id = "FLOW";
		String pw = "1234";
		
		Class.forName(driver);
		Connection conn = DriverManager.getConnection(url, id, pw);
		
		return conn;
	}
	
//	[SH-93] - 실시간 알림 내용 뿌려주기 (p185)
//	-input : member_idx(숫자),
//			확인 여부(문자)[Y, N],
//			나를 언급 여부(문자)[Y, N],
//			내 게시물 여부(문자)[Y, N],
//			담당 업무 여부(문자)[Y, N],
//			검색어(문자열)
//	-output : ArrayList<LiveAlarmDto>
	public ArrayList<LiveAlarmDto> getLiveAlarmSearchList(int memberIdx, char checkYN, String str) throws Exception{
		String m = "";
		if(checkYN == 'N') {
			m = "AND     la.check_yn = 'N'";
		}
		String sql = "SELECT  la.live_alarm_idx AS \"실시간 알림IDX\"," + 
				"        la.board_idx AS \"게시물\"," + 
				"        la.company_idx AS \"회사\"," + 
				"        la.comment_idx AS \"댓글\"," + 
				"        la.mention_me_yn AS \"나를언급 여부\"," + 
				"        la.my_board_yn AS \"내 게시물 여부\", " + 
				"        la.work_yn AS \"담당 업무 여부\"," + 
				"        la.title AS \"제목\"," + 
				"        la.alarm_date AS \"알람 일시\"," + 
				"        la.simple_content AS \"간단 내용\"," + 
				"        la.full_content AS \"상세 내용\"," + 
				"        la.check_yn AS \"확인 여부\"," + 
				"        m.name AS \"이름\", " + 
				"        la.writer_idx AS \"작성자IDX\"," + 
				"        m.profile_img AS \"프로필주소\"," + 
				"        CASE" + 
				"            WHEN (SYSDATE - la.alarm_date) * 24 < 1" + 
				"            THEN TO_CHAR(ROUND((SYSDATE - la.alarm_date) * 24 * 60), '9999') || '분 전'" + 
				"            WHEN (SYSDATE - la.alarm_date) * 24 < 24 " + 
				"            THEN TO_CHAR(ROUND((SYSDATE - la.alarm_date) * 24), '9999') || '시간 전'" + 
				"            ELSE TO_CHAR(la.alarm_date, 'YYYY-MM-DD HH24:MI:SS')" + 
				"        END AS \"알람안내일시\"," + 
				"        CASE" + 
				"            WHEN la.company_idx IS NOT NULL THEN TO_CHAR(la.company_idx) || '회사'" + 
				"            WHEN la.board_idx IS NOT NULL THEN TO_CHAR(la.board_idx) || '보드'" + 
				"            WHEN la.comment_idx IS NOT NULL THEN TO_CHAR(la.comment_idx) || '댓글'" + 
				"        END AS \"좌표\"" + 
				" FROM    live_alarm la" + 
				" INNER JOIN members m ON la.writer_idx = m.member_idx" + 
				" WHERE   la.member_idx = ?" + 
				" AND     (title LIKE ? OR simple_content LIKE ? OR full_content LIKE ?)" + 
				" "+m+"" + 
				" ORDER BY la.alarm_date DESC";
		ArrayList<LiveAlarmDto> listRet = new ArrayList<LiveAlarmDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, memberIdx);
		pstmt.setString(2, "%"+str+"%");
		pstmt.setString(3, "%"+str+"%");
		pstmt.setString(4, "%"+str+"%");
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int liveAlarmIdx = rs.getInt("실시간 알림IDX");
			int boardIdx = rs.getInt("게시물");
			int companyIdx = rs.getInt("회사");
			int commentIdx = rs.getInt("댓글");
			char mentionMeYn = rs.getString("나를언급 여부").charAt(0);
			char myBoardYn = rs.getString("내 게시물 여부").charAt(0);
			char workYn = rs.getString("담당 업무 여부").charAt(0);
			String title = rs.getString("제목");
			String alarmDate = rs.getString("알람 일시");
			String simpleContent = rs.getString("간단 내용");
			String fullContent = rs.getString("상세 내용");
			char checkYn = rs.getString("확인 여부").charAt(0);
			String writerName = rs.getString("이름");
			String writerProf = rs.getString("프로필주소");
			int writerIdx = rs.getInt("작성자IDX");
			String alarmInfoDate = rs.getString("알람안내일시");
			String coordinate = rs.getString("좌표");
			LiveAlarmDto dto = new LiveAlarmDto(liveAlarmIdx, boardIdx, companyIdx, commentIdx, mentionMeYn, myBoardYn, workYn, title, alarmDate, simpleContent, fullContent, checkYn, writerName, writerProf, alarmInfoDate, writerIdx, coordinate);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	
//	모두읽음 처리
	public void allReadFunc(int memberIdx) throws Exception {
		String sql = "UPDATE live_alarm SET check_yn = 'Y' WHERE member_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, memberIdx);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	
//	실시간 알림 테이블 INSERT
	public void addLiveAlarm(int memberIdx, String title, String simpleContent, String fullContent, Integer companyIdx, Integer boardIdx, Integer commentIdx, char mentionMeYN, char myBoardYN, char workYN, int writerIdx) throws Exception {
		String sql = "INSERT INTO live_alarm (live_alarm_idx, member_idx, title, simple_content, full_content, company_idx, board_idx, comment_idx, mention_me_yn, my_board_yn, work_yn, writer_idx)" + 
				" VALUES(SEQ_LIVE_ALARM.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, memberIdx);
		pstmt.setString (2, title);
		pstmt.setString (3, simpleContent);
		pstmt.setString (4, fullContent);
		if(companyIdx != null) {
			pstmt.setInt (5, companyIdx);
		}else {
			pstmt.setNull(5, Types.NUMERIC);
		}
		if(boardIdx != null) {
			pstmt.setInt (6, boardIdx);
		}else {
			pstmt.setNull(6, Types.NUMERIC);
		}
		if(commentIdx != null) {
			pstmt.setInt (7, commentIdx);
		}else {
			pstmt.setNull(7, Types.NUMERIC);
		}
		pstmt.setString(8, mentionMeYN+"");
		pstmt.setString(9, myBoardYN+"");
		pstmt.setString(10, workYN+"");
		pstmt.setInt(11, writerIdx);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	// 미확인 알림 갯수 가져오기
	public int getNotReadAlarmCnt(int memberIdx) throws Exception {
		String sql = "SELECT  COUNT(live_alarm_idx) AS \"미확인알람수\"" + 
				" FROM    live_alarm" + 
				" WHERE   member_idx = ?" + 
				" AND     check_yn = 'N'";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, memberIdx);
		ResultSet rs = pstmt.executeQuery();
		int ret = 0;
		if(rs.next()) {
			ret = rs.getInt("미확인알람수");
		}
		rs.close();
		pstmt.close();
		conn.close();
		return ret;
	}
	// 알림 읽을처리 기능
	public void setAlarmSelectReadFunc(int liveAlarmIdx) throws Exception {
		String sql = "UPDATE live_alarm SET check_yn = 'Y' WHERE live_alarm_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, liveAlarmIdx);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	
	public static void main(String[] args) throws Exception{
		LiveAlarmDao ladao = new LiveAlarmDao();
		
//		int cnt = ladao.getNotReadAlarmCnt(2);
		
		
//		ladao.addLiveAlarm(2, "제목", "간단내용", "상세내용", null, 1, null, 'N', 'N', 'N', 2);
		
		
//		ladao.allReadFunc(2);
		
//		ArrayList<LiveAlarmDto> LiveAlarmList = ladao.getLiveAlarmSearchList(memberIdx, checkYN, mentionMeYN, myBoardYN, workYN, str)
//		ArrayList<LiveAlarmDto> LiveAlarmList = ladao.getLiveAlarmSearchList(2, 'N', 'Y', 'N', 'N', "");
//		for(LiveAlarmDto dto : LiveAlarmList) {
//			System.out.println("실시간 알림IDX : "+dto.getLiveAlarmIdx());
//			System.out.println("작성자 : "+dto.getWriterName());
//			System.out.println("작성자프로필 : "+dto.getWriterProf());
//			System.out.println("게시물IDX : "+dto.getBoardIdx());
//			System.out.println("회사IDX : "+dto.getCompanyIdx());
//			System.out.println("댓글IDX : "+dto.getCommentIdx());
//			System.out.println("나를언급 여부 : "+dto.getMentionMeYn());
//			System.out.println("내 게시물 여부 : "+dto.getMyBoardYn());
//			System.out.println("담당 업무 여부 : "+dto.getWorkYn());
//			System.out.println("제목 : "+dto.getTitle());
//			System.out.println("알람 일시 : "+dto.getAlarmDate());
//			System.out.println("간단 내용 : "+dto.getSimpleContent());
//			System.out.println("상세 내용 : "+dto.getFullContent());
//			System.out.println("확인 여부 : "+dto.getCheckYN());
//			System.out.println("좌표 : "+dto.getCoordinate());
//			System.out.println("-----------------------------------------");
//		}
	}
}