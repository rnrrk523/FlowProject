package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import dto.ChatMonitoringHistoryDto;
import dto.ChatRoomMonitoringHistoryDto;
import dto.MemberCompanyDepartmentDto;
import dto.ObservingRecordDto;

public class ChatMonitoringHistoryDao {
	public Connection getConnection() throws Exception{
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@//114.207.245.107:1521/XE";
		String id = "FLOW";
		String pw = "1234";
		
		Class.forName(driver);
		Connection conn = DriverManager.getConnection(url, id, pw);
		
		return conn;
	}
//	[SH-74] - 채팅방 감사 검색 조회하기 (p48-1)
//	-input : company_idx(숫자), 검색 기준(문자열)[이름, 이메일], 검색할 텍스트(문자열)
//	-output : ArrayList<ChatRoomMonitoringHistoryDto>
	public ArrayList<ChatRoomMonitoringHistoryDto> getChatRoomMonitoringHistory(int companyIdx, String standard, String str) throws Exception{
		String m = null;
		if(standard == "이름") {
			m = "m.name";
		}else if(standard == "이메일") {
			m = "m.email";
		}
		String sql = "SELECT  DISTINCT cr.chat_room_idx AS \"채팅방IDX\"," + 
				"        cr.chat_room_name AS \"채팅방 명\"," + 
				"        c.audit_chat_date||' ~ '||cc.input_date_time AS \"채팅기간\"" + 
				" FROM    companies c" + 
				" INNER JOIN members m" + 
				" ON      c.company_idx = m.company_idx" + 
				" INNER JOIN chat_conversation cc" + 
				" ON      m.member_idx = cc.writer_idx" + 
				" INNER JOIN chat_room cr" + 
				" ON      cc.chat_room_idx = cr.chat_room_idx" + 
				" WHERE   cc.input_date_time >= c.audit_chat_date" + 
				" AND     c.company_idx = ?" + 
				" AND     "+m+" LIKE ?";
		ArrayList<ChatRoomMonitoringHistoryDto> listRet = new ArrayList<ChatRoomMonitoringHistoryDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, companyIdx);
		pstmt.setString(2, "%"+str+"%");
		
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int chatRoomIdx = rs.getInt("채팅방IDX");
			String roomName = rs.getString("채팅방 명");
			String chatDate = rs.getString("채팅기간");
			
			String sql2 = "SELECT  m.member_idx AS \"회원IDX\"," + 
					"        m.name AS \"참여자 명\"" + 
					" FROM    chat_member cm" + 
					" INNER JOIN members m" + 
					" ON      cm.member_idx = m.member_idx" + 
					" WHERE   cm.chat_room_idx = ?";
			ArrayList<String> memberList = new ArrayList<String>();
			PreparedStatement pstmt2 = conn.prepareStatement(sql2);
			pstmt2.setInt(1, chatRoomIdx);
			ResultSet rs2 = pstmt2.executeQuery();
			while(rs2.next()) {
				String memberName = rs2.getString("참여자 명");
				memberList.add(memberName);
			}
			ChatRoomMonitoringHistoryDto dto = new ChatRoomMonitoringHistoryDto(chatRoomIdx, roomName, memberList, chatDate);
			listRet.add(dto);
			rs2.close();
			pstmt2.close();
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	
	
//	[SH-75] - 채팅내용 검색 조회하기 (p49-1)
//	-input : company_idx(숫자), chat_room_idx(숫자),
//		   검색기준(문자열)[내용, 이메일, 이름], 검색어(문자열),
//		   시작일(문자열), 마지막일(문자열)
//	-output : ArrayList<ChatMonitoringHistoryDto>
	public ArrayList<ChatMonitoringHistoryDto> getChatMonitoringHistory(int companyIdx, int chatRoomIdx, String standard, String str, String startDate, String endDate) throws Exception{
		String m = null;
		if(standard == "이름") {
			m = "m.name LIKE ?";
		}else if(standard == "이메일") {
			m = "m.email LIKE ?";
		}else if(standard == "내용") {
			m = "(cc.conversation LIKE ? OR bf.file_name LIKE ?)";
		}
		String sql = "SELECT  (CASE " + 
				"            WHEN m.company_idx = ? THEN '임직원'" + 
				"            WHEN m.company_idx != ? THEN '외부인' END) AS \"임직원/외부인\"," + 
				"        cc.input_date_time AS \"발송일자\"," + 
				"        m.name || chr(10) || '(' || m.email || ')' AS \"발신자(이메일)\"," + 
				"        (CASE WHEN cc.conversation IS NOT NULL THEN cc.conversation" + 
				"                WHEN cc.flyemotion_idx IS NOT NULL THEN '이모티콘'" + 
				"                WHEN cc.file_url IS NOT NULL THEN bf.file_name END) AS \"내용\"," + 
				"        (CASE WHEN cc.conversation IS NOT NULL THEN '텍스트'" + 
				"                WHEN cc.flyemotion_idx IS NOT NULL THEN '이모티콘'" + 
				"                WHEN cc.file_url IS NOT NULL THEN '파일' END) AS \"타입\"" + 
				" FROM    members m" + 
				" INNER JOIN chat_conversation cc" + 
				" ON      m.member_idx = cc.writer_idx" + 
				" INNER JOIN board_file bf" + 
				" ON      cc.file_url = bf.file_url" + 
				" WHERE   m.company_idx = ?" + 
				" AND     cc.chat_room_idx = ?" + 
				" AND     cc.input_date_time BETWEEN" + 
				"         TO_DATE(?, 'YYYY-MM-DD') " + 
				" AND     TO_DATE(?, 'YYYY-MM-DD')" + 
				" AND     "+m+"" + 
				" ORDER BY cc.input_date_time DESC";
		ArrayList<ChatMonitoringHistoryDto> listRet = new ArrayList<ChatMonitoringHistoryDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, companyIdx);
		pstmt.setInt(2, companyIdx);
		pstmt.setInt(3, companyIdx);
		pstmt.setInt(4, chatRoomIdx);
		pstmt.setString(5, startDate);
		pstmt.setString(6, endDate);
		pstmt.setString(7, "%"+str+"%");
		if(standard == "내용") {
			pstmt.setString(8, "%"+str+"%");
		}
		
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			String affiliation = rs.getString("임직원/외부인");
			String writeDate = rs.getString("발송일자");
			String nameAndEmail = rs.getString("발신자(이메일)");
			String content = rs.getString("내용");
			String type = rs.getString("타입");
			ChatMonitoringHistoryDto dto = new ChatMonitoringHistoryDto(affiliation, writeDate, nameAndEmail, content, type);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	
//	[SH-76] - 채팅방 참여자 검색 조회하기 (p50-1)
//	-input : company_idx(숫자), chat_room_idx(숫자), 검색기준(문자열)[이름, 이메일, 부서], 검색어(문자열)
//	-output : ArrayList<MemberCompanyDepartmentDto>
	public ArrayList<MemberCompanyDepartmentDto> getChatRoomMemberList(int companyIdx, int chatRoomIdx, String standard, String str) throws Exception{
		String m = null;
		if(standard == "이름") {
			m = "m.name";
		}else if(standard == "이메일") {
			m = "m.email";
		}else if(standard == "부서") {
			m = "d.department_name";
		}
		String sql = "SELECT  m.member_idx," + 
				"        m.name AS \"이름\"," + 
				"        m.email AS \"이메일\"," + 
				"        d.department_name AS \"부서\"," + 
				"        m.phone AS \"휴대폰 번호\"" + 
				" FROM    chat_member cm" + 
				" INNER JOIN members m" + 
				" ON      cm.member_idx = m.member_idx" + 
				" INNER JOIN departments d" + 
				" ON      m.department_idx = d.department_idx" + 
				" WHERE   chat_room_idx = ?" + 
				" AND     m.company_idx = ?" + 
				" AND     "+m+" LIKE ?";
		ArrayList<MemberCompanyDepartmentDto> listRet = new ArrayList<MemberCompanyDepartmentDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, companyIdx);
		pstmt.setInt(2, chatRoomIdx);
		pstmt.setString(3, "%"+str+"%");
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int memberIdx = rs.getInt("member_idx");
			String name = rs.getString("이름");
			String departmentName = rs.getString("부서");
			String email = rs.getString("이메일");
			String phone = rs.getString("휴대폰 번호");
			MemberCompanyDepartmentDto dto = new MemberCompanyDepartmentDto(memberIdx, name, departmentName, email, phone);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	
//	[SH-77] - 감사 이력 보기 (p51)
//	-input : company_idx(숫자), 검색 기준(문자열)[수정자, 기능, 대상, 변경사항], 검색어(문자열),
//			시작일(문자열), 마지막일(문자열)
//	-output : ArrayList<ObservingRecordDto>
	public ArrayList<ObservingRecordDto> getObservingRecordList(int companyIdx, String standard, String str, String startDate, String endDate) throws Exception{
		String m = null;
		if(standard.equals("수정자")) {
			m = "(m.name LIKE ? OR m.email LIKE ?)";
		}else if(standard.equals("기능")) {
			m = "ah.function LIKE ?";
		}else if(standard.equals("대상")) {
			m = "ah.target LIKE ?";
		}else if(standard.equals("변경사항")) {
			m = "ah.changes LIKE ?";
		}
		String sql = "SELECT  ah.company_idx," + 
				"        m.name||'('||m.email||')' AS \"수정자\"," + 
				"        ah.function AS \"기능\"," + 
				"        ah.target AS \"대상\"," + 
				"        ah.changes AS \"변경사항\"," + 
				"        ah.change_date AS \"변경일시\"" + 
				" FROM    audit_history ah" + 
				" INNER JOIN members m" + 
				" ON      ah.modifier_idx = m.member_idx" + 
				" WHERE   ah.company_idx = ?" + 
				" AND     ah.change_date BETWEEN TO_DATE(?, 'YYYY-MM-DD') AND TO_DATE(?, 'YYYY-MM-DD  HH24:MI:SS')" + 
				" AND     "+m+"" +
				" ORDER BY ah.change_date DESC";
		ArrayList<ObservingRecordDto> listRet = new ArrayList<ObservingRecordDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, companyIdx);
		pstmt.setString(2, startDate);
		pstmt.setString(3, endDate+" 23:59:59");
		pstmt.setString(4, "%"+str+"%");
		if(standard.equals("수정자"))
			pstmt.setString(5, "%"+str+"%");
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			String modifier = rs.getString("수정자");
			String func = rs.getString("기능");
			String target = rs.getString("대상");
			String changeContent = rs.getString("변경사항");
			String changeDate = rs.getString("변경일시");
			ObservingRecordDto dto = new ObservingRecordDto(modifier, func, target, changeContent, changeDate);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	
//	채팅 감사 기능 켜기/끄기
//	input: company_idx(숫자)
	public void setCompanyAuditChatDate(int companyIdx) throws Exception {
		String sql = "UPDATE companies " + 
				" SET audit_chat_date = (CASE" + 
				"                WHEN audit_chat_date IS NULL THEN SYSDATE" + 
				"                WHEN audit_chat_date IS NOT NULL THEN null" + 
				"                END)" + 
				" WHERE company_idx = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, companyIdx);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	
//	감사 이력 테이블에 INSERT
//	input: company_idx(숫자), member_idx(숫자), 기능(문자열), 대상(문자열), 변경사항(문자열), 변경일시(문자열)
	public void addAuditRecord(int companyIdx, int memberIdx, String func, String target, String changeContent) throws Exception{
		String sql = "INSERT INTO audit_history(company_idx, modifier_idx, function, target, changes)" + 
				" VALUES(?, ?, ?, ?, ?)";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, companyIdx);
		pstmt.setInt(2, memberIdx);
		pstmt.setString(3, func);
		pstmt.setString(4, target);
		pstmt.setString(5, changeContent);
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
	}
	
	public static void main(String[] args) throws Exception{
		ChatMonitoringHistoryDao cmhdao = new ChatMonitoringHistoryDao();
		
		
//		-감사 이력 검색 조회하기
		ArrayList<ObservingRecordDto> ObservingRecordList = cmhdao.getObservingRecordList(1, "수정자", "", "2024-11-01", "2024-11-30");
		for(ObservingRecordDto dto : ObservingRecordList) {
			System.out.println("수정자 : "+dto.getModifier());
			System.out.println("기능 : "+dto.getFunc());
			System.out.println("대상 : "+dto.getTarget());
			System.out.println("변경사항 : "+dto.getChangeContent());
			System.out.println("변경일시 : "+dto.getChangeDate());
			System.out.println("-----------------------------------");
		}
		
//		-채팅방 참여자 검색 조회하기
//		ArrayList<MemberCompanyDepartmentDto> chatRoomMemberList = cmhdao.getChatRoomMemberList(1, 1, "이름", "민");
//		for(MemberCompanyDepartmentDto dto : chatRoomMemberList) {
//			System.out.println("이름 : "+dto.getName());
//			System.out.println("이메일 : "+dto.getEmail());
//			System.out.println("부서 : "+dto.getDepartmentName());
//			System.out.println("휴대폰 번호 : "+dto.getPhone());
//			System.out.println("-------------------------------");
//		}
		
//		-채팅방 감사 검색 조회하기
//		ArrayList<ChatRoomMonitoringHistoryDto> ChatRoomMonitoringHistoryList = cmhdao.getChatRoomMonitoringHistory(1, "이름", "민");
//		for(ChatRoomMonitoringHistoryDto dto : ChatRoomMonitoringHistoryList) {
//			System.out.println("채팅방 명 : "+dto.getRoomName());
//			ArrayList<String> memberList = dto.getMemberList();
//			int tryCnt = 0;
//			System.out.print("참여자 명 : ");
//			for(String mList : memberList) {
//				tryCnt++;
//				if(tryCnt <= memberList.size()-1) {
//					System.out.print(mList+", ");
//				}else {
//					System.out.println(mList);
//				}
//			}
//			System.out.println("채팅기간 : "+dto.getChatDate());
//		}
		
//		ArrayList<ChatMonitoringHistoryDto> chatMonitoringHistoryList = cmhdao.getChatMonitoringHistory(1, 1, "내용", "2조", "2024-11-01", "2024-11-30");
//		for(ChatMonitoringHistoryDto dto : chatMonitoringHistoryList) {
//			System.out.println("임직원/외부인 : "+dto.getAffiliation());
//			System.out.println("발송일자 : "+dto.getWriteDate());
//			System.out.println("발신자(이메일) : "+dto.getNameAndEmail());
//			System.out.println("내용 : "+dto.getContent());
//			System.out.println("타입 : "+dto.getType());
//			System.out.println("-----------------------------------------");
//		}
	}
}
