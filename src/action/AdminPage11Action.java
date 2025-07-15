package action;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.LoginRecordDao;
import dao.MemberDao;
import dto.LoginRecordDto;
import dto.MemberCompanyDepartmentDto;
import dto.loginRecordDateDto;

public class AdminPage11Action implements Action{
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
		
		// 현재 날짜기준 이번달 말일 가져오기
		Calendar cal0 = Calendar.getInstance();
		cal0.setTime(now);
		cal0.set(Calendar.DAY_OF_MONTH, cal0.getActualMaximum(Calendar.DAY_OF_MONTH));
		Date endOfMonth = cal0.getTime();
		
		// 6개월 전 날짜 가져오기
		Calendar cal1 = Calendar.getInstance();
		cal1.setTime(now);
		cal1.add(Calendar.MONTH, -6);
		Date sixMonthsAgo = cal1.getTime();
		
		// 30일전 날짜 가져오기
		Calendar cal2 = Calendar.getInstance();
		cal2.setTime(now);
		cal2.add(Calendar.MONTH, -1);
		Date oneMonthAgo = cal2.getTime();
		
		// 어제 날짜 가져오기
		Calendar cal3 = Calendar.getInstance();
		cal3.setTime(now);
		cal3.add(Calendar.DAY_OF_MONTH, -1);
		Date yesterDay = cal3.getTime();
		
		// 이번주 일요일의 날짜 가져오기
		Calendar cal4 = Calendar.getInstance();
		cal4.setTime(now);
		int dayOfWeekInt = cal4.get(Calendar.DAY_OF_WEEK);
		int daysUntilSunday = Calendar.SATURDAY - dayOfWeekInt + 1;
		cal4.add(Calendar.DAY_OF_MONTH, daysUntilSunday);
		Date sunday = cal4.getTime();
		
		// 형식 지정
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		String today = df.format(now);
		String sixMonthsAgoFormatted = df.format(sixMonthsAgo);
		String oneMonthsAgoFormatted = df.format(oneMonthAgo);
		String nowMonthEndDayFormatted = df.format(endOfMonth);
		String yesterDayFormatted = df.format(yesterDay);
		String nowWeeksunDay = df.format(sunday);
		
		// 요일 뽑아오기 (현재 날짜 기준)
		SimpleDateFormat sdf = new SimpleDateFormat("EEEE");
			
		String dayOfWeek = sdf.format(now); // 현재 날짜 기준으로 요일 가져오기
		String dayOfWeek6prev = sdf.format(sixMonthsAgo); // 6개월 전 기준으로 요일 가져오기
			
		String week = "(" + dayOfWeek.charAt(0) + ")";
		String week6prev = "(" + dayOfWeek6prev.charAt(0) + ")";
		
		// 날짜뒤에 요일 붙이기
		String startDate = sixMonthsAgoFormatted+week6prev;
		String endDate = today+week;
		
		// 요일 빼기
		String searchStartDate = sixMonthsAgoFormatted;
		String searchEndDate = today;
		
		// 6개월 전 날짜를 1일로 변경
		String sixMonthsAgoFirstDay = sixMonthsAgoFormatted.replace(sixMonthsAgoFormatted.substring(8, 10), "01");
		
		// 이번달 01일 가져오기
		String nowMonthFirstDay = nowMonthEndDayFormatted.replace(nowMonthEndDayFormatted.substring(8, 10), "01");
		
		LoginRecordDao  lDao = new LoginRecordDao();
		ArrayList<LoginRecordDto> monthList = null;
		try {
			monthList = lDao.getLoginRecordSearchDto(companyIdx, "이름", "", nowMonthFirstDay, nowMonthEndDayFormatted);
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		ArrayList<LoginRecordDto> weekList = null;
		try {
			weekList = lDao.getLoginRecordSearchDto(companyIdx, "이름", "", nowWeeksunDay, nowWeeksunDay);
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		ArrayList<LoginRecordDto> dayList = null;
		try {
			dayList = lDao.getLoginRecordSearchDto(companyIdx, "이름", "", yesterDayFormatted, yesterDayFormatted);
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		MemberDao mDao = new MemberDao();
		ArrayList<MemberCompanyDepartmentDto> mList = null;
		try {
			mList = mDao.getAllMembersAvailable(companyIdx);
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		// 차트API 값 넣기
		ArrayList<String> listMonths4Chart = new ArrayList<String>();
		ArrayList<Integer> listCount4Chart = new ArrayList<Integer>();
		
		
		for(int i=5; i>=0; i--) {
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(now);
			if(i == 0) { calendar.add(Calendar.MONTH, -0); }
			else { calendar.add(Calendar.MONTH, -i); }
			Date iMonthAgo = calendar.getTime();
			SimpleDateFormat formatter = new SimpleDateFormat("yyyyMM");
			String formattedDate = formatter.format(iMonthAgo);
			
			listMonths4Chart.add(formattedDate);
			
			try {
				loginRecordDateDto lDto = lDao.getRecordCntMonth(companyIdx, formattedDate, formattedDate);
				listCount4Chart.add(lDto.getLoginCnt());
			} catch(Exception e) { listCount4Chart.add(0); }
		}
		
		request.setAttribute("companyIdx", companyIdx);
		request.setAttribute("memberIdx", memberIdx);
		
		request.setAttribute("monthList", monthList);
		request.setAttribute("weekList", weekList);
		request.setAttribute("dayList", dayList);
		
		request.setAttribute("listMonths4Chart", listMonths4Chart);
		request.setAttribute("listCount4Chart", listCount4Chart);
		
		request.getRequestDispatcher("flow_admin11.jsp").forward(request, response);
	}
}