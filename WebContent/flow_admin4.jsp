<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="dao.CompanyDao"%>
<%@page import="dao.DepartmentDao"%>
<%@page import="dto.DepartmentDto"%>
<%@page import="java.util.ArrayList"%>
<%-- <%
	int companyIdx = Integer.parseInt(request.getParameter("companyIdx"));
	CompanyDao cDao = new CompanyDao();
	char dFuncYN = cDao.getDepartmentFuncYN(1);
	DepartmentDao dDao = new DepartmentDao();
	ArrayList<DepartmentDto> departmentList = dDao.getDepartmentInfo(companyIdx);
%> --%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>조직도 관리</title>
	<script src="js/jquery-3.7.1.min.js"></script>
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
			$("#admin-15").click(function() {
				window.location.href = 'Controller?command=admin_page15&companyIdx='+${companyIdx}+'&memberIdx='+${memberIdx};
			});
			/*조직도 기능 활성화*/
			$(".toggle-btn").click(function() {
				let nowColor = $(this).css('background-color');
				if(nowColor == 'rgb(204, 204, 204)'){
					$(this).css('background-color', '#307CFE');
					$(this).find('div').css('left', '24px');
					$(this).find('div').css('background-color', '#FFF');
					
					$(this).prev().find("#off").css('display', 'none');
					$(this).prev().find("#on").css('display', 'inline');
					
					$(".department-plus-btn").css('background-color', '#307CFE');
					$(".department-plus-btn").css('color', '#FFF');
					
					$("#search-submit").css('background-color', '#FFFFFF');
					$("#search-submit").css('color', '#3d4044');
					$("#search-submit").css('font-weight', 'bold');
					$("#search-submit").css('border-color', '#C5C6CB');
					
					$(".department-list-off").css('display', 'none');
				}else{
					$(this).css('background-color', '#CCC');
					$(this).find('div').css('left', '2px');
					$(this).find('div').css('background-color', '#EEE');
					
					$(this).prev().find("#off").css('display', 'inline');
					$(this).prev().find("#on").css('display', 'none');
					
					$(".department-plus-btn").css('background-color', '#EEE');
					$(".department-plus-btn").css('color', '#999');
					
					$("#search-submit").css('background-color', '#eeeeee');
					$("#search-submit").css('color', '#999999');
					$("#search-submit").css('font-weight', 'bold');
					$("#search-submit").css('border-color', '#eeeeee');
					
					$(".department-list-off").css('display', 'flex');
				}
			});
			/*상위 부서의 하위부서 목록보기 버튼 클릭*/
			$(".dep-show-btn").click(function() {
				let text = $(this).parent().text();
				let parentIdx = text.charAt(text.length-2);
				let nowDisplay = $(this).find("span:nth-child(2)").css('display');
				if(nowDisplay == 'block'){
					$(this).find("span:nth-child(2)").css('display', 'none');
					$(this).parent().parent().find("."+parentIdx+"").css('display', 'block');
				}else if(nowDisplay == 'none'){
					$(this).find("span:nth-child(2)").css('display', 'block');
					$(this).parent().parent().find("."+parentIdx+"").css('display', 'none');
				}
			});
			/*부서를 클릭(선택)하기*/
			$(".depSelect").click(function() {
				$(this).parent().find(".depSelect").each(function() {
					$(this).removeClass("on");
				});
				$(this).addClass("on");
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
		z-index: 999;
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
		border-bottom: 1px solid #e6e6e6;
	}
	.info-box{
		width: 1600px;
		height: 122px;
		background-color: #F9F9FB;
		margin-top: 25px;
		margin-bottom: 20px;
		padding: 15px 130px 15px 20px;
	}
	.info-box > p{
		font-size: 12px;
		line-height: 24px;
	}
	.toggle-box{
		display: flex;
		width: 1600px;
		font-weight: bold;
		padding-bottom: 20px;
		border-bottom: 1px solid #E6E6E6;
	}
	.toggle-box > p{
		letter-spacing: -1.5px;
	}
	#off{
		/*display: none;*/
		color: #307CFE;
	}
	#on{
		display: none;
		color: #307CFE;
	}
	.toggle-btn{
		position: relative;
		left: 10px;
		width: 40px;
		height: 18px;
		cursor: pointer;
		border-radius: 14px;
		background-color:#CCC;
	}
	.toggle-btn > div{
		position: absolute;
		left: 2px;
		top: 2px;
		width: 14px;
		height: 14px;
		background-color: #EEE;
		border-radius: 20px;
	}
	.department-list-box{
		width: 1600px;
		margin-top: 20px;
	}
	.search-box{
		display: flex;
		justify-content: space-between;
		width: 100%;
		font-weight: bold;
	}
	#left-box{
		height: 32px;
	}
	.right-box{
		display: flex;
	}
	#search-text{
		padding: 0px 10px;
		width: 240px;
		height: 32px;
		font-size: 13px;
		border: 1px solid #E6E6E6;
		border-radius: 2px;
		outline: none;
	}
	#search-text::placeholder{
		color: lightgray;
	}
	#search-submit{
		margin-top: 2px;
		width: 67.77px;
		height: 30px;
		color: #999;
		background-color: #EEE;
		margin-left: 2px;
		padding: 0px 20px;
		border: 1px solid #EEE !important;
		cursor: pointer;
	}
	.excel-down-btn{
		padding: 0px 10px;
		height: 30px;
		cursor: pointer;
		line-height: 28px;
		border: 1px solid #C9C9C9;
		border-radius: 2px;
		text-align: center;
	}
	.excel-down-btn > span::before{
		content: url('https://flow.team/img/ico/ico_download_admin.png');
	}
	.department-plus-btn{
		margin-left: 3px;
		cursor: pointer;
		height: 30px;
		color: #999;
		padding: 0px 10px;
		background-color: #EEE;
		line-height: 28px;
	}
	.list-box{
		position: relative;
		margin-top: 11px;
	}
	.department-list-off{
		/*display: none;*/
		display: flex;
		position: absolute;
		left: 0;
		top: 0;
		align-items: center;
		justify-content: center;
		width: 100%;
		height: 100%;
		text-align: center;
		background: rgba(250, 249, 249, 0.6);
		z-index: 1;
	}
	/*.department-list-on{}*/
	.list1{
		height: 43px;
		padding: 12px 0px;
		color: #111;
		font-size: 13px;
		text-align: center;
		border: 1px solid #E6E6E6;
		background: #F9F9FB;
	}
	.list2{
		height: 40px;
		padding: 12px 20px;
		display: flex;
		align-items: center;
		height: 40px;
	}
	.list3{
		display: flex;
		justify-content: center;
		align-items: center;
		height: 100px;
		text-align: center;
		border: 1px solid #E6E6E6;
	}
	.list4{
		display: flex;
		align-items: center;
		height: 60px;
		padding: 14px 20px;
		background: #F9F9FB;
		border: 1px solid #E6E6E6;
	}
	.list4 div{
		font-weight: bold;
	}
	.add-btn{
		display: flex;
		justify-content: center;
		align-items: center;
		width: 67.77px;
		height: 30px;
		padding: auto;
		background-color: #FFF;
		border: 1px solid #C5C6CB;
		border-radius: 2px;
		cursor: pointer;
	}
	.add-btn:hover{
		border: 1px solid black;
	}
	.alter-btn{
		display: flex;
		justify-content: center;
		align-items: center;
		width: 67.77px;
		height: 30px;
		padding: auto;
		margin-left: 6px;
		background-color: #FFF;
		border: 1px solid #C5C6CB;
		border-radius: 2px;
		cursor: pointer;
	}
	.alter-btn:hover{
		border: 1px solid black;
	}
	.drop-btn{
		display: flex;
		justify-content: center;
		align-items: center;
		width: 67.77px;
		height: 30px;
		padding: auto;
		margin-left: 6px;
		background-color: #FFF;
		border: 1px solid #C5C6CB;
		border-radius: 2px;
		cursor: pointer;
	}
	.drop-btn:hover{
		border: 1px solid black;
	}
	.reset-btn{
		display: flex;
		justify-content: center;
		align-items: center;
		width: 80.64px;
		height: 30px;
		padding: auto;
		margin-left: 1255.06px;
		background-color: #FFF;
		border: 1px solid #C5C6CB;
		border-radius: 2px;
		cursor: pointer;
	}
	.reset-btn:hover{
		border: 1px solid black;
	}
	.parentDep{
		border-left: 1px solid #ECECEF;
		border-right: 1px solid #ECECEF;
		cursor: pointer;
	}
	.parentDep:hover{
		background-color: #ECECEF;
	}
	.childDep{
		border-left: 1px solid #ECECEF;
		border-right: 1px solid #ECECEF;
		cursor: pointer;
	}
	.childDep:hover{
		background-color: #ECECEF;
	}
	.dep-show-btn{
		position: relative;
		width: 18px;
		height: 18px;
		background-color: #FFF;
		border: 1px solid #ccc;
		border-radius: 2px;
		margin-right: 5px;
	}
	.dep-show-btn > span:nth-child(1){
		position: absolute;
		left: 4px;
		top: 50%;
		width: 9px;
		height: 1px;
		background-color: #555;
	}
	.dep-show-btn > span:nth-child(2){
		position: absolute;
		top: 25%;
		left: 50%;
		margin-left: -0.5px;
		width: 1px;
		height: 9px;
		background-color: #555;
	}
	.child-dep-before{
		margin-left: 40px;
		margin-right: 8px;
		display: inline-block;
		width: 8px;
		height: 8px;
		background-color: #555;
		border-radius: 100%;
	}
	#companyName{
		border: 1px solid #E6E6E6;
	}
	.on{
		font-weight: bold !important;
		background-color: #ECECEF !important;
	}
</style>
<body>
	<div class="all-container">
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
						<h3 class="blue-h3">조직도 관리</h3>
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
						<h3 id="admin-15">채팅 감사</h3>
					</div>
				</div>
			</div>
			<div class="side-foot">
				<div class="footer"></div>
			</div>
		</div>
		<div class="main-box">
			<div class="main-title"><h1>조직도 관리</h1></div>
			<div class="info-box">
				<strong>가이드</strong>
				<p>· 조직도 관리 기능 사용여부를 설정할 수 있습니다.</p>
				<p>· 부서 정보는 1개씩 추가하거나 엑셀을 통한 일괄 등록도 가능합니다.</p>
				<p>· 부서 정보는 최대 8 Depth까지 구성할 수 있습니다.</p>
			</div>
			<div class="toggle-box">
				<p>조직도 기능이 <span id="off">비활성화</span><span id="on">활성화</span> 상태로 설정되어 있습니다.</p>
				<div class="toggle-btn"><div></div></div>
			</div>
			<div class="department-list-box">
				<div class="search-box">
					<div>
						<form id="left-box">
							<input type="text" name="search-text" id="search-text" placeholder="검색어를 입력해주세요">
							<input type="button" id="search-submit" value="검색">
						</form>
					</div>
					<div class="right-box">
						<div class="excel-down-btn"><span> 엑셀 다운로드</span></div>
						<div class="department-plus-btn">부서 일괄 등록</div>
					</div>
				</div>
				<div class="list-box">
					<div class="department-list-off">조직도 관리 기능 활성화 후, 이용할 수 있습니다.</div>
					<div class="department-list-on">
						<div class="list1">부서명</div>
						<div class="list2" id="companyName">리썰컴퍼니</div>
						<c:forEach var="dto" items="${departmentList }">
							<c:choose>
								<c:when test="${dto.parentIdx == 0 }">
									<div class="list2 parentDep depSelect"><span class="dep-show-btn"><span></span><span></span></span>${dto.name } (부서코드:${dto.departmentIdx })</div>
								</c:when>
								<c:otherwise>
									<div class="list2 childDep depSelect ${dto.parentIdx }" style="display: none;"><span class="child-dep-before"></span>${dto.name } (부서코드:${dto.departmentIdx })</div>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<c:choose>
							<c:when test="${departmentList.size() == 0 }">
								<div class="list3">부서 등록이 되어 있지 않습니다.</div>
							</c:when>
						</c:choose>
						<div class="list4">
							<div class="add-btn">추가</div>
							<div class="alter-btn">수정</div>
							<div class="drop-btn">삭제</div>
							<div class="reset-btn">초기화</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>