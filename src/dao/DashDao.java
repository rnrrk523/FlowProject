package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import dto.BoardTopFixedDto;
import dto.DashboardDto;
import dto.GoToDto;
import dto.RequestTaskDto;

public class DashDao {
	public Connection getConnection() throws Exception {
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@//114.207.245.107:1521/XE";
		String id = "FLOW";
		String pw = "1234";
		
		Class.forName(driver);
		Connection conn = DriverManager.getConnection(url, id, pw);
		
		return conn;
		}
		public ArrayList<DashboardDto> showDashboardWidget(int memberIdx) throws Exception{
			String sql = " SELECT dash_board_idx AS \"위젯번호\", widget_category AS \"위젯\", board_size AS \"사이즈\"" + 
					" FROM DASH_BOARD" + 
					" WHERE MEMBER_IDX = ?" +
					" ORDER BY \"위젯번호\"";
			ArrayList<DashboardDto> listRet = new ArrayList<DashboardDto>();
			Connection conn = getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, memberIdx);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				int dashBoardIdx = rs.getInt("위젯번호");
				int widgetCategory = rs.getInt("위젯");
				int boardSize = rs.getInt("사이즈");
				DashboardDto dto = new DashboardDto(widgetCategory, boardSize, dashBoardIdx);
				listRet.add(dto);
			}
			rs.close();
			pstmt.close();
			conn.close();
			return listRet;
		}
		public void WidgetSize(int size, int dashBoardIdx) throws Exception{
			String sql = "UPDATE DASH_BOARD SET BOARD_SIZE = ? WHERE dash_board_idx = ?";
			Connection conn = getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, size);
			pstmt.setInt(2, dashBoardIdx);
			pstmt.executeUpdate();
			pstmt.close();
			conn.close();
		}
		public void WidgetDelete(int dashBoardIdx) throws Exception{
			String sql = "DELETE DASH_BOARD WHERE dash_board_idx = ?";
			Connection conn = getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dashBoardIdx);
			pstmt.executeUpdate();
			pstmt.close();
			conn.close();
		}
		public ArrayList<RequestTaskDto> requestlist(int filter, int memberIdx) throws Exception {
			String sql = " SELECT T.Task_IDX AS \"업무번호\" ,T.STATE AS \"상태\", B.TITLE AS \"제목\", T.PRIORITY AS \"우선순위\", T.END_DATE AS \"마감일\"" + 
					" FROM TASK T " + 
					" INNER JOIN TASK_MANAGER TM" + 
					" ON T.TASK_IDX = TM.TASK_IDX" + 
					" INNER JOIN BOARD B" + 
					" ON T.BOARD_IDX = B.BOARD_IDX" + 
					" WHERE TM.MEMBER_IDX = ?" + 
					" AND T.END_DATE IS NOT NULL";
			if(filter == 0) {
				sql += " AND TO_CHAR(T.END_DATE,'YYYYMMDD') > TO_CHAR(SYSDATE,'YYYYMMDD')";
			} else {
				sql += " AND TO_CHAR(T.END_DATE,'YYYYMMDD') <= TO_CHAR(SYSDATE,'YYYYMMDD')";
			}
			ArrayList<RequestTaskDto> listRet = new ArrayList<RequestTaskDto>();
			Connection conn = getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, memberIdx);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				int taskIdx = rs.getInt("업무번호");
				int state = rs.getInt("상태") ;
				String title = rs.getString("제목");
				int priority = rs.getInt("우선순위");
				String endDate = rs.getString("마감일");
				RequestTaskDto dto = new RequestTaskDto(taskIdx, state, title, priority, endDate);
				listRet.add(dto);
			}
			rs.close();
			pstmt.close();
			conn.close();
			return listRet;
		}
		public int requestCount(int filter, int memberIdx) throws Exception {
			String sql = " SELECT count(B.BOARD_IDX)" + 
					" FROM TASK T " + 
					" INNER JOIN TASK_MANAGER TM" + 
					" ON T.TASK_IDX = TM.TASK_IDX" + 
					" INNER JOIN BOARD B" + 
					" ON T.BOARD_IDX = B.BOARD_IDX" + 
					" WHERE TM.MEMBER_IDX = ?" + 
					" AND T.END_DATE IS NOT NULL";
			if(filter == 0) {
				sql += " AND TO_CHAR(T.END_DATE,'YYYYMMDD') > TO_CHAR(SYSDATE,'YYYYMMDD')";
			} else {
				sql += " AND TO_CHAR(T.END_DATE,'YYYYMMDD') <= TO_CHAR(SYSDATE,'YYYYMMDD')";
			}
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
		public ArrayList<GoToDto> GoToList(int companyIdx) throws Exception {
			String sql = " SELECT " + 
					"    URL AS \"주소\"," + 
					"    NAME AS \"이름\"," + 
					"    ICON AS \"아이콘\"" + 
					" FROM GO_TO" + 
					" WHERE company_Idx = ?" + 
					" AND state_yn = 'Y'";
			Connection conn = getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ArrayList<GoToDto> listRet = new ArrayList<GoToDto>();
			pstmt.setInt(1, companyIdx);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				String url = rs.getString("주소");
				String name = rs.getString("이름");
				String icon = rs.getString("아이콘");
				GoToDto dto = new GoToDto(url, name, icon);
				listRet.add(dto);
			}
			rs.close();
			pstmt.close();
			conn.close();
			return listRet;
		}
	public static void main(String[] args) {
		DashDao dao = new DashDao();
		try {
			ArrayList<DashboardDto> list = dao.showDashboardWidget(1);
			for(DashboardDto dto : list) {
				System.out.println(dto.getWidgetCategory());
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		try {
			System.out.println(dao.requestCount(0, 1));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
