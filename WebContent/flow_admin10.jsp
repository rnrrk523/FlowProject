<%@page import="dto.ProjectAdminDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="dao.ProjectDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dto.DeactivProjectDto"%>
<%-- <%
	int companyIdx = 1;
	ProjectDao pDao = new ProjectDao();
	ArrayList<DeactivProjectDto> deactiveProjectList = pDao.getDeactivProject(companyIdx);
%> --%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>비활성화 프로젝트 관리</title>
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
		});
	</script>
	<style>
		*{
			padding: 0;
			margin: 0;
			box-sizing: border-box;
			border: none;
			letter-spacing: -0.7px;
		}
		.all-container{
			display: flex;
		}
		body{
			overflow-y: hidden;
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
		.main-box{
			position: relative;
			padding: 21px 30px 25px 30px;
			width: 100%;
			color: #4F545D;
			font-size: 14px;
		}
		.main-title{
			width: 1600px;
			height: 39px;
			padding-bottom: 14px;
			border-bottom: 1px solid #e6e6e6;
		}
		h1{
			color: #111;
			font-size: 19px;
		}
		.info-box{
			width: 1600px;
			height: 98px;
			padding: 15px 130px 15px 20px;
			margin: 20px 0 20px;
			background-color: #F9F9FB;
		}
		.info-box strong{
			display: block;
			margin-bottom: 3px;
			height: 20px;
		}
		.info-box p{
			font-size: 12px;
			height: 24px;
		}
		.search-box{
			display: flex;
			justify-content: space-between;
			align-items: center;
			width: 1600px;
			height: 32px;
		}
		.right-area{
			display: flex;
			align-items: center;
		}
		.left-area select{
			width: 150px;
			height: 32px;
			color: #333;
			font-size: 14px;
			border: 1px solid #E6E6E6;
			border-radius: 1px;
			outline: none;
			cursor: pointer;
		}
		.input-text{
			width: 350px;
			height: 30px;
			padding-left: 10px;
			font-size: 13px;
			border: 1px solid #E6E6E6;
			border-radius: 1px;
			outline: none;
		}
		.input-text::placeholder{
			color: lightgrey;
		}
		.search-btn{
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
		}
		.search-btn:hover{
			color: #000;
			border-color: #999aa0;
			font-weight: bold;
		}
		.target-cnt{
			height: 18px;
			color: #307CFF;
			font-size: 12px;
			margin-right: 12px;
			font-weight: bold;
			cursor: default;
		}
		.admin-plus{
			width: 97.83px;
			height: 30px;
			line-height: 28px;
			font-weight: bold;
			border: 1px solid #C9C9C9;
			border-radius: 2px;
			color: #FFF;
			font-size: 14px;
			background-color: #307CFF;
			padding: auto;
			text-align: center;
			cursor: pointer;
		}
		table{
			width: 1600px;
			border-collapse: collapse;
			margin-top: 10px;
		}
		th{
			height: 37px;
			background-color: #F9F9FB;
			border: 1px solid #E1E1E2;
			text-align: center;
			
		}
		td{
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
			width: 1607px;
			height: 611px;
			font-size: 14px;
		}
		.page-btn-box{
			display: flex;
			justify-content: center;
			align-items: center;
			position: fixed;
			left: 260px;
			bottom: 0;
			border-top: 1px solid #E6E6E6;
			width: 1660px;
			height: 65px;
			padding: 20px 100px;
		}
		.page-btn-box div{
			width: 24px;
			height: 24px;
			font-size: 100%;
			color: #C5C6CB;
			cursor: default;
			border: 1px solid #C5C6CB;
			border-radius: 4px;
			text-align: center;
			letter-spacing: -3px;
			line-height: 20px;
		}
		.tr-row:hover{
			cursor: pointer;
			background-color: #ececef;
		}
	</style>
</head>
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
						<h3 id="admin-4"  style="display:none">조직도 관리</h3>
						<h3 id="admin-5">회사 바로가기 관리</h3>
					</div>
					<h2>프로젝트</h2>
					<div class="h3-box">
						<h3 id="admin-6">프로젝트 관리</h3>
						<h3 id="admin-7">회사 프로젝트 관리</h3>
						<h3 id="admin-8">공개 프로젝트 관리</h3>
						<h3 id="admin-9">공개 프로젝트 카테고리</h3>
						<h3 class="blue-h3">비활성화 프로젝트 관리</h3>
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
			<div class="main-title"><h1>비활성화 프로젝트 관리</h1></div>
			<div class="info-box">
				<strong>가이드</strong>
				<p>1. 이용 중지된 회사 임직원이 만들었던 프로젝트 중, 내부 참여자가 없어서 확인이 불가능한 프로젝트를 관리할 수 있습니다.</p>
				<p>2. 프로젝트에 외부인만 남아 있어 확인이 불가능한 프로젝트를 관리할 수 있습니다.</p>
			</div>
			<div class="search-box">
				<div class="left-area">
					<select>
						<option>프로젝트명</option>
						<option>관리자</option>
						<option>임직원</option>
						<option>외부인</option>
						<option>프로젝트 만든이</option>
					</select>
					<input type="text" class="input-text" placeholder="검색어를 입력해주세요"/>
					<input type="submit" class="search-btn" value="검색"/>
				</div>
				<div class="right-area">
					<p class="target-cnt">선택 프로젝트 수 <span>0</span>/30</p>
					<div class="admin-plus">+관리자 추가</div>
				</div>
			</div>
			<table id="projectTable">
				<tr>
					<th style="width: 40px;"><input id="all-check" type="checkbox"/></th>
					<th style="width: 401.5px;">프로젝트명</th>
					<th style="width: 240.89px;">관리자</th>
					<th style="width: 90.48px;">외부인</th>
					<th style="width: 321.19px;">프로젝트 만든이</th>
					<th style="width: 90.48px;">업무</th>
					<th style="width: 90.48px;">게시물</th>
					<th style="width: 90.48px;">댓글</th>
					<!-- <th style="width: 90.48px;">파일</th> -->
					<th style="width: 150px;">최근 활동일</th>
				</tr>
				<c:forEach var="dto" items="${deactiveProjectList}" varStatus="status">
		            <c:set var="projectInfo" value="${projectInfoList[status.index]}" />
		            <tr class="tr-row">
		                <td><input class="tr-check" type="checkbox"/></td>
		                <td>${dto.pName}</td>
		                <td>
		                    <c:choose>
		                        <c:when test="${projectInfo.adminCnt > 1}">
		                            ${projectInfo.adminName} 외 ${projectInfo.adminCnt - 1}명
		                        </c:when>
		                        <c:otherwise>
		                            ${projectInfo.adminName}
		                        </c:otherwise>
		                    </c:choose>
		                </td>
		                <td>${projectInfo.outsiderCnt}</td>
		                <td>${projectInfo.writer}</td>
		                <td>${projectInfo.taskCnt}</td>
		                <td>${projectInfo.boardCnt}</td>
		                <td>${projectInfo.commentCnt}</td>
		                <td>${projectInfo.lastActivity}</td>
		            </tr>
		        </c:forEach>
				<%-- <%
				for(DeactivProjectDto dto : deactiveProjectList) { 
					ArrayList<ProjectAdminDto> adminList = pDao.getProjectAdminInfo(companyIdx, dto.getProjectIdx());
					String adminName = adminList.get(0).getName();
					int adminCnt = adminList.size();
					int outsiderCnt = pDao.getOutsiderCnt(companyIdx, dto.getProjectIdx());
					int taskCnt = pDao.getTaskCnt(companyIdx, dto.getProjectIdx());
				%>
				<tr class="tr-row">
					<td><input class="tr-check" type="checkbox"/></td>
					<td><%=dto.getpName() %></td>
						<%if(adminCnt > 1){ %>
							<td><%=adminName %> 외 <%=adminCnt-1 %>명</td>
						<%}else { %>
							<td><%=adminName %></td>
						<%} %>
					<td><%=outsiderCnt %></td>
					<td><%=dto.getWriter() %></td>
					<td><%=taskCnt %></td>
					<td><%=pDao.getBoardCnt(companyIdx, dto.getProjectIdx()) %></td>
					<td><%=pDao.getCommentCnt(companyIdx, dto.getProjectIdx()) %></td>
					<!-- <td></td> -->
					<td><%=dto.getLastActivity() %></td>
				</tr>
				<%} %> --%>
			</table>
			<c:choose>
				<c:when test="${deactiveProjectList.size() == 0 }">
					<div class="nothing">검색 결과가 없습니다.</div>
				</c:when>
			</c:choose>
		</div>
		<div class="page-btn-box">
			<div style="margin-right: 10px;">&lt;&lt;</div>
			<div style="margin-right: 30px;">&lt;</div>
			<div style="margin-right: 10px;">&gt;</div>
			<div>&gt;&gt;</div>
		</div>
	</div>
</body>
</html>