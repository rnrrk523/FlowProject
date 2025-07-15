<%@page import="dao.LoginOrJoinDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link href='http://fonts.googleapis.com/css?family=Roboto:400,300,100,500,700' rel='stylesheet' type='text/css'/>
<link rel = "stylesheet" href = "css/make_company_input_email_css.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
$(function() {
    $(document).ready(function() {
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        // 이메일 입력 이벤트 핸들러
        $(".company_email_input").on("input", function() {
            const val = $(this).val().trim(); // 현재 입력값
            if (emailRegex.test(val)) {
            	$(".send_company_email").find("input[type='submit']").prop("disabled" , false);
                $(".now_start_button").addClass("now_start_button_add");
            } else {
            	$(".send_company_email").find("input[type='submit']").prop("disabled" , true);
                $(!".now_start_button").removeClass("now_start_button_add");
            }
        });
        // 뒤로 가기 버튼 클릭 핸들러
        $(".make_company_input_email_header_lef").on("click", function() {
            window.history.back(); // 뒤로가기
        });

        $(".send_company_email").on("submit", function(e) {
            const emailInput = $(".company_email_input").val().trim();
            
            if (!emailRegex.test(emailInput)) {
                e.preventDefault(); // 제출 방지
                alert("유효한 이메일 주소를 입력해주세요.");
                return; 
            }

            $.ajax({
                type: "POST",
                url: "EmailDuplicationCheckServlet", 
                data: {
                    email: emailInput
                },
                success: function(data) {
                    console.log(data);

                    if (data.Check === 'Y') {
                        e.preventDefault();  
                        alert("이메일이 중복되었습니다.");
                    } else {
                    	$(".send_company_email")[0].submit(); // 폼 제출
                    }
                },
                error: function(r, s, e) {
                    console.log(r.status);
                    console.log(e);
                    alert("서버 오류가 발생했습니다. 다시 시도해주세요.");
                }
            });
            return false; 
        });
    });
    $('.already_have_id_go').click(function(){
    	window.location.href = "Controller?command=Login"
    });
});

</script>
<body>
	<div class = "make_company_input_email_header">
		<div class = "make_company_input_email_header_left"></div>
		<div class = "make_company_input_email_header_right">
			<div class = "already_have_id">이미 계정이 있으신가요?</div>
			<div class = "already_have_id_go">로그인</div>
		</div>
	</div>
	<div class = "part_input_main_area">
		<div class = "flow_start_anounce">플로우 회사 시작하기</div>
		<div class = "parti_input_area">
			<form class="send_company_email" action="emailPin" method="post">
			    <input type="text" class="company_email_input" placeholder="회사 이메일" name="email">
			    <br/>
			    <input type="submit" value="이제 시작하기" class="now_start_button"> 
			</form>
		</div>
	</div>
</body>
</html>