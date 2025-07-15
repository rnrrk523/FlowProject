package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import dto.ProjectAlarmListDto;

public class ProjectAlarmDao {
	public Connection getConnection() throws Exception{
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@//114.207.245.107:1521/XE";
		String id = "FLOW";
		String pw = "1234";
		
		Class.forName(driver);
		Connection conn = DriverManager.getConnection(url, id, pw);
		
		return conn;
	}
	
//	[SH-92] - 프로젝트 알림 목록 검색 조회하기 (p128)
//	-input : project_idx(숫자),
//		   검색어(문자열), 검색기준(문자열)[전체, 내용만, 작성자만]
//	-output : ArrayList<ProjectAlarmListDto>
	public ArrayList<ProjectAlarmListDto> getProjectAlarmList(int projectIdx, String str, String standard) throws Exception{
		String m = "";
		if(standard.equals("전체")) {
			m = "AND     (pa.content LIKE ? OR m.name LIKE ?)";
		}else if(standard.equals("내용만")) {
			m = "AND     pa.content LIKE ?";
		}else if(standard.equals("작성자만")) {
			m = "AND     m.name LIKE ?";
		}
		String sql = "SELECT  m.member_idx AS \"회원IDX\"," + 
				"        m.name AS \"작성자\"," + 
				"        pa.title AS \"제목\"," + 
				"        pa.type AS \"유형\"," + 
				"        pa.content AS \"내용\"," + 
				"        m.profile_img AS \"작성자프로필\"," + 
				"        pa.alarm_date AS \"알람 일시\"" + 
				" FROM    project_alarm pa" + 
				" INNER JOIN members m" + 
				" ON      pa.member_idx = m.member_idx" + 
				" WHERE   pa.project_idx = ?" + 
				" "+m+"";
		ArrayList<ProjectAlarmListDto> listRet = new ArrayList<ProjectAlarmListDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, projectIdx);
		pstmt.setString(2, "%"+str+"%");
		if(standard.equals("전체"))
			pstmt.setString(3, "%"+str+"%");
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int memberIdx = rs.getInt("회원IDX");
			String memberName = rs.getString("작성자");
			String type = rs.getString("유형");
			String content = rs.getString("내용");
			String alarmDate = rs.getString("알람 일시");
			String title = rs.getString("제목");
			String prof = rs.getString("작성자프로필");
			ProjectAlarmListDto dto = new ProjectAlarmListDto(memberIdx, memberName, type, content, alarmDate, title, prof);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	
	// 게시물 댓글작성 시 프로젝트알람 INSERT
	public void setProjectAlarmCommentWrite(int projectIdx, int memberIdx, String type, String content, String WriterName, String write) throws Exception {
		String sql = "INSERT INTO project_alarm(project_idx, member_idx, type, content, alarm_date, read_yn, title) VALUES(?, ?, ?, ?, SYSDATE, 'N', ?)";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, projectIdx);
		pstmt.setInt(2, memberIdx);
		pstmt.setString(3, type);
		pstmt.setString(4, "게시글명 : "+content+"<br/>내용 : "+WriterName+"님이 " + type + "을 "+write+"했습니다.");
		pstmt.setString(5, WriterName);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	
	public static void main(String[] args) throws Exception{
		ProjectAlarmDao padao = new ProjectAlarmDao();
		
		
//		ArrayList<ProjectAlarmListDto> projectAlarmList = padao.getProjectAlarmList(1, "", "전체");
//		for(ProjectAlarmListDto dto : projectAlarmList) {
//			System.out.println("작성자 : "+dto.getMemberName());
//			System.out.println("유형 : "+dto.getType());
//			System.out.println("내용 : "+dto.getContent());
//			System.out.println("알람 일시 : "+dto.getAlarmDate());
//			System.out.println("--------------------------------");
//		}
	}
}