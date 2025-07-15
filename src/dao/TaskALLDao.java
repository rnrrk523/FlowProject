package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import dto.TaskGroupViewDto;
import dto.TaskManagerDto;
import dto.TaskMangerViewProjectDto;
import dto.TaskSearchDto;
import dto.TaskViewOptionDto;

public class TaskALLDao {
	public Connection getConnection() throws Exception {
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@//114.207.245.107:1521/XE";
		String id = "FLOW";
		String pw = "1234";
		
		Class.forName(driver);
		Connection conn = DriverManager.getConnection(url, id, pw);
		
		return conn;
		}
	//업무그룹내의 글수 출력
	public int taskGroupCount(String search, int WriterIdx,int memberIdx, int state1, 
			int state2, int state3, int state4, int state5, int priority1, int priority2, int priority3, int priority4,
			int priority5,int projectIdx,int writevalue,int startDateIdx, int endDateIdx, int taskGroupIdx, int category) throws Exception {
		String sql = "SELECT COUNT(DISTINCT T.TASK_IDX)" + 
				" FROM BOARD B" + 
				" JOIN TASK T ON B.BOARD_IDX = T.BOARD_IDX" + 
				" JOIN MEMBERS M ON B.WRITER_IDX = M.MEMBER_IDX" + 
				" LEFT JOIN TASK_MANAGER TM ON T.TASK_IDX = TM.TASK_IDX" + 
				" WHERE (T.TASK_IDX LIKE ? OR " + 
				"        CASE WHEN T.TOP_TASK_IDX IS NULL THEN UPPER(B.TITLE) ELSE UPPER(T.TITLE) END LIKE UPPER(?))" + 
				" AND T.STATE IN (?, ?, ?, ?, ?)" + 
				" AND T.PRIORITY IN (?, ?,?, ?, ?)" + 
				" AND B.PROJECT_IDX = ?"; 
				if(category == 0) {
				    sql += " AND T.TASK_GROUP_IDX = ?";
				} else {
				    sql += " AND T.TASK_GROUP_IDX IS NULL";
				}
				String write1 = " AND TM.member_IDX = ?";
				String write2 = " AND T.WRITER_IDX = ?";
				String write3 = "";
				String start1 = "";
				String start2 = " AND T.START_DATE = TO_CHAR(SYSDATE, 'YYYY-MM-DD')";
				String start3 = " AND T.START_DATE BETWEEN (SELECT TRUNC(SYSDATE,'iw') FROM DUAL) AND " + 
						" (SELECT TRUNC(SYSDATE,'iw')+6 FROM DUAL)";
				String start4 = " AND TO_CHAR(T.START_DATE, 'YYYY-MM') = TO_CHAR(SYSDATE, 'YYYY-MM')";
				String start5 = " AND T.START_DATE IS NULL";
				String end1 = "";
				String end2 = " AND T.END_DATE < SYSDATE";
				String end3 = " AND T.END_DATE = SYSDATE";
				String end4 = "AND T.END_DATE BETWEEN (SELECT TRUNC(SYSDATE,'iw') FROM DUAL) AND " + 
						"                       (SELECT TRUNC(SYSDATE,'iw')+6 FROM DUAL)" + 
						" AND T.END_DATE >= TO_DATE(SYSDATE, 'YYYY-MM-DD')";
				String end5 = " AND TO_CHAR(T.END_DATE, 'YYYY-MM') = TO_CHAR(SYSDATE, 'YYYY-MM')" + 
						" AND TO_DATE(T.END_DATE, 'YYYY-MM-DD') >= TO_DATE(SYSDATE, 'YYYY-MM-DD')";
				String end6 = "AND T.END_DATE IS NULL";
				if (writevalue == 1) {
				    sql += write1; 
				} else if (writevalue == 2) {
				    sql += write2; 
				} else if (writevalue == 3) {
				    sql += write3; 
				}
				if (startDateIdx == 1) {
				    sql += start1;
				} else if (startDateIdx == 2) {
				    sql += start2;
				} else if (startDateIdx == 3) {
				    sql += start3;
				} else if (startDateIdx == 4) {
				    sql += start4;
				} else if (startDateIdx == 5) {
				    sql += start5;
				}
				if (endDateIdx == 1) {
					sql += end1;
				} else if (endDateIdx == 2) {
					sql += end2;
				} else if (endDateIdx == 3) {
					sql += end3;
				} else if (endDateIdx == 4) {
					sql += end4;
				} else if (endDateIdx == 5) {
					sql += end5;
				}else if (endDateIdx == 6) {
					sql += end6;
				}

				
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,"%"+search+"%");
		pstmt.setString(2,"%"+search+"%");
		pstmt.setInt(3,state1);
		pstmt.setInt(4,state2);
		pstmt.setInt(5,state3);
		pstmt.setInt(6,state4);
		pstmt.setInt(7,state5);
		pstmt.setInt(8,priority1);
		pstmt.setInt(9,priority2);
		pstmt.setInt(10,priority3);
		pstmt.setInt(11,priority4);
		pstmt.setInt(12,priority5);
		pstmt.setInt(13,projectIdx);
		if(category == 0) {
		    pstmt.setInt(14, taskGroupIdx);
			if(writevalue==1) {
				pstmt.setInt(15,WriterIdx);
			}
			else if (writevalue==2) {
				pstmt.setInt(15,memberIdx);
			}
		} else {
			if(writevalue==1) {
				pstmt.setInt(14,WriterIdx);
			}
			else if (writevalue==2) {
				pstmt.setInt(14,memberIdx);
			}
		}
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
	//첫 담당자 한명만 출력
	public String TaskManagerOneView(int taskIdx) throws Exception {
		String sql = " SELECT M.NAME AS \"이름\"" + 
				" FROM TASK_MANAGER TM" + 
				" JOIN MEMBERS M" + 
				" ON TM.MEMBER_IDX = M.MEMBER_IDX" + 
				" WHERE TASK_IDX = ?" + 
				" AND ROWNUM = 1";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1,taskIdx);
		ResultSet rs = pstmt.executeQuery();
		String name = "";
		if(rs.next()) {
			name = rs.getString("이름");
		}
		rs.close();
		pstmt.close();
		conn.close();
		return name;
	}
	public int TaskManagerCount(int taskIdx) throws Exception {
		String sql = " SELECT count(name)" + 
				" FROM TASK_MANAGER TM" + 
				" JOIN MEMBERS M" + 
				" ON TM.MEMBER_IDX = M.MEMBER_IDX" + 
				" WHERE TASK_IDX =?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1,taskIdx);
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
//	[Minsuk24] 프로젝트 업무 검색(p112) 기본 검색 (업무번호 제목)
//	input : String(검색어) int(프로젝트idx)
//	output : 업무idx로 검색, 제목으로 검색, 작성자, 담당자로 검색시 해당 옵션에 맞게 업무 글 출력
	public ArrayList<TaskSearchDto>TaskBasicSearchInt(String search, int WriterIdx,int memberIdx, int state1, 
			int state2, int state3, int state4, int state5, int priority1, int priority2, int priority3, int priority4,
			int priority5,int projectIdx,int writevalue,int startDateIdx, int endDateIdx) throws Exception {
		
		String sql = "SELECT DISTINCT " + 
				"    CASE WHEN T.TOP_TASK_IDX IS NULL THEN B.TITLE ELSE T.TITLE END AS \"업무명\"," + 
				"    T.STATE AS \"상태\"," + 
				"    T.PRIORITY AS \"우선 순위\"," + 
				"    T.START_DATE AS \"시작일\"," + 
				"    T.END_DATE AS \"마감일\"," + 
				"    T.WRITE_DATE AS \"작성일\"," + 
				"    T.TASK_IDX AS \"업무 번호\"," + 
				"    M.NAME AS \"작성자\"," + 
				"    T.LAST_MODIFIED_DATE AS \"수정일\"," + 
				"    T.PROGRESS AS \"진척도\"," + 
				"    T.TASK_GROUP_IDX AS \"업무그룹\""+
				" FROM " + 
				"    BOARD B " + 
				"    INNER JOIN TASK T ON B.BOARD_IDX = T.BOARD_IDX" + 
				"    INNER JOIN MEMBERS M ON T.WRITER_IDX = M.MEMBER_IDX" + 
				"    LEFT JOIN TASK_MANAGER TM ON T.TASK_IDX = TM.TASK_IDX" + 
				" WHERE " + 
				"    (T.TASK_IDX LIKE ? OR " + 
				"    CASE WHEN T.TOP_TASK_IDX IS NULL THEN UPPER(B.TITLE) ELSE UPPER(T.TITLE) END LIKE UPPER(?))" + 
				"    AND T.STATE IN (?, ?, ?, ?, ?)" + 
				"    AND T.PRIORITY IN (?, ?, ?, ?, ?)" + 
				"    AND B.PROJECT_IDX = ?";
		
		String write1 = "AND TM.member_IDX = ?";
		String write2 = "AND T.WRITER_IDX = ?";
		String write3 = "";
		String start1 = "";
		String start2 = " AND T.START_DATE = TO_CHAR(SYSDATE, 'YYYY-MM-DD')";
		String start3 = " AND T.START_DATE BETWEEN (SELECT TRUNC(SYSDATE,'iw') FROM DUAL) AND " + 
				" (SELECT TRUNC(SYSDATE,'iw')+6 FROM DUAL)";
		String start4 = " AND TO_CHAR(T.START_DATE, 'YYYY-MM') = TO_CHAR(SYSDATE, 'YYYY-MM')";
		String start5 = " AND T.START_DATE IS NULL";
		String end1 = "";
		String end2 = " AND T.END_DATE < SYSDATE";
		String end3 = " AND T.END_DATE = SYSDATE";
		String end4 = "AND T.END_DATE BETWEEN (SELECT TRUNC(SYSDATE,'iw') FROM DUAL) AND " + 
				"                       (SELECT TRUNC(SYSDATE,'iw')+6 FROM DUAL)" + 
				" AND T.END_DATE >= TO_DATE(SYSDATE, 'YYYY-MM-DD')";
		String end5 = " AND TO_CHAR(T.END_DATE, 'YYYY-MM') = TO_CHAR(SYSDATE, 'YYYY-MM')" + 
				" AND TO_DATE(T.END_DATE, 'YYYY-MM-DD') >= TO_DATE(SYSDATE, 'YYYY-MM-DD')";
		String end6 = "AND T.END_DATE IS NULL";
		if(writevalue==1) {
			sql += write1;
			if(startDateIdx==1) {sql += start1;
				if(endDateIdx==1) {sql += end1;}
				if(endDateIdx==2) {sql += end2;}
				if(endDateIdx==3) {sql += end3;}
				if(endDateIdx==4) {sql += end4;}
				if(endDateIdx==5) {sql += end5;}
				if(endDateIdx==6) {sql += end6;}
			}
			if(startDateIdx==2) {sql += start2;
				if(endDateIdx==1) {sql += end1;}
				if(endDateIdx==2) {sql += end2;}
				if(endDateIdx==3) {sql += end3;}
				if(endDateIdx==4) {sql += end4;}
				if(endDateIdx==5) {sql += end5;}
				if(endDateIdx==6) {sql += end6;}
			}
			if(startDateIdx==3) {sql += start3;
				if(endDateIdx==1) {sql += end1;}
				if(endDateIdx==2) {sql += end2;}
				if(endDateIdx==3) {sql += end3;}
				if(endDateIdx==4) {sql += end4;}
				if(endDateIdx==5) {sql += end5;}
				if(endDateIdx==6) {sql += end6;}
			}
			if(startDateIdx==4) {sql += start4;
				if(endDateIdx==1) {sql += end1;}
				if(endDateIdx==2) {sql += end2;}
				if(endDateIdx==3) {sql += end3;}
				if(endDateIdx==4) {sql += end4;}
				if(endDateIdx==5) {sql += end5;}
				if(endDateIdx==6) {sql += end6;}
				
			}
			if(startDateIdx==5) {sql += start5;
				if(endDateIdx==1) {sql += end1;}
				if(endDateIdx==2) {sql += end2;}
				if(endDateIdx==3) {sql += end3;}
				if(endDateIdx==4) {sql += end4;}
				if(endDateIdx==5) {sql += end5;}
				if(endDateIdx==6) {sql += end6;}
			}
		}
		if(writevalue==2) {
			sql += write2;
			if(startDateIdx==1) {sql += start1;
				if(endDateIdx==1) {sql += end1;}
				if(endDateIdx==2) {sql += end2;}
				if(endDateIdx==3) {sql += end3;}
				if(endDateIdx==4) {sql += end4;}
				if(endDateIdx==5) {sql += end5;}
				if(endDateIdx==6) {sql += end6;}
			}
			if(startDateIdx==2) {sql += start2;
				if(endDateIdx==1) {sql += end1;}
				if(endDateIdx==2) {sql += end2;}
				if(endDateIdx==3) {sql += end3;}
				if(endDateIdx==4) {sql += end4;}
				if(endDateIdx==5) {sql += end5;}
				if(endDateIdx==6) {sql += end6;}
			}
			if(startDateIdx==3) {sql += start3;
				if(endDateIdx==1) {sql += end1;}
				if(endDateIdx==2) {sql += end2;}
				if(endDateIdx==3) {sql += end3;}
				if(endDateIdx==4) {sql += end4;}
				if(endDateIdx==5) {sql += end5;}
				if(endDateIdx==6) {sql += end6;}
			}
			if(startDateIdx==4) {sql += start4;
				if(endDateIdx==1) {sql += end1;}
				if(endDateIdx==2) {sql += end2;}
				if(endDateIdx==3) {sql += end3;}
				if(endDateIdx==4) {sql += end4;}
				if(endDateIdx==5) {sql += end5;}
				if(endDateIdx==6) {sql += end6;}
			}
			if(startDateIdx==5) {sql += start5;
				if(endDateIdx==1) {sql += end1;}
				if(endDateIdx==2) {sql += end2;}
				if(endDateIdx==3) {sql += end3;}
				if(endDateIdx==4) {sql += end4;}
				if(endDateIdx==5) {sql += end5;}
				if(endDateIdx==6) {sql += end6;}
			}
		}
		if(writevalue==3) {
			sql += write3;
			if(startDateIdx==1) {sql += start1;
				if(endDateIdx==1) {sql += end1;}
				if(endDateIdx==2) {sql += end2;}
				if(endDateIdx==3) {sql += end3;}
				if(endDateIdx==4) {sql += end4;}
				if(endDateIdx==5) {sql += end5;}
				if(endDateIdx==6) {sql += end6;}
			}
			if(startDateIdx==2) {sql += start2;
				if(endDateIdx==1) {sql += end1;}
				if(endDateIdx==2) {sql += end2;}
				if(endDateIdx==3) {sql += end3;}
				if(endDateIdx==4) {sql += end4;}
				if(endDateIdx==5) {sql += end5;}
				if(endDateIdx==6) {sql += end6;}
			}
			if(startDateIdx==3) {sql += start3;
				if(endDateIdx==1) {sql += end1;}
				if(endDateIdx==2) {sql += end2;}
				if(endDateIdx==3) {sql += end3;}
				if(endDateIdx==4) {sql += end4;}
				if(endDateIdx==5) {sql += end5;}
				if(endDateIdx==6) {sql += end6;}
			}
			if(startDateIdx==4) {sql += start4;
				if(endDateIdx==1) {sql += end1;}
				if(endDateIdx==2) {sql += end2;}
				if(endDateIdx==3) {sql += end3;}
				if(endDateIdx==4) {sql += end4;}
				if(endDateIdx==5) {sql += end5;}
				if(endDateIdx==6) {sql += end6;}
				
			}
			if(startDateIdx==5) {sql += start5;
				if(endDateIdx==1) {sql += end1;}
				if(endDateIdx==2) {sql += end2;}
				if(endDateIdx==3) {sql += end3;}
				if(endDateIdx==4) {sql += end4;}
				if(endDateIdx==5) {sql += end5;}
				if(endDateIdx==6) {sql += end6;}
			}
		}
		ArrayList<TaskSearchDto> listRet = new ArrayList<TaskSearchDto>();
		
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,"%"+search+"%");
		pstmt.setString(2,"%"+search+"%");
		pstmt.setInt(3,state1);
		pstmt.setInt(4,state2);
		pstmt.setInt(5,state3);
		pstmt.setInt(6,state4);
		pstmt.setInt(7,state5);
		pstmt.setInt(8,priority1);
		pstmt.setInt(9,priority2);
		pstmt.setInt(10,priority3);
		pstmt.setInt(11,priority4);
		pstmt.setInt(12,priority5);
		pstmt.setInt(13,projectIdx);
		if(writevalue==1) {
			pstmt.setInt(14,WriterIdx);
		}
		else if (writevalue==2) {
			pstmt.setInt(14,memberIdx);
		}
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			String title = rs.getString("업무명");
			int state = rs.getInt("상태");
			int priority = rs.getInt("우선 순위");
			String startDate = rs.getString("시작일");
			String endDate = rs.getString("마감일");
			String writeDate = rs.getString("작성일");
			int taskIdx = rs.getInt("업무 번호");
			String name = rs.getString("작성자");
			String lastModifiedDate = rs.getString("수정일");
			int progress = rs.getInt("진척도");
			Integer taskGroupIdx = rs.getObject("업무그룹") != null ? rs.getInt("업무그룹") : 0;
			TaskSearchDto dto = new TaskSearchDto(title, state, priority, startDate, endDate, writeDate, taskIdx, name, lastModifiedDate, progress,taskGroupIdx);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
//	[Minsuk24] 프로젝트 업무 검색(p112) 기본 검색 (업무번호 제목)의 담당자 출력
//	input : String(검색어) int(프로젝트idx)
	public ArrayList<TaskManagerDto>SearchTaskManager(String search, int WriterIdx,int memberIdx, int state1, 
			int state2, int state3, int state4, int state5, int priority1, int priority2, int priority3, int priority4,
			int priority5,int projectIdx,int writevalue,int startDateIdx, int endDateIdx)throws Exception {
		String sql = " SELECT T.TASK_IDX AS \"업무 번호\",M.NAME AS \"담당자\"" + 
				" FROM BOARD B INNER JOIN TASK T " + 
				" ON B.BOARD_IDX = T.BOARD_IDX LEFT JOIN  TASK_MANAGER TM " + 
				" ON T.TASK_IDX = TM.TASK_IDX INNER JOIN MEMBERS M" + 
				" ON TM.MEMBER_IDX = M.MEMBER_IDX" + 
				" WHERE (T.TASK_IDX LIKE ? " + 
				" OR  CASE WHEN T.TOP_TASK_IDX IS NULL THEN UPPER(B.TITLE) ELSE UPPER(T.TITLE) END LIKE UPPER(?))" + 
				" AND t.state In (?,?,?,?,?)" + 
				" AND t.priority In (?,?,?,?,?)" + 
				" AND B.PROJECT_IDX = ?";
		ArrayList<TaskManagerDto> listRet = new ArrayList<TaskManagerDto>();
		String write1 = "AND TM.member_IDX = ?";
		String write2 = "AND T.WRITER_IDX = ?";
		String write3 = "";
		String start1 = "";
		String start2 = " AND T.START_DATE = TO_CHAR(SYSDATE, 'YYYY-MM-DD')";
		String start3 = " AND T.START_DATE BETWEEN (SELECT TRUNC(SYSDATE,'iw') FROM DUAL) AND " + 
				" (SELECT TRUNC(SYSDATE,'iw')+6 FROM DUAL)";
		String start4 = " AND TO_CHAR(T.START_DATE, 'YYYY-MM') = TO_CHAR(SYSDATE, 'YYYY-MM')";
		String start5 = " AND T.START_DATE IS NULL";
		String end1 = "";
		String end2 = " AND T.END_DATE < SYSDATE";
		String end3 = " AND T.END_DATE = SYSDATE";
		String end4 = "AND T.END_DATE BETWEEN (SELECT TRUNC(SYSDATE,'iw') FROM DUAL) AND " + 
				"                       (SELECT TRUNC(SYSDATE,'iw')+6 FROM DUAL)" + 
				" AND T.END_DATE >= TO_DATE(SYSDATE, 'YYYY-MM-DD')";
		String end5 = " AND TO_CHAR(T.END_DATE, 'YYYY-MM') = TO_CHAR(SYSDATE, 'YYYY-MM')" + 
				" AND TO_DATE(T.END_DATE, 'YYYY-MM-DD') >= TO_DATE(SYSDATE, 'YYYY-MM-DD')";
		String end6 = "AND T.END_DATE IS NULL";
		if(writevalue==1) {
			sql += write1;
			if(startDateIdx==1) {sql += start1;
				if(endDateIdx==1) {sql += end1;}
				if(endDateIdx==2) {sql += end2;}
				if(endDateIdx==3) {sql += end3;}
				if(endDateIdx==4) {sql += end4;}
				if(endDateIdx==5) {sql += end5;}
				if(endDateIdx==6) {sql += end6;}
			}
			if(startDateIdx==2) {sql += start2;
				if(endDateIdx==1) {sql += end1;}
				if(endDateIdx==2) {sql += end2;}
				if(endDateIdx==3) {sql += end3;}
				if(endDateIdx==4) {sql += end4;}
				if(endDateIdx==5) {sql += end5;}
				if(endDateIdx==6) {sql += end6;}
			}
			if(startDateIdx==3) {sql += start3;
				if(endDateIdx==1) {sql += end1;}
				if(endDateIdx==2) {sql += end2;}
				if(endDateIdx==3) {sql += end3;}
				if(endDateIdx==4) {sql += end4;}
				if(endDateIdx==5) {sql += end5;}
				if(endDateIdx==6) {sql += end6;}
			}
			if(startDateIdx==4) {sql += start4;
				if(endDateIdx==1) {sql += end1;}
				if(endDateIdx==2) {sql += end2;}
				if(endDateIdx==3) {sql += end3;}
				if(endDateIdx==4) {sql += end4;}
				if(endDateIdx==5) {sql += end5;}
				if(endDateIdx==6) {sql += end6;}
				
			}
			if(startDateIdx==5) {sql += start5;
				if(endDateIdx==1) {sql += end1;}
				if(endDateIdx==2) {sql += end2;}
				if(endDateIdx==3) {sql += end3;}
				if(endDateIdx==4) {sql += end4;}
				if(endDateIdx==5) {sql += end5;}
				if(endDateIdx==6) {sql += end6;}
			}
		}
		if(writevalue==2) {
			sql += write2;
			if(startDateIdx==1) {sql += start1;
				if(endDateIdx==1) {sql += end1;}
				if(endDateIdx==2) {sql += end2;}
				if(endDateIdx==3) {sql += end3;}
				if(endDateIdx==4) {sql += end4;}
				if(endDateIdx==5) {sql += end5;}
				if(endDateIdx==6) {sql += end6;}
			}
			if(startDateIdx==2) {sql += start2;
				if(endDateIdx==1) {sql += end1;}
				if(endDateIdx==2) {sql += end2;}
				if(endDateIdx==3) {sql += end3;}
				if(endDateIdx==4) {sql += end4;}
				if(endDateIdx==5) {sql += end5;}
				if(endDateIdx==6) {sql += end6;}
			}
			if(startDateIdx==3) {sql += start3;
				if(endDateIdx==1) {sql += end1;}
				if(endDateIdx==2) {sql += end2;}
				if(endDateIdx==3) {sql += end3;}
				if(endDateIdx==4) {sql += end4;}
				if(endDateIdx==5) {sql += end5;}
				if(endDateIdx==6) {sql += end6;}
			}
			if(startDateIdx==4) {sql += start4;
				if(endDateIdx==1) {sql += end1;}
				if(endDateIdx==2) {sql += end2;}
				if(endDateIdx==3) {sql += end3;}
				if(endDateIdx==4) {sql += end4;}
				if(endDateIdx==5) {sql += end5;}
				if(endDateIdx==6) {sql += end6;}
				
			}
			if(startDateIdx==5) {sql += start5;
				if(endDateIdx==1) {sql += end1;}
				if(endDateIdx==2) {sql += end2;}
				if(endDateIdx==3) {sql += end3;}
				if(endDateIdx==4) {sql += end4;}
				if(endDateIdx==5) {sql += end5;}
				if(endDateIdx==6) {sql += end6;}
			}
		}
		if(writevalue==3) {
			sql += write3;
			if(startDateIdx==1) {sql += start1;
				if(endDateIdx==1) {sql += end1;}
				if(endDateIdx==2) {sql += end2;}
				if(endDateIdx==3) {sql += end3;}
				if(endDateIdx==4) {sql += end4;}
				if(endDateIdx==5) {sql += end5;}
				if(endDateIdx==6) {sql += end6;}
			}
			if(startDateIdx==2) {sql += start2;
				if(endDateIdx==1) {sql += end1;}
				if(endDateIdx==2) {sql += end2;}
				if(endDateIdx==3) {sql += end3;}
				if(endDateIdx==4) {sql += end4;}
				if(endDateIdx==5) {sql += end5;}
				if(endDateIdx==6) {sql += end6;}
			}
			if(startDateIdx==3) {sql += start3;
				if(endDateIdx==1) {sql += end1;}
				if(endDateIdx==2) {sql += end2;}
				if(endDateIdx==3) {sql += end3;}
				if(endDateIdx==4) {sql += end4;}
				if(endDateIdx==5) {sql += end5;}
				if(endDateIdx==6) {sql += end6;}
			}
			if(startDateIdx==4) {sql += start4;
				if(endDateIdx==1) {sql += end1;}
				if(endDateIdx==2) {sql += end2;}
				if(endDateIdx==3) {sql += end3;}
				if(endDateIdx==4) {sql += end4;}
				if(endDateIdx==5) {sql += end5;}
				if(endDateIdx==6) {sql += end6;}
				
			}
			if(startDateIdx==5) {sql += start5;
				if(endDateIdx==1) {sql += end1;}
				if(endDateIdx==2) {sql += end2;}
				if(endDateIdx==3) {sql += end3;}
				if(endDateIdx==4) {sql += end4;}
				if(endDateIdx==5) {sql += end5;}
				if(endDateIdx==6) {sql += end6;}
			}
		}
		
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,"%"+search+"%");
		pstmt.setString(2,"%"+search+"%");
		pstmt.setInt(3,state1);
		pstmt.setInt(4,state2);
		pstmt.setInt(5,state3);
		pstmt.setInt(6,state4);
		pstmt.setInt(7,state5);
		pstmt.setInt(8,priority1);
		pstmt.setInt(9,priority2);
		pstmt.setInt(10,priority3);
		pstmt.setInt(11,priority4);
		pstmt.setInt(12,priority5);
		pstmt.setInt(13,projectIdx);
		if(writevalue==1) {
			pstmt.setInt(14,WriterIdx);
		}
		else if (writevalue==2) {
			pstmt.setInt(14,memberIdx);
		}
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int taskIdx = rs.getInt("업무 번호");
			String name = rs.getString("담당자");
			TaskManagerDto dto = new TaskManagerDto(taskIdx, taskIdx, name, name);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
		
	}
//	[Minsuk26] 프로젝트 업무 그룹 생성,변경,삭제(p113)
//	input : int(프로젝트idx), String(업무 그룹 이름)
//	output  :-
//	INSERT INTO task_group values ((업무 그룹 IDX),’그룹명’,(입력한 프로젝트 IDX));
	public void ADDProjectTaskGroup(String TaskGroupName, int projectIdx) throws Exception {
		String sql = "INSERT INTO task_group values (TASKGROUPUP.nextval,?,?)";
		
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1,TaskGroupName);
		pstmt.setInt(2,projectIdx);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	public void UpdateProjectTaskGroup(String TaskGroupName, int TaskGroupIdx) throws Exception {
		String sql = "UPDATE task_group set task_group_name = ? where task_group_idx = ?";
		
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1,TaskGroupName);
		pstmt.setInt(2,TaskGroupIdx);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	public void DeleteProjectTaskGroup(int TaskGroupIdx) throws Exception {
		String sql = "DELETE FROM task_group where task_group_idx = ?";
		
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setInt(1,TaskGroupIdx);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	public void UpdateTaskDelete(int taskIdx) throws Exception {
			String sql = "UPDATE task set task_group_idx = null where task_idx = ?";
		
			Connection conn = getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1,taskIdx);
			pstmt.executeUpdate();
			pstmt.close();
			conn.close();	
	}
	public void UpdateTaskGroup(int taskGroupIdx,int taskIdx) throws Exception {
		String sql = "UPDATE task set task_group_idx = ? where task_idx = ?";
		
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setInt(1,taskGroupIdx);
		pstmt.setInt(2,taskIdx);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();	
	}
	//업무 삭제
	public void DelTaskSubTask(int taskIdx) throws Exception {
		String sql= "DELETE FROM task WHERE TASK_IDX = ?";
		
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setInt(1,taskIdx);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
//	[Minsuk27-1] 업무 담당자 추가/변경(p116)
//	input : 추가 : int(멤버idx), int(업무idx)
//		제거 : int(담당자),  int(업무idx)
//	output :  -
//	추가 : INSERT INTO TASK_MANAGER VALUES((입력한 업무 IDX),(담당시킬 멤버 IDX));
//
//	변경 : UPDATE TASK_MANAGER SET MEMBER_IDX = (담당시킬 멤버 IDX) WHERE task_idx = (입력한 업무 IDX) AND MEMBER_IDX = (변경할 멤버 IDX);
//
//	제거 : DELETE FROM TASK_MANAGER WHERE task_idx = (입력한 업무 IDX) AND MEMBER_IDX = (제거할 멤버 IDX);
	public void ADDtaskManager(int taskIdx, int memberIdx) throws Exception {
		String sql = "INSERT INTO TASK_MANAGER VALUES (?,?)";
		
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setInt(1,taskIdx);
		pstmt.setInt(2,memberIdx);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	public void DeleteALLtaskManager(int taskIdx) throws Exception {
		String sql = "DELETE FROM TASK_MANAGER WHERE task_idx = ?";
		
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setInt(1,taskIdx);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	public void DeletetaskManager(int taskIdx, int memberIdx) throws Exception {
		String sql = "DELETE FROM TASK_MANAGER WHERE task_idx = ? AND MEMBER_IDX = ?";
		
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setInt(1,taskIdx);
		pstmt.setInt(2,memberIdx);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	public ArrayList<TaskGroupViewDto> TaskGroupView (int projectIdx) throws Exception {
		String sql = "SELECT " + 
				"    TASK_GROUP_IDX AS \"업무그룹번호\"," + 
				"    TASK_GROUP_NAME AS \"업무그룹명\"" + 
				" FROM TASK_GROUP" + 
				" WHERE PROJECT_IDX = ?";
			ArrayList<TaskGroupViewDto> listRet = new ArrayList<TaskGroupViewDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1,projectIdx);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int taskGroupIdx = rs.getInt("업무그룹번호");
			String taskGroupName = rs.getString("업무그룹명");
			TaskGroupViewDto dto = new TaskGroupViewDto(taskGroupIdx,taskGroupName);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	public TaskMangerViewProjectDto TaskManagerViewProjectOne(int taskIdx,int memberIdx) throws Exception {
		String sql = "SELECT " + 
				"    M.PROFILE_IMG AS \"프로필URL\"," + 
				"    M.NAME AS \"이름\"," + 
				"    M.MEMBER_IDX \"멤버번호\"" + 
				" FROM TASK_MANAGER TM" + 
				" JOIN MEMBERS M" + 
				" ON TM.MEMBER_IDX = M.MEMBER_IDX" + 
				" WHERE TM.TASK_IDX = ?" + 
				" AND M.MEMBER_IDX = ?";
		TaskMangerViewProjectDto dto = null;
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1,taskIdx);
		pstmt.setInt(2,memberIdx);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			String profileImg = rs.getString("프로필URL");
			String name = rs.getString("이름");
			memberIdx = rs.getInt("멤버번호");
			dto = new TaskMangerViewProjectDto(profileImg, memberIdx, name, null, null, null, '0');
		}
		rs.close();
		pstmt.close();
		conn.close();
		return dto;
	}
	//해당 업무의 매니저로 선택가능한 인원 출력
	public ArrayList<TaskMangerViewProjectDto>TaskMangerViewProject(int taskIdx,int projectIdx) throws Exception {
		String sql = " SELECT DISTINCT " + 
				"    m.profile_img AS \"프로필URL\"," + 
				"    M.MEMBER_IDX AS \"멤버IDX\"," + 
				"    M.NAME AS \"이름\"," + 
				"    M.POSITION AS \"직책\"," + 
				"    C.company_name AS \"회사명\"," + 
				"    D.department_name AS \"부서명\"," + 
				"    CASE " + 
				"        WHEN EXISTS (" + 
				"            SELECT 1" + 
				"            FROM TASK_MANAGER TM" + 
				"            WHERE TM.TASK_IDX = ? " + 
				"            AND TM.MEMBER_IDX = M.MEMBER_IDX" + 
				"        ) THEN 'Y'" + 
				"        ELSE 'N'" + 
				"    END AS \"담당자여부\"" + 
				" FROM PROJECT_MEMBER PM" + 
				" JOIN MEMBERS M ON PM.PARTICIPANT_IDX = M.MEMBER_IDX" + 
				" LEFT JOIN DEPARTMENTS D ON M.DEPARTMENT_IDX = D.DEPARTMENT_IDX" + 
				" JOIN COMPANIES C ON M.COMPANY_IDX = C.COMPANY_IDX" + 
				" JOIN BOARD B ON PM.PROJECT_IDX = B.PROJECT_IDX" + 
				" JOIN TASK T ON B.BOARD_IDX = T.BOARD_IDX" + 
				" left JOIN TASK_MANAGER TM ON T.TASK_IDX = TM.TASK_IDX" + 
				" WHERE PM.PROJECT_IDX = ?";
		ArrayList<TaskMangerViewProjectDto> listRet = new ArrayList<TaskMangerViewProjectDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1,taskIdx);
		pstmt.setInt(2,projectIdx);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			String profileImg = rs.getString("프로필URL");
			int memberIdx = rs.getInt("멤버IDX");
			String name = rs.getString("이름");
			String position = rs.getString("직책");
			String companyName = rs.getString("회사명");
			String departmentName = rs.getString("부서명");
			char ManagerYN = rs.getString("담당자여부").charAt(0);
			if(departmentName == null) {
				departmentName = "";
			}
			if(position == null) {
				position = "";
			}
			TaskMangerViewProjectDto dto = new TaskMangerViewProjectDto(profileImg, memberIdx, name, position, companyName, departmentName, ManagerYN);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	//해당 인원중 담당자인 인원만 출력
	public ArrayList<TaskMangerViewProjectDto>TaskMangerViewaddProject(int taskIdx,int projectIdx) throws Exception {
		String sql = " SELECT DISTINCT " + 
				"    m.profile_img AS \"프로필URL\"," + 
				"    M.MEMBER_IDX AS \"멤버IDX\"," + 
				"    M.NAME AS \"이름\"," + 
				"    M.POSITION AS \"직책\"," + 
				"    C.company_name AS \"회사명\"," + 
				"    D.department_name AS \"부서명\"," + 
				"    CASE " + 
				"        WHEN EXISTS (" + 
				"            SELECT 1" + 
				"            FROM TASK_MANAGER TM" + 
				"            WHERE TM.TASK_IDX = ? " + 
				"            AND TM.MEMBER_IDX = M.MEMBER_IDX" + 
				"        ) THEN 'Y'" + 
				"        ELSE 'N'" + 
				"    END AS \"담당자여부\"" + 
				" FROM PROJECT_MEMBER PM" + 
				" JOIN MEMBERS M ON PM.PARTICIPANT_IDX = M.MEMBER_IDX" + 
				" LEFT JOIN DEPARTMENTS D ON M.DEPARTMENT_IDX = D.DEPARTMENT_IDX" + 
				" JOIN COMPANIES C ON M.COMPANY_IDX = C.COMPANY_IDX" + 
				" JOIN BOARD B ON PM.PROJECT_IDX = B.PROJECT_IDX" + 
				" JOIN TASK T ON B.BOARD_IDX = T.BOARD_IDX" + 
				" JOIN TASK_MANAGER TM ON T.TASK_IDX = TM.TASK_IDX" + 
				" WHERE PM.PROJECT_IDX = ?" + 
				" AND EXISTS (" + 
				"    SELECT 1" + 
				"    FROM TASK_MANAGER TM" + 
				"    WHERE TM.TASK_IDX = ?" + 
				"    AND TM.MEMBER_IDX = M.MEMBER_IDX" + 
				" )";
		ArrayList<TaskMangerViewProjectDto> listRet = new ArrayList<TaskMangerViewProjectDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1,taskIdx);
		pstmt.setInt(2,projectIdx);
		pstmt.setInt(3,taskIdx);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			String profileImg = rs.getString("프로필URL");
			int memberIdx = rs.getInt("멤버IDX");
			String name = rs.getString("이름");
			String position = rs.getString("직책");
			String companyName = rs.getString("회사명");
			String departmentName = rs.getString("부서명");
			char ManagerYN = rs.getString("담당자여부").charAt(0);
			if(departmentName == null) {
				departmentName = "";
			}
			if(position == null) {
				position = "";
			}
			TaskMangerViewProjectDto dto = new TaskMangerViewProjectDto(profileImg, memberIdx, name, position, companyName, departmentName, ManagerYN);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	//해당 업무의 매니저로 선택가능한 인원 검색
	public ArrayList<TaskMangerViewProjectDto>TaskMangerSearchProject(int taskIdx,int projectIdx,String search) throws Exception {
		String sql = " SELECT DISTINCT " + 
				"    m.profile_img AS \"프로필URL\"," + 
				"    M.MEMBER_IDX AS \"멤버IDX\"," + 
				"    M.NAME AS \"이름\"," + 
				"    M.POSITION AS \"직책\"," + 
				"    C.company_name AS \"회사명\"," + 
				"    D.department_name AS \"부서명\"," + 
				"    CASE " + 
				"        WHEN EXISTS (" + 
				"            SELECT 1" + 
				"            FROM TASK_MANAGER TM" + 
				"            WHERE TM.TASK_IDX = ? " + 
				"            AND TM.MEMBER_IDX = M.MEMBER_IDX" + 
				"        ) THEN 'Y'" + 
				"        ELSE 'N'" + 
				"    END AS \"담당자여부\"" + 
				" FROM PROJECT_MEMBER PM" + 
				" JOIN MEMBERS M ON PM.PARTICIPANT_IDX = M.MEMBER_IDX" + 
				" LEFT JOIN DEPARTMENTS D ON M.DEPARTMENT_IDX = D.DEPARTMENT_IDX" + 
				" JOIN COMPANIES C ON M.COMPANY_IDX = C.COMPANY_IDX" + 
				" JOIN BOARD B ON PM.PROJECT_IDX = B.PROJECT_IDX" + 
				" JOIN TASK T ON B.BOARD_IDX = T.BOARD_IDX" + 
				" JOIN TASK_MANAGER TM ON T.TASK_IDX = TM.TASK_IDX" + 
				" WHERE PM.PROJECT_IDX = ?" +
				" AND M.NAME LIKE ?";
		ArrayList<TaskMangerViewProjectDto> listRet = new ArrayList<TaskMangerViewProjectDto>();
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1,taskIdx);
		pstmt.setInt(2,projectIdx);
		pstmt.setString(3,"%"+search+"%");
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			String profileImg = rs.getString("프로필URL");
			int memberIdx = rs.getInt("멤버IDX");
			String name = rs.getString("이름");
			String position = rs.getString("직책");
			String companyName = rs.getString("회사명");
			String departmentName = rs.getString("부서명");
			char ManagerYN = rs.getString("담당자여부").charAt(0);
			if(departmentName == null) {
				departmentName = "";
			}
			if(position == null) {
				position = "";
			}
			TaskMangerViewProjectDto dto = new TaskMangerViewProjectDto(profileImg, memberIdx, name, position, companyName, departmentName, ManagerYN);
			listRet.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listRet;
	}
	//해당 업무의 매니저 수 구하기
	public int taskManagerCount(int taskIdx) throws Exception {
		String sql = " SELECT COUNT(TASK_idx)" + 
				" FROM TASK_MANAGER" + 
				" WHERE TASK_IDX = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1,taskIdx);
		ResultSet rs = pstmt.executeQuery();
		int count = 0;
		while(rs.next()) {
			count = rs.getInt(1);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return count;
	}
//	[Minsuk27-2] 업무 시작일/마감일 변경(p116)
//	input : 추가: 시작일 : String(시작일), int(업무idx) /
//	                    마감일 : String(마감일)(단 시작일이 존재할 경우 시작일 전을 마감일 지정불가),
//	                                   int(업무idx)
//	제거 : 	시작일 : int(업무idx),String(시작일) 
//	 	마감일 : int(업무idx),String(마감일)
//	output : -
//	추가
//	시작일 : UPDATE TASK SET START_DATE = (입력한 날짜) WHERE TASK_IDX = (추가할 업무 IDX)
//
//	마감일 : UPDATE TASK SET END_DATE = (입력한 날짜) WHERE TASK_IDX = (추가할 업무 IDX)
	public void UpdateStartDate(String StartDate, int TaskIDX)throws Exception {
		String sql = "UPDATE TASK SET START_DATE = To_Date(?, 'YYYY-MM-DD') WHERE TASK_IDX = ?";
		
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1,StartDate);
		pstmt.setInt(2,TaskIDX);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	public void UpdateEndDate(String EndDate, int TaskIDX)throws Exception {
		String sql = "UPDATE TASK SET END_DATE = To_Date(?, 'YYYY-MM-DD') WHERE TASK_IDX = ?";
		
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1,EndDate);
		pstmt.setInt(2,TaskIDX);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
//	[Minsuk27-3] 상태 변경(p116)
//	input :  int(상태), int(업무idx)
//	output : -
//	UPDATE TASK SET TASK_STATE = (입력한 상태번호) WHERE TASK_IDX = (입력한 업무 IDX);
	public void UpdateState(int state, int taskIdx) throws Exception {
		String sql = "";
		if(state==4) {
			sql = " UPDATE TASK SET STATE = ?,Progress=100 WHERE TASK_IDX = ?";
		} else {
			sql = " UPDATE TASK SET STATE = ? WHERE TASK_IDX = ?";
		}
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setInt(1,state);
		pstmt.setInt(2,taskIdx);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	
//	[Minsuk27-4] : 우선순위 변경(p116)
//	input :  변경 : int(우선순위), int(업무idx)
//	output : -
//	UPDATE TASK SET priority = (입력한 상태번호) WHERE TASK_IDX = (입력한 업무 IDX);

	public void UpdatePriority(int Priority, int taskIdx) throws Exception {
		String sql = "UPDATE TASK SET priority = ? WHERE TASK_IDX = ?";
		
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setInt(1,Priority);
		pstmt.setInt(2,taskIdx);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
//		[Minsuk27-5] : 진척도
//		input :  int(진척도(10단위max100)), int(업무idx)
//		output :   -
//		UPDATE TASK SET progress = (입력한 상태번호) WHERE TASK_IDX = (입력한 업무 IDX);

	public void UpdateProgress(int Progress, int taskIdx) throws Exception {
		String sql = "UPDATE TASK SET progress = ? WHERE TASK_IDX = ?";
		
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setInt(1,Progress);
		pstmt.setInt(2,taskIdx);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	//업무 게시물의 boardIdx 꺼내는 문 
	public int ShowBoardIdx(int taskIdx) throws Exception {
		String sql = " SELECT board_Idx" + 
				" FROM TASK" + 
				" WHERE TASK_IDX = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1,taskIdx);
		ResultSet rs = pstmt.executeQuery();
		int boardIdx = 0;
		if(rs.next()) {
			boardIdx = rs.getInt(1);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return boardIdx;
	}
	//업무 게시글 제목 변경
	public void UpdateTitle(int boardIdx, String title) throws Exception {
		String sql = "UPDATE board SET title = ? WHERE board_Idx = ?";
		
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1,title);
		pstmt.setInt(2,boardIdx);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
//	[Minsuk28] : 보기설정
//	input : char(11개 y/n), int(멤버idx)
//	ouput : -
//	UPDATE VIEW_SETTING SET 바꿀컬럼 = ‘Y OR N’ WHERE member_idx = (입력한 멤버 idx)
	public void UpdateViewSetting(char workNameYN, char StateYN, char priorityYN, char managerYN, char startDateYN,
			char deaeLineYN, char registrationDateYN, char taskIdxYN, char writerYN, char LastModifiedDateYN, char progressYN, int memberIdx) throws Exception {
		String sql = "UPDATE VIEW_SETTING SET work_name_yn = ?, State_yn = ?, priority_yn = ?, manager_yn = ?, start_date_yn = ?,"
				+"deae_line_yn = ?, registration_date_yn = ?, task_idx_yn = ?, writer_yn = ?, Last_modified_date_yn = ?, progress_yn = ?"
				+ "Where member_idx = ? ";
		
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1,String.valueOf(workNameYN));
		pstmt.setString(2,String.valueOf(StateYN));
		pstmt.setString(3,String.valueOf(priorityYN));
		pstmt.setString(4,String.valueOf(managerYN));
		pstmt.setString(5,String.valueOf(startDateYN));
		pstmt.setString(6,String.valueOf(deaeLineYN));
		pstmt.setString(7,String.valueOf(registrationDateYN));
		pstmt.setString(8,String.valueOf(taskIdxYN));
		pstmt.setString(9,String.valueOf(writerYN));
		pstmt.setString(10,String.valueOf(LastModifiedDateYN));
		pstmt.setString(11,String.valueOf(progressYN));
		pstmt.setInt(12,memberIdx);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	public TaskViewOptionDto SelectTaskViewOption(int memberIdx) throws Exception {
		String sql = " SELECT " + 
				"    MEMBER_IDX AS \"멤버IDX\"," + 
				"    WORK_NAME_YN AS \"업무명\"," + 
				"    STATE_YN AS \"상태\"," + 
				"    PRIORITY_YN AS \"우선순위\"," + 
				"    MANAGER_YN AS \"담당자\"," + 
				"    START_DATE_YN AS \"시작일\"," + 
				"    DEAE_LINE_YN AS \"마감일\"," + 
				"    REGISTRATION_DATE_YN AS \"작성일\"," + 
				"    TASK_IDX_YN AS \"업무번호\"," + 
				"    WRITER_YN AS \"작성자\"," + 
				"    LAST_MODIFIED_DATE_YN AS \"최근수정일\"," + 
				"    PROGRESS_YN AS \"진척도\"" + 
				" FROM VIEW_SETTING" + 
				" WHERE MEMBER_IDX =?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1,memberIdx);
		ResultSet rs = pstmt.executeQuery();
		TaskViewOptionDto dto = null;
		if(rs.next()) {
			 memberIdx = rs.getInt("멤버IDX");
			 char workNameYN = rs.getString("업무명").charAt(0);
			 char stateYN = rs.getString("상태").charAt(0);
			 char priorityYN = rs.getString("우선순위").charAt(0);
			 char managerYN = rs.getString("담당자").charAt(0);
			 char startDateYN = rs.getString("시작일").charAt(0);
			 char deadLineYN = rs.getString("마감일").charAt(0);
			 char registrationDateYN = rs.getString("작성일").charAt(0);
			 char taskIdxYN = rs.getString("업무번호").charAt(0);
			 char writerYN = rs.getString("작성자").charAt(0);
			 char lastModifiedDateYN = rs.getString("최근수정일").charAt(0);
			 char progressYN = rs.getString("진척도").charAt(0);
			 dto = new TaskViewOptionDto(memberIdx, workNameYN, stateYN, priorityYN, managerYN, startDateYN, deadLineYN, registrationDateYN, taskIdxYN, writerYN, lastModifiedDateYN, progressYN);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return dto;
	}
	public void UpdateTask(int state, int priority, String startDate, String endDate,int progress, int TaskGroupIdx, int taskIdx) throws Exception {
		String sql = "UPDATE Task SET state = ?,priority = ?,start_date = ?,end_date = ?,progress = ?,TASK_GROUP_IDX = ?" + 
				" WHERE TASK_IDX = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, state);
		pstmt.setInt(2, priority);
		pstmt.setString(3,startDate);
		pstmt.setString(4,endDate);
		pstmt.setInt(5, progress);
		pstmt.setInt(6, TaskGroupIdx);
		pstmt.setInt(7, taskIdx);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	public static void main(String[] args) throws Exception {
		TaskALLDao Dao = new TaskALLDao();
		System.out.println(Dao.taskGroupCount("", 1, 1, 1, 2, 3, 4, 5, 1, 2, 3, 4, 5, 1, 3, 1, 2, 0, 1));
		
		
	}

}
