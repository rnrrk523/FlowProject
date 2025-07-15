package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import dto.UseRecordDto;

public class UseRecordDao {
	public Connection getConnection() throws Exception{
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@//114.207.245.107:1521/XE";
		String id = "FLOW";
		String pw = "1234";
		
		Class.forName(driver);
		Connection conn = DriverManager.getConnection(url, id, pw);
		
		return conn;
	}
	
//	[SH-71] - 사용 통계 검색 (p44-1)
//	-input : company_idx(숫자), 검색 기준(문자열), 검색할 텍스트(문자열),
//		   검색할 시작날짜(문자열), 검색할 끝날짜(문자열)
//	-output : ArrayList<UseRecordDto>
	public ArrayList<UseRecordDto> getUseRecordSearch(int companyIdx, String standard, String str, String startDate, String endDate) throws Exception{
		String m = null;
		if(standard.equals("이름")) {
			m = "m.name";
		}else if(standard.equals("부서")) {
			m = "d.department_name";
		}else if(standard.equals("직책")) {
			m = "m.position";
		}else if(standard.equals("이메일")) {
			m = "m.email";
		}
		String sql = "SELECT  c.company_name AS \"회사명\"," + 
				"        m.member_idx AS \"회원IDX\"," + 
				"        m.name AS \"이름\"," + 
				"        d.department_name AS \"부서\"," + 
				"        m.position AS \"직책\"," + 
				"        m.email AS \"이메일\"" + 
				" FROM    companies c" + 
				" INNER JOIN members m" + 
				" ON      c.company_idx = m.company_idx" + 
				" INNER JOIN departments d" + 
				" ON      m.department_idx = d.department_idx" + 
				" INNER JOIN use_record ur" + 
				" ON      m.member_idx = ur.member_idx" + 
				" WHERE   ur.use_date BETWEEN TO_DATE(?, 'YYYY-MM-DD') AND TO_DATE(?, 'YYYY-MM-DDHH24:MI:SS')" + 
				" AND     "+m+" LIKE ?" + 
				" AND     m.company_idx = ?";
		ArrayList<UseRecordDto> listRet = new ArrayList<UseRecordDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, startDate);
		pstmt.setString(2, endDate+" 23:59:59");
		pstmt.setString(3, "%"+str+"%");
		pstmt.setInt(4, companyIdx);
		
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int memberIdx = rs.getInt("회원IDX");
			String cName = rs.getString("회사명");
			String mName = rs.getString("이름");
			String dName = rs.getString("부서");
			String position = rs.getString("직책");
			String email = rs.getString("이메일");
			
			String sql2 = "SELECT  DISTINCT COUNT(b.board_idx) AS \"게시물 작성 수\"" + 
					" FROM    members m" + 
					" INNER JOIN board b" + 
					" ON      m.member_idx = b.writer_idx" + 
					" WHERE   m.member_idx = "+memberIdx+"" + 
					" AND     b.write_date BETWEEN " + 
					"        TO_DATE(?, 'YYYY-MM-DD')" + 
					" AND     TO_DATE(?, 'YYYY-MM-DD')" + 
					" GROUP BY b.writer_idx";
			PreparedStatement pstmt2 = conn.prepareStatement(sql2);
			pstmt2.setString(1, startDate);
			pstmt2.setString(2, endDate);
			ResultSet rs2 = pstmt2.executeQuery();
			int boardUseCnt = 0;
			if(rs2.next()) {
				boardUseCnt = rs2.getInt("게시물 작성 수");
			}
			rs2.close();
			pstmt2.close();
			
			String sql3 = "SELECT  DISTINCT COUNT(c.comment_idx) AS \"댓글 작성 수\"" + 
					" FROM    members m" + 
					" INNER JOIN board b" + 
					" ON      m.member_idx = b.writer_idx" + 
					" INNER JOIN comments c" + 
					" ON      b.board_idx = c.board_idx" + 
					" WHERE   m.member_idx = "+memberIdx+"" + 
					" AND     c.write_time BETWEEN " + 
					"        TO_DATE(?, 'YYYY-MM-DD')" + 
					" AND     TO_DATE(?, 'YYYY-MM-DD')" + 
					" GROUP BY c.writer_idx";
			PreparedStatement pstmt3 = conn.prepareStatement(sql3);
			pstmt3.setString(1, startDate);
			pstmt3.setString(2, endDate);
			ResultSet rs3 = pstmt3.executeQuery();
			int commentUseCnt = 0;
			if(rs3.next()) {
				commentUseCnt = rs3.getInt("댓글 작성 수");
			}
			rs3.close();
			pstmt3.close();
			
			String sql4 = "SELECT  DISTINCT COUNT(cr.chat_room_idx) AS \"채팅방 개설 수\"" + 
					" FROM    members m" + 
					" INNER JOIN chat_room cr" + 
					" ON      m.member_idx = cr.creater_chat_idx" + 
					" WHERE   m.member_idx = "+memberIdx+"" + 
					" AND     cr.chat_room_open_date BETWEEN " + 
					"         TO_DATE(?, 'YYYY-MM-DD')" + 
					" AND     TO_DATE(?, 'YYYY-MM-DD')" + 
					" GROUP BY cr.creater_chat_idx";
			PreparedStatement pstmt4 = conn.prepareStatement(sql4);
			pstmt4.setString(1, startDate);
			pstmt4.setString(2, endDate);
			ResultSet rs4 = pstmt4.executeQuery();
			int chatRoomUseCnt = 0;
			if(rs4.next()) {
				chatRoomUseCnt = rs4.getInt("채팅방 개설 수");
			}
			rs4.close();
			pstmt4.close();
			
			String sql5 = "SELECT  DISTINCT COUNT(cr.chat_room_idx) AS \"채팅메시지 사용 수\"" + 
					" FROM    members m" + 
					" INNER JOIN chat_room cr" + 
					" ON      m.member_idx = cr.creater_chat_idx" + 
					" WHERE   m.member_idx = "+memberIdx+"" + 
					" AND     cr.chat_room_open_date BETWEEN " + 
					"         TO_DATE(?, 'YYYY-MM-DD')" + 
					" AND     TO_DATE(?, 'YYYY-MM-DD')" + 
					" GROUP BY cr.creater_chat_idx";
			PreparedStatement pstmt5 = conn.prepareStatement(sql5);
			pstmt5.setString(1, startDate);
			pstmt5.setString(2, endDate);
			ResultSet rs5 = pstmt5.executeQuery();
			int chatUseCnt = 0;
			if(rs5.next()) {
				chatUseCnt = rs5.getInt("채팅메시지 사용 수");
			}
			rs5.close();
			pstmt5.close();
			
			UseRecordDto dto = new UseRecordDto(companyIdx, memberIdx, cName, mName, dName, position, email, boardUseCnt, commentUseCnt, chatRoomUseCnt, chatUseCnt);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	public static void main(String[] args) throws Exception{
		UseRecordDao udao = new UseRecordDao();
		
		ArrayList<UseRecordDto> useRecordList = udao.getUseRecordSearch(1, "이름", "", "2024-11-01", "2024-11-30");
		for(UseRecordDto dto : useRecordList) {
			System.out.println("회사명  : "+dto.getcName());
			System.out.println("이름  : "+dto.getmName());
			System.out.println("부서  : "+dto.getdName());
			System.out.println("직책  : "+dto.getPosition());
			System.out.println("이메일  : "+dto.getEmail());
			System.out.println("게시물 작성 수  : "+dto.getBoardUseCnt());
			System.out.println("댓글  입력 수  : "+dto.getCommentUseCnt());
			System.out.println("채팅방 개설 수  : "+dto.getChatRoomUseCnt());
			System.out.println("채팅 메시지 수  : "+dto.getChatUseCnt());
			System.out.println("------------------------------------------------------");
		}
	}
}
