<%@page import="dao.LoginOrJoinDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%
   	LoginOrJoinDao loginDao = new LoginOrJoinDao();
   	
   %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link href='http://fonts.googleapis.com/css?family=Roboto:400,300,100,500,700' rel='stylesheet' type='text/css'/>
<link rel = "stylesheet" href = "css/prefer_company_input.css">
<script src = "js/jquery-3.7.1.min.js"></script>
<script>
$(function(){
	$('.now_start_button').click(function(){
		if($('.company_name_input').val().length >= 2) {
			
		} else {
			alert("이름을 2글자 이상 입력하시오.");
			return false;
		}
		if($('.company_pass_input').val().length >= 8) {
			
		} else {
			alert("비밀번호를 8글자 이상 입력하시오.");
			return false;
		}
		if($('.company_phone_input').val().length == 11) {
			
		} else {
			alert("전화번호를 입력하시오.(11글자 -없이)");
			return false;
		}
		$('.blind_area').css('display','block');
		$('.all_agree').css('display','block');
		$('.checked_all').on('change', function() {
		    if($(this).prop('checked')) {
		        $('.all_agree').find('input[type="checkbox"]').prop('checked', true);
		    } else {
		    	 $('.all_agree').find('input[type="checkbox"]').prop('checked', false);
		    }
		});
		 // "확인" 버튼을 클릭했을 때
	    $('.agree_submit_button').click(function(event) {
	        // 필수 체크박스들이 모두 체크되었는지 확인
	        if (!$('.age_agrees').prop('checked')) {
	            alert('만 14세 이상에 동의해 주세요.');
	            event.preventDefault(); // 폼 제출을 막기 위해
	            return false;
	        }
	        if (!$('.agree1').prop('checked')) {
	            alert('서비스 이용 약관에 동의해 주세요.');
	            event.preventDefault();
	            return false;
	        }
	        if (!$('.agree2').prop('checked')) {
	            alert('개인정보 처리 방침에 동의해 주세요.');
	            event.preventDefault();
	            return false;
	        }

	        return true;
	    });
	});
	
});
</script>
<body>
	<form action = "Controller?command=account-company" method = "post">
	<div class = "agree_area">
		<header class = "agree">
			<div class = "agree_area"></div>
			<div class = "cancel_button"></div>
		</header>
		<div class = "all_agree">
			<div class = "agree_header">
				<label class = "all_check_area">
					<input type ="checkbox" class = checked_all>
					<div class = "all_agree_kor">모두 동의</div>
				</label>
					<div class = "close_button"></div>
			</div>
			<div class = "age_agree">
				<label>
					<input type = "checkbox" name = "age_agree" class = "age_agrees" value = "on">
					<div class = "agree_explain_kor">
						<div class = "red_area">(필수)</div>
						<div class = "black_area">만 14세 이상입니다.</div>
					</div>
				</label>
			</div>
			<div class = "service_agree">
					<label>
						<input type = "checkbox" name = "agree1" class =  "agree1" value = "on">
						<div class = "agree_explain_kor">
							<div class = "red_area">(필수)</div>
							<div class = "black_area">서비스 이용 약관 동의</div>
						</div>
					</label>
			</div>
			<div class = "prefer_agree">
					<label>
						<input type = "checkbox" name = "agree2" class = "agree2" value = "on">
						<div class = "agree_explain_kor">
							<div class = "red_area">(필수)</div>
							<div class = "black_area">개인정보 처리 방침 동의</div>
						</div>
					</label>
			</div>
			<div class = "marketing_agree">
					<label>
						<input type = "checkbox" name = "choice_agree" class = "choice_agree" value = "Y">
						<div class = "agree_explain_kor">
							<div class = "black_area">(선택) 마케팅활용동의.</div>
						</div>
					</label>
			</div>
			<input type = "submit" value = "확인" class = "agree_submit_button">
		</div>
	</div>
<div class = "make_company_input_email_header">
	<div class = " make_company_input_email_header_left"></div>
</div>
	<div class = "part_input_main_area">
			<div class = "input_company">사용자 정보 입력</div>
			<div class = "require_input">아래 정보를 모두 입력해 주세요.</div>
		<div class = "parti_input_area">
					<input type = "text" name = "name" class = "company_name_input" placeholder = "이름">
				<br/>
					<input type = "password" class = "company_pass_input" placeholder = "비밀번호" name = "password">
				<br/>
					<div class = "phone_fly_pin">
						<input type = "text" class = "company_phone_input" placeholder = "휴대폰 번호(숫자만 적으시오)" name = "phone" maxlength ="11">
					</div>
					<input type = "button" value = "다음" class = "now_start_button">
		</div>
	</div>
	<div class = "blind_area"></div>
	</form>
</body>
</html>