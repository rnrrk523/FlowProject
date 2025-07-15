<%@page import="dao.LoginOrJoinDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
	<%
	String email ="";
	try{
		request.setCharacterEncoding("UTF-8");
		  email = (String) session.getAttribute("email");
	}catch(Exception e){
	}
	%>	
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link href='http://fonts.googleapis.com/css?family=Roboto:400,300,100,500,700' rel='stylesheet' type='text/css'/>
<link rel = "stylesheet" href = "css/base_login_css.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
	$(document).ready(function(){
		let minutes = 3;
		let second = 0;
		function countTime(){
			let formatTime = (minutes <= 0 ? "0 분" : minutes + "분" ) + ":" + 
							 (second < 10 ? "0 초" : second + "초");
			$(".count_anounce").text("남은 시간  : " + formatTime);
			if(second === 0){
				if(minutes === 0){
					clearInterval(timer);
					$(".count_anounce").text("인증번호가 만료되었습니다.");
					$(".reply").css("display" , "block");
					return;
				}
				minutes--;
				second = 59;
			}
			else{
				second--;
			}
		}
		let timer = setInterval(countTime , 1000);
			const email = "<%= email %>";
		$(".reply").click(function(){
			clearInterval(timer); 
			let reply = setInterval(countTime , 1000);
		})	
		    $(".company_email_input").on("input" , function(){
		    	 this.value = this.value.replace(/[^0-9]/g, "");
		    	const val = $(this).val();
		    	if(val.length === 6){
		    		 $(".now_start_button").prop("disabled", false);
		    		$(".now_start_button").addClass("now_start_button_add");
		    	}
		    	else{
		    		 $(".now_start_button").prop("disabled", true);
		    		$(".now_start_button").removeClass("now_start_button_add");
		    	}
		    }) //입력되었을떄.
		    $(".spend_number > input[type='submit']").on("click", function (e) {
			        e.preventDefault();
		        if (!$(this).hasClass("now_start_button_add")) {
			        return;
		        }
		        // 입력된 PIN 값 가져오기
		        const pin = $(".company_email_input").val();
		        if (!pin || pin.trim() === "") {
		            alert("PIN 번호를 입력해주세요.");
		            return;
		        }
		        // AJAX 요청
		        $.ajax({
		            url: "pinCheck",
		            type: "POST",
		            dataType: "json",
		            data: {
		                "email": email,
		                "pinNumber": pin
		            },
		            success: function (response) {
		                alert(response.bool);
		                // 서버에서 받은 값에 따라 동작 결정
		                if (!response.bool) {
		                    alert("조건이 맞지 않아 진행을 중단합니다.");
		                } else {
		                    alert("조건이 맞아 이벤트를 진행합니다.");
		                    // 기본 동작 수행 (예: 폼 제출)
		                    $(".parti_input_area > form").submit();
		                }
		            },
		            error: function (request, status, error) {
		                alert("AJAX 요청 실패");
		                alert("code: " + request.status + "\nmessage: " + request.responseText + "\nerror: " + error);
		            }
		        });
		    });

		$(".make_company_input_email_header_left").on("click" , function(){
			window.history.back();
		})
	});
</script>
<body>
<div class = "make_company_input_email_header">
	<div class = "make_company_input_email_header_left"></div>
</div>
	<div class = "part_input_main_area">
			<div class = "pass_input_anounce">인증번호 입력</div>
			<div class = "alarm_anounce_area"><%=email %>으로 인증번호가 전송되었습니다.</div>
		<div class = "parti_input_area">
		<form action = "Controller?command=account-userImformation" method = "post" class = "spend_number">
		<div class = "pin_input">
			<input type = "text" class = "company_email_input"  maxlength="6" inputmode="numeric" pattern="[0-9]*" placeholder = "인증번호를 입력해주세요.">
			<div class = "count_anounce">
				남은 시간 : 
			</div>
		</div>
			<span class = "count_time">
			</span>
			<br/>
			<input type = "submit" value = "이제 시작하기" class = "now_start_button">
		</form>
		</div>
			<div class = "google_login_grey_bars">
				<div class = "left_gogle_grey_bar"></div>
			</div>
	</div>
</body>
</html>