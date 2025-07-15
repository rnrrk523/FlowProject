<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    	request.setCharacterEncoding("UTF-8");
        session.setAttribute("name", request.getParameter("name"));
        session.setAttribute("password",request.getParameter("password"));
        session.setAttribute("phone", request.getParameter("phone"));
        session.setAttribute("choice_agree", request.getParameter("choice_agree"));
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link href='http://fonts.googleapis.com/css?family=Roboto:400,300,100,500,700' rel='stylesheet' type='text/css'/>
<link rel = "stylesheet" href = "css/make_company_page_css.css">
<script src = "js/jquery-3.7.1.min.js"></script>
<script>
$(document).ready(function(){
		$('.now_start_button').click(function(){
			if ($('.company_email_input').val().length == 0) {
		        alert('회사 이름을 입력하시오');
		        event.preventDefault();
		        return false;
		    }
			if ($('.indust').val() == '0') {
				alert('제조 업종을 선택하세요');
				event.preventDefault();
	            return false; 
	        }
			if ($('.expect_per').val() == '0') {
				alert('예상 사용 인원을 선택하세요');
				event.preventDefault();
	            return false; 
	        }
			return true;
		});
    });
</script>
<body>
<div class = "make_company_input_email_header">
	<div class = "make_company_input_email_header_left"></div>
	<div class = "make_company_input_email_header_right">
		
	</div>
</div>
	<div class = "part_input_main_area">
			<div class = "flow_start_anounce">회사 만들기</div>
			<div class = "anounce_start">새 회사를 만들고 관리자로 시작합니다.</div>
		<div class = "parti_input_area">
		<form class = "send_company_email" action = "Insert_companySevlet" method = "POST">
				<input type = "text" class = "company_email_input" placeholder = "회사 이름" name = "company_name">
			<br/>
			<div class = "indust_option_area">
					<select class ="indust" name = "indust">
						<option value = "0">제조 업종을 선택하세요.</option>
						<option value = "1">제조업</option>
						<option value = "2">정보통신업(IT)</option>
						<option value = "3">F&B 프랜차이즈</option>
						<option value = "4">도●소매 유통판매</option>
						<option value = "5">엔터테인먼트 , 여행 , 예술</option>
						<option value = "6">공공 행정</option>
						<option value = "7">건설 및 기간 산업</option>
						<option value = "8">서비스</option>
						<option value = "9">세무, 법무, 노무</option>
						<option value = "10">의료보건, 사회 복지</option>
						<option value = "11">금융, 보험, 부동산</option>
						<option value = "12">협회 및 단체</option>
						<option value = "13">교육 및 연구</option>
						<option value = "14">1차 산업(농●임●수산업)</option>
						<option value = "15">기타</option>
					</select>
				</div>
				<div class = per_expects>
						<Select class = "expect_per" name = "expect_per">
							<option value = "0">예상 사용 인원을 선택하세요</option>
							<option value = "1">10인 이하</option>
							<option value = "2">10인 이상 ~ 30인 이하</option>
							<option value = "3">31인 이상 ~ 50인 이하</option>
							<option value = "4">100인 이상</option>
							<option value = "5">500인 이상</option>
							<option value = "6">1000인 이상</option>
						</Select>
				</div>
			<input type = "submit" value = "가입 완료" class = "now_start_button">
		</form>
		</div>
	</div>

</body>
</html>