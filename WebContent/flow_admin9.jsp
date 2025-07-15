<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="dao.ProjectDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dto.OpenProjectCategoryDto"%>
<%-- <%
	int companyIdx = 1;
	int memberIdx = 1;
	ProjectDao pDao = new ProjectDao();
	ArrayList<OpenProjectCategoryDto> categoryList = pDao.getOpenProjectCategory(companyIdx);
%> --%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>공개 프로젝트 카테고리</title>
	<script src="js/jquery-3.7.1.min.js"></script>
	<script>
		let addCnt = -1;
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
			/*편집 버튼 클릭*/
			$(".edit-btn").click(function() {
				$(this).parent().css('display', 'none');
				$(".save-btn-box").css('display', 'flex');
				$(".show-table").css('display', 'none');
				$(".edit-table").css('display', 'block');
			});
			/*취소 버튼 클릭*/
			$(".cancel-btn").click(function() {
				/* $(this).parent().css('display', 'none');
				$(".edit-btn-box").css('display', 'flex');
				$(".edit-table").css('display', 'none');
				$(".show-table").css('display', 'block');
				$(".addTr").each(function() {
					$(".addTr").remove();
				}) */
				location.reload();
			});
			/*추가 버튼 클릭*/
			$('.add-btn').click(function() {
				let yn = true;
				let categoryCnt = 1;
				$('.category_name').each(function() {
					let text = $(this).attr('name');
					let idx = (text.replace('categoryName', ''));
					if(idx < 0){
						categoryCnt++;
					}
					if($(this).val()==""){
						yn = false;
					}
				})
				$("#categoryCntInput").val(categoryCnt);
				if(yn){
		            let newTr = $('<tr class="addTr">' +
									'<td><div class="btn-drag"><img src="images/btn_drag.png"/></div></td>' +
									'<td><input type="text" name="categoryName'+addCnt+'" class="category_name" placeholder="카테고리명을 입력해주세요." value=""/></td>' +
										'<td>0</td>' +
										'<td>' +
											'<select class="state-select" name="state'+addCnt+'">' +
												'<option value="Y" selected>ON</option>' +
												'<option value="N">OFF</option>' +
											'</select>' +
										'</td>' +
										'<td><span class="drop-btn">삭제</span></td>' +
								'</tr>');
		            $('.edit-table').append(newTr);
		            addCnt--;
				}
	         });
			/*삭제 버튼 클릭*/
			$(document).on("click", ".drop-btn", function() {
				$(this).parent().parent().remove();
			})
			/*활성 체크 시*/
			$("#active").click(function() {
				let val = $(this).find('input[type="radio"]:checked').val();
				if(val){
					$(".tr-Y").css('display', 'table-row');
					$(".tr-N").css('display', 'none');
				}
			})
			/*비활성 체크 시*/
			$("#inactive").click(function() {
				let val = $(this).find('input[type="radio"]:checked').val();
				if(val){
					$(".tr-Y").css('display', 'none');
					$(".tr-N").css('display', 'table-row');
				}
			})
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
		.edit-btn-box{
			display: flex;
			justify-content: space-between;
			margin-top: 15px;
			margin-bottom: 10px;
			width: 1600px;
			height: 30px;
		}
		.edit-btn{
			width: 47.77px;
			height: 30px;
			line-height: 28px;
			font-weight: bold;
			color: #FFF;
			background-color: #307CFF;
			padding: auto;
			cursor: pointer;
			border-radius: 2px;
			text-align: center;
		}
		.save-btn-box{
			/*display: none;*/
			display: flex;
			margin-top: 15px;
			margin-bottom: 10px;
			width: 1600px;
			height: 30px;
		}
		.save-btn{
			width: 47.77px;
			height: 30px;
			line-height: 28px;
			font-weight: bold;
			color: #FFF;
			background-color: #307CFF;
			padding: auto;
			cursor: pointer;
			border-radius: 2px;
			text-align: center;
		}
		.cancel-btn{
			margin-left: 3px;
			width: 47.77px;
			height: 30px;
			line-height: 28px;
			font-weight: bold;
			padding: auto;
			cursor: pointer;
			border: 1px solid #C9C9C9;
			border-radius: 2px;
			text-align: center;
		}
		table{
			width: 1600px;
			border: 1px solid #E1E1E2;
			text-align: center;
			color: #111;
			border-collapse: collapse;
			font-size: 13px;
		}
		th{
			border-left: none !important;
			border-right: none !important;
			background: #F9F9FB;
			border: 1px solid #E1E1E2;
			height: 37px;
			text-align: center;
		}
		td{
			border-left: none !important;
			border-right: none !important;
			padding: 8px;
			border: 1px solid #E1E1E2;
			text-align: center;
		}
		.add-btn{
			margin: 0 auto;
			width: 60px;
			height: 22px;
			line-height: 20px;
			background-color: #FFF;
			padding: 0 10px;
			font-weight: bold;
			border: 1px solid #C9C9C9;
			border-radius: 2px;
			cursor: pointer;
		}
		.add-btn > span::before{
			content: "+ ";
		}
		.show-table td{
			height: 33px;
		}
		.edit-table td{
			height: 49px;
		}
		.btn-drag{
			margin-left: 15px;
			cursor: pointer;
		}
		.category_name{
			width: 400px;
			height: 25px;
			color: #333;
			margin-left: 15px;
			border: 1px solid #E6E6E6;
			border-radius: 1px;
			outline: none;
		}
		.state-select{
			width: 48px;
			height: 32px;
			font-size: 13px;
			margin-left: 15px;
			cursor: pointer;
			border: 1px solid #E6E6E6;
			border-radius: 1px;
			outline: none;
		}
		.drop-btn{
			display: inline-block;
			width: 47.77px;
			height: 30px;
			color: #FF0000;
			margin: 0 15px;
			padding: auto;
			cursor: pointer;
			text-align: center;
			line-height: 28px;
			font-size: 14px;
			font-weight: bold;
			border: 1px solid #C9C9C9;
			border-radius: 2px;
		}
		.tr-Y{
			display: table-row;
		}
		.tr-N{
			display: none;
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
						<h3 class="blue-h3">공개 프로젝트 카테고리</h3>
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
			<div class="main-title"><h1>공개 프로젝트 카테고리</h1></div>
			<div class="edit-btn-box">
				<div class="edit-btn">편집</div>
				<div class="state-box">
					<span>상태 </span>
					<label id="active"><input type="radio" name="state" checked/> 활성</label>
					<label id="inactive"><input type="radio" name="state"/> 비활성</label>
				</div>
			</div>
			<form action="categoryAlterAction.jsp?companyIdx=${companyIdx }&memberIdx=${memberIdx}" method="post">
				<input type="hidden" name="addCategoryCnt" id="categoryCntInput" value="0"/>
				<div class="save-btn-box" style="display: none;">
					<input type="submit" class="save-btn" value="저장"/>
					<div class="cancel-btn">취소</div>
				</div>
				<table class="show-table">
					<tr>
						<th style="width: 112.52px;"></th>
						<th style="width: 675.22px;">카테고리명</th>
						<th style="width: 270.08px;">프로젝트</th>
						<th style="width: 270.08px;">상태</th>
						<th style="width: 270.11px;"></th>
					</tr>
					<c:forEach var="dto" items="${categoryList }">
						<c:choose>
							<c:when test="${dto.state.toString() eq 'Y' }">
								<tr class="tr-Y">
									<td></td>
									<td>${dto.name }</td>
									<td>${dto.projectCnt }</td>
									<td class="state-td">${dto.state }</td>
									<td></td>
								</tr>
							</c:when>
							<c:when test="${dto.state.toString() eq 'N' }">
								<tr class="tr-N">
									<td></td>
									<td>${dto.name }</td>
									<td>${dto.projectCnt }</td>
									<td class="state-td">${dto.state }</td>
									<td></td>
								</tr>
							</c:when>
						</c:choose>
					</c:forEach>
				</table>
				<table class="edit-table" style="display: none;">
					<tr>
						<th style="width: 112.52px;"><div class="add-btn"><span>추가</span></div></th>
						<th style="width: 675.22px;">카테고리명</th>
						<th style="width: 270.08px;">프로젝트</th>
						<th style="width: 270.08px;">상태</th>
						<th style="width: 270.11px;"></th>
					</tr>
					<c:forEach var="dto" items="${categoryList }">
						<tr>
							<td><div class="btn-drag"><img src="images/btn_drag.png"/></div></td>
							<td><input type="text" name="categoryName${dto.categoryIdx }" class="category_name" value="${dto.name }"/></td>
							<td>${dto.projectCnt }</td>
							<td>
								<select class="state-select" name="state${dto.categoryIdx }">
									<c:choose>
										<c:when test="${dto.state.toString() eq 'Y' }">
											<option value="Y" selected>ON</option>
											<option value="N">OFF</option>
										</c:when>
										<c:otherwise>
											<option value="Y">ON</option>
											<option value="N" selected>OFF</option>
										</c:otherwise>
									</c:choose>
								</select>
							</td>
							<td><span class="drop-btn">삭제</span></td>
						</tr>
					</c:forEach>
					<c:choose>
						<c:when test="${categoryList.size() == 0 }">
							<tr>
								<td colspan="5">결과값이 존재하지 않습니다.</td>
							</tr>
						</c:when>
					</c:choose>
				</table>
			</form>
		</div>
	</div>
</body>
</html>