<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="dao.AdminChangeHistoryDao"%>
<%@page import="dto.AdminChangeHistoryDto"%>
<%@page import="java.util.ArrayList"%>
<%-- <%
	int companyIdx = 1;

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
	
	AdminChangeHistoryDao achDao = new AdminChangeHistoryDao();
	ArrayList<AdminChangeHistoryDto> adminChangeHistoryList = achDao.getAdminChangeHistory(companyIdx, "변경자", "", startDate.substring(0, startDate.length()-3), endDate.substring(0, endDate.length()-3));
%> --%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>관리자 변경 이력</title>
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
			$("#admin-15").click(function() {
				window.location.href = 'Controller?command=admin_page15&companyIdx='+${companyIdx}+'&memberIdx='+${memberIdx};
			});
			/*검색하기*/
			$("#searchBtn").click(function() {
				let standard = $(this).parent().find('select').val();
				let str = $(this).parent().find('input[type="text"]').val();
				$.ajax({
					type: 'post',
					url: 'adminChangeHistoryAjaxServlet',
					data: {
						"companyIdx":${companyIdx},
						"standard":standard,
						"str":str,
						"startDate":"${startDate.substring(0, startDate.length()-3)}",
						"endDate":"${endDate.substring(0, endDate.length()-3)}"
					},
					success: function(data) {
						console.log(data);
						$(".list-row").remove();
						if(data.length != 0){
							for(let i=0; i<=data.length-1; i++){
								let newTr = '<tr class="list-row">' +
												'<td>'+data[i].changer+'</td>' +
												'<td>'+data[i].menu+'</td>' +
												'<td>'+data[i].func+'</td>';
												if(data[i].target == null){
													newTr += '<td></td>';
												}else {
													newTr += '<td>'+data[i].target+'</td>';
												}
												if(data[i].changeContent == null){
													newTr += '<td></td>';
												}else {
													newTr += '<td>'+data[i].changeContent+'</td>';
												}
												newTr += '<td>'+data[i].changeDate+'</td>' +
											'</tr>';
								
								$("#listTable").append(newTr);
							}
						}else{
							let newTr = '<tr class="list-row">' +
											'<td colspan="6">결과값이 존재하지 않습니다.</td>' +
										'</tr>';
							
							$("#listTable").append(newTr);
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
		.search-box{
			position: relative;
			margin-top: 15px;
			width: 1600px;
			height: 32px;
		}
		.search-box select{
			width: 100px;
			height: 32px;
			color: #333;
			font-size: 14px;
			border: 1px solid #E6E6E6;
			border-radius: 1px;
			outline: none;
		}
		.input-text{
			width: 190px;
			height: 30px;
			padding-left: 10px;
			font-size: 13px;
			border: 1px solid #E6E6E6;
			border-radius: 1px;
			outline: none;
			margin-right: 152px;
		}
		.input-text::placeholder{
			color: lightgrey;
		}
		.input-date{
			width: 130px;
			height: 30px;
			padding-left: 10px;
			font-size: 13px;
			border: 1px solid #E6E6E6;
			border-radius: 1px;
			color: #333;
			margin-right: -2px;
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
			margin-left: 45px;
		}
		.search-btn:hover {
			color: #000;
			border-color: #999aa0;
			font-weight: bold;
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
			position: absolute;
			right: 0;
		}
		.excel-down::before {
			content: url(https://flow.team/design2/flow_admin_2019/img/ico_down.png);
		}
		.excel-down:hover {
			font-weight: bold;
		}
		#listTable{
			width: 1600px;
			margin-top: 15px;
			font-size: 13px;
			color: #111;
			border-collapse: collapse;
			border: 1px solid #E1E1E2;
			text-align: center;
		}
		#listTable th{
			height: 37px;
			background-color: #F9F9FB;
			border: 1px solid #E1E1E2;
			text-align: center;
		}
		#listTable td{
			padding: 8px;
			line-height: 16px;
			height: 49px;
			border: 1px solid #E1E1E2;
			text-align: center;
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
						<h3 id="admin-11">접속 통계</h3>
						<h3 id="admin-12">사용 통계</h3>
					</div>
					<h2>로그</h2>
					<div class="h3-box">
						<h3 id="admin-13">파일 다운로드 이력</h3>
						<h3 class="blue-h3">관리자 변경 이력</h3>
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
				<h1>관리자 변경 이력</h1>
			</div>
			<div class="search-box">
				<select>
					<option>변경자</option>
					<option>이메일</option>
					<option>메뉴</option>
					<option>기능</option>
				</select>
				<input type="text" class="input-text" placeholder="검색어를 입력해주세요"/>
				<input type="text" class="input-date datepicker" value="${startDate }"/>
				<input type="text" class="input-date datepicker" value="${endDate }"/>
				<input type="button" id="searchBtn" class="search-btn" value="검색"/>
				<span class="excel-down">엑셀 다운로드</span>
			</div>
			<table id="listTable">
				<tr>
					<th>변경자(ID)</th>
					<th>메뉴</th>
					<th>기능</th>
					<th>대상(프로젝트명, 사용자)</th>
					<th>변경사항</th>
					<th>변경일시</th>
				</tr>
				<c:forEach var="dto" items="${adminChangeHistoryList }">
					<tr class="list-row">
						<td>${dto.changerNameAndEmail }</td>
						<td>${dto.menu }</td>
						<td>${dto.func }</td>
						<c:choose>
							<c:when test="${dto.target == null }">
								<td></td>
							</c:when>
							<c:otherwise>
								<td>${dto.target }</td>
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test="${dto.changeContent == null }">
								<td></td>
							</c:when>
							<c:otherwise>
								<td>${dto.changeContent }</td>
							</c:otherwise>
						</c:choose>
						<td>${dto.changeDate }</td>
					</tr>
				</c:forEach>
			<c:choose>
				<c:when test="${adminChangeHistoryList.size() == 0 }">
					<tr class="list-row">
						<td colspan="6">결과값이 존재하지 않습니다.</td>
					</tr>
				</c:when>
			</c:choose>
			</table>
		</div>
	</div>
</body>
</html>