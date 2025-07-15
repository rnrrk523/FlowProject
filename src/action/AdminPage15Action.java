package action;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.ChatMonitoringHistoryDao;
import dao.CompanyDao;
import dto.ChatRoomMonitoringHistoryDto;
import dto.CompanyDto;

public class AdminPage15Action implements Action{
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false); // false: 세션 없으면 null 반환

		if (session == null || session.getAttribute("memberIdx") == null) {
        	response.setContentType("text/html; charset=UTF-8");
        	response.setCharacterEncoding("UTF-8");
        	PrintWriter out = response.getWriter();
            out.println("<script>");
            out.println("alert('로그인이 필요합니다.');");
            out.println("location.href='Controller?command=Login';");
            out.println("</script>");
            out.close();
            return; // 더 이상 실행 안 하고 종료
        }
//		int companyIdx = Integer.parseInt(request.getParameter("companyIdx"));
		int companyIdx = (int)session.getAttribute("companyIdx");
//		int memberIdx = Integer.parseInt(request.getParameter("memberIdx"));
		int memberIdx = (int)session.getAttribute("memberIdx");
		
		CompanyDao cDao = new CompanyDao();
		CompanyDto companyInfo = null;
		try {
			companyInfo = cDao.getCompanyInfo(companyIdx);
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		String auditChatDate = companyInfo.getAuditChatDate();
		
		ChatMonitoringHistoryDao cmhDao = new ChatMonitoringHistoryDao();
		ArrayList<ChatRoomMonitoringHistoryDto> auditChatRoomList = new ArrayList<ChatRoomMonitoringHistoryDto>();
		if(auditChatDate != null){
			try {
				auditChatRoomList = cmhDao.getChatRoomMonitoringHistory(companyIdx, "이름", "");
			}catch(Exception e) {}
		}
		
		//현재 날짜 가져오기
		Date now = new Date();
			
		// Calendar 인스턴스 생성
		Calendar cal = Calendar.getInstance();
		cal.setTime(now);
			
		// 6개월 전으로 설정
		cal.add(Calendar.MONTH, -6);
		Date sixMonthsAgo = cal.getTime();
			
		// 형식 지정
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		String today = df.format(now);
		String sixMonthsAgoFormatted = df.format(sixMonthsAgo);
			
		// 요일 뽑아오기 (현재 날짜 기준)
		SimpleDateFormat sdf = new SimpleDateFormat("EEEE",Locale.KOREA);
			
		String dayOfWeek = sdf.format(now); // 현재 날짜 기준으로 요일 가져오기
		String dayOfWeek6prev = sdf.format(sixMonthsAgo); // 6개월 전 기준으로 요일 가져오기
			
		String week = "(" + dayOfWeek.charAt(0) + ")";
		String week6prev = "(" + dayOfWeek6prev.charAt(0) + ")";
			
		String startDate = sixMonthsAgoFormatted+week6prev;
		String endDate = today+week;
		
		request.setAttribute("companyIdx", companyIdx);
		request.setAttribute("memberIdx", memberIdx);
		request.setAttribute("companyInfo", companyInfo);
		request.setAttribute("auditChatDate", auditChatDate);
		request.setAttribute("auditChatRoomList", auditChatRoomList);
		request.setAttribute("startDate", startDate);
		request.setAttribute("endDate", endDate);
		
		request.getRequestDispatcher("flow_admin15.jsp").forward(request, response);
	}
}