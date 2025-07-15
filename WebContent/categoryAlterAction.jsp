<%@page import="dao.AdminChangeHistoryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dto.OpenProjectCategoryDto"%>
<%@page import="dao.ProjectDao"%>
<%
	request.setCharacterEncoding("UTF-8");
	int companyIdx = Integer.parseInt(request.getParameter("companyIdx"));
	int memberIdx = Integer.parseInt(request.getParameter("memberIdx"));
	AdminChangeHistoryDao adao = new AdminChangeHistoryDao();
	ProjectDao pDao = new ProjectDao();
	ArrayList<OpenProjectCategoryDto> categoryList = pDao.getOpenProjectCategory(companyIdx);
	
	ArrayList<String> categoryNameList = new ArrayList<String>();
	ArrayList<Character> categoryStateList = new ArrayList<Character>();
	
	for(OpenProjectCategoryDto dto : categoryList){
		if(request.getParameter("categoryName"+dto.getCategoryIdx())==null) {
			// 관리자 변경 이력 INSERT
			adao.addAdminChangeRecord(memberIdx, "공개 프로젝트 카테고리 관리", "카테고리 삭제", dto.getName(), "");
			
			// 삭제 => category_idx = dto.getCategoryIdx()
			pDao.delOpenProjectCategoryInfo(companyIdx, dto.getCategoryIdx());
			continue;
		}
		// 수정할 카테고리명/카테고리상태 add
		categoryNameList.add(request.getParameter("categoryName"+dto.getCategoryIdx()));
		categoryStateList.add(request.getParameter("state"+dto.getCategoryIdx()).charAt(0));
	}
	// 추가할 카테고리 수 
	int addCategoryCnt = Integer.parseInt(request.getParameter("addCategoryCnt"));
	ArrayList<String> categoryAddNameList = new ArrayList<String>();
	ArrayList<Character> categoryAddStateList = new ArrayList<Character>();
	
// 	System.out.println("addCategoryCnt : " + addCategoryCnt);
	for(int i=1; i<=addCategoryCnt; i++){
		categoryAddNameList.add(request.getParameter("categoryName-"+i));
		categoryAddStateList.add(request.getParameter("state-"+i).charAt(0));
	}
	
	/*카테고리 INSERT*/
	for(int i=0; i<=categoryAddNameList.size()-1; i++){
		// 관리자 변경 이력 INSERT
		adao.addAdminChangeRecord(memberIdx, "공개 프로젝트 카테고리 관리", "카테고리 추가", categoryAddNameList.get(i), "");
		pDao.addOpenProjectCategoryInfo(companyIdx, categoryAddNameList.get(i), categoryAddStateList.get(i));
	}
	
	/*카테고리 UPDATE*/
	for(int i=0; i<=categoryNameList.size()-1; i++){
		pDao.setOpenProjectCategoryInfo(companyIdx, categoryList.get(i).getCategoryIdx(), categoryNameList.get(i), categoryStateList.get(i));
	}
%>
<script src="https://code.jquery.com/jquery-3.7.1.slim.js" integrity="sha256-UgvvN8vBkgO0luPSUl2s8TIlOSYRoGFAX4jlCIm9Adc=" crossorigin="anonymous"></script>
<script>
	location.href = "flow_admin9.jsp?companyIdx="+<%=companyIdx %>;
</script>