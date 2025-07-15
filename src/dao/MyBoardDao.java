package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import dto.BookmarkSideTabDto;
import dto.MyBoardSideTabDto;

public class MyBoardDao {
	public Connection getConnection() throws Exception{
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@//114.207.245.107:1521/XE";
		String id = "FLOW";
		String pw = "1234";
		
		Class.forName(driver);
		Connection conn = DriverManager.getConnection(url, id, pw);
		
		return conn;
	}
	
	// 내 게시물 사이드탭 열기
	public ArrayList<MyBoardSideTabDto> getSidetabMyBoardOpen(int memberIdx) throws Exception{
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
				" INNER JOIN members m" + 
				" ON      m.member_idx = b.writer_idx" + 
				" WHERE   b.writer_idx = ?" + 
				" ORDER BY b.write_date DESC";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, memberIdx);
		ArrayList<MyBoardSideTabDto> listRet = new ArrayList<MyBoardSideTabDto>();
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int boardIdx = rs.getInt("게시물IDX");
			int projectIdx = rs.getInt("프로젝트IDX");
			int writerIdx = rs.getInt("작성자IDX");
			String boardTitle = rs.getString("게시물제목");
			String projectName = rs.getString("프로젝트이름");
			String boardCategory = rs.getString("게시물카테고리");
			String writerName = rs.getString("작성자이름");
			String writeDate = rs.getString("작성날짜");
			MyBoardSideTabDto dto = new MyBoardSideTabDto(boardIdx, projectIdx, boardTitle, projectName, boardCategory, writerIdx, writerName, writeDate);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	
	// 내 게시물 사이드탭 옵션을 통한 검색
	public ArrayList<MyBoardSideTabDto> getSidetabMyBoardOptionSearch(int memberIdx, String projectSearchName, String writerSearchName, String selectSearchDate, String selectTarget) throws Exception {
		String m = "";
		if(selectSearchDate.equals("오늘")) {
			m = " AND     b.write_date BETWEEN TRUNC(SYSDATE) AND TRUNC(SYSDATE) + INTERVAL '1' DAY - INTERVAL '1' SECOND";
		}else if(selectSearchDate.equals("전체")) {
			m = "";
		}else if(selectSearchDate.equals("7일")) {
			m = " AND b.write_date BETWEEN SYSDATE - INTERVAL '7' DAY AND SYSDATE";
		}else if(selectSearchDate.equals("1개월")) {
			m = " AND b.write_date >= ADD_MONTHS(SYSDATE, -1)";
		}else if(selectSearchDate.equals("3개월")) {
			m = " AND b.write_date >= ADD_MONTHS(SYSDATE, -3)";
		}else if(selectSearchDate.equals("6개월")) {
			m = " AND b.write_date >= ADD_MONTHS(SYSDATE, -6)";
		}else if(selectSearchDate.equals("1년")) {
			m = " AND b.write_date >= ADD_MONTHS(SYSDATE, -12)";
		}
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
				" INNER JOIN members m" + 
				" ON      m.member_idx = b.writer_idx" + 
				" WHERE   b.writer_idx = ?" + 
				" "+m+"" + 
				" AND     p.project_name LIKE ?" + 
				" AND     m.name LIKE ?" + 
				" AND     b.category LIKE ?" + 
				" ORDER BY b.write_date DESC";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, memberIdx);
		pstmt.setString(2, "%"+projectSearchName+"%");
		pstmt.setString(3, "%"+writerSearchName+"%");
		switch(selectTarget) {
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
		ArrayList<MyBoardSideTabDto> listRet = new ArrayList<MyBoardSideTabDto>();
		while(rs.next()) {
			int boardIdx = rs.getInt("게시물IDX");
			int projectIdx = rs.getInt("프로젝트IDX");
			String boardTitle = rs.getString("게시물제목");
			String projectName = rs.getString("프로젝트이름");
			String boardCategory = rs.getString("게시물카테고리");
			int writerIdx = rs.getInt("작성자IDX");
			String writerName = rs.getString("작성자이름");
			String writeDate = rs.getString("작성날짜");
			MyBoardSideTabDto dto = new MyBoardSideTabDto(boardIdx, projectIdx, boardTitle, projectName, boardCategory, writerIdx, writerName, writeDate);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	
	// 내 게시물 사이드탭 텍스트검색
	public ArrayList<MyBoardSideTabDto> getSidetabMyBoardTextSearch(int memberIdx, String str) throws Exception {
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
				" INNER JOIN members m" + 
				" ON      m.member_idx = b.writer_idx" + 
				" WHERE   b.writer_idx = ?" + 
				" AND     (m.name LIKE ? OR p.project_name LIKE ? OR b.title LIKE ?)" + 
				" ORDER BY b.write_date DESC";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, memberIdx);
		pstmt.setString(2, "%"+str+"%");
		pstmt.setString(3, "%"+str+"%");
		pstmt.setString(4, "%"+str+"%");
		ResultSet rs = pstmt.executeQuery();
		ArrayList<MyBoardSideTabDto> listRet = new ArrayList<MyBoardSideTabDto>();
		while(rs.next()) {
			int boardIdx = rs.getInt("게시물IDX");
			int projectIdx = rs.getInt("프로젝트IDX");
			int writerIdx = rs.getInt("작성자IDX");
			String boardTitle = rs.getString("게시물제목");
			String projectName = rs.getString("프로젝트이름");
			String boardCategory = rs.getString("게시물카테고리");
			String writerName = rs.getString("작성자이름");
			String writeDate = rs.getString("작성날짜");
			MyBoardSideTabDto dto = new MyBoardSideTabDto(boardIdx, projectIdx, boardTitle, projectName, boardCategory, writerIdx, writerName, writeDate);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	
	public static void main(String[] args) {
		MyBoardDao mDao = new MyBoardDao();
		ArrayList<MyBoardSideTabDto> list = new ArrayList<MyBoardSideTabDto>();
		try {
			list = mDao.getSidetabMyBoardOptionSearch(2, "", "", "1년", "일정");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		for(MyBoardSideTabDto dto : list) {
			System.out.println(dto.getBoardTitle());
		}
	}
}