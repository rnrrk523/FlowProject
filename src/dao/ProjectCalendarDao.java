package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import dto.ScheduleCalendarDto;
import dto.TaskCalendarDto;

public class ProjectCalendarDao {
	public Connection getConnection() throws Exception{
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@//114.207.245.107:1521/XE";
		String id = "FLOW";
		String pw = "1234";
		
		Class.forName(driver);
		Connection conn = DriverManager.getConnection(url, id, pw);
		
		return conn;
	}
	
//	[SH-83] - 캘린더 업무 검색 조회하기 (p118)
//	-input : project_idx(숫자), member_idx(숫자), 검색기준(문자열)[내 업무, 요청한 업무, 전체]
//	-output : ArrayList<TaskCalendarDto>
	public ArrayList<TaskCalendarDto> getTaskCalendarList(int projectIdx, int memberIdx, String standard, String str) throws Exception{
		String m = "";
		if(standard.equals("내 업무")) {
			m = "AND     tm.member_idx = ?";
		}else if(standard.equals("요청한 업무")) {
			m = "AND     t.writer_idx = ?";
		}else if(standard.equals("선택안함")) {
			m = "AND     t.task_idx = 0";
		}
		String sql = "SELECT  DISTINCT t.task_idx," + 
				"        (CASE WHEN t.state = 1 THEN '요청'" + 
				"            WHEN t.state = 2 THEN '진행'" + 
				"            WHEN t.state = 3 THEN '피드백'" + 
				"            WHEN t.state = 4 THEN '완료'" + 
				"            WHEN t.state = 5 THEN '보류' END) AS \"상태\"," + 
				"        COALESCE(t.title, b.title) AS \"제목\"," + 
				"        t.start_date AS \"시작일\"," + 
				"        t.end_date AS \"마감일\"" + 
				" FROM    task t" + 
				" INNER JOIN board b" + 
				" ON      t.board_idx = b.board_idx" + 
				" FULL OUTER JOIN projects p" + 
				" ON      p.project_idx = b.project_idx" + 
				" FULL OUTER JOIN task_manager tm" + 
				" ON      t.task_idx = tm.task_idx" + 
				" WHERE   p.project_idx = ?" + 
				" AND     COALESCE(t.title, b.title) LIKE ?" + 
				" "+m+"" +
				" ORDER BY t.start_date, t.task_idx";
		ArrayList<TaskCalendarDto> listRet = new ArrayList<TaskCalendarDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, projectIdx);
		pstmt.setString(2, "%"+str+"%");
		if(!standard.equals("전체") && !standard.equals("선택안함")) {
			pstmt.setInt(3, memberIdx);
		}
		
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int taskIdx = rs.getInt("task_idx");
			String title = rs.getString("제목");
			String startDate = rs.getString("시작일");
			String endDate = rs.getString("마감일");
			String state = rs.getString("상태");
			TaskCalendarDto dto = new TaskCalendarDto(taskIdx, title, startDate, endDate, state);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	
	// (사이드탭 캘린더)모든 업무 가져오기
	public ArrayList<TaskCalendarDto> getAllTaskList(int memberIdx, String standard, String str) throws Exception{
		String m = "";
		if(standard.equals("내 업무")) {
			m = "AND     tm.member_idx = ?";
		}else if(standard.equals("요청한 업무")) {
			m = "AND     t.writer_idx = ?";
		}else if(standard.equals("선택안함")) {
			m = "AND     t.task_idx = 0";
		}
		String sql = "SELECT  DISTINCT t.task_idx," + 
				"        (CASE WHEN t.state = 1 THEN '요청'" + 
				"            WHEN t.state = 2 THEN '진행'" + 
				"            WHEN t.state = 3 THEN '피드백'" + 
				"            WHEN t.state = 4 THEN '완료'" + 
				"            WHEN t.state = 5 THEN '보류' END) AS \"상태\"," + 
				"        COALESCE(t.title, b.title) AS \"제목\"," + 
				"        t.start_date AS \"시작일\"," + 
				"        t.end_date AS \"마감일\"" + 
				" FROM    task t" + 
				" INNER JOIN board b" + 
				" ON      t.board_idx = b.board_idx" + 
				" FULL OUTER JOIN projects p" + 
				" ON      p.project_idx = b.project_idx" + 
				" FULL OUTER JOIN task_manager tm" + 
				" ON      t.task_idx = tm.task_idx" + 
				" WHERE   COALESCE(t.title, b.title) LIKE ?" + 
				" "+m+"" +
				" ORDER BY t.start_date, t.task_idx";
		ArrayList<TaskCalendarDto> listRet = new ArrayList<TaskCalendarDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, "%"+str+"%");
		if(!standard.equals("전체") && !standard.equals("선택안함")) {
			pstmt.setInt(2, memberIdx);
		}
		
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int taskIdx = rs.getInt("task_idx");
			String title = rs.getString("제목");
			String startDate = rs.getString("시작일");
			String endDate = rs.getString("마감일");
			String state = rs.getString("상태");
			TaskCalendarDto dto = new TaskCalendarDto(taskIdx, title, startDate, endDate, state);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}

	public static void main(String[] args) throws Exception{
		ProjectCalendarDao pcdao = new ProjectCalendarDao();
		
		ArrayList<TaskCalendarDto> taskList = pcdao.getTaskCalendarList(1, 2, "전체", "");
		for(TaskCalendarDto dto : taskList) {
			System.out.println(dto.getTaskIdx());
			System.out.println(dto.getTitle());
		}
	}
}