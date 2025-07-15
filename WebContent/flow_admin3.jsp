<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%
	int companyIdx = Integer.parseInt(request.getParameter("companyIdx"));
%> --%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>구성원 초대</title>
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
			
			/*클립보드에 복사버튼 클릭*/
			$(".url-copy-btn").click(function() {
				let url = $(".url-link").text();
				
				let tempTextArea = $("<textarea>");
				tempTextArea.val(url);
				$("body").append(tempTextArea);

				tempTextArea.select();
				let yn = document.execCommand("copy");
				if(yn) {
					alert("팀 주소를 클립보드에 저장했습니다.");
				}
				tempTextArea.remove();
			})
			
			/*이메일 초대 전송버튼 클릭*/
			$("#submit-btn").click(function() {
				let yn = true;
				$("input[name='email']").each(function(i) {
					if(i === 0 && $(this).val() == "") { alert("이메일을 다시 확인해주세요."); yn = false; }
					if($(this).val() == "") {
						return;
					}
				})
				if(yn) {
					alert("초대 메일 발송을 완료했습니다!");
					$("form").submit();
				}
			})
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
		border-bottom: 1px solid #E6E6E6;
	}
	.info-box{
		padding: 15px 130px 15px 20px;
		margin: 25px 0px 20px 0px;
		background-color: #F9F9FB;
		font-size: 12px;
		width: 1600px;
		height: 102px;
		line-height: 24px;
		font-size: 12px;
		color: #4C4D4E;
	}
	.mini-title1{
		height: 20px;
		margin-bottom: 12px;
		font-weight: bold;
		color: #4F545D;
	}
	.url-input-box > p{
		height: 20px;
		margin-bottom: 15px;
	}
	.url-input-box > div{
		display: flex;
		height: 32px;
	}
	.url-link{
		min-width: 300px;
		padding-left: 10px;
		width: 320px;
		height: 32px;
		font-size: 16px;
		font-weight: bold;
		border-width: 0;
		border-bottom: 1px solid #E6E6E6;
		color: #307CFF;
		line-height: 1.8em;
		white-space: nowrap;
		overflow-x: hidden;
		letter-spacing: -0.01px;
	}
	.url-copy-btn{
		width: 30px;
		height: 30px;
		cursor: pointer;
		background: url('images/copy_btn_default.png') no-repeat center center;
	}
	.url-copy-btn:hover{
		background: url('images/copy_btn_hover.png') no-repeat center center;
	}
	.mini-title2{
		height: 20px !important;
		margin: 25px 0px 12px;
		font-size: 14px;
		font-weight: bold;
		color: #4F545D;
	}
	.email-input-box{
		display: flex;
		flex-direction: column;
	}
	.email-input-box > p {
		height: 20px;
		font-size: 14px;
		margin-bottom: 15px;
	}
	.input-email{
		width: 320px;
		height: 32px;
		margin-bottom: 10px;
		padding-left: 10px;
		color: black;
		min-width: 300px;
		font-size: 13px;
		border: 1px solid #E6E6E6;
		border-radius: 1px;
		outline: none;
	}
	.input-email::placeholder{
		color: lightgray;
		letter-spacing: 0.1px;
	}
	#submit-btn{
		width: 48px;
		height: 30px;
		padding: 0px 10px;
		color: #FFF;
		border-color: #307CFF;
		background-color: #307CFF;
		cursor: pointer;
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
						<h3 class="blue-h3">구성원 초대</h3>
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
						<h3 id="admin-15">채팅 감사</h3>
					</div>
				</div>
			</div>
			<div class="side-foot">
				<div class="footer"></div>
			</div>
		</div>
		<div class="main-box">
			<div class="main-title"><h1>구성원 초대</h1></div>
			<div class="info-box">
				<p>· 전용 URL을 통해 초대받은 직원은 관리자가 설정한 참여 옵션에 따라서 이용이 가능합니다.</p>
				<p>(관리자 설정 -> 회사 정보 -> 전용 URL - 직원 참여 옵션)</p>
				<p>· 이메일 초대를 통해 이메일을 수신한 직원은 직접 계정 가입 후 바로 이용 가능합니다.</p>
			</div>
			<div>
				<div class="mini-title1">전용 URL</div>
				<div class="url-input-box">
					<p>전용 URL 주소를 전달하여 회사 직원들을 참여시킬 수 있습니다.</p>
					<div>
						<div class="url-link">${companyInfo.companyUrl }</div>
						<button class="url-copy-btn"></button>
					</div>
					<div class="mini-title2">이메일 초대</div>
					<div class="email-input-box">
						<p>직원들의 이메일 주소를 입력하여 바로 초대할 수 있습니다.</p>
						<form action="emailInviteServlet" method="post">
							<input type="email" name="email" placeholder="example@flow.team" class="input-email"><br>
							<input type="email" name="email" placeholder="example@flow.team" class="input-email"><br>
							<input type="email" name="email" placeholder="example@flow.team" class="input-email"><br>
							<input type="email" name="email" placeholder="example@flow.team" class="input-email"><br>
							<input type="email" name="email" placeholder="example@flow.team" class="input-email"><br>
							<input type="button" value="전송" id="submit-btn">
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>