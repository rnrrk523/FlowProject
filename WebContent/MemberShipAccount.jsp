<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    	int companyIdx = (Integer)request.getAttribute("companyIdx");
    	String CompanyName = (String)request.getAttribute("CompanyName");
    	String CompanyURL = (String)request.getAttribute("CompanyURL");
    	session.setAttribute("companyIdx", companyIdx);
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link href='http://fonts.googleapis.com/css?family=Roboto:400,300,100,500,700' rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="css/MemberShipAccount.css"/>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
$(document).ready(function() {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
	$('.Submit-btn').click(function(e){
		let email = $('.email-input').val();
		let name = $(".name-input").val();
		let pw = $("#password1").val();
		let pwCheck = $("#password2").val();
		var hasLetter = /[a-zA-Z]/.test(pw);  // 대문자 또는 소문자 포함
        var hasNumbers = /[0-9]/.test(pw);    // 숫자 포함
        var hasSpecialChar = /[!@#$%^&*(_+&=~)]/.test(pw);
		if (!emailRegex.test(email)) {
			e.preventDefault(); // 제출 방지
            alert("유효한 이메일 주소를 입력해주세요.");
            return;
		} 
		if (name.length == 0) {
			e.preventDefault(); // 제출 방지
            alert("이름을 입력해주세요.");
            return;
		}
		if (!(hasLetter && hasNumbers && hasSpecialChar)) {
			e.preventDefault(); // 제출 방지
            alert('영어, 숫자, 특수문자를 모두 포함해야 합니다.');
            return;
		}
		if (pw.length < 11) {
			e.preventDefault(); // 제출 방지
            alert("비밀번호를 12자 이상 입력해주세요.");
            return;
		}
		if (pw != pwCheck ) {
			e.preventDefault(); // 제출 방지
            alert("비밀번호가 일치하지 않습니다.");
            return;
		}
		 if (!$('#check1').is(':checked')) {
			 e.preventDefault(); // 제출 방지
	         alert("서비스 이용약관과 개인정보처리방침 확인을 동의하지 않았습니다.");
	         return;
		 }
		 alert("가입이 요청되었습니다. 승인을 기다려 주십시오.");
	});
});
</script>
<body style = "overflow-y: auto">
	<div class = "account-header">
		<div class = "flow-logo">
			<img src="https://team-0aazcm.flow.team/flow-renewal/assets/images/logo/logo-flow.svg" class="logo-flow">
		</div>
	</div>
	<div class = "account-middle">
		<div class = "account-user-input">
			<div class = "account-company-name"><%=CompanyName %></div>
			<div class = "account-user-input-box">
				<form action="AccountUser" method="post">
					<label>
						<span class = "label-title">이메일</span>
						<input type = "text" maxlength="50" placeholder="example@gmail.com" class = "email-input" name = email>
					</label></br>
					<label>
						<span class = "label-title">이름</span>
						<input type = "text" maxlength="50" placeholder="이름" class = "name-input" name = name>
					</label></br>
					<label>
						<span class = "label-title">비밀번호</span>
						<input type = "password" minlength = "8" maxlength="20" placeholder="비밀번호(12~20자 영문, 숫자, 특수문자 조합)" id="password1" class = "password-input" name = password>
					</label></br>
					<label>
						<span class = "label-title">비밀번호 확인</span>
						<input type = "password" maxlength="20" placeholder="비밀번호 재입력" id="password2" class = "password-input" name = password>
					</label></br>
					<div class = "account-check-box">
						<input type = "checkbox" id = "check1" name = "check1">
						<span class = "checkbox-text">
							<span class = "check1">(필수)</span> 서비스 이용약관, 개인정보처리방침을 확인하였고, 이에 동의합니다.
						</span>
						</br>
						<input type = "checkbox" id = "check2" value="Y" name = "check2">
						<span class = "checkbox-text">
							<span class = "check2">(선택)</span> 플로우 혜택 알림 수신에 동의합니다.
						</span>
					</div></br>
					<input type = "Submit" value = "회원가입" class = "Submit-btn">
					<div class = "orText">이미 계정이 있으신가요?</div>
					<button class = "join-Login">로그인</button>
				</form>
			</div>
		</div>
	</div>
</body>
</html>