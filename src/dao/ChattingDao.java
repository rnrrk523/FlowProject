package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import dto.ChatContentsDto;
import dto.ChatNumDto;
import dto.ChatRoomListDto;
import dto.ChattingRoomContentsDto;
import dto.MemberDto;
import dto.ProjectMemberViewDto;

public class ChattingDao {
	public Connection getConnection() throws Exception {
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@//114.207.245.107:1521/XE";
		String id = "FLOW";
		String pw = "1234";
		
		Class.forName(driver);
		Connection conn = DriverManager.getConnection(url, id, pw);
		
		return conn;
		}
	public ArrayList<ChatRoomListDto> ChatRoomList(int memberIdx, String search) throws Exception{
		String sql = " WITH LatestChat AS (" + 
				"    SELECT CHAT_ROOM_IDX, CHAT_IDX, INPUT_DATE_TIME," + 
				"           ROW_NUMBER() OVER (PARTITION BY CHAT_ROOM_IDX ORDER BY INPUT_DATE_TIME DESC) AS rn" + 
				"    FROM CHAT_CONVERSATION" + 
				" )" + 
				" SELECT" + 
				"    C.CHAT_ROOM_IDX AS 채팅방IDX," + 
				"    C.CHAT_ROOM_NAME AS 채팅방이름," + 
				"    C.project_idx AS 프로젝트IDX," + 
				"    C.CREATER_CHAT_IDX AS 작성자IDX," + 
				"    C.GROUP_CHAT_YN AS 그룹챗여부," + 
				"    CC.CONVERSATION AS 마지막채팅내용," + 
				"    TO_CHAR(CC.INPUT_DATE_TIME, 'YYYY-MM-DD') AS 년월일," + 
				"    TO_CHAR(CC.INPUT_DATE_TIME, 'HH:MI') AS 시간분," + 
				"    TO_CHAR(CC.INPUT_DATE_TIME, 'AM') AS 오전오후," + 
				"    (" + 
				"        SELECT COUNT(*)" + 
				"        FROM CHAT_CONVERSATION CC2" + 
				"        WHERE CC2.CHAT_ROOM_IDX = C.CHAT_ROOM_IDX" + 
				"          AND NOT EXISTS (" + 
				"              SELECT 1" + 
				"              FROM CHAT_VIEW CV" + 
				"              WHERE CV.CHAT_IDX = CC2.CHAT_IDX" + 
				"                AND CV.MEMBER_IDX = ?" + 
				"          )" + 
				"    ) AS 읽지않은채팅수" + 
				" FROM CHAT_ROOM C" + 
				" INNER JOIN CHAT_MEMBER CM ON C.chat_room_idx = CM.chat_room_idx" + 
				" INNER JOIN LatestChat LC ON C.CHAT_ROOM_IDX = LC.CHAT_ROOM_IDX AND LC.rn = 1" + 
				" INNER JOIN CHAT_CONVERSATION CC ON LC.CHAT_IDX = CC.CHAT_IDX" + 
				" WHERE CM.member_idx = ?" + 
				" AND C.CHAT_ROOM_NAME LIKE ?" + 
				" ORDER BY CC.INPUT_DATE_TIME DESC";
		ArrayList<ChatRoomListDto> listRet = new ArrayList<ChatRoomListDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, memberIdx);
		pstmt.setInt(2, memberIdx);
		pstmt.setString(3, "%"+search+"%");
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int chatRoomIdx = rs.getInt("채팅방IDX"); 
		    String chatRoomName = rs.getString("채팅방이름");
		    int projectIdx = rs.getInt("프로젝트IDX");
		    int createrChatIdx = rs.getInt("작성자IDX");
		    char groupChatYN = rs.getString("그룹챗여부").charAt(0);
		    String Conversation = rs.getString("마지막채팅내용") ;
		    String date = rs.getString("년월일");
		    String time = rs.getString("시간분");
		    String amPm = rs.getString("오전오후");
		    int readNotCount = rs.getInt("읽지않은채팅수");
		    ChatRoomListDto dto = new ChatRoomListDto(chatRoomIdx, chatRoomName, projectIdx, createrChatIdx, groupChatYN, Conversation, date, time, amPm, readNotCount);
		    listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	public int ChatRoomIdx() throws Exception {
		String sql = "SELECT last_number From user_sequences where sequence_name = 'SEQ_CHATROOM_IDX'";
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
	public void ChatCreate(String title, int writer) throws Exception {
		String sql = "Insert into chat_room values(SEQ_CHATROOM_IDX.nextval,?,?,null,'Y')";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, title);
		pstmt.setInt(2, writer);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	public void ChatCreateProject(String title, int writer, int projectIdx) throws Exception {
		String sql = "Insert into chat_room values(SEQ_CHATROOM_IDX.nextval,?,?,?,'Y')";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, title);
		pstmt.setInt(2, writer);
		pstmt.setInt(3, projectIdx);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	public void ChatMemberInsert(int chatIdx, int memberIdx, char admin) throws Exception {
		String sql = "Insert into CHAT_MEMBER values(?,?,null,'N','N',12,?)";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, chatIdx);
		pstmt.setInt(2, memberIdx);
		pstmt.setString(3, String.valueOf(admin));
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	public ArrayList<ChatNumDto> ChatNumber(int memberIdx) throws Exception {
		String sql = "SELECT cv.chat_idx AS \"채팅번호\"" + 
				" FROM CHAT_ROOM CR" + 
				" INNER JOIN CHAT_MEMBER CM" + 
				" ON cr.chat_room_idx = cm.chat_room_idx" + 
				" INNER JOIN CHAT_CONVERSATION CV" + 
				" ON cr.chat_room_idx = cv.chat_room_idx" + 
				" WHERE cm.member_idx = ?" + 
				" AND NOT EXISTS (" + 
				"    SELECT 1" + 
				"    FROM CHAT_VIEW CVW" + 
				"    WHERE CVW.chat_idx = CV.chat_idx" + 
				"    AND CVW.member_idx = ?" + 
				" )" + 
				" ORDER BY CHAT_IDX";
		ArrayList<ChatNumDto> listRet = new ArrayList<ChatNumDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, memberIdx);
		pstmt.setInt(2, memberIdx);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int chatIdx = rs.getInt("채팅번호");
			ChatNumDto dto = new ChatNumDto(chatIdx);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	public void ReadChat (int memberIdx, int ChatIdx) throws Exception {
		String sql = "Insert into chat_view values (?,?)";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, ChatIdx);
		pstmt.setInt(2, memberIdx);	
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	public int NotReadALLCheck(int memberIdx) throws Exception {
		String sql = "SELECT COUNT(cv.chat_idx)" + 
				" FROM CHAT_ROOM CR" + 
				" INNER JOIN CHAT_MEMBER CM" + 
				" ON cr.chat_room_idx = cm.chat_room_idx" + 
				" INNER JOIN CHAT_CONVERSATION CV" + 
				" ON cr.chat_room_idx = cv.chat_room_idx" + 
				" WHERE cm.member_idx = ?" + 
				" AND NOT EXISTS (" + 
				"    SELECT 1" + 
				"    FROM CHAT_VIEW CVW" + 
				"    WHERE CVW.chat_idx = CV.chat_idx" + 
				"    AND CVW.member_idx = ?" + 
				" )";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, memberIdx);
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
	//해당 멤버 두명이 있는 채팅방 찾기
	public int ChattingRoomIdxSearch(int memberidx1, int memberidx2) throws Exception {
		String sql = " SELECT CHAT_ROOM_IDX AS \"채팅방번호\"" + 
				" FROM CHAT_MEMBER" + 
				" WHERE CHAT_ROOM_IDX IN (" + 
				"    SELECT CHAT_ROOM_IDX" + 
				"    FROM CHAT_MEMBER" + 
				"    GROUP BY CHAT_ROOM_IDX" + 
				"    HAVING COUNT(MEMBER_IDX) = 2" + 
				" )" + 
				" AND MEMBER_IDX IN (?, ?)" + 
				" GROUP BY CHAT_ROOM_IDX" + 
				" HAVING COUNT(DISTINCT MEMBER_IDX) = 2";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, memberidx1);
		pstmt.setInt(2, memberidx2);
		ResultSet rs = pstmt.executeQuery();
		int chatRoomIdx = 0;
		if(rs.next()) {
			chatRoomIdx = rs.getInt("채팅방번호");
		}
		rs.close();
		pstmt.close();
		conn.close();
		return chatRoomIdx;
	}
	public int ChattingRoomIdxSearchOne(int memberidx1) throws Exception {
		String sql = "  SELECT CHAT_ROOM_IDX AS \"채팅방번호\"" + 
				" FROM CHAT_MEMBER" + 
				" WHERE CHAT_ROOM_IDX IN (" + 
				"    SELECT CHAT_ROOM_IDX" + 
				"    FROM CHAT_MEMBER" + 
				"    GROUP BY CHAT_ROOM_IDX" + 
				"    HAVING COUNT(MEMBER_IDX) = 1" + 
				" )" + 
				" AND MEMBER_IDX = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, memberidx1);
		ResultSet rs = pstmt.executeQuery();
		int chatRoomIdx = 0;
		if(rs.next()) {
			chatRoomIdx = rs.getInt("채팅방번호");
		}
		rs.close();
		pstmt.close();
		conn.close();
		return chatRoomIdx;
	}
	public int ProjectChattingSearch(int projectIdx) throws Exception {
		String sql = "SELECT CHAT_ROOM_IDX AS \"채팅방번호\" " + 
				"FROM CHAT_ROOM " + 
				"WHERE project_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, projectIdx);
		ResultSet rs = pstmt.executeQuery();
		int chatRoomIdx = 0;
		if(rs.next()) {
			chatRoomIdx = rs.getInt("채팅방번호");
		}
		rs.close();
		pstmt.close();
		conn.close();
		return chatRoomIdx;
	}
	public ArrayList<ProjectMemberViewDto>ProjectMemberView(int projectIdx) throws Exception {
		String sql = " SELECT " + 
				"    m.member_idx AS \"멤버번호\"" + 
				" FROM " + 
				"    members m" + 
				"  INNER JOIN project_member pm ON pm.participant_idx = m.member_idx" + 
				" WHERE " + 
				"    pm.project_idx = ?" + 
				"    AND pm.state_yn = 'Y'";
		ArrayList<ProjectMemberViewDto> listRet = new ArrayList<ProjectMemberViewDto>();
		
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, projectIdx);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int memberIdx = rs.getInt("멤버번호");
			ProjectMemberViewDto dto = new ProjectMemberViewDto(memberIdx, sql, memberIdx, sql, sql, sql, '0', sql);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	//채팅방 정보 출력
	public ChattingRoomContentsDto ChattingRoomContents(int chatRoomIdx) throws Exception {
		String sql = " SELECT  C.CHAT_ROOM_IDX AS \"채팅방번호\"," + 
				"        C.CHAT_ROOM_NAME AS \"채팅방이름\"," + 
				"        C.PROJECT_IDX AS \"프로젝트번호\"," + 
				"        C.GROUP_CHAT_YN AS \"그룹챗여부\"," + 
				"        COUNT(CM.MEMBER_IDX) AS \"채팅방인원수\"" + 
				" FROM CHAT_ROOM C" + 
				" INNER JOIN CHAT_MEMBER CM" + 
				" ON c.chat_room_idx = cm.chat_room_idx" + 
				" WHERE c.chat_room_idx = ?" + 
				" GROUP BY C.CHAT_ROOM_IDX," + 
				"        C.CHAT_ROOM_NAME," + 
				"        C.PROJECT_IDX," + 
				"        C.GROUP_CHAT_YN";
		ChattingRoomContentsDto dto = null;
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, chatRoomIdx);
		ResultSet rs = pstmt.executeQuery();
		if(rs.next()) {
			chatRoomIdx = rs.getInt("채팅방번호");
			String chatRoomName = rs.getString("채팅방이름");
			int projectIdx = rs.getInt("프로젝트번호");
			char groupChatYN = rs.getString("그룹챗여부").charAt(0);
			int count = rs.getInt("채팅방인원수");
			dto = new ChattingRoomContentsDto(chatRoomIdx, chatRoomName, projectIdx, groupChatYN, count, count, count, count);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return dto;
	}
	public ChattingRoomContentsDto ChattingRoomPeopleCount(int chatRoomIdx) throws Exception {
		String sql = " SELECT " + 
				"    COUNT(CASE WHEN CM.admin_yn = 'Y' THEN 1 END) AS \"관리자\"," + 
				"    COUNT(CASE WHEN CM.admin_yn = 'N' AND M.COMPANY_IDX = 1 THEN 1 END) AS \"임원\"," + 
				"    COUNT(CASE WHEN CM.admin_yn = 'N' AND M.COMPANY_IDX != 1 THEN 1 END) AS \"외부인\"" + 
				" FROM CHAT_ROOM C" + 
				" INNER JOIN CHAT_MEMBER CM ON C.chat_room_idx = CM.chat_room_idx" + 
				" INNER JOIN MEMBERS M ON CM.member_idx = M.member_idx" + 
				" WHERE C.chat_room_idx = ?";
		ChattingRoomContentsDto dto = null;
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, chatRoomIdx);
		ResultSet rs = pstmt.executeQuery();
		if(rs.next()) {
			int Admincount = rs.getInt("관리자");
			int Employeecount = rs.getInt("임원");
			int Outsidercount = rs.getInt("외부인");
			dto = new ChattingRoomContentsDto(chatRoomIdx, "", 0, '0', 0, Admincount,Employeecount, Outsidercount);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return dto;
	}
	public ArrayList<MemberDto> AdminChatMemberList(int chatRoomIdx) throws Exception {
		String sql = "SELECT " + 
				"       m.profile_img AS \"프로필\"," + 
				"       M.MEMBER_IDX AS \"멤버IDX\"," + 
				"       M.NAME AS \"이름\"," + 
				"       M.POSITION AS \"직책\"," + 
				"       C.COMPANY_NAME AS \"회사명\"," + 
				"       D.DEPARTMENT_NAME AS \"부서명\"" + 
				" FROM CHAT_MEMBER CM" + 
				" INNER JOIN MEMBERS M ON CM.MEMBER_IDX = M.MEMBER_IDX" + 
				" INNER JOIN COMPANIES C ON M.COMPANY_IDX = c.company_idx" + 
				" LEFT JOIN DEPARTMENTS D ON d.department_idx = M.department_idx" + 
				" WHERE CM.CHAT_ROOM_IDX = ?";
				ArrayList<MemberDto> listRet = new ArrayList<MemberDto>();
				Connection conn = getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1,chatRoomIdx);
				ResultSet rs = pstmt.executeQuery();
				while(rs.next()) {
					String profile = rs.getString("프로필");
					int memberIdx = rs.getInt("멤버IDX");
					String name = rs.getString("이름"); 
					String departmentName = rs.getString("부서명"); 
					String position = rs.getString("직책"); 
					String companyName = rs.getString("회사명"); 
					if(departmentName == null) {
						departmentName = "";
					}
					if(position == null) {
						position = "";
					}
					MemberDto dto = new MemberDto(memberIdx,0,companyName, name, departmentName, position, companyName, companyName, companyName, companyName, '0', companyName, '0' , profile,"");
					listRet.add(dto);
				}
				rs.close();
				pstmt.close();
				conn.close();
				return listRet;
	}
	public ArrayList<MemberDto> ChatRoomMemberSearch(int chatRoomIdx) throws Exception {
		String sql = " SELECT MEMBER_IDX AS \"멤버IDX\"" + 
				" FROM CHAT_MEMBER" + 
				" WHERE chat_room_idx = ?";
		ArrayList<MemberDto> listRet = new ArrayList<MemberDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1,chatRoomIdx);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int memberIdx = rs.getInt("멤버IDX");
			MemberDto dto = new MemberDto(memberIdx, 0, "", "", "", "", "", "", "", "", '0', "", '0', "", "");
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	public ArrayList<ChatContentsDto> ChatContentsList(int chatRoomIdx) throws Exception {
		String sql = " SELECT " + 
				"    CV.chat_idx AS \"채팅IDX\"," + 
				"    CV.WRITER_IDX AS \"작성자IDX\"," + 
				"    CV.conversation AS \"채팅내용\"," + 
				"    CV.input_date_time AS \"작성시간\"," + 
				"    NVL(unread_member_count, 0) AS \"읽지않은사람수\"" + 
				" FROM CHAT_CONVERSATION CV" + 
				" INNER JOIN CHAT_ROOM C ON C.CHAT_ROOM_IDX = CV.CHAT_ROOM_IDX" + 
				" LEFT JOIN (" + 
				"    SELECT " + 
				"        CC.chat_idx, " + 
				"        COUNT(DISTINCT CM.MEMBER_IDX) AS unread_member_count" + 
				"    FROM CHAT_CONVERSATION CC" + 
				"    INNER JOIN CHAT_ROOM C ON CC.chat_room_idx = C.chat_room_idx" + 
				"    INNER JOIN CHAT_MEMBER CM ON C.chat_room_idx = CM.chat_room_idx" + 
				"    WHERE C.chat_room_idx = ?" + 
				"    AND NOT EXISTS (" + 
				"        SELECT 1" + 
				"        FROM CHAT_VIEW CV" + 
				"        WHERE CV.chat_idx = CC.chat_idx" + 
				"        AND CV.member_idx = CM.member_idx" + 
				"    )" + 
				"    GROUP BY CC.chat_idx" + 
				" ) unread_count ON CV.chat_idx = unread_count.chat_idx" + 
				" WHERE C.CHAT_ROOM_IDX = ?" + 
				" ORDER BY CV.input_date_time";
		ArrayList<ChatContentsDto> listRet = new ArrayList<ChatContentsDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1,chatRoomIdx);
		pstmt.setInt(2,chatRoomIdx);		
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int chatIdx = rs.getInt("채팅IDX");
			int writerIdx = rs.getInt("작성자IDX");
			String conversation = rs.getString("채팅내용");
			String inputDateTime = rs.getString("작성시간");
			int unreadMemberCount = rs.getInt("읽지않은사람수");
			ChatContentsDto dto = new ChatContentsDto(chatIdx, writerIdx, conversation, inputDateTime, unreadMemberCount);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	public ChatContentsDto ChatContents(int chatIdx) throws Exception {
		String sql = " SELECT " + 
				"    CV.chat_idx AS \"채팅IDX\"," + 
				"    CV.WRITER_IDX AS \"작성자IDX\"," + 
				"    CV.conversation AS \"채팅내용\"," + 
				"    CV.input_date_time AS \"작성시간\"," + 
				"    NVL(unread_member_count, 0) AS \"읽지않은사람수\"" + 
				" FROM CHAT_CONVERSATION CV" + 
				" INNER JOIN CHAT_ROOM C ON C.CHAT_ROOM_IDX = CV.CHAT_ROOM_IDX" + 
				" LEFT JOIN (" + 
				"    SELECT " + 
				"        CC.chat_idx, " + 
				"        COUNT(DISTINCT CM.MEMBER_IDX) AS unread_member_count" + 
				"    FROM CHAT_CONVERSATION CC" + 
				"    INNER JOIN CHAT_ROOM C ON CC.chat_room_idx = C.chat_room_idx" + 
				"    INNER JOIN CHAT_MEMBER CM ON C.chat_room_idx = CM.chat_room_idx" + 
				"    WHERE CC.chat_idx = ?" + 
				"    AND NOT EXISTS (" + 
				"        SELECT 1" + 
				"        FROM CHAT_VIEW CV" + 
				"        WHERE CV.chat_idx = CC.chat_idx" + 
				"        AND CV.member_idx = CM.member_idx" + 
				"    )" + 
				"    GROUP BY CC.chat_idx" + 
				" ) unread_count ON CV.chat_idx = unread_count.chat_idx" + 
				" WHERE CV.CHAT_IDX = ?" + 
				" ORDER BY CV.input_date_time";
		ChatContentsDto dto = null;
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1,chatIdx);
		pstmt.setInt(2,chatIdx);		
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			chatIdx = rs.getInt("채팅IDX");
			int writerIdx = rs.getInt("작성자IDX");
			String conversation = rs.getString("채팅내용");
			String inputDateTime = rs.getString("작성시간");
			int unreadMemberCount = rs.getInt("읽지않은사람수");
			dto = new ChatContentsDto(chatIdx, writerIdx, conversation, inputDateTime, unreadMemberCount);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return dto;
	}
	public void chattingInsert(int chatRoomIdx,int writerIdx, String chat) throws Exception {
		String sql = "INSERT INTO CHAT_CONVERSATION VALUES(SEQ_CHATING_IDX.nextval,?,?,?,null,sysdate,null,null,'N')";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1,chatRoomIdx);
		pstmt.setInt(2,writerIdx);	
		pstmt.setString(3,chat);	
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	public int ChattingIdxSearch() throws Exception {
		String sql = "SELECT LAST_NUMBER FROM USER_SEQUENCES WHERE sequence_name = 'SEQ_CHATING_IDX'";
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
	public void ChattingRoomNameChange(int chatRoomIdx, String text) throws Exception {
		String sql = "UPDATE CHAT_ROOM SET CHAT_ROOM_NAME = ? WHERE chat_room_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,text);
		pstmt.setInt(2,chatRoomIdx);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	public static void main(String[] args) throws Exception  {
		ChattingDao dao = new ChattingDao();
		System.out.println(dao.ChattingRoomIdxSearchOne(1));
		System.out.println(dao.ChattingRoomIdxSearch(1, 2));

	}

}
