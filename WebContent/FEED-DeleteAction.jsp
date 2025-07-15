<%@page import="dao.MemberDao"%>
<%@page import="dto.MemberDto"%>
<%@page import="dao.ProjectALLDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	int pno = Integer.parseInt(request.getParameter("pno"));
	int memberIdx = Integer.parseInt(request.getParameter("memberIdx"));
	ProjectALLDao pdao = new ProjectALLDao();
	pdao.DeleteProject(pno);
	MemberDao mdao = new MemberDao();
	MemberDto mdto = null;
	try {
		mdto = mdao.GetMyProfile(memberIdx);
	} catch (Exception e2) {
		e2.printStackTrace();
	}
	String hometab = mdto.getHometabSetting();
%>
<script>
	alert("삭제되었습니다.");
	<%if(hometab.equals("대시보드")) {%>
	location.href="Controller?command=Dashboard";
	<% } else {%>
	location.href="Controller?command=Myprojects";
	<% } %>
</script>