<%@page import="dto.loginRecordDateDto"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="dto.MemberCompanyDepartmentDto"%>
<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="dao.LoginRecordDao"%>
<%@page import="dto.LoginRecordDto"%>
<%@page import="java.util.ArrayList"%>
<%
	// int companyIdx = Integer.parseInt(request.getParameter("companyIdx"));
	int companyIdx = 1;
	
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
	ArrayList<LoginRecordDto> monthList = lDao.getLoginRecordSearchDto(companyIdx, "이름", "", nowMonthFirstDay, nowMonthEndDayFormatted);
	ArrayList<LoginRecordDto> weekList = lDao.getLoginRecordSearchDto(companyIdx, "이름", "", nowWeeksunDay, nowWeeksunDay);
	ArrayList<LoginRecordDto> dayList = lDao.getLoginRecordSearchDto(companyIdx, "이름", "", yesterDayFormatted, yesterDayFormatted);
	MemberDao mDao = new MemberDao();
	ArrayList<MemberCompanyDepartmentDto> mList = mDao.getAllMembersAvailable(companyIdx);
	
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
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>접속 통계</title>
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	<script src="js/jquery-3.7.1.min.js"></script>
	<script>
		/* let chart_data_records = [
			{date:'20241026', count:0},
			{date:'20241027', count:50},
			{date:'20241028', count:0},
			{date:'20241106', count:100},
			{date:'20241122', count:100}
		]; */
//		const dates_for_chart = ['202408', '202409', '202410', '202411', '202412', '202501'];
//		const data2 = [1, 3, 3, 1, 9, 24];
		const dates_for_chart = [];
		const data2 = [];
		<% for(int i=0; i<=listMonths4Chart.size()-1; i++) { %>
			dates_for_chart.push('<%=listMonths4Chart.get(i)%>');
			data2.push(<%=listCount4Chart.get(i)%>);
		<% } %>
		
		function draw_chart() {
			const myChart = new Chart('chart1', {
				type: "line",
				data: {
					labels: dates_for_chart,
					datasets: [
						{
						    data: data2,
						    borderColor: "rgb(182, 179, 179)",
						    backgroundColor: "white",
						    fill: false
						},
					]
				},
				options: {
					responsive: false, 
					elements: {
						point: {
							radius: 0
						}
					},
					hover: {
						mode: 'label'
					},
					scales: {
						x: {
							display: true
						},
						y: {
							ticks: {
								stepSize: 5,
								min: 0,
								max: 50,
								callback: function(value, index, values) {
									return value + '명';
								}
							}
						}						
					},
					spanGaps: true,
					plugins: {
						legend: {
							display: false
						}
					}
				}
			});
		}

	</script>
	<script>
		$(function() {
			draw_chart();
			
			/*페이지 이동*/
			$("#admin-1").click(function() {
				window.location.href = 'Controller?command=admin_page1&companyIdx='+${companyIdx}+'&memberIdx='+${memberIdx};
			});
			$("#admin-2").click(function() {
				window.location.href = 'Controller?command=admin_page2&companyIdx='+${companyIdx}+'&memberIdx='+${memberIdx};
			});
			$("#admin-3").click(function() {
				window.location.href = 'Controller?command=admin_page3&companyIdx='+${companyIdx}+'&memberIdx='+${memberIdx};
			});
			$("#admin-4").click(function() {
				window.location.href = 'Controller?command=admin_page4&companyIdx='+${companyIdx}+'&memberIdx='+${memberIdx};
			});
			$("#admin-5").click(function() {
				window.location.href = 'Controller?command=admin_page5&companyIdx='+${companyIdx}+'&memberIdx='+${memberIdx};
			});
			$("#admin-6").click(function() {
				window.location.href = 'Controller?command=admin_page6&companyIdx='+${companyIdx}+'&memberIdx='+${memberIdx};
			});
			$("#admin-7").click(function() {
				window.location.href = 'Controller?command=admin_page7&companyIdx='+${companyIdx}+'&memberIdx='+${memberIdx};
			});
			$("#admin-8").click(function() {
				window.location.href = 'Controller?command=admin_page8&companyIdx='+${companyIdx}+'&memberIdx='+${memberIdx};
			});
			$("#admin-9").click(function() {
				window.location.href = 'Controller?command=admin_page9&companyIdx='+${companyIdx}+'&memberIdx='+${memberIdx};
			});
			$("#admin-10").click(function() {
				window.location.href = 'Controller?command=admin_page10&companyIdx='+${companyIdx}+'&memberIdx='+${memberIdx};
			});
			$("#admin-12").click(function() {
				window.location.href = 'Controller?command=admin_page12&companyIdx='+${companyIdx}+'&memberIdx='+${memberIdx};
			});
			$("#admin-13").click(function() {
				window.location.href = 'Controller?command=admin_page13&companyIdx='+${companyIdx}+'&memberIdx='+${memberIdx};
			});
			$("#admin-14").click(function() {
				window.location.href = 'Controller?command=admin_page14&companyIdx='+${companyIdx}+'&memberIdx='+${memberIdx};
			});
			$("#admin-15").click(function() {
				window.location.href = 'Controller?command=admin_page15&companyIdx='+${companyIdx}+'&memberIdx='+${memberIdx};
			});
			/*월별 탭 클릭*/
			$(".month-tab").click(function() {
				$(this).css('border-bottom', '4px solid #307CFF');
				$(".week-tab").css('border-bottom', '1px solid #C5C6CB');
				$(".day-tab").css('border-bottom', '1px solid #C5C6CB');
				
				$(this).css('cursor', 'default');
				$(".week-tab").css('cursor', 'pointer');
				$(".day-tab").css('cursor', 'pointer');
				
				$(".mini-title-box").find('p:nth-child(1)').text('월별 통계 차트');
				$(".mini-title-box").find('p:nth-child(2)').text('최근 6개월');
				
				$(".month-img").css('display', 'block');
				$(".week-img").css('display', 'none');
				$(".day-img").css('display', 'none');
				
				$(".sb1").css('display', 'flex');
				$(".sb2").css('display', 'none');
				$(".sb3").css('display', 'none');
				
				$(".table-1").css('display', 'table');
				$(".table-2").css('display', 'none');
				$(".table-3").css('display', 'none');
				
				$(".input-text").val("");
			});
			/*주별 탭 클릭*/
			$(".week-tab").click(function() {
				$(this).css('border-bottom', '4px solid #307CFF');
				$(".month-tab").css('border-bottom', '1px solid #C5C6CB');
				$(".day-tab").css('border-bottom', '1px solid #C5C6CB');
				
				$(this).css('cursor', 'default');
				$(".month-tab").css('cursor', 'pointer');
				$(".day-tab").css('cursor', 'pointer');
				
				$(".mini-title-box").find('p:nth-child(1)').text('주별 통계 차트');
				$(".mini-title-box").find('p:nth-child(2)').text('최근 10주');
				
				$(".month-img").css('display', 'none');
				$(".week-img").css('display', 'block');
				$(".day-img").css('display', 'none');
				
				$(".sb1").css('display', 'none');
				$(".sb2").css('display', 'flex');
				$(".sb3").css('display', 'none');
				
				$(".table-1").css('display', 'none');
				$(".table-2").css('display', 'table');
				$(".table-3").css('display', 'none');
				
				$(".input-text").val("");
			});
			/*일별 탭 클릭*/
			$(".day-tab").click(function() {
				$(this).css('border-bottom', '4px solid #307CFF');
				$(".month-tab").css('border-bottom', '1px solid #C5C6CB');
				$(".week-tab").css('border-bottom', '1px solid #C5C6CB');
				
				$(this).css('cursor', 'default');
				$(".month-tab").css('cursor', 'pointer');
				$(".week-tab").css('cursor', 'pointer');
				
				$(".mini-title-box").find('p:nth-child(1)').text('일별 통계 차트');
				$(".mini-title-box").find('p:nth-child(2)').text('최근 30일');
				
				$(".month-img").css('display', 'none');
				$(".week-img").css('display', 'none');
				$(".day-img").css('display', 'block');
				
				$(".sb1").css('display', 'none');
				$(".sb2").css('display', 'none');
				$(".sb3").css('display', 'flex');
				
				$(".table-1").css('display', 'none');
				$(".table-2").css('display', 'none');
				$(".table-3").css('display', 'table');
				
				$(".input-text").val("");
			});
			/*활성, 비활성 체크박스 제한*//*table1(월별 통계)*/
			$("#t1Connection-btn").click(function() {
				if(!$("#t1Non-connection-btn").is(':checked')){
					$(this).prop('checked', true);
				}
				if($(this).is(':checked')){
					$('.t1conn').css('display', 'table-row');
				}else {
					$('.t1conn').css('display', 'none');
				}
			})
			$("#t1Non-connection-btn").click(function() {
				if(!$("#t1Connection-btn").is(':checked')){
					$(this).prop('checked', true);
				}
				if($(this).is(':checked')){
					$('.t1non-conn').css('display', 'table-row');
				}else{
					$('.t1non-conn').css('display', 'none');
				}
			})
			/*활성, 비활성 체크박스 제한*//*table2(주별 통계)*/
			$("#t2Connection-btn").click(function() {
				if(!$("#t2Non-connection-btn").is(':checked')){
					$(this).prop('checked', true);
				}
				if($(this).is(':checked')){
					$('.t2conn').css('display', 'table-row');
				}else {
					$('.t2conn').css('display', 'none');
				}
			})
			$("#t2Non-connection-btn").click(function() {
				if(!$("#t2Connection-btn").is(':checked')){
					$(this).prop('checked', true);
				}
				if($(this).is(':checked')){
					$('.t2non-conn').css('display', 'table-row');
				}else{
					$('.t2non-conn').css('display', 'none');
				}
			})
			/*활성, 비활성 체크박스 제한*//*table3(일별 통계)*/
			$("#t3Connection-btn").click(function() {
				if(!$("#t3Non-connection-btn").is(':checked')){
					$(this).prop('checked', true);
				}
				if($(this).is(':checked')){
					$('.t3conn').css('display', 'table-row');
				}else {
					$('.t3conn').css('display', 'none');
				}
			})
			$("#t3Non-connection-btn").click(function() {
				if(!$("#t3Connection-btn").is(':checked')){
					$(this).prop('checked', true);
				}
				if($(this).is(':checked')){
					$('.t3non-conn').css('display', 'table-row');
				}else{
					$('.t3non-conn').css('display', 'none');
				}
			})
			/*월별통계탭에서 검색하기*/
			$("#sb1-search-btn").click(function() {
				let standard = $(this).prev().prev().val();
				let str = $(this).prev().val();
				let date = $(this).parent().next().find('select').val();
				$.ajax({
					type: 'post',
					url: 'loginRecordSearchMonthAjaxServlet',
					data: {
						"companyIdx":${companyIdx},
						"standard":standard,
						"str":str,
						"date":date
					},
					success: function(data) {
						console.log(data);
						$(".tr1").remove();
						let connRow = "table-row";
						let non_connRow = "table-row";
						if(!($("#t1Connection-btn").is(':checked'))){
							connRow = "none";
						}
						if(!($("#t1Non-connection-btn").is(':checked'))){
							non_connRow = "none";
						}
						for(let i=0; i<=data.length-1; i++){
							if(data[i].loginCnt > 0){
								let newTr = '<tr class="conn t1conn tr-row tr1" style="display: '+connRow+';">' +
												'<td>'+data[i].cName+'</td>' +
												'<td>'+data[i].mName+'</td>' +
												'<td>'+data[i].dName+'</td>' +
												'<td>'+data[i].position+'</td>' +
												'<td>'+data[i].email+'</td>' +
												'<td>'+data[i].loginCnt+'</td>' +
											'</tr>';
								
								$(".table-1").append(newTr);
							}else if(data[i].loginCnt == 0){
								let newTr = '<tr class="non-conn t1non-conn tr-row tr1" style="display: '+non_connRow+';">' +
												'<td>'+data[i].cName+'</td>' +
												'<td>'+data[i].mName+'</td>';
												if(data[i].dName == null){
													newTr += '<td></td>';
												}else{
													newTr += '<td>'+data[i].dName+'</td>';
												}
												if(data[i].position == null){
													newTr += '<td></td>';
												}else{
													newTr += '<td>'+data[i].position+'</td>';
												}
												newTr += '<td>'+data[i].email+'</td>' +
												'<td>'+data[i].loginCnt+'</td>' +
											'</tr>';
								
								$(".table-1").append(newTr);
							}
						}
					},
					error: function(r, s, e) {
						console.log(r.status);
						console.log(r.responseText);
						console.log(e);
					}
				})
			})
			/*주별통계탭에서 검색하기*/
			$("#sb2-search-btn").click(function() {
				let standard = $(this).prev().prev().val();
				let str = $(this).prev().val();
				let date = $(this).parent().next().find('select').val();
				$.ajax({
					type: 'post',
					url: 'loginRecordSearchWeekAjaxServlet',
					data: {
						"companyIdx":${companyIdx},
						"standard":standard,
						"str":str,
						"date":date
					},
					success: function(data) {
						console.log(data);
						$(".tr2").remove();
						let connRow = "table-row";
						let non_connRow = "table-row";
						if(!($("#t2Connection-btn").is(':checked'))){
							connRow = "none";
						}
						if(!($("#t2Non-connection-btn").is(':checked'))){
							non_connRow = "none";
						}
						for(let i=0; i<=data.length-1; i++){
							if(data[i].loginCnt > 0){
								let newTr = '<tr class="conn t2conn tr-row tr2" style="display: '+connRow+';">' +
												'<td>'+data[i].cName+'</td>' +
												'<td>'+data[i].mName+'</td>' +
												'<td>'+data[i].dName+'</td>' +
												'<td>'+data[i].position+'</td>' +
												'<td>'+data[i].email+'</td>' +
												'<td>'+data[i].loginCnt+'</td>' +
											'</tr>';
								
								$(".table-2").append(newTr);
							}else if(data[i].loginCnt == 0){
								let newTr = '<tr class="non-conn t2non-conn tr-row tr2" style="display: '+non_connRow+';">' +
												'<td>'+data[i].cName+'</td>' +
												'<td>'+data[i].mName+'</td>';
												if(data[i].dName == null){
													newTr += '<td></td>';
												}else{
													newTr += '<td>'+data[i].dName+'</td>';
												}
												if(data[i].position == null){
													newTr += '<td></td>';
												}else{
													newTr += '<td>'+data[i].position+'</td>';
												}
												newTr += '<td>'+data[i].email+'</td>' +
												'<td>'+data[i].loginCnt+'</td>' +
											'</tr>';
								
								$(".table-2").append(newTr);
							}
						}
					},
					error: function(r, s, e) {
						console.log(r.status);
						console.log(r.responseText);
						console.log(e);
					}
				})
			})
			/*일별통계탭에서 검색하기*/
			$("#sb3-search-btn").click(function() {
				let standard = $(this).prev().prev().val();
				let str = $(this).prev().val();
				let date = $(this).parent().next().find('select').val();
				$.ajax({
					type: 'post',
					url: 'loginRecordSearchDayAjaxServlet',
					data: {
						"companyIdx":${companyIdx},
						"standard":standard,
						"str":str,
						"date":date
					},
					success: function(data) {
						console.log(data);
						$(".tr3").remove();
						let connRow = "table-row";
						let non_connRow = "table-row";
						if(!($("#t3Connection-btn").is(':checked'))){
							connRow = "none";
						}
						if(!($("#t3Non-connection-btn").is(':checked'))){
							non_connRow = "none";
						}
						for(let i=0; i<=data.length-1; i++){
							if(data[i].loginCnt > 0){
								let newTr = '<tr class="conn t3conn tr-row tr3" style="display: '+connRow+';">' +
												'<td>'+data[i].cName+'</td>' +
												'<td>'+data[i].mName+'</td>' +
												'<td>'+data[i].dName+'</td>' +
												'<td>'+data[i].position+'</td>' +
												'<td>'+data[i].email+'</td>' +
												'<td>'+data[i].loginCnt+'</td>' +
											'</tr>';
								
								$(".table-3").append(newTr);
							}else if(data[i].loginCnt == 0){
								let newTr = '<tr class="non-conn t3non-conn tr-row tr3" style="display: '+non_connRow+';">' +
												'<td>'+data[i].cName+'</td>' +
												'<td>'+data[i].mName+'</td>';
												if(data[i].dName == null){
													newTr += '<td></td>';
												}else{
													newTr += '<td>'+data[i].dName+'</td>';
												}
												if(data[i].position == null){
													newTr += '<td></td>';
												}else{
													newTr += '<td>'+data[i].position+'</td>';
												}
												newTr += '<td>'+data[i].email+'</td>' +
												'<td>'+data[i].loginCnt+'</td>' +
											'</tr>';
								
								$(".table-3").append(newTr);
							}
						}
					},
					error: function(r, s, e) {
						console.log(r.status);
						console.log(r.responseText);
						console.log(e);
					}
				})
			})
		});
	</script>
<style>
* {
	padding: 0;
	margin: 0;
	box-sizing: border-box;
	border: none;
	letter-spacing: -0.7px;
}

.all-container {
	display: flex;
}

body {
	overflow-y: hidden;
}

.side-box {
	position: relative;
	background-color: #52545b;
	width: 260px;
	height: 920px;
}

.side-head {
	width: 260px;
	height: 60px;
	z-index: 999;
	padding: 18px 0px;
	background-color: #3D4044;
}

.logo-box {
	height: 28.86px;
	margin: 0px 0px 0px 30px;
}

.logo-box>img {
	width: 128px;
	height: 28.86px;
}

.side-foot {
	position: absolute;
	left: 0;
	bottom: 0;
	width: 260px;
	height: 65px;
	background-color: #52545b;
	z-index: 999;
}

.side-body {
	width: 260px;
	padding: 25px 10px 25px 30px;
	overflow-y: auto;
	height: 780px;
}

h2 {
	margin: 0px 0px 7px;
	color: #fff;
	font-size: 15px;
}

.h3-box {
	margin: 0px 0px 18px;
	padding: 0px 0px 0px 6px;
}

h3 {
	color: #BEBEC3;
	font-size: 14px;
	padding: 5px 20px 5px 0px;
	cursor: pointer;
}

h3:hover {
	text-decoration: underline;
}

.blue-h3 {
	color: #7FAEFF;
}

.blue-h3:hover {
	text-decoration: none;
}

.main-box {
	position: relative;
	padding: 21px 30px 25px 30px;
	width: 100%;
	color: #4F545D;
	font-size: 14px;
}

.main-title {
	width: 1600px;
	height: 39px;
	padding-bottom: 14px;
	border-bottom: 1px solid #e6e6e6;
}

h1 {
	color: #111;
	font-size: 19px;
}

.mini-title-box {
	display: flex;
	align-items: center;
	width: 1593px;
	height: 22.2px;
	margin-top: 20px;
}

.mini-title-box>p:nth-child(1) {
	height: 20px;
	padding-right: 12px;
	font-weight: bold;
}

.mini-title-box>p:nth-child(2) {
	height: 15px;
	line-height: 14px;
	color: #818285;
	font-size: 13px;
	padding-left: 11px;
	border-left: 1px solid #818285;
}

.tab-box {
	display: flex;
	width: 1600px;
	height: 41px;
	margin-top: 20px;
	border-bottom: 1px solid #C5C6CB;
}

.month-tab {
	width: 120px;
	height: 41px;
	font-size: 15px;
	font-weight: bold;
	text-align: center;
	border: 1px solid #E7E7E9;
	border-bottom: 4px solid #307CFF;
	border-radius: 7px 0 0 0;
	line-height: 38px;
	margin: 0 -1px 0 0;
	cursor: default;
}

.week-tab {
	width: 120px;
	height: 41px;
	font-size: 15px;
	font-weight: bold;
	text-align: center;
	border: 1px solid #E7E7E9;
	cursor: pointer;
	line-height: 38px;
	border-bottom: 1px solid #C5C6CB;
}

.day-tab {
	width: 120px;
	height: 41px;
	font-size: 15px;
	font-weight: bold;
	text-align: center;
	border: 1px solid #E7E7E9;
	cursor: pointer;
	border-radius: 0 7px 0 0;
	line-height: 38px;
	border-bottom: 1px solid #C5C6CB;
}
/*
.graph-box img {
	width: 1593px;
	height: 400px;
}
*/
/*
.graph-box canvas {
	width: 1593px;
	height: 300px;
}
*/

.search-box {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-top: 30px;
	width: 1600px;
	height: 32px;
	color: #333;
	font-size: 14px;
}

.search-box select {
	width: 100px;
	height: 32px;
	cursor: pointer;
	border: 1px solid #E6E6E6;
	border-radius: 1px;
	outline: none;
}

.input-text {
	width: 200px;
	height: 30px;
	padding-left: 10px;
	font-size: 13px;
	border: 1px solid #E6E6E6;
	border-radius: 1px;
	outline: none;
}

.search-btn {
	width: 67.77px;
	height: 30px;
	padding: 0 20px;
	cursor: pointer;
	line-height: 28px;
	font-size: 14px;
	border: 1px solid #C5C6CB;
	border-radius: 2px;
	text-align: center;
	background-color: #FFF;
	margin-right: 5px;
}

.search-btn:hover {
	color: #000;
	border-color: #999aa0;
	font-weight: bold;
}

.right-area {
	display: flex;
}

.excel-down {
	color: #4C80D6;
	font-size: 12px;
	padding: 0 0 1px 21px;
	background-color: #FFF;
	cursor: pointer;
	text-decoration: underline;
	line-height: 32px;
	margin-right: 5px;
}

.excel-down::before {
	content: url(https://flow.team/design2/flow_admin_2019/img/ico_down.png);
}

.excel-down:hover {
	font-weight: bold;
}

.check {
	width: 16px;
	height: 16px;
}

.left-area span {
	width: 46.89px;
	height: 20px;
	font-size: 13px;
	color: #818285;
	padding-left: 11px;
}
table{
	width: 1600px;
	border-collapse: collapse;
	margin-top: 5px;
	font-size: 13px;
	color: #111;
	margin-top: 10px;
}
th{
	height: 37px;
	text-align: center;
	background-color: #F9F9FB;
	width: 15%;
	border: 1px solid #E1E1E2;
}
td{
	height: 33px;
	text-align: center;
	padding: 8px;
	border: 1px solid #E1E1E2;
}
.non-conn{
	display: none;
}
</style>
</head>
<body>
	<div class="all-container">
		<div class="side-box">
			<div class="side-head">
				<div class="logo-box">
					<img src="https://flow.team/flow-renewal/assets/images/flow-logo-w.svg" alt="flow">
				</div>
			</div>
			<div class="side-body">
				<div class="scroll-menu">
					<h2>회사</h2>
					<div class="h3-box">
						<h3 id="admin-1">회사 정보</h3>
						<h3 id="admin-2">구성원 관리</h3>
						<h3 id="admin-3">구성원 초대</h3>
						<h3 id="admin-4"  style="display:none">조직도 관리</h3>
						<h3 id="admin-5">회사 바로가기 관리</h3>
					</div>
					<h2>프로젝트</h2>
					<div class="h3-box">
						<h3 id="admin-6">프로젝트 관리</h3>
						<h3 id="admin-7">회사 프로젝트 관리</h3>
						<h3 id="admin-8">공개 프로젝트 관리</h3>
						<h3 id="admin-9">공개 프로젝트 카테고리</h3>
						<h3 id="admin-10">비활성화 프로젝트 관리</h3>
					</div>
					<h2>통계/리포트</h2>
					<div class="h3-box">
						<h3 class="blue-h3">접속 통계</h3>
						<h3 id="admin-12">사용 통계</h3>
					</div>
					<h2>로그</h2>
					<div class="h3-box">
						<h3 id="admin-13">파일 다운로드 이력</h3>
						<h3 id="admin-14">관리자 변경 이력</h3>
					</div>
					<h2>감사</h2>
					<div class="h3-box">
						<h3 id="admin-15">채팅 감사</h3>
					</div>
				</div>
			</div>
			<div class="side-foot">
				<div class="footer"></div>
			</div>
		</div>
		<div class="main-box">
			<div class="main-title">
				<h1>접속 통계</h1>
			</div>
			<div class="mini-title-box">
				<p>월별 통계 차트</p>
				<p>최근 6개월</p>
			</div>
			<div class="tab-box">
				<div class="month-tab">월별</div>
				<div class="week-tab" style="display: none;">주별</div>
				<div class="day-tab" style="display: none;">일별</div>
			</div>
			<div class="graph-box">
				<!-- <img src="images/month.png" class="month-img"/> --> 
				<canvas id="chart1" width="1593" height="400"></canvas>
				
				<%--
				<img src="images/week.png" class="week-img" style="display: none;"/> 
				<img src="images/day.png" class="day-img" style="display: none;"/>
				 --%>
			</div>
			<div class="search-box sb1">
				<div class="left-area">
					<select id="sb1-select">
						<option>이름</option>
						<option>부서</option>
						<option>직책</option>
					</select>
					<input type="text" class="input-text" placeholder="검색어를 입력해주세요" />
					<input type="button" id="sb1-search-btn" class="search-btn" value="검색" />
					<label><input type="checkbox" class="check" id="t1Connection-btn" checked />접속자</label> 
					<label><input type="checkbox" class="check" id="t1Non-connection-btn"/>비접속자</label>
				</div>
				<div class="right-area">
					<span class="excel-down">엑셀 다운로드</span>
					<select class="date-select">
					<%
					for(int i=0; i<=5; i++) {
						Calendar oneCal = Calendar.getInstance();
						oneCal.setTime(now);
							
						// i개월 전 으로 설정
						oneCal.add(Calendar.MONTH, -i);
						Date oneMonthAgo2 = oneCal.getTime();
						
						String oneMonthAgoFormatted = df.format(oneMonthAgo2);
						
						String yeerStr = oneMonthAgoFormatted.substring(0, 4);
						String month = oneMonthAgoFormatted.substring(5, 7);
						String monthStr = month.charAt(0) == '0' ? month.replace("0", "") : month;
					%>
						<option value="<%=oneMonthAgoFormatted %>"><%=yeerStr+" "+monthStr+"월" %></option>
					<%} %>
					</select>
				</div>
			</div>
			<div class="search-box sb2" style="display: none;">
				<div class="left-area">
					<select>
						<option>이름</option>
						<option>부서</option>
						<option>직책</option>
					</select>
					<input type="text" class="input-text" placeholder="검색어를 입력해주세요" />
					<input type="button" id="sb2-search-btn" class="search-btn" value="검색" />
					<label><input type="checkbox" id="t2Connection-btn" class="check" checked />접속자</label>
					<label><input type="checkbox" id="t2Non-connection-btn" class="check" />비접속자</label>
				</div>
				<div class="right-area">
					<span class="excel-down">엑셀 다운로드</span>
					<select class="date-select">
					<%
					for(int i=0; i<=9; i++) {
						Calendar oneCal = Calendar.getInstance();
						oneCal.setTime(now);
							
						// i주 전 으로 설정
						oneCal.add(Calendar.WEEK_OF_YEAR, -i);
						Date oneWeekAgo = oneCal.getTime();
						
						String oneWeekAgoFormatted = df.format(oneWeekAgo);
						
						String date = oneWeekAgoFormatted;
					%>
						<option><%=date %></option>
					<%} %>
					</select>
				</div>
			</div>
			<div class="search-box sb3" style="display: none;">
				<div class="left-area">
					<select>
						<option>이름</option>
						<option>부서</option>
						<option>직책</option>
					</select> <input type="text" class="input-text" placeholder="검색어를 입력해주세요" />
					<input type="button" id="sb3-search-btn" class="search-btn" value="검색"/>
					<label><input type="checkbox" id="t3Connection-btn" class="check" checked/>접속자</label>
					<label><input type="checkbox" id="t3Non-connection-btn" class="check"/>비접속자</label>
				</div>
				<div class="right-area">
					<span class="excel-down">엑셀 다운로드</span>
					<select class="date-select">
					<%
					for(int i=1; i<=30; i++) {
						Calendar oneCal = Calendar.getInstance();
						oneCal.setTime(now);
							
						// i일 전 으로 설정
						oneCal.add(Calendar.DAY_OF_MONTH, -i);
						Date oneDayAgo = oneCal.getTime();
						
						String oneDayAgoFormatted = df.format(oneDayAgo);
						
						String month = oneDayAgoFormatted.substring(5, 7).charAt(0) == '0' ? oneDayAgoFormatted.substring(5, 7).replace("0", "") : oneDayAgoFormatted.substring(5, 7);
						String day = oneDayAgoFormatted.substring(8, 10);
					%>
						<option value="<%=oneDayAgoFormatted %>"><%=month+"월 "+day %></option>
					<%} %>
					</select>
				</div>
			</div>
			<table class="table-1">
				<tr>
					<th>회사</th>
					<th>이름</th>
					<th>부서</th>
					<th>직책</th>
					<th>이메일</th>
					<th>접속 수</th>
				</tr>
			<%for(LoginRecordDto dto : monthList) { %>
				<%if(dto.getLoginCnt() > 0) { %>
					<tr class="conn t1conn tr-row tr1">
						<td><%=dto.getcName() %></td>
						<td><%=dto.getmName() %></td>
						<td><%=dto.getdName() %></td>
						<td><%=dto.getPosition() %></td>
						<td><%=dto.getEmail() %></td>
						<td><%=dto.getLoginCnt() %></td>
					</tr>
				<%}else if(dto.getLoginCnt() == 0) { %>
					<tr class="non-conn t1non-conn tr-row tr1">
						<td><%=dto.getcName() %></td>
						<td><%=dto.getmName() %></td>
						<td><%=dto.getdName() %></td>
						<%if(dto.getPosition() != null) { %>
							<td><%=dto.getPosition() %></td>
						<%}else{ %>
							<td></td>
						<%} %>
						<%if(dto.getEmail() != null) { %>
							<td><%=dto.getEmail() %></td>
						<%}else{ %>
							<td></td>
						<%} %>
						<td><%=dto.getLoginCnt() %></td>
					</tr>
				<%} %>
			<%} %>
			<%if(monthList.size() == 0) { %>
				<tr class="tr-row tr1">
					<td colspan="6">검색 결과가 없습니다.</td>
				</tr>
			<%} %>
			</table>
			<table class="table-2" style="display: none;">
				<tr>
					<th>회사</th>
					<th>이름</th>
					<th>부서</th>
					<th>직책</th>
					<th>이메일</th>
					<th>접속 수</th>
				</tr>
				<%for(LoginRecordDto dto : weekList) { %>
				<%if(dto.getLoginCnt() > 0) { %>
					<tr class="conn t2conn tr-row tr2">
						<td><%=dto.getcName() %></td>
						<td><%=dto.getmName() %></td>
						<td><%=dto.getdName() %></td>
						<td><%=dto.getPosition() %></td>
						<td><%=dto.getEmail() %></td>
						<td><%=dto.getLoginCnt() %></td>
					</tr>
				<%}else if(dto.getLoginCnt() == 0) { %>
					<tr class="non-conn t2non-conn tr-row tr2">
						<td><%=dto.getcName() %></td>
						<td><%=dto.getmName() %></td>
						<td><%=dto.getdName() %></td>
						<%if(dto.getPosition() != null) { %>
							<td><%=dto.getPosition() %></td>
						<%}else{ %>
							<td></td>
						<%} %>
						<%if(dto.getEmail() != null) { %>
							<td><%=dto.getEmail() %></td>
						<%}else{ %>
							<td></td>
						<%} %>
						<td><%=dto.getLoginCnt() %></td>
					</tr>
				<%} %>
			<%} %>
			<%if(weekList.size() == 0) { %>
				<tr class="tr-row tr2">
					<td colspan="6">검색 결과가 없습니다.</td>
				</tr>
			<%} %>
			</table>
			<table class="table-3" style="display: none;">
				<tr>
					<th>회사</th>
					<th>이름</th>
					<th>부서</th>
					<th>직책</th>
					<th>이메일</th>
					<th>접속 수</th>
				</tr>
				<%for(LoginRecordDto dto : dayList) { %>
				<%if(dto.getLoginCnt() > 0) { %>
					<tr class="conn t3conn tr-row tr3">
						<td><%=dto.getcName() %></td>
						<td><%=dto.getmName() %></td>
						<td><%=dto.getdName() %></td>
						<td><%=dto.getPosition() %></td>
						<td><%=dto.getEmail() %></td>
						<td><%=dto.getLoginCnt() %></td>
					</tr>
				<%}else if(dto.getLoginCnt() == 0) { %>
					<tr class="non-conn t3non-conn tr-row tr3">
						<td><%=dto.getcName() %></td>
						<td><%=dto.getmName() %></td>
						<td><%=dto.getdName() %></td>
						<%if(dto.getPosition() != null) { %>
							<td><%=dto.getPosition() %></td>
						<%}else{ %>
							<td></td>
						<%} %>
						<%if(dto.getEmail() != null) { %>
							<td><%=dto.getEmail() %></td>
						<%}else{ %>
							<td></td>
						<%} %>
						<td><%=dto.getLoginCnt() %></td>
					</tr>
				<%} %>
			<%} %>
			<%if(dayList.size() == 0) { %>
				<tr class="tr-row tr3">
					<td colspan="6">검색 결과가 없습니다.</td>
				</tr>
			<%} %>
			</table>
		</div>
	</div>
</body>
</html>