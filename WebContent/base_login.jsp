<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>로그인</title>
</head>
<link href='http://fonts.googleapis.com/css?family=Roboto:400,300,100,500,700' rel='stylesheet' type='text/css'/>
<link rel = "stylesheet" href = "css/base_login_css.css">
<script src = "js/jquery-3.7.1.min.js"></script>
<script>
	/* $(document).ready(function(){
		$(".send_company_email").on("submit", function(e){
			const id = $(".send_company_email > input[type = 'text']")
			if($(".send_company_email > input[type = 'text']").val() == ""){
				$(".error_id_area").css("display" , "block");
				$(".send_company_email > input[type = 'text']").css("border" , "1px solid #ff6b6b");
				e.preventDefault();
			}
			const password = $(".send_company_email > input[type = 'password']");
			if($(".send_company_email > input[type = 'password']").val() == ""){
				$(".error_pass_area").css("display" , "block");
				e.preventDefault();
			$(".send_company_email > input[type = 'password']").css("border" , "1px solid #ff6b6b");
			}
		})
		$(".send_company_email > input[type = 'password']").on("input" , function(){
			$(".send_company_email > input[type = 'password']").css("border", "1px solid #ddd");
			//$(".error_pass_area").css("display" , "none");
		})
		$(".send_company_email > input[type = 'text']").on("input" , function(){
			$(".send_company_email > input[type = 'text']").css("border", "1px solid #ddd");
			//$(".error_id_area").css("display" , "none");
		})
	}) */
	$(function() {
		$(".now_start_button_add").click(function() {
			let email = $("input[type='text']").val();
			let pw = $("input[type='password']").val();
			let emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
			if(email == "") { $("input[type='text']").focus(); alert("이메일을 입력하세요."); return; }
			if(!(emailPattern.test(email))) { $("input[type='text']").focus(); alert("이메일을 다시 입력하세요."); return; }
			if(pw == "") { $("input[type='password']").focus(); alert("비밀번호를 다시 입력하세요."); return; }
			$(".send_company_email").submit();
		})
		$('#joinBtn').click(function(){
			location.href = "Controller?command=AccountEmailMemberShip";
		});
	});
</script>
<body>
	<!-- <div class = "make_company_input_email_header">
		<div class = "make_company_input_email_header_left"></div>
	</div> -->
	<div class = "part_input_main_area">
		<div class = "flow_start_anounce">로그인</div>
		<div class = "parti_input_area">
			<form class = "send_company_email" action = "base_login_action.jsp" method = "post">
				<input type = "text" class = "company_email_input" placeholder = "아이디" name = "id">
				<br/>
				<div class = "error_id_area">아이디를 입력하세요.</div>
				<input type = "password" class = "company_email_input" placeholder = "비밀번호" name = "password">
				<div class = "error_pass_area">비밀번호를 입력하세요.</div>
				<div><a href = "#">비밀번호 찾기</a></div>
				<br/>
				<input type = "button" value = "로그인" class = "now_start_button_add">
				<br/>
				<input type = "button" value = "회원가입" id="joinBtn">
				<div class = "ID">
					테스트계정 <br/>
					아이디 : lms44561000@gmail.com <br/>
					비밀번호 : team123~!
				</div>
			</form>
		</div>
		<!-- <div class = "google_login_grey_bars">
			<div class = "left_gogle_grey_bar"></div>
			<div class = "gogle_or">또는</div>
			<div class = "right_gogle_grey_bar"></div>
		</div>
		<div class = "thr_google">
			<div class = "google_logo"></div>
			<span class = "google_to_go">Google 계정으로 로그인</span>
		</div>
		<div class = "thr_kakao">
			<div class = "kakao_logo"></div>
			<span class = "kakao_to_go">Kakao 계정으로 로그인</span>
		</div> -->
	</div>
</body>
</html>