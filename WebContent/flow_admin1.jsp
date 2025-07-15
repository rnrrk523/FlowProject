<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="dao.CompanyDao"%>
<%@page import="dto.CompanyDto"%>
<%-- <%
	CompanyDao dao = new CompanyDao();
	// int companyIdx = Integer.parseInt(request.getParameter("companyIdx"));
	int companyIdx = 1;
	int memberIdx = 1;
	CompanyDto companyInfo = dao.getCompanyInfo(companyIdx);
	String companyName = companyInfo.getCompanyName();
	String companyLogo = companyInfo.getLogoImg();
	String companyUrl = companyInfo.getCompanyUrl();
	
	String fileName = null;
	try {
		fileName = (String)request.getAttribute("fileName");
	} catch(Exception e) {}
%> --%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회사 정보</title>
	<script src="js/jquery-3.7.1.min.js"></script>
	<script>
		let prevCName;
		let prevCUrl;
		$(function() {
			/*페이지 이동*/
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
			$("#admin-15").click(function() {
				window.location.href = 'Controller?command=admin_page15&companyIdx='+${companyIdx}+'&memberIdx='+${memberIdx};
			});
			/*수정 버튼 클릭*/
			$(".update-btn").click(function() {
				if($(this).hasClass('cName')){
					prevCName = $(this).prev().text();
					$(this).parent().next().find('input[type="text"]').val(prevCName);
					$(this).parent().css('display', 'none');
					$(this).parent().next().css('display', 'flex');
				}else if($(this).hasClass('cUrl')){
					prevCUrl = $(this).prev().text();
					let domain = prevCUrl.replace("https://", "").replace(".flow.team", "");
					$(this).parent().next().find('input[type="text"]').val(domain);
					$(this).parent().css('display', 'none');
					$(this).parent().next().css('display', 'flex');
				}
			});
			/*저장 버튼 클릭*/
			$("#cName-record").click(function() {
				let cName = $(this).prev().val();
				$(this).parent().prev().find('.input').text(cName);
				$(this).parent().css('display', 'none');
				$(this).parent().prev().css('display', 'flex');
				$.ajax({
					type: 'post',
					data: {
						"prevCName":prevCName,
						"cName":cName,
						"companyIdx":${companyIdx},
						"memberIdx":${memberIdx}
					},
					url: 'SetcNameAjaxServlet',
					success: function() {},
					error: function(r, s, e) {
						console.log(r.status);
						console.log(r.responseText);
						console.log(e);
					}
				});
			});
			$("#url-record").click(function() {
				let url = $(this).prev().val();
				$.ajax({
					type: 'post',
					data: {
						"prevCUrl":prevCUrl,
						"memberIdx":${memberIdx},
						"url":url,
						"companyIdx":${companyIdx}
					},
					url: 'SetcUrlAjaxServlet',
					success: function() {},
					error: function(r, s, e) {
						console.log(r.status);
						console.log(r.responseText);
						console.log(e);
					}
				});
				let completionUrl = "https://"+url+".flow.team";
				$(this).parent().prev().find('.url-input').text(completionUrl);
				$(this).parent().css('display', 'none');
				$(this).parent().prev().css('display', 'flex');
			});
			/*취소 버튼 클릭*/
			$(".cancel-btn").click(function() {
				$(this).parent().css('display', 'none');
				$(this).parent().prev().css('display', 'flex');
			});
			/*로고 등록 클릭*/
			$("#logo-add").click(function() {
				$("#logo-add-bg").css('display', 'flex');
			});
			/*로고 등록창 닫기*/
			$(".logo-add-close-btn").click(function() {
				$("#logo-add-bg").css('display', 'none');
			});
			/*파일 첨부 클릭*/
			$("#file-add-btn").on('click', function() {
				$("#file-add-btn-input").click();
			})
			/*로고 다시등록하기 버튼클릭*/
			$("#logoRegesterBtn").on('click', function() {
				$("#file-add-btn-input").click();
			})
			/*로고 등록 저장 버튼클릭*/
			$("#logo-add-record-btn").on('click', function() {
				alert("로고가 등록 되었습니다.");
			})
			/*로고 삭제 버튼 클릭*/
			$("#logoDelBtn").click(function() {
				let yn = confirm("로고를 삭제 하시겠습니까?");
				if(yn) {
					$.ajax({
						type: 'post',
						data: {},
						url: "CompanyLogoDeleteServlet",
						success: function() {
							alert("로고를 삭제 하였습니다.");
							location.reload();
						},
						error: function(r, s, e) {
							console.log(r.status);
							console.log(r.responseText);
							console.log(e);
						}
					})
				}
			})
			$("#file-add-btn-input").change(function() {
				alert("파일 선택됨!");
			})
			$("#logo-add").hover(
				function() {
					$("#logoBtnHover").css("display", "block");
				},
				function() {
					$("#logoBtnHover").css("display", "none");
				}
			);
		});
	</script>
</head>
	<style>
		*{
			padding: 0;
			margin: 0;
			box-sizing: border-box;
			border: none;
			letter-spacing: -0.7px;
		}
		.all-container{
			position: relative;
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
		.main-box{
			position: relative;
			padding: 21px 30px 25px 30px;
			width: 100%;
			color: #4F545D;
			font-size: 14px;
		}
		.main-1{
			width: 1600px;
			border-bottom: 1px solid #e6e6e6;
			padding: 0px 0px 14px;
		}
		h1{
			color: #111;
			font-size: 19px;
		}
		.main-2{
			width: 1120px;
			height: 200px;
			padding-top: 25px;
		}
		.miniTitle1{
			height: 20px;
			margin-bottom: 12px;
			font-weight: bold;
		}
		.miniTitle2{
			height: 20px;
			font-weight: bold;
			margin-top: 25px;
			margin-bottom: 12px;
		}
		.miniTitle3{
			height: 20px;
			font-weight: bold;
			margin-bottom: 12px;
		}
		.show-box{
			display: flex;
			height: 32px;
		}
		.input{
			width: 300px;
			height: 32px;
			padding-left: 10px;
			border-bottom: 1px solid #e6e6e6;
			font-size: 16px;
			line-height: 36px;
		}
		.update-btn{
			width: 47.77px;
			height: 30px;
			color: #4C4C4C;
			background-color: #FFF;
			margin-left:8px;
			padding: auto;
			font-weight: bold;
			border: 1px solid #c9c9c9;
			border-radius: 2px;
			line-height: 28px;
			text-align: center;
			cursor: pointer;
		}
		.logo-wrap{
			height: 79px;
			margin-top: 5px;
			margin-bottom: 10px;
		}
		#logo-add{
			position: relative;
			display: flex;
			justify-content: center;
			align-items: center;
			width: 280px;
			height: 53px;
			color: #8B8C8E;
			font-size: 13px;
			font-weight: bold;
			text-align: center;
			line-height: 40px;
			border: 1px solid #e7e7e9;
			cursor: pointer;
		}
		#logo-add:hover{
			color: #333;
		}
		.logo-info{
			height: 19px;
			color: #A2A2A2;
			font-size: 13px;
			margin-top: 5px;
		}
		.url-wrap{
			height: 99px;
			width: 1600px;
		}
		.url-info{
			height: 20px;
			margin-bottom: 15px;
			
		}
		.main-3{
			width: 1600px;
			height: 234.94px;
			margin-top: 52px;
			padding-top: 25px;
			border-top: 1px solid #e6e6e6;
		}
		.url-input{
			width: 300px;
			height: 32px;
			font-weight: bold;
			color: #307cff;
			font-size: 16px;
			border-width: 0;
			border-bottom-width: 1px;
			border-bottom: 1px solid #e6e6e6;
			padding-left: 10px;
			line-height: 36px;
			outline: none;
			white-space: nowrap;
			overflow-x: hidden;
			overflow-y: hidden;
		}
		.input{
			font-size: 16px;
			outline: none;
			border-bottom: 1px solid #E6E6E6;
		}
		.record-btn{
			color: #FFF;
			border: 1px solid #307CFF;
			background-color: #307CFF;
			margin-left: 8px;
			padding: 0 10px;
			height: 30px;
			line-height: 28px;
			font-size: 14px;
			font-weight: bold;
			border: 1px solid #c9c9c9;
			border-radius: 2px;
			cursor: pointer;
		}
		.cancel-btn{
			margin-left: 8px;
			padding: 0 10px;
			height: 30px;
			line-height: 28px;
			font-size: 14px;
			color: #4c4c4c;
			font-weight: bold;
			border: 1px solid #c9c9c9;
			border-radius: 2px;
			background-color: #FFF;
			cursor: pointer;
		}
		#logo-add-bg{
			position: absolute;
			top: 0;
			left: 0;
			display: flex;
			justify-content: center;
			align-items: center;
			width: 100%;
			height: 100%;
			z-index: 999;
			background: rgb(0, 0, 0, .6);
		}
		#logo-add-box{
			width: 450px;
			height: 400px;
			background-color: #FFF;
			border-radius: 7px;
		}
		#logo-add-header img{
			width: 14px;
			height: 14px;
			cursor: pointer;
		}
		#logo-add-content-box{
			position: relative;
			width: 450px;
			height: 256px;
			padding: 20px;
		}
		#logo-add-content-box p{
			position: absolute;
			bottom: 20px;
			width: 410px;
			height: 20px;
			font-size: 14px;
		}
		#logo-add-info{
			width: 410px;
			height: 40px;
			padding: 10px;
			font-weight: bold;
			text-align: center;
			font-size: 14px;
		}
		#logo-add-header{
			display: flex;
			justify-content: space-between;
			align-items: center;
			padding: 11px 16px 11px 16px;
			font-size: 16px;
			color: #111;
			background-color: #f4f4f4;
			border-radius: 7px 7px 0 0;
			height: 43px;
		}
		#logo-add-btn-box{
			display: flex;
			justify-content: center;
			padding: 15px 0;
			text-align: center;
			border-top: 1px solid #E5E5E5;
		}
		#logo-add-cancel-btn{
			display: flex;
			justify-content: center;
			align-items: center;
			width: 68px;
			height: 30px;
			font-size: 13px;
			line-height: 20px;
			padding: 5px 8px 0 10px;
			font-weight: bold;
			color: #505050;
			cursor: pointer;
			background-color: #FFF;
			border: 1px solid #BBBBBB;
		}
		#logo-add-record-btn{
			display: flex;
			justify-content: center;
			align-items: center;
			width: 68px;
			height: 30px;
			font-size: 13px;
			line-height: 20px;
			padding: 5px 8px 0 10px;
			font-weight: bold;
			color: #FFF;
			cursor: pointer;
			background-color: #6A63BB;
			border: 1px solid #BBBBBB;
			margin-left: 5px;
		}
		#file-content-wrap{
			display: flex;
			justify-content: center;
			align-items: center;
			width: 408px;
			height: 142px;
			cursor: pointer;
			border: 1px solid #e9eaed;
			border-radius: 2px;
		}
		#file-add-btn{
			padding: 2px 10px 2px 10px;
			font-size: 13px;
			font-weight: bold;
			border: 1px solid #94AACB;
			text-align: center;
		}
		#logoOnCase-fileContentWrap{
			display: flex;
			justify-content: center;
			align-items: center;
			margin-bottom: 12px;
			height: 144px;
			text-align: center;
			border 1px solid #747576;
			border-radius: 2px;
			background-color: #e2e1e3;
		}
		#logoRegesterBtn{
			cursor: pointer;
			color: #4f545d
			font-size: 14px;
		}
		#logoDelBtn{
			cursor: pointer;
			color: red;
			font-size: 14px;
		}
		#logoFileAddImg {
			max-width: 408px;
			max-height: 142px;
		}
		#logoImg {
			max-width: 280px;
			max-height: 40px;
		}
		#logoBtnHover {
			display: none;
			width: 100%;
			height: 100%;
			line-height: 53px;
			position: absolute;
			top: 0;
			left: 0;
			font-size: 13px;
			font-weight: bold;
			color: #fff;
			text-align: center;
			text-shadow: rgb(0, 0, 0, .3) 1px 1px 1px;
			background-color: rgba(0, 0, 0, .5);
			border-radius: 1px;
			cursor: pointer;
		}
		#logoBtnHover:before {
			display: inline-block;
			vertical-align: middle;
			content: "";
			margin-top: 0;
			margin-right: 6px;
			width: 15px;
			height: 15px;
			background: url("https://flow.team/design2/flow_admin_2019/img/ico_logoimg_edit.png") no-repeat;
		}
	</style>
<body>
	<div class="all-container">
		<div id="logo-add-bg" style="display: none;">
			<div id="logo-add-box">
				<div id="logo-add-header">
					<div>로고등록</div>
					<img class="logo-add-close-btn" src="https://flow.team/design2/img_rn/btn/btn_layerstyle4_close2.png?1"/>
				</div>
				<form action="adminPageLogoAddServlet" method="post" enctype="multipart/form-data">
					<div id="logo-add-content-box">
						<div id="logo-add-info">우리 회사 로고를 등록 하세요</div>
					<c:choose>
						<c:when test="${companyInfo.logoImg == null }">
							<div id="file-content-wrap">
								<div id="file-add-btn">파일 첨부</div>
								<input type="file" id="file-add-btn-input" name="file1" value="파일 첨부" style="display: none;">
							</div>
							<p>권장사항 - 400*100px, PNG / 최대 500KB</p>
						</c:when>
						<c:otherwise>
							<div id="logoOnCase-fileContentWrap">
								<img src="upload/${companyInfo.logoImg }" id="logoFileAddImg"/>
								<input type="file" id="file-add-btn-input" name="file1" value="파일 첨부" style="display: none;">
							</div>
							<span id="logoRegesterBtn">다시 등록하기</span><br/>
							<span id="logoDelBtn">로고 삭제</span>
						</c:otherwise>
					</c:choose>
					</div>
					<div id="logo-add-btn-box">
						<button type="button" id="logo-add-cancel-btn" class="logo-add-close-btn">취소</button>
						<button id="logo-add-record-btn">저장</button>
					</div>
				</form>
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
						<h3 class="blue-h3">회사 정보</h3>
						<h3 id="admin-2">구성원 관리</h3>
						<h3 id="admin-3">구성원 초대</h3>
						<h3 id="admin-4" style="display:none">조직도 관리</h3>
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
			<div class="main-1">
				<h1>회사 정보</h1>
			</div>
			<div class="main-2">
				<div class="miniTitle1">회사명</div>
				<div class="show-box">
					<div class="input">${companyInfo.companyName }</div>
					<div class="update-btn cName">수정</div>
				</div>
				<div class="input-box" style="display: none;">
					<input type="text" class="input"/>
					<button class="record-btn" id="cName-record" type="submit">저장</button>
					<button class="cancel-btn" type="button">취소</button>
				</div>
				<div class="miniTitle2">로고 설정</div>
				<div class="logo-wrap">
					<c:choose>
						<c:when test="${companyInfo.logoImg == null }">
							<div id="logo-add">
								<span style="margin: -8px 6px 0px 0px; font-size: 24px;">+</span>로고 등록
							</div>
						</c:when>
						<c:otherwise>
							<div id="logo-add">
								<img src="upload/${companyInfo.logoImg }" id="logoImg"/>
								<div id="logoBtnHover">편집 및 삭제</div>
							</div>
						</c:otherwise>
					</c:choose>
					<p class="logo-info">권장사항 - 400*100px,PNG / 최대 500KB</p>
				</div>
			</div>
			<div class="main-3" style="display: none;">
				<div class="url-wrap">
					<div class="miniTitle3">전용 URL</div>
					<p class="url-info">전용 URL 주소를 전달하여 회사 직원들을 참여시킬 수 있습니다.</p>
					<div class="show-box">
						<div class="url-input">${companyInfo.companyUrl }</div>
						<div class="update-btn cUrl">수정</div>
					</div>
					<div class="input-box" style="display: none;">
						<input class="url-input" type="text"/>
						<button class="record-btn" id="url-record" type="button">저장</button>
						<button class="cancel-btn" type="button">취소</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>