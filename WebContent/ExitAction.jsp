<%@page import="dao.ProjectALLDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int projectIdx = Integer.parseInt(request.getParameter("pno"));
	int memberIdx = Integer.parseInt(request.getParameter("mno"));
	ProjectALLDao dao = new ProjectALLDao();
	dao.ExitProject(projectIdx,memberIdx);
%>
<script>location.href = "Dashboard.jsp"</script>