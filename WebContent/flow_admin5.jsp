<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="dao.GoToDao"%>
<%@page import="dto.GoToDto"%>
<%@page import="java.util.ArrayList"%>
<%-- <%
	//int companyIdx = Integer.parseInt(request.getParameter("companyIdx"));
	int companyIdx = 1;
	int memberIdx = 1;
	GoToDao gDao = new GoToDao();
	ArrayList<GoToDto> goToList = gDao.getGoTo(companyIdx);
%> --%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회사 바로가기 관리</title>
	<script src="js/jquery-3.7.1.min.js"></script>
	<script>
		let _this;
		
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
			$("#admin-15").click(function() {
				window.location.href = 'Controller?command=admin_page15&companyIdx='+${companyIdx}+'&memberIdx='+${memberIdx};
			});
			/*바로가기 추가 클릭*/
			$(".add-btn").click(function() {
				$(".goto-add-bg").css('display', 'flex');
			});
			/*바로가기 추가 창 확인버튼 클릭*/
			$("#goto-add-check-btn").click(function() {
				let name = $("#goto-name-input").val();
				let url = $("#goto-url-input").val();
				let state = $('input[name="state"]:checked').val();
				
				$.ajax({
					type: 'post',
					url: 'addGoToAjaxServlet',
					data: {
						"changerIdx":${memberIdx },
						"companyIdx":${companyIdx },
						"name":name,
						"url":url,
						"state":state
					},
					success: function() {
						alert("바로가기가 추가됐습니다.");
						location.reload();
					},
					error: function(r, s, e) {
						console.log(r.status);
						console.log(r.responseText);
						console.log(e);
					}
				});
			})
			/*바로가기 추가 창 닫기&취소*/
			$("#goto-add-close-btn").click(function() {
				$("#goto-add-table").find('input[type="text"]').val("");
				$("#goto-add-table").find('input[type="radio"][value="on"]').prop('checked', true);
				$(".goto-add-bg").css('display', 'none');
			});
			$("#goto-add-cancel-btn").click(function() {
				$("#goto-add-table").find('input[type="text"]').val("");
				$("#goto-add-table").find('input[type="radio"][value="on"]').prop('checked', true);
				$(".goto-add-bg").css('display', 'none');
			});
			/*바로가기 상태변경 메서드*/
			function setGoTo(goToIdx, goToName, state) {
				$.ajax({
					type: 'post',
					url: 'setGoToAjaxServlet',
					data: {
						"goToIdx":goToIdx,
						"goToName":goToName,
						"state":state,
						"changerIdx":${memberIdx}
					},
					success: function() {},
					error: function(r, s, e) {
						console.log(r.status);
						console.log(r.responseText);
						console.log(e);
					}
				});
			}
			/*상태 off로 변경하기*/
			$(document).on("click",".on-toggle", function() {
				let idx = $(this).parent().parent().data("idx");
				let goToName = $(this).parent().parent().find('td:nth-child(2)').text();
				let state = 'on';
				setGoTo(idx, goToName, state);
				
				$(this).removeClass('on-toggle');
				$(this).addClass('off-toggle');
			});
			/*상태 on으로 변경하기*/
			$(document).on("click",".off-toggle", function() {
				let idx = $(this).parent().parent().data("idx");
				let goToName = $(this).parent().parent().find('td:nth-child(2)').text();
				let state = 'off';
				setGoTo(idx, goToName, state);
				
				$(this).removeClass('off-toggle');
				$(this).addClass('on-toggle');
			});
			/*바로가기 삭제 클릭*/
			$(".drop-btn").click(function() {
				_this = $(this);
				$(".goto-del-bg").css('display', 'flex');
			});
			/*바로가기 삭제창 닫기&취소*/
			$("#goto-del-close-btn").click(function() {
				$(".goto-del-bg").css('display', 'none');
			});
			$("#goto-del-cancel-btn").click(function() {
				$(".goto-del-bg").css('display', 'none');
			});
			/*바로가기 삭제창 확인 클릭*/
			$("#goto-del-check-btn").click(function() {
				let idx = _this.parent().parent().data("idx");
				let goToName = _this.parent().parent().find('td:nth-child(2)').text();
				$.ajax({
					type: 'post',
					url: 'delGoToAjaxServlet',
					data: {
						"goToIdx":idx,
						"changerIdx":${memberIdx},
						"goToName":goToName
					},
					success: function() {
						alert("바로가기가 삭제되었습니다.");
						location.reload();
					},
					error: function(r, s, e) {
						console.log(r.status);
						console.log(r.responseText);
						console.log(e);
					}
				});
				
				$(".goto-del-bg").css('display', 'none');
			});
		});
	</script>
</head>
<style>
	*{
		padding: 0;
		margin: 0;
		box-sizing: border-box;
		border: none;
		letter-spacing: -1px;
	}
	.all-container{
		display: flex;
	}
	body{
		overflow-y: hidden;
		font-size: 14px;
		color: #4F545D;
	}
	.side-box{
		position: relative;
		background-color: #52545b;
		width: 260px;
		height: 920px;
	}
	.side-head{
		width: 260px;
		height: 60px;
		z-index: 999;
		padding: 18px 0px;
		background-color: #3D4044;
	}
	.logo-box{
		height: 28.86px;
		margin: 0px 0px 0px 30px;
	}
	.logo-box > img {
		width: 128px;
		height: 28.86px;
	}
	.side-foot{
		position: absolute;
		left: 0;
		bottom: 0;
		width: 260px;
		height: 65px;
		background-color: #52545b;
		z-index: 10;
	}
	.side-body{
		width: 260px;
		padding: 25px 10px 25px 30px;
		overflow-y: auto;
		height: 780px;
	}
	h2{
		margin: 0px 0px 7px;
		color: #fff;
		font-size: 15px;
	}
	.h3-box{
		margin: 0px 0px 18px;
		padding: 0px 0px 0px 6px;
	}
	h3{
		color: #BEBEC3;
		font-size: 14px;
		padding: 5px 20px 5px 0px;
		cursor: pointer;
	}
	h3:hover{
		text-decoration: underline;
	}
	.blue-h3{
		color: #7FAEFF;
	}
	.blue-h3:hover{
		text-decoration: none;
	}
	h1{
		color: #111;
		font-size: 19px;
	}
	.main-box{
		padding: 21px 30px 25px 30px;
		width: 1600px;
	}
	.main-title{
		width: 1600px;
		height: 39px;
		padding-bottom: 14px;
		border-bottom: 1px solid #E6E6E6;
	}
	.info-box{
		width: 1600px;
		height: 146px;
		background-color: #F9F9FB;
		margin-bottom: 20px;
		padding: 15px 20px;
		font-weight: bold;
	}
	.info-box > p{
		font-size: 12px;
		line-height: 24px;
		color: #4C4D4E;
	}
	.info-box > p::before{
		content: "•";
		margin-right: 4px;
	}
	.add-btn-box{
		width: 1600px;
		height: 32px;
	}
	.add-btn{
		width: 124px;
		height: 32px;
		padding: 0px 15px;
		line-height: 30px;
		font-size: 14px;
		font-weight: bold;
		color: #3D4044;
		font-weight: bold;
		border: 1px solid #C5C6CB;
		border-radius: 2px;
		cursor: pointer;
		text-align: center;
	}
	.add-btn:hover{
		border: 1px solid gray;
	}
	.table{
		width: 1600px;
		border-collapse: collapse;
		font-size: 13px;
		color: #111;
		border: 1px solid #E1E1E2;
		margin-top: 10px;
	}
	th{
		height: 37px;
		background-color: #F9F9FB;
		border: 1px solid #E1E1E2;
	}
	td{
		height: 36px;
		text-align: center;
		line-height: 16px;
		border: 1px solid #E1E1E2;
		letter-spacing: 0.01em;
	}
	img{
		width: 16px;
		height: 16px;
	}
	.drop-btn{
		width: 35px;
		height: 19px;
		color: #FF6868;
		cursor: pointer;
		font-weight: bold;
	}
	.on-toggle{
		position: relative !important;
		margin: auto auto !important;
		width: 40px !important;
		height: 18px !important;
		background-color: #307CFE !important;
		cursor: pointer !important;
		border-radius: 14px !important;
	}
	.on-toggle > div{
		position: absolute !important;
		top: 2px !important;
		left: 24px !important;
		width: 14px !important;
		height: 14px !important;
		background-color: #FFF !important;
		border-radius: 20px !important;
	}
	.state-td > div:first-of-type{
		position: relative;
		margin: auto auto;
		width: 40px;
		height: 18px;
		background-color: #CCC;
		cursor: pointer;
		border-radius: 14px;
	}
	.state-td > div:first-of-type > div:first-of-type{
		position: absolute;
		top: 2px;
		left: 2px;
		width: 14px;
		height: 14px;
		background-color: #EEE;
		border-radius: 20px;
	}
	.off-toggle {
		position: relative !important;
		margin: auto auto !important;
		width: 40px !important;
		height: 18px !important;
		background-color: #CCC !important;
		cursor: pointer !important;
		border-radius: 14px !important;
	}
	.off-toggle > div{
		position: absolute !important;
		top: 2px !important;
		left: 2px !important;
		width: 14px !important;
		height: 14px !important;
		background-color: #EEE !important;
		border-radius: 20px !important;
	}
	tr th:nth-child(1){
		width: 120px;
	}
	tr th:nth-child(2){
		width: 436px;
	}
	tr th:nth-child(3){
		width: 796px;
	}
	tr th:nth-child(4){
		width: 120px;
	}
	tr th:nth-child(5){
		width: 120px;
	}
	.goto-add-bg{
		position: absolute;
		display: flex;
		justify-content: center;
		align-items: center;
		width: 100%;
		height: 100%;
		z-index: 999;
		background: rgb(0, 0, 0, .6);
	}
	#goto-add-box{
		width: 675px;
		background-color: #FFF;
		padding: 25px 30px 30px 30px;
	}
	#goto-add-header{
		display: flex;
		justify-content: space-between;
		align-items: center;
		padding-bottom: 14px;
		border-bottom: 1px solid #E6E6E6;
	}
	#goto-add-header > div{
		font-size: 19px;
		color: #111;
		font-weight: 700;
	}
	#goto-add-close-btn{
		width: 30px;
		height: 30px;
		background: url(https://flow.team/design2/flow_admin_2019/img/btn_popclose.gif) no-repeat center;
		cursor: pointer;
	}
	#goto-add-table{
		border-collapse: collapse;
		width: 615px;
		text-align: left;
		border: none;
		margin-top: 5px;
	}
	#goto-add-table label{
		font-size: 13px;
	}
	#goto-add-table input[type="radio"]{
		width: 16px;
		height: 16px;
		margin: -2px 0 0;
	}
	#goto-add-table th{
		width: 150px;
		padding: 5px 0 6px;
		font-size: 14px;
		background-color: #FFF;
		border: none;
	}
	#goto-add-table td{
		width: 465px;
		padding: 5px 0 6px;
		border: none;
		text-align: left;
	}
	#goto-name-input{
		width: 233px;
		height: 30px;
		background-color: #FFF;
		padding-left: 10px;
		outline: none;
		border: 1px solid #E6E6E6;
		border-radius: 1px;
	}
	#goto-url-input{
		width: 465px;
		height: 30px;
		background-color: #FFF;
		padding-left: 10px;
		outline: none;
		border: 1px solid #E6E6E6;
		border-radius: 1px;
	}
	#goto-add-btn-box{
		display: flex;
		justify-content: center;
		align-items: center;
		width: 615px;
		height: 36px;
		margin-top: 15px;
	}
	#goto-add-check-btn{
		width: 120px;
		height: 36px;
		color: #FFF;
		font-size: 16px;
		background-color: #307CFF;
		text-align: center;
		line-height: 34px;
		border: 1px solid #C5C6CB;
		border-radius: 3px;
		cursor: pointer;
	}
	#goto-add-cancel-btn{
		width: 120px;
		height: 36px;
		color: #4C4C4C;
		font-size: 16px;
		background-color: #FFF;
		text-align: center;
		line-height: 34px;
		border: 1px solid #C5C6CB;
		border-radius: 3px;
		margin-left: 15px;
		cursor: pointer;
	}
	#goto-add-table input::placeholder{
		color: #C9CACE;
	}
	.goto-del-bg{
		position: absolute;
		display: flex;
		justify-content: center;
		align-items: center;
		width: 100%;
		height: 100%;
		background: rgb(0, 0, 0, .3);
		z-index: 999;
	}
	#goto-del-box{
		width: 380px;
		height: 173px;
		background-color: #FFF;
		border-radius: 8px;
	}
	#goto-del-header{
		display: flex;
		justify-content: space-between;
		align-items: center;
		width: 380px;
		height: 43px;
		background-color: #F4F4F4;
		padding: 11px 16px 16px 16px;
		border-radius: 8px 8px 0 0;
		font-size: 16px;
		color: #111;
	}
	#goto-del-close-btn{
		width: 14px;
		height: 14px;
		cursor: pointer;
		background-image: url(https://flow.team/design2/img_rn/btn/btn_layerstyle4_close2.png?1);
	}
	#goto-del-body{
		width: 380px;
		height: 130px;
		padding: 20px;
	}
	#goto-del-info-msg{
		text-align: center;
	}
	#goto-del-btn-box{
		display: flex;
		justify-content: center;
		align-items: center;
		width: 340px;
		height: 50px;
		padding-top: 20px;
	}
	#goto-del-cancel-btn{
		width: 153px;
		height: 30px;
		color: 4C4C4C;
		background-color: #FFF;
		margin-right: 10px;
		border: 1px solid rgb(201, 201, 201);
		cursor: pointer;
		font-weight: bold;
	}
	#goto-del-check-btn{
		width: 153px;
		height: 30px;
		font-weight: bold;
		border-radius: 2px;
		color: #FFF;
		background-color: rgb(48, 124, 255);
		border: 1px solid rgb(201, 201, 201);
		cursor: pointer;
	}
</style>
<body>
	<div class="all-container">
		<div class="goto-del-bg" style="display: none;">
			<div id="goto-del-box">
				<div id="goto-del-header">
					<div>바로가기 설정</div>
					<div id="goto-del-close-btn"></div>
				</div>
				<div id="goto-del-body">
					<div id="goto-del-info-msg">삭제시 모든 직원들의 바로가기에서 삭제됩니다.<br/>진행하시겠습니까?</div>
					<div id="goto-del-btn-box">
						<button id="goto-del-cancel-btn">취소</button>
						<button id="goto-del-check-btn">확인</button>
					</div>
				</div>
			</div>
		</div>
		<div class="goto-add-bg" style="display: none;">
			<div id="goto-add-box">
				<div id="goto-add-header">
					<div>회사 바로가기 추가</div>
					<div id="goto-add-close-btn"></div>
				</div>
				<table id="goto-add-table">
					<tr>
						<th>이름</th>
						<td><input type="text" id="goto-name-input" placeholder="이름을 입력해 주세요.(최대 30자)"/></td>
					</tr>
					<tr>
						<th>링크</th>
						<td><input type="text" id="goto-url-input" placeholder="URL을 입력해주세요."/></td>
					</tr>
					<tr>
						<th>상태</th>
						<td><label><input type="radio" name="state" value="on" checked/> 활성</label> <label><input type="radio" name="state" value="off"/> 비활성</label></td>
					</tr>
				</table>
				<div id="goto-add-btn-box">
					<button id="goto-add-check-btn">확인</button>
					<button id="goto-add-cancel-btn">취소</button>
				</div>
			</div>
		</div>
		<div class="side-box">
			<div class="side-head">
				<div class="logo-box"><img src="https://flow.team/flow-renewal/assets/images/flow-logo-w.svg" alt="flow"></div>
			</div>
			<div class="side-body">
				<div class="scroll-menu">
					<h2>회사</h2>
					<div class="h3-box">
						<h3 id="admin-1">회사 정보</h3>
						<h3 id="admin-2">구성원 관리</h3>
						<h3 id="admin-3">구성원 초대</h3>
						<h3 id="admin-4"  style="display:none">조직도 관리</h3>
						<h3 class="blue-h3">회사 바로가기 관리</h3>
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
						<h3 id="admin-15">채팅 감사</h3>
					</div>
				</div>
			</div>
			<div class="side-foot">
				<div class="footer"></div>
			</div>
		</div>
		<div class="main-box">
			<div class="main-title"><h1>회사 바로가기 관리</h1></div>
			<div class="info-box">
				<strong style="color: #4F545D">가이드</strong>
				<p>구성원이 공통으로 사용하는 바로가기를 관리할 수 있습니다.</p>
				<p>회사 바로가기를 활성화하는 순간 모든 구성원의 대시보드에 바로가기가 등록됩니다.</p>
				<p>회사 바로가기를 삭제/비활성화하는 순간 모든 구성원의 대시보드에서 바로가기가 삭제됩니다.</p>
				<p>바로가기 추가는 최대 100개까지 가능하며, 활성 가능한 바로가기는 최대 20개입니다.</p>
			</div>
			<div class="add-btn-box">
				<div class="add-btn">+바로가기 추가</div>
			</div>
			<table class="table">
				<tr>
					<th>아이콘</th>
					<th>이름</th>
					<th>링크</th>
					<th>상태</th>
					<th>삭제</th>
				</tr>
				<c:forEach var="dto" items="${goToList }">
					<tr data-idx="${dto.goToIdx }">
						<td><img src="${dto.icon }" alt="${dto.name }"></td>
						<td>${dto.name }</td>
						<td>${dto.url }</td>
						<td class="state-td">
						<c:choose>
							<c:when test="${dto.state.toString() eq 'Y' }">
								<div class="on-toggle"><div></div></div>
							</c:when>
							<c:otherwise>
								<div class="off-toggle"><div></div></div>
							</c:otherwise>
						</c:choose>
						</td>
						<td><span class="drop-btn">[삭제]</span></td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>
</body>
</html>