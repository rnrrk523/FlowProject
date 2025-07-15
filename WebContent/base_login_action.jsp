<%@page import="dto.MemberDto"%>
<%@page import="dao.MemberDao"%>
<%@page import="dao.LoginOrJoinDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    	request.setCharacterEncoding("UTF-8");
        	String email = request.getParameter("id");
        	String pw = request.getParameter("password");
        	LoginOrJoinDao loginDao = new LoginOrJoinDao();
        	MemberDao dao = new MemberDao();
    	    String result = "실패";
    	    //System.out.println("!!");
        	try{
        		System.out.println(email);
        		System.out.println(pw);
        		result = loginDao.clickLogin(email, pw);
        	}catch(Exception e){
        		e.printStackTrace();
    //    		System.out.println("실패");
        	}
        	if(result.equals("이용가능")){
        		int companyIdx = loginDao.getCompanyIdx(email);
    	    	int memberIdx = loginDao.getMemberIdx(email);
    	    	MemberDto dto =  dao.GetMyProfile(memberIdx);
     			session.setAttribute("companyIdx" , companyIdx);
     			session.setAttribute("memberIdx" , memberIdx);
     			session.setAttribute("adminYN", dto.getAdminYN()+"");
     			loginDao.setLoginRecord(memberIdx);
    %>
 				<script>alert("로그인에 성공하였습니다"); 
 				<%if(dto.getHometabSetting().equals("대시보드")) {%>
 				location.href="Controller?command=Dashboard";
 				<% } else {%>
 				location.href="Controller?command=Myprojects";
 				<% } %>
 				</script>
    <%		} else if(result.equals("가입대기")) {%>
    			<script>alert("관리자가 가입을 아직 승인하지 않았습니다."); window.history.back();</script>
    <%		} else if(result.equals("이용중지")) { %>
    		<script>alert("이용이 중지된 계정입니다."); window.history.back();</script>
    <% 		} else { %>
    <script>alert("로그인에 실패했습니다."); window.history.back();</script>
    <% }%>