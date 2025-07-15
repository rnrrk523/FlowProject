<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="dto.ChatRoomMonitoringHistoryDto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.ChatMonitoringHistoryDao"%>
<%@page import="dto.CompanyDto"%>
<%@page import="dao.CompanyDao"%>
<%-- <%
	int companyIdx = 1;
	int memberIdx = 1;
	
	CompanyDao cDao = new CompanyDao();
	CompanyDto companyInfo = cDao.getCompanyInfo(companyIdx);
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
	SimpleDateFormat sdf = new SimpleDateFormat("EEEE");
		
	String dayOfWeek = sdf.format(now); // 현재 날짜 기준으로 요일 가져오기
	String dayOfWeek6prev = sdf.format(sixMonthsAgo); // 6개월 전 기준으로 요일 가져오기
		
	String week = "(" + dayOfWeek.charAt(0) + ")";
	String week6prev = "(" + dayOfWeek6prev.charAt(0) + ")";
		
	String startDate = sixMonthsAgoFormatted+week6prev;
	String endDate = today+week;
%> --%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>채팅 감사</title>
	<link rel="stylesheet" href="https://code.jquery.com/ui/1.14.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
  	<script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
	<script>
	    // 한국어 설정 추가
	    $.datepicker.regional['ko'] = {
	        closeText: '닫기',
	        prevText: '이전',
	        nextText: '다음',
	        currentText: '오늘',
	        monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	        monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	        dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'],
	        dayNamesShort: ['일','월','화','수','목','금','토'],
	        dayNamesMin: ['일','월','화','수','목','금','토'],
	        weekHeader: '주',
	        dateFormat: 'yy-mm-dd',
	        firstDay: 0,
	        isRTL: false,
	        showMonthAfterYear: true,
	        yearSuffix: '년'
	    };
	    $.datepicker.setDefaults($.datepicker.regional['ko']);
	    $(function() {
	        $( ".datepicker" ).datepicker({
	            dateFormat: 'yy-mm-dd (D)', // 날짜 형식을 yy-mm-dd (요일)로 설정
	            beforeShowDay: function(date) {
	                let dayNames = ['일', '월', '화', '수', '목', '금', '토'];
	                let day = date.getDay();
	                let dayName = dayNames[day];
	                return [true, '', dayName]; // 요일 정보를 반환
	            }
	        });
	    });
	</script>
	<script>
		$(function() {
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
			$("#admin-11").click(function() {
				window.location.href = 'Controller?command=admin_page11&companyIdx='+${companyIdx}+'&memberIdx='+${memberIdx};
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
			/*감사자 탭 클릭*/
			$(".observer-tab").click(function() {
				$(this).css('border-bottom', '4px solid #307CFF');
				$(this).next().css('border-bottom', '1px solid #C5C6CB');
				$(this).css('cursor', 'default');
				$(this).next().css('cursor', 'pointer');
				
				$(".tab1-page").css('display', 'block');
				$(".tab2-page").css('display', 'none');
			});
			/*감사이력 테이블 새로고침*/
			function getObservingRecord(standard, str, startDate, endDate) {
				$.ajax({
					type: 'post',
					url: 'getObservingRecordAjaxServlet',
					data: {
						"companyIdx":${companyIdx},
						"standard":standard,
						"str":str,
						"startDate":startDate,
						"endDate":endDate
					},
					success: function(data) {
						$(".t2-row").remove();
						console.log(data);
						if(data.length != 0){
							for(let i=0; i<=data.length-1; i++){
								let newTr = '<tr class="t2-row">' +
												'<td>'+data[i].modifier+'</td>' +
												'<td>'+data[i].func+'</td>' +
												'<td>'+data[i].target+'</td>' +
												'<td>'+data[i].changeContent+'</td>' +
												'<td>'+data[i].changeDate+'</td>' +
											'</tr>';
								
								$(".table2").append(newTr);
							}
						}else{
							let newTr = '<tr class="t2-row">' +
											'<td colspan="5">결과값이 존재하지 않습니다.</td>' +
										'</tr>';
							
							$(".table2").append(newTr);
						}
					},
					error: function(r, s, e) {
						console.log(r.status);
						console.log(r.responseText);
						console.log(e);
					}
				})
			}
			/*감사 이력 탭 클릭*/
			$(".record-tab").click(function() {
				getObservingRecord("수정자", "", "${startDate.substring(0, startDate.length()-3)}", "${endDate.substring(0, endDate.length()-3)}");
				$(this).css('border-bottom', '4px solid #307CFF');
				$(this).prev().css('border-bottom', '1px solid #C5C6CB');
				$(this).css('cursor', 'default');
				$(this).prev().css('cursor', 'pointer');
				
				$(".tab1-page").css('display', 'none');
				$(".tab2-page").css('display', 'block');
			});
			/*채팅 감사버튼 켜기*/
			$(".off-togle").click(function() {
				$('#obs-agree1').prop('checked', false);
				$('#obs-agree2').prop('checked', false);
				$(".observing-agree-bg").css('display', 'flex');
			});
			/*채팅 감사버튼 끄기*/
			$(".on-togle").click(function() {
				$(".observing-func-off-bg").css('display', 'flex');
			});
			/*비활성화 알림창 취소클릭*/
			$("#observing-func-off-cancel-btn").click(function() {
				$(".observing-func-off-bg").css('display', 'none');
			});
			/*비활성화 알림창 확인클릭*/
			$("#observing-func-off-check-btn").click(function() {
				$.ajax({
					type: 'post',
					url: 'companyAuditChatDateSetAjaxServlet',
					data: {
						"companyIdx":${companyIdx},
						"memberIdx":${memberIdx}
					},
					success: function() {
						location.reload();
					},
					error: function(r, s, e) {
						console.log(r.status);
						console.log(r.responseText);
						console.log(e);
					}
				})
				$(".off-togle").css('display', 'block');
				$(".on-togle").css('display', 'none');
				$(".observing-func-off-bg").css('display', 'none');
				$(".info-box").css('display', 'block');
				$(".func-on").css('display', 'none');
			});
			/*채팅감사 동의창 닫기&취소*/
			$("#observing-agree-close-btn").click(function() {
				$(".observing-agree-bg").css('display', 'none');
			});
			$("#observing-agree-cancel-btn").click(function() {
				$(".observing-agree-bg").css('display', 'none');
			});
			/*채팅 감사 동의창 시작하기 클릭*/
			$("#observing-agree-check-btn").click(function() {
				let check1 = $('#obs-agree1').prop('checked');
				let check2 = $('#obs-agree2').prop('checked');
				if(check1&check2){
					$.ajax({
						type: 'post',
						url: 'companyAuditChatDateSetAjaxServlet',
						data: {
							"companyIdx":${companyIdx},
							"memberIdx":${memberIdx}
						},
						success: function() {
							location.reload();
						},
						error: function(r, s, e) {
							console.log(r.status);
							console.log(r.responseText);
							console.log(e);
						}
					})
					
					$(".off-togle").css('display', 'none');
					$(".on-togle").css('display', 'block');
					$(".observing-agree-bg").css('display', 'none');
					$(".info-box").css('display', 'none');
					$(".func-on").css('display', 'block');
				}else{
					alert("체크박스를 클릭해 동의후 시작할 수 있습니다.");
				}
			});
			/*감사이력 검색하기*/
			$("#t2-searchBtn").click(function() {
				let standard = $(this).prev().prev().val();
				let str = $(this).prev().val();
				let startDate = $("#t2-startDate").val().substring(0, $("#t2-startDate").val().length-3);
				let endDate = $("#t2-endDate").val().substring(0, $("#t2-endDate").val().length-3);
				
				getObservingRecord(standard, str, startDate, endDate);
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
			position: relative;
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
			z-index: 10;
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
		.tab-box{
			display: flex;
			width: 1600px;
			height: 41px;
			margin-top: 30px;
			border-bottom: 1px solid #C5C6CB;
		}
		.observer-tab{
			width: 120px;
			height: 41px;
			font-size: 15px;
			margin: 0 -1px 0 0;
			cursor: default;
			font-weight: bold;
			border-radius: 7px 0 0 0;
			line-height: 38px;
			text-align: center;
			border: 1px solid #E7E7E9;
			border-bottom: 4px solid #307CFF;
		}
		.record-tab{
			width: 120px;
			height: 41px;
			font-size: 15px;
			margin: 0 -1px 0 0;
			cursor: pointer;
			line-height: 38px;
			text-align: center;
			border: 1px solid #E7E7E9;
			border-radius: 0 7px 0 0;
			border-bottom: 1px solid #C5C6CB;
		}
		.func-btn-box{
			width: 1600px;
			height: 79px;
			margin-top: 30px;
			margin-bottom: 20px;
			padding-bottom: 20px;
			border-bottom: 1px solid #E6E6E6;
		}
		.func-btn-box > div{
			display: flex;
			align-items: center;
			font-weight: 700;
			line-height: 24px;
			height: 24px;
			margin-bottom: 14px;
			font-size: 16px;
		}
		.off-togle{
			margin-left: 5px;
			position: relative;
			width: 40px;
			height: 18px;
			background-color: #CCC;
			border-radius: 20px;
			cursor: pointer;
		}
		.off-togle > div{
			position: absolute;
			top: 2px;
			left: 2px;
			width: 14px;
			height: 14px;
			background-color: #EEE;
			border-radius: 20px;
		}
		.on-togle{
			margin-left: 5px !important;
			position: relative !important;
			width: 40px !important;
			height: 18px !important;
			background-color: #307cfe !important;
			cursor: pointer !important;
			border-radius: 14px !important;
		}
		.on-togle > div{
			position: absolute !important;
			top: 2px !important;
			left: 24px !important;
			background-color: #FFF !important;
			width: 14px !important;
			height: 14px !important;
			border-radius: 20px !important;
		}
		.info-box{
			width: 1600px;
			height: 114px;
			background-color: #F9F9FB;
			margin: 20px 0 35px;
			padding: 9px 12px;
		}
		.info-box p{
			position: relative;
			height: 24px;
			font-size: 12px;
			padding-left: 20px;
			line-height: 22px;
		}
		.info-box p::before{
			content: "\2022";
			position: absolute;
			left: 10px;
			top: 0;
			font-size: 10px;
			line-height: 20px;
			color: black;
		}
		.search-box1{
			width: 1600px;
			height: 32px;
			color: #333;
		}
		.search-box1 > select{
			margin-left: 5px;
			margin-right: 2px;
			width: 100px;
			height: 32px;
			border: 1px solid #E6E6E6;
			border-radius: 1px;
			outline: none;
		}
		.input-text{
			width: 230px;
			height: 30px;
			padding-left: 36px;
			background: url(https://flow.team/design2/img_rn/ico/icon_search2.png) no-repeat;
			background-position: 10px;
			font-size: 13px;
			border: 1px solid #E6E6E6;
			border-radius: 1px;
			outline: none;
		}
		.input-text::placeholder{
			color: lightgrey;
		}
		.table1{
			width: 1600px;
			border-collapse: collapse;
			margin-top: 10px;
			border: 1px solid #E1E1E2;
		}
		.table1 th{
			height: 37px;
			color: #111;
			background-color: #F9F9FB;
			font-size: 13px;
			border: 1px solid #E1E1E2;
		}
		.table1 td{
			border: 1px solid #E1E1E2;
			padding: 8px;
			line-height: 16px;
			font-size: 13px;
			color: #111;
			text-align: center;
			font-weight: normal;
			border: 1px solid #e1e1e2;
		}
		.nothing{
			display: flex;
			justify-content: center;
			align-items: center;
			width: 1600px;
			height: 328px;
		}
		.nothing div{
			width: 300px;
			height: 130px;
			text-align: center;
		}
		.nothing div img{
			width: 70px;
			height: 69px;
		}
		.nothing div p{
			height: 36px;
			font-size: 24px;
			margin-top: 25px;
		}
		.main-footer{
			position: absolute;
			left: 30px;
			bottom: 30px;
			width: 1600px;
			height: 114px;
			font-size: 14px;
			background-color: #F9F9FB;
			margin: 20px 0 35px;
			padding: 9px 12px;
		}
		.main-footer p{
			position: relative;
			height: 24px;
			font-size: 12px;
			padding-left: 20px;
			line-height: 22px;
		}
		.main-footer p::before{
			content: "\2022";
			position: absolute;
			left: 10px;
			top: 0;
			font-size: 10px;
			line-height: 20px;
			color: black;
		}
		.search-date-box{
			display: flex;
			align-items: center;
			margin-top: 15px;
			width: 1600px;
			height: 30px;
		}
		.search-date-box p{
			padding: 0 10px;
			height: 20px;
			font-size: 14px;
			font-weight: bold;
		}
		.input-date{
			width: 130px;
			height: 30px;
			padding-left: 10px;
			font-size: 13px;
			border: 1px solid #E6E6E6;
			border-radius: 1px;
		}
		.search-text-box{
			display: flex;
			align-items: center;
			margin-top: 10px;
			width: 1600px;
			height: 32px;
		}
		.search-text-box p{
			height: 20px;
			font-size: 14px;
			padding: 0 10px;
			font-weight: bold;
		}
		.search-text-box select{
			width: 100px;
			height: 32px;
			color: #333;
			border: 1px solid #E6E6E6;
			border-radius: 1px;
			outline: none;
			margin-right: 3px;
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
			margin-left: 3px;
		}
		.search-btn:hover {
			color: #000;
			border-color: #999aa0;
			font-weight: bold;
		}
		.table-container{
			margin-top: 15px;
			width: 1600px;
			max-height: 608px;
			overflow-y: auto;
			border: 1px solid #E1E1E2;
		}
		.table2{
			width: 100%;
			border-collapse: collapse;
			color: #111;
			font-size: 13px;
		}
		.table2 th{
			position: sticky;
			top: 0;
			background-color: #F9F9FB;
			z-index: 1;
			text-align: center;
			border: 1px solid #E1E1E2;
			height: 37px;
			color: #111;
			font-size: 13px;
		}
		.table2 td{
			height: 33px;
			text-align: center;
			border: 1px solid #E1E1E2;
			color: #111;
			font-size: 13px;
			line-height: 16px;
			padding: 8px;
		}
		.observing-agree-bg{
			position: absolute;
			display: flex;
			justify-content: center;
			align-items: center;
			width: 100%;
			height: 100%;
			z-index: 999;
			background: rgb(0, 0, 0, .6);
		}
		#observing-agree-box{
			width: 960px;
			height: 581px;
			background-color: #FFF;
			border-radius: 7px;
			padding: 20px 30px;
		}
		#observing-agree-top{
			width: 840px;
			height: 43px;
			margin: 25px 30px 0;
			padding-bottom: 14px;
			border-bottom: 1px solid #e6e6e6;
		}
		#observing-agree-header{
			position: relative;
			width: 840px;
			height: 28px;
			font-size: 19px;
			font-weight: bold;
			color: #4f545d;
		}
		#observing-agree-close-btn{
			position: absolute;
			top: 0;
			right: 0;
			width: 20px;
			height: 20px;
			cursor: pointer;
			background: url(https://flow.team/js/admin/assets/img/btn_popclose.gif);
		}
		#observing-agree-body{
			margin: 20px;
			width: 860px;
			height: 397px;
		}
		#observing-agree-body p{
			width: 860px;
			height: 20px;
			font-size: 14px;
			color: #4f545d;
		}
		#observing-agree-content-box{
			width: 860px;
			height: 232px;
			background: #f9f9fb;
			margin: 20px 0 35px;
			padding: 20px;
			font-size: 14px;
			color: #4f545d;
		}
		#observing-agree-content-box p{
			width: 820px;
			height: 24px !important;
			font-size: 13px !important;
			color: #4f545d;
			padding-left: 10px;
			line-height: 24px;
		}
		.agree-info-p::before{
			content: '• ';
			font-size: 1em;
		}
		#observing-agree-checkbox-box{
			display: flex;
			flex-direction: column;
			justify-content: space-between;
			margin-top: 20px;
			width: 860px;
			height: 50px;
		}
		#observing-agree-checkbox-box label{
			font-size: 14px;
			color: #4f545d;
			width: 860px;
			height: 20px;
		}
		#observing-agree-checkbox-box input[type="checkbox"]{
			width: 16px;
			height: 16px;
		}
		#observing-agree-footer{
			width: 900px;
			height: 36px;
			text-align: center;
		}
		#observing-agree-cancel-btn{
			width: 182px;
			height: 36px;
			line-height: 34px;
			text-align: center;
			border: 1px solid #ddd;
			border-radius: 4px;
			color: #555;
			background-color: #FFF;
			cursor: pointer;
			font-size: 13px;
		}
		#observing-agree-check-btn{
			width: 182px;
			height: 36px;
			line-height: 34px;
			text-align: center;
			background-color: #6449fc;
			border-radius: 4px;
			color: #FFF;
			font-size: 13px;
			cursor: pointer;
			margin-left: 8px;
		}
		.observing-func-off-bg{
			position: absolute;
			display: flex;
			justify-content: center;
			align-items: center;
			width: 100%;
			height: 100%;
			background: rgb(0, 0, 0, .6);
			z-index: 999;
		}
		#observing-func-off-box{
			width: 556px;
			height: 137px;
			background-color: #fff;
			padding: 20px 30px;
			border-radius: 5px;
		}
		#observing-func-off-content-box{
			width: 496px;
			height: 60px;
		}
		#observing-func-off-content-box p{
			width: 496px;
			height: 20px;
			font-size: 13px;
			color: #4f545d;
		}
		#observing-func-off-btn-box{
			width: 496px;
			height: 36px;
			text-align: center;
		}
		#observing-func-off-cancel-btn{
			background-color: #FFF;
			width: 182px;
			height: 36px;
			line-height: 34px;
			text-align: center;
			border: 1px solid #ddd;
			border-radius: 4px;
			color: #555;
			font-size: 13px;
			cursor: pointer;
		}
		#observing-func-off-check-btn{
			width: 182px;
			height: 36px;
			line-height: 34px;
			text-align: center;
			background-color: #6449fc;
			border-radius: 4px;
			color: #fff;
			margin-left: 8px;
			font-size: 13px;
			cursor: pointer;
		}
		.excelDownloadBtn {
			color: #4c80d6;
			background-color: #FFF;
			text-decoration: underline;
			cursor: pointer;
		}
		.excelDownloadBtn:hover {
			font-weight: bold;
		}
		.chatRoomInfoShowBtn {
			text-decoration: underline;
			cursor: pointer;
		}
		.chatRoomInfoShowBtn:hover {
			font-weight: bold;
		}
	</style>
</head>
<body>
	<div class="all-container">
		<div class="observing-agree-bg" style="display: none;">
			<div id="observing-agree-box">
				<div id="observing-agree-top">
					<div id="observing-agree-header">
						채팅 감사
						<div id="observing-agree-close-btn"></div>
					</div>
				</div>
				<div id="observing-agree-body">
					<p>채팅 감사 기능을 활성화하게 되면 등록된 임직원들에게 아래와 같은 알림 메시지가 전송됩니다.</p>
					<div id="observing-agree-content-box">
						채팅 감사 기능이 활성화 되었습니다. 기능이 활성화된 시점부터의 대화 내역만 조회됩니다. 단, 시크릿 메시지는 완전히 삭제되어 채팅 감사 대상에서 제외됩니다.
						<br/><br/>
						채팅 감사 기능의 목적
						<br/>
						<p class="agree-info-p">회사 기밀 및 정보자산의 유출을 방지하기 위함입니다.</p>
						<p class="agree-info-p">직장내 성희롱 및 따돌림 등 법적 분쟁이 발생 시 근거를 마련하기 위함입니다.</p>
						<p class="agree-info-p">사내의 부조리한 문화 및 행태를 미연에 방지하여 건전한 업무 소통문화를 만들 수 있습니다.</p>
						<br/>
						업무간 효율적이고 생산성 있는 대화를 당부드립니다.
					</div>
					<p>아래 내용에 동의 후 이용할 수 있습니다.</p>
					<div id="observing-agree-checkbox-box">
						<label><input id="obs-agree1" type="checkbox"/> 채팅 감사 기능 이용에 대한 임직원의 동의를 받았습니다.</label>
						<label><input id="obs-agree2" type="checkbox"/> 채팅 감사 기능 사용으로 인한 법적 책임은 개발사에서 지지 않으며 잘못된 사용으로 플로우의 브랜드 가치 훼손시 손해를 배상합니다.</label>
					</div>
				</div>
				<div id="observing-agree-footer">
					<button id="observing-agree-cancel-btn">취소</button>
					<button id="observing-agree-check-btn">시작하기</button>
				</div>
			</div>
		</div>
		<div class="observing-func-off-bg" style="display: none;">
			<div id="observing-func-off-box">
				<div id="observing-func-off-content-box">
					<p>감사 기능을 비활성화하게 되면 활성화되었을 때 기록중이던 채팅 내역은 초기화됩니다.</p>
					<p>그래도 비활성화 하시겠습니까?</p>
				</div>
				<div id="observing-func-off-btn-box">
					<button id="observing-func-off-cancel-btn">취소</button>
					<button id="observing-func-off-check-btn">확인</button>
				</div>
			</div>
		</div>
		<div class="side-box">
			<div class="side-head">
				<div class="logo-box">
					<img
						src="https://flow.team/flow-renewal/assets/images/flow-logo-w.svg"
						alt="flow">
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
						<h3 id="admin-11">접속 통계</h3>
						<h3 id="admin-12">사용 통계</h3>
					</div>
					<h2>로그</h2>
					<div class="h3-box">
						<h3 id="admin-13">파일 다운로드 이력</h3>
						<h3 id="admin-14">관리자 변경 이력</h3>
					</div>
					<h2>감사</h2>
					<div class="h3-box">
						<h3 class="blue-h3">채팅 감사</h3>
					</div>
				</div>
			</div>
			<div class="side-foot">
				<div class="footer"></div>
			</div>
		</div>
		<div class="main-box">
			<div class="main-title">
				<h1>채팅 감사</h1>
			</div>
			<div class="tab-box">
				<div class="observer-tab">감사자</div>
				<div class="record-tab">감사 이력</div>
			</div>
			<div class="tab1-page">
				<div class="func-btn-box">
					<div>
						<p>채팅 감사</p>
						<c:choose>
							<c:when test="${auditChatDate == null }">
								<div class="off-togle" ><div></div></div>
								<div class="on-togle" style="display: none;"><div></div></div>
							</c:when>
							<c:otherwise>
								<div class="off-togle" style="display: none;"><div></div></div>
								<div class="on-togle"><div></div></div>
							</c:otherwise>
						</c:choose>
					</div>
					<p>개인/단체/프로젝트 채팅방의 대화내역을 조회할 수 있습니다.</p>
				</div>
				<c:choose>
					<c:when test="${auditChatDate == null }">
						<div class="func-on" style="display: none;">
							<div class="search-box1">
								<select>
									<option>이름</option>
									<option>이메일</option>
								</select>
								<input type="text" class="input-text" placeholder="감사대상자를 입력해주세요"/>
							</div>
							<table class="table1">
								<tr>
									<th style="width: 516px;">채팅방명</th>
									<th style="width: 60px;">조회</th>
									<th style="width: 516px;">참여자명</th>
									<th style="width: 400px;">채팅 기간</th>
									<th style="width: 100px;">엑셀 다운로드</th>
								</tr>
							</table>
							<div class="nothing">
								<div>
									<img src="https://flow.team/img/ico/ico_magnifying_glass.png"/>
									<p>감사대상자를 입력해주세요.</p>
								</div>
							</div>
						</div>
					</c:when>
					<c:otherwise>
						<div class="func-on">
							<div class="search-box1">
								<select>
									<option>이름</option>
									<option>이메일</option>
								</select>
								<input type="text" class="input-text" placeholder="감사대상자를 입력해주세요"/>
							</div>
							<table class="table1">
								<tr>
									<th style="width: 516px;">채팅방명</th>
									<th style="width: 60px;">조회</th>
									<th style="width: 516px;">참여자명</th>
									<th style="width: 400px;">채팅 기간</th>
									<th style="width: 100px;">엑셀 다운로드</th>
								</tr>
								<%
								ArrayList<ChatRoomMonitoringHistoryDto> auditChatRoomList = null;
								auditChatRoomList = (ArrayList<ChatRoomMonitoringHistoryDto>)request.getAttribute("auditChatRoomList");
								for(ChatRoomMonitoringHistoryDto dto : auditChatRoomList) { 
								System.out.println(dto.getChatDate());
								%>
								<tr class="t1-row">
									<td><%=dto.getRoomName() %></td>
									<td><span class="chatRoomInfoShowBtn">[보기]</span></td>
									<%
									int i=1;
									out.write("<td>");
									for(String name : dto.getMemberList()) {
										if(i != dto.getMemberList().size()){
											out.write(name+", ");
										}else{
											out.write(name);
										}
										i++;
									}
									out.write("</td>");
									%>
									<td><%=dto.getChatDate() %></td>
									<td><button class="excelDownloadBtn">Download</button></td>
								</tr>
								<%} %>
							</table>
							<c:choose>
								<c:when test="${auditChatRoomList.size() == 0 }">
									<div class="nothing">
										<div>
											<img src="https://flow.team/img/ico/ico_magnifying_glass.png"/>
											<p>감사대상자를 입력해주세요.</p>
										</div>
									</div>
								</c:when>
							</c:choose>
						</div>
					</c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${auditChatDate != null }">
						<div class="info-box" style="position: absolute; bottom: 30px;">
							<p>개인/단체/프로젝트 채팅방의 대화내역을 조회할 수 있습니다.</p>
							<p>감사 기능이 활성화된 이후의 대화 내역만 조회되며 비활성화시 초기화됩니다.</p>
							<p>임직원 외 이용자의 대화 내역은 감사 대상이 아니므로 조회할 수 없습니다.</p>
							<p>시크릿 메시지는 완전히 삭제되어 조회할 수 없습니다.</p>
						</div>
					</c:when>
					<c:otherwise>
						<div class="info-box">
							<p>개인/단체/프로젝트 채팅방의 대화내역을 조회할 수 있습니다.</p>
							<p>감사 기능이 활성화된 이후의 대화 내역만 조회되며 비활성화시 초기화됩니다.</p>
							<p>임직원 외 이용자의 대화 내역은 감사 대상이 아니므로 조회할 수 없습니다.</p>
							<p>시크릿 메시지는 완전히 삭제되어 조회할 수 없습니다.</p>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
			<div class="tab2-page" style="display: none;">
				<div class="search-date-box">
					<p>기간</p>
					<div>
						<input type="text" id="t2-startDate" class="input-date datepicker" value="${startDate }"/>
						~
						<input type="text" id="t2-endDate" class="input-date datepicker" value="${endDate }"/>
					</div>
				</div>
				<div class="search-text-box">
					<p>검색</p>
					<select>
						<option>수정자</option>
						<option>기능</option>
						<option>대상</option>
						<option>변경사항</option>
					</select>
					<input type="text" class="input-text" placeholder="검색어를 입력해주세요"/>
					<input type="button" id="t2-searchBtn" class="search-btn" value="검색"/>
				</div>
				<div class="table-container">
					<table class="table2">
						<tr>
							<th>수정자</th>
							<th>기능</th>
							<th>대상</th>
							<th>변경사항</th>
							<th>변경일시</th>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
</body>
</html>