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

import dao.CompanyDao;
import dto.FileDownloadRecordDto;

public class AdminPage13Action implements Action{
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

		CompanyDao cDao = new CompanyDao();
		ArrayList<FileDownloadRecordDto> fileDownRecordList = null;
		try {
			fileDownRecordList = cDao.getFileDownloadRecord(companyIdx, "이름", "", startDate.substring(0, startDate.length()-3), endDate.substring(0, endDate.length()-3));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		request.setAttribute("companyIdx", companyIdx);
		request.setAttribute("memberIdx", memberIdx);
		request.setAttribute("fileDownRecordList", fileDownRecordList);
		request.setAttribute("startDate", startDate);
		request.setAttribute("endDate", endDate);
		
		request.getRequestDispatcher("flow_admin13.jsp").forward(request, response);
	}
}