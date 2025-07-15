package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDateTime;
import java.util.ArrayList;

import dto.BookmarkSideTabDto;

public class BookmarkDao {
	public Connection getConnection() throws Exception{
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@//114.207.245.107:1521/XE";
		String id = "FLOW";
		String pw = "1234";
		
		Class.forName(driver);
		Connection conn = DriverManager.getConnection(url, id, pw);
		
		return conn;
	}
	
	// 사이드탭 북마크 - 옵션을 통해 검색하기
	public ArrayList<BookmarkSideTabDto> getBookmarkSideTabDtoList(int memberIdx, String projectSearchName, String writerSearchName, String searchDate, String target) throws Exception {
		String m = "";
		if(searchDate.equals("오늘")) {
			m = " AND     b.write_date BETWEEN TRUNC(SYSDATE) AND TRUNC(SYSDATE) + INTERVAL '1' DAY - INTERVAL '1' SECOND";
		}else if(searchDate.equals("전체")) {
			m = "";
		}else if(searchDate.equals("7일")) {
			m = " AND b.write_date BETWEEN SYSDATE - INTERVAL '7' DAY AND SYSDATE";
		}else if(searchDate.equals("1개월")) {
			m = " AND b.write_date >= ADD_MONTHS(SYSDATE, -1)";
		}else if(searchDate.equals("3개월")) {
			m = " AND b.write_date >= ADD_MONTHS(SYSDATE, -3)";
		}else if(searchDate.equals("6개월")) {
			m = " AND b.write_date >= ADD_MONTHS(SYSDATE, -6)";
		}else if(searchDate.equals("1년")) {
			m = " AND b.write_date >= ADD_MONTHS(SYSDATE, -12)";
		}
		String sql = "SELECT  b.board_idx AS \"게시물IDX\"," + 
				"        p.project_idx AS \"프로젝트IDX\"," + 
				"        b.title AS \"게시물제목\"," + 
				"        p.project_name AS \"프로젝트이름\"," + 
				"        b.category AS \"게시물카테고리\"," + 
				"        b.writer_idx AS \"작성자IDX\"," + 
				"        b.write_date AS \"작성날짜\"," + 
				"        m.name AS \"작성자이름\"" + 
				" FROM    board b" + 
				" INNER JOIN projects p" + 
				" ON      b.project_idx = p.project_idx" + 
				" INNER JOIN board_bookmark bb" + 
				" ON      bb.board_idx = b.board_idx" + 
				" INNER JOIN members m" + 
				" ON      m.member_idx = bb.member_idx" + 
				" WHERE   bb.member_idx = ?" + 
				" "+m+"" +
				" AND     m.name LIKE ?" +
				" AND     p.project_name LIKE ?" +
				" AND     b.category LIKE ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, memberIdx);
		pstmt.setString(2, "%"+writerSearchName+"%");
		pstmt.setString(3, "%"+projectSearchName+"%");
		switch(target) {
		case "전체": pstmt.setString(4, "%%");
			break;
		case "글": pstmt.setString(4, "글");
			break;
		case "업무": pstmt.setString(4, "업무");
			break;
		case "일정": pstmt.setString(4, "일정");
			break;
		}
		ResultSet rs = pstmt.executeQuery();
		ArrayList<BookmarkSideTabDto> listRet = new ArrayList<BookmarkSideTabDto>();
		while(rs.next()) {
			int boardIdx = rs.getInt("게시물IDX");
			int projectIdx = rs.getInt("프로젝트IDX");
			String boardTitle = rs.getString("게시물제목");
			String projectName = rs.getString("프로젝트이름");
			String boardCategory = rs.getString("게시물카테고리");
			int writerIdx = rs.getInt("작성자IDX");
			String writerName = rs.getString("작성자이름");
			String writeDate = rs.getString("작성날짜");
			BookmarkSideTabDto dto = new BookmarkSideTabDto(boardIdx, projectIdx, boardTitle, projectName, boardCategory, writerIdx, writerName, writeDate);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	
	// 사이드탭 북마크 - 옵션을 통해 검색하기
	public ArrayList<BookmarkSideTabDto> getBookmarkSideTabDtoListStr(int memberIdx, String str) throws Exception {
		String sql = "SELECT  b.board_idx AS \"게시물IDX\", " + 
				"		p.project_idx AS \"프로젝트IDX\"," + 
				"		b.title AS \"게시물제목\"," + 
				"		p.project_name AS \"프로젝트이름\"," + 
				"		b.category AS \"게시물카테고리\"," + 
				"		b.writer_idx AS \"작성자IDX\"," + 
				"		b.write_date AS \"작성날짜\"," + 
				"		m.name AS \"작성자이름\"" + 
				" FROM    board b" + 
				" INNER JOIN projects p" + 
				" ON      b.project_idx = p.project_idx" + 
				" INNER JOIN board_bookmark bb" + 
				" ON      bb.board_idx = b.board_idx" + 
				" INNER JOIN members m" + 
				" ON      m.member_idx = bb.member_idx" + 
				" WHERE   bb.member_idx = ?" + 
				" AND     (m.name LIKE ? OR p.project_name LIKE ? OR b.title LIKE ?)";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, memberIdx);
		pstmt.setString(2, "%"+str+"%");
		pstmt.setString(3, "%"+str+"%");
		pstmt.setString(4, "%"+str+"%");
		ResultSet rs = pstmt.executeQuery();
		ArrayList<BookmarkSideTabDto> listRet = new ArrayList<BookmarkSideTabDto>();
		while(rs.next()) {
			int boardIdx = rs.getInt("게시물IDX");
			int projectIdx = rs.getInt("프로젝트IDX");
			int writerIdx = rs.getInt("작성자IDX");
			String boardTitle = rs.getString("게시물제목");
			String projectName = rs.getString("프로젝트이름");
			String boardCategory = rs.getString("게시물카테고리");
			String writerName = rs.getString("작성자이름");
			String writeDate = rs.getString("작성날짜");
			BookmarkSideTabDto dto = new BookmarkSideTabDto(boardIdx, projectIdx, boardTitle, projectName, boardCategory, writerIdx, writerName, writeDate);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	
	public static void main(String[] args) {
		BookmarkDao bDao = new BookmarkDao();
		
		
		ArrayList<BookmarkSideTabDto> list = null;
		try {
			list = bDao.getBookmarkSideTabDtoListStr(2, "입");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
//		try {// int memberIdx, String projectSearchName, String writerSearchName, String searchDate, String target
//			list = bDao.getBookmarkSideTabDtoList(2, "프", "", "전체", "전체");
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
		for(BookmarkSideTabDto dto : list) {
			System.out.println(dto.getBoardCategory());
		}
	}
}