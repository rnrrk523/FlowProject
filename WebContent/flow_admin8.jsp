<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="dao.ProjectDao"%>
<%@page import="dto.OpenProjectDto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dto.OpenProjectCategoryDto"%>
<%-- <%
	int companyIdx = 1;
	int memberIdx = 1;
	ProjectDao pDao = new ProjectDao();
	ArrayList<OpenProjectDto> openProjectList = pDao.getOpenProjects(companyIdx);
	ArrayList<OpenProjectCategoryDto> categoryList = pDao.getOpenProjectCategory(companyIdx);
%> --%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>공개 프로젝트 관리</title>
	<script src="js/jquery-3.7.1.min.js"></script>
	<script>
		let _this;
		let _prevWritingGrant;
		let _prevCategoryIdx;
		$(function() {
			/*페이지 이동*/
			$("#admin-1").click(function() {
				window.location.href = 'Controller?command=admin_page1&companyIdx='+${companyIdx}+'&memberIdx='+${memberIdx};
			});
			$("#admin-2").click(function() {
				window.location.href = 'Controller?command=admin_page2&companyIdx='+${companyIdx}+'&memberIdx='+${memberIdx};
			});
			$("#admin-3").click(function() {
				window.location.href = 'Controller?command=admin_page3&companyIdx='+${companyIdx}+'&memberIdx='+${memberIdx};
			});
			$("#admin-4").click(function() {
				window.location.href = 'Controller?command=admin_page4&companyIdx='+${companyIdx}+'&memberIdx='+${memberIdx};
			});
			$("#admin-5").click(function() {
				window.location.href = 'Controller?command=admin_page5&companyIdx='+${companyIdx}+'&memberIdx='+${memberIdx};
			});
			$("#admin-6").click(function() {
				window.location.href = 'Controller?command=admin_page6&companyIdx='+${companyIdx}+'&memberIdx='+${memberIdx};
			});
			$("#admin-7").click(function() {
				window.location.href = 'Controller?command=admin_page7&companyIdx='+${companyIdx}+'&memberIdx='+${memberIdx};
			});
			$("#admin-9").click(function() {
				window.location.href = 'Controller?command=admin_page9&companyIdx='+${companyIdx}+'&memberIdx='+${memberIdx};
			});
			$("#admin-10").click(function() {
				window.location.href = 'Controller?command=admin_page10&companyIdx='+${companyIdx}+'&memberIdx='+${memberIdx};
			});
			$("#admin-11").click(function() {
				window.location.href = 'Controller?command=admin_page11&companyIdx='+${companyIdx}+'&memberIdx='+${memberIdx};
			});
			$("#admin-12").click(function() {
				window.location.href = 'Controller?command=admin_page12&companyIdx='+${companyIdx}+'&memberIdx='+${memberIdx};
			});
			$("#admin-13").click(function() {
				window.location.href = 'Controller?command=admin_page13&companyIdx='+${companyIdx}+'&memberIdx='+${memberIdx};
			});
			$("#admin-14").click(function() {
				window.location.href = 'Controller?command=admin_page14&companyIdx='+${companyIdx}+'&memberIdx='+${memberIdx};
			});
			$("#admin-15").click(function() {
				window.location.href = 'Controller?command=admin_page15&companyIdx='+${companyIdx}+'&memberIdx='+${memberIdx};
			});
			/*공개 프로젝트 선택*/
			$(".row-target").click(function() {
				_this = $(this).data("idx");
				$.ajax({
					type: 'post',
					url: 'openProjectSelectAjaxServlet',
					data: {"companyIdx":${companyIdx}, "projectIdx":_this},
					success: function(data) {
						console.log(data);
						$("#openProjectCategorySelect").val(data.categoryIdx);
						$("#openProjectNameInput").val(data.pName);
						$(".openProjectAdminTr").remove();
						for(let i=0; i<=data.adminList.length-1; i++){
							let newTr = '<tr class="openProjectAdminTr" data-idx="'+data.adminList[i].memberIdx+'">' +
											'<td>'+data.adminList[i].name+'</td>' +
											'<td>'+data.adminList[i].email+'</td>' +
											'<td>'+data.adminList[i].departmentName+'</td>' +
											'<td>'+data.adminList[i].phone+'</td>' +
											'<td><span class="adminClearBtn">[해제]</span></td>' +
										'</tr>';
							$("#release-prj-info-table2").append(newTr);
						}
						$('input[name="writingGrant"][value="'+data.writingGrant+'"]').prop('checked', true);
						$('input[name="commentGrant"][value="'+data.commentGrant+'"]').prop('checked', true);
						$('input[name="postViewGrant"][value="'+data.postViewGrant+'"]').prop('checked', true);
						$('input[name="postViewGrant"][value="0"]').prop('disabled', true);
						$('input[name="postViewGrant"][value="1"]').prop('disabled', true);
						$('input[name="editPostGrant"][value="'+data.editPostGrant+'"]').prop('checked', true);
						_prevCategoryIdx = data.categoryIdx;
						_prevWritingGrant = data.writingGrant;
					},
					error: function(r, s, e) {
						console.log(r.status);
						console.log(r.responseText);
						console.log(e);
					}
				})
				$(".release-prj-info-bg").css('display', 'flex');
			});
			/*프로젝트 수정창에서 관리자 해제버튼 클릭*/
			$(document).on("click", ".adminClearBtn", function() {
				let memberIdx = $(this).parent().parent().data("idx");
				let trCnt = $(".openProjectAdminTr").length;
				if(trCnt == 1){
					alert("※ 최소 1명 이상의 관리자가 필요합니다.");
				}else{
					$.ajax({
						type: 'post',
						url: 'notAdminProjectMemberSelectAjaxServlet',
						data: {"companyIdx":${companyIdx}, "projectIdx":_this, "memberIdx":memberIdx},
						success: function(data) {
							console.log(data);
							$(".openProjectAdminTr").remove();
							for(let i=0; i<=data.length-1; i++){
								let newTr = '<tr class="openProjectAdminTr" data-idx="'+data[i].idx+'">' +
												'<td>'+data[i].name+'</td>' +
												'<td>'+data[i].email+'</td>' +
												'<td>'+data[i].departmentName+'</td>' +
												'<td>'+data[i].phone+'</td>' +
												'<td><span class="adminClearBtn">[해제]</span></td>' +
											'</tr>';
								$("#release-prj-info-table2").append(newTr);
							}
						},
						error: function(r, s, e) {
							console.log(r.status);
							console.log(r.responseText);
							console.log(e);
						}
					});
				}
			})
			/*공개 프로젝트 정보창 닫기&취소*/
			$("#release-prj-info-close-btn").click(function() {
				$(".release-prj-info-bg").css('display', 'none');
			});
			$("#release-prj-info-cancel-btn").click(function() {
				$(".release-prj-info-bg").css('display', 'none');
			});
			/*공개 프로젝트 정보 수정버튼 클릭*/
			$("#release-prj-info-alter-btn").click(function() {
				let categoryIdx = $("#release-prj-info-table1").find('select').val();
				let pName = $("#release-prj-info-table1").find('input[type="text"]').val();
				let writingGrant = $('input[name="writingGrant"]:checked').val();
				let commentGrant = $('input[name="commentGrant"]:checked').val();
				let postViewGrant = $('input[name="postViewGrant"]:checked').val();
				let editPostGrant = $('input[name="editPostGrant"]:checked').val();
				$.ajax({
					type: 'post',
					url: 'openProjectAlterAjaxServlet',
					data: {
						"categoryIdx":categoryIdx,
						"projectIdx":_this,
						"pName":pName,
						"writingGrant":writingGrant,
						"commentGrant":commentGrant,
						"postViewGrant":postViewGrant,
						"editPostGrant":editPostGrant,
						"prevWritingGrant":_prevWritingGrant,
						"prevCategoryIdx":_prevCategoryIdx,
						"companyIdx":${companyIdx},
						"changerIdx":${memberIdx}
					},
					success: function() {
						alert("공개 프로젝트 정보가 수정되었습니다.");
						location.reload();
					},
					error: function(r, s, e) {
						console.log(r.status);
						console.log(r.responseText);
						console.log(e);
					}
				})
				
				// $(".release-prj-info-bg").css('display', 'none');
			});
			/*관리자 추가버튼 클릭*/
			$("#release-prj-info-table1 button").click(function() {
				$.ajax({
					type: 'post',
					url: 'notAdminProjectMemberListAjaxServlet',
					data: {"projectIdx":_this},
					success: function(data) {
						console.log(data);
						$(".addAdminTr").remove();
						for(let i=0; i<=data.length-1; i++){
							let newTr = '<tr class="addAdminTr" data-idx="'+data[i].idx+'">' +
											'<td>'+data[i].name+'</td>' +
											'<td>'+data[i].email+'</td>' +
											'<td><span class="admin-select">[선택]</span></td>' +
										'</tr>';
							
							$("#release-prj-add-admin-table2").append(newTr);
						}
					},
					error: function(r, s, e) {
						console.log(r.status);
						console.log(r.responseText);
						console.log(e);
					}
				})
				$(".release-prj-add-admin-bg").css('display', 'flex');
			});
			/*관리자 선택창에서 선택버튼 클릭*/
			$(document).on("click", ".admin-select", function() {
				let memberIdx = $(this).parent().parent().data("idx");
				$.ajax({
					type: 'post',
					url: 'notAdminProjectMemberSelectAjaxServlet',
					data: {"companyIdx":${companyIdx}, "projectIdx":_this, "memberIdx":memberIdx},
					success: function(data) {
						console.log(data);
						$(".openProjectAdminTr").remove();
						for(let i=0; i<=data.length-1; i++){
							let newTr = '<tr class="openProjectAdminTr" data-idx="'+data[i].idx+'">' +
											'<td>'+data[i].name+'</td>' +
											'<td>'+data[i].email+'</td>' +
											'<td>'+data[i].departmentName+'</td>' +
											'<td>'+data[i].phone+'</td>' +
											'<td><span class="adminClearBtn">[해제]</span></td>' +
										'</tr>';
							$("#release-prj-info-table2").append(newTr);
						}
					},
					error: function(r, s, e) {
						console.log(r.status);
						console.log(r.responseText);
						console.log(e);
					}
				})
				$(".release-prj-add-admin-bg").css('display', 'none');
			})
			/*관리자 선택창 닫기&취소*/
			$("#release-prj-add-admin-cancel-btn").click(function() {
				$(".release-prj-add-admin-bg").css('display', 'none');
			});
			$("#release-prj-add-admin-close-btn").click(function() {
				$(".release-prj-add-admin-bg").css('display', 'none');
			});
			/*공개 프로젝트 삭제버튼 클릭*/
			$("#release-prj-info-del-btn").click(function() {
				$(".release-prj-del-bg").css('display', 'flex');
			});
			/*공개 프로젝트 삭제창 닫기&취소*/
			$("#release-prj-del-close-btn").click(function() {
				$(".release-prj-del-bg").css('display', 'none');
			});
			$("#release-prj-del-cancel-btn").click(function() {
				$(".release-prj-del-bg").css('display', 'none');
			});
			/*관리자 선택창에서 멤버 검색하기*/
			$("#adminSearchBtn").click(function() {
				let standard = $("#memberSearchSelect").val();
				let str = $("#adminSearchInput").val();
				$.ajax({
					type: 'post',
					url: 'notAdminProjectMemberSearchAjaxServlet',
					data: {"projectIdx":_this, "standard":standard, "str":str},
					success: function(data) {
						console.log(data);
						$(".addAdminTr").remove();
						for(let i=0; i<=data.length-1; i++){
							let newTr = '<tr class="addAdminTr" data-idx="'+data[i].idx+'">' +
											'<td>'+data[i].name+'</td>' +
											'<td>'+data[i].email+'</td>' +
											'<td><span class="admin-select">[선택]</span></td>' +
										'</tr>';
							
							$("#release-prj-add-admin-table2").append(newTr);
						}
					},
					error: function(r, s, e) {
						console.log(r.status);
						console.log(r.responseText);
						console.log(e);
					}
				})
			})
			/*공개 프로젝트 삭제창에서 확인버튼 클릭*/
			$("#release-prj-del-check-btn").click(function() {
				$.ajax({
					type: 'post',
					url: 'ProjectDeleteAjaxServlet',
					data: {"projectIdx":_this, "memberIdx":${memberIdx}},
					success: function() {
						alert("공개 프로젝트가 삭제 되었습니다.");
						location.reload();
					},
					error: function(r, s, e) {
						console.log(r.status);
						console.log(r.responseText);
						console.log(e);
					}
				})
			})
			/*공개 프로젝트 검색버튼 클릭*/
			$("#openProjectSearchBtn").click(function() {
				let str = $(this).prev().val();
				$.ajax({
					type: 'post',
					url: 'openProjectSearchAjaxServlet',
					data: {"companyIdx":${companyIdx}, "str":str},
					success: function(data) {
						console.log(data);
						$(".row-target").remove();
						if(data.length != 0){
							for(let i=0; i<=data.length-1; i++){
								let newTr = '<tr class="row-target" data-idx="'+data[i].idx+'">' +
												'<td>'+data[i].categoryName+'</td>' +
												'<td style="text-align: left;">'+data[i].pName+'</td>' +
												'<td>'+data[i].pmCnt+'</td>' +
												'<td>'+data[i].boardCnt+'</td>' +
												'<td>'+data[i].commentCnt+'</td>' +
												'<td>'+data[i].lastActivity+'</td>' +
												'<td>'+data[i].openDate+'</td>' +
											'</tr>';
								
								$("#openProjectListTable").append(newTr);
							}
						}else{
							let newTr = '<tr class="row-target">' +
											'<td colspan="7">검색 결과가 없습니다.</td>' +
										'</tr>';
							
							$("#openProjectListTable").append(newTr);
						}
					},
					error: function(r, s, e) {
						console.log(r.status);
						console.log(r.responseText);
						console.log(e);
					}
				})
			})
		});
	</script>
<style>
	*{
		padding: 0;
		margin: 0;
		box-sizing: border-box;
		border: none;
		letter-spacing: -0.7px;
	}
	.all-container{
		position: relative;
		display: flex;
	}
	body{
		overflow-y: hidden;
	}
	.side-box{
		position: relative;
		background-color: #52545b;
		width: 260px;
		height: 920px;
	}
	.side-head{
		width: 260px;
		height: 60px;
		z-index: 999;
		padding: 18px 0px;
		background-color: #3D4044;
	}
	.logo-box{
		height: 28.86px;
		margin: 0px 0px 0px 30px;
	}
	.logo-box > img {
		width: 128px;
		height: 28.86px;
	}
	.side-foot{
		position: absolute;
		left: 0;
		bottom: 0;
		width: 260px;
		height: 65px;
		background-color: #52545b;
		z-index: 10;
	}
	.side-body{
		width: 260px;
		padding: 25px 10px 25px 30px;
		overflow-y: auto;
		height: 780px;
	}
	h2{
		margin: 0px 0px 7px;
		color: #fff;
		font-size: 15px;
	}
	.h3-box{
		margin: 0px 0px 18px;
		padding: 0px 0px 0px 6px;
	}
	h3{
		color: #BEBEC3;
		font-size: 14px;
		padding: 5px 20px 5px 0px;
		cursor: pointer;
	}
	h3:hover{
		text-decoration: underline;
	}
	.blue-h3{
		color: #7FAEFF;
	}
	.blue-h3:hover{
		text-decoration: none;
	}
	.main-box{
		position: relative;
		padding: 21px 30px 25px 30px;
		width: 100%;
		color: #4F545D;
		font-size: 14px;
	}
	.main-title{
		width: 1600px;
		height: 39px;
		padding-bottom: 14px;
		border-bottom: 1px solid #e6e6e6;
	}
	h1{
		color: #111;
		font-size: 19px;
	}
	select {
		width: 120px;
		height: 32px;
		outline: none;
		cursor: pointer;
		border: 1px solid #E6E6E6;
	}
	.search-box{
		display: flex;
		align-items: center;
		padding: 30px 0 32px;
		width: 1600px;
		height: 50px;
		font-size: 13px;
		color : #333;
	}
	.input-text{
		width: 490px;
		height: 30px;
		padding-left: 10px;
		outline: none;
		border: 1px solid #E6E6E6;
	}
	.input-text::placeholder{
		color: lightgrey;
	}
	.submit-btn{
		padding: 0 20px;
		height: 30px;
		line-height: 28px;
		font-size: 14px;
		border: 1px solid #C5C6CB;
		border-radius: 2px;
		cursor: pointer;
		text-align: center;
		background-color: #FFF;
	}
	.submit-btn:hover{
		color: #000;
		border-color: #999aa0;
		font-weight: bold;
	}
	table{
		width: 1600px;
		border: 1px solid #E1E1E2;
		text-align: center;
		color: #111;
		border-collapse: collapse;
		font-size: 13px;
	}
	th{
		width: 14.3%;
		height: 37px;
		background: #F9F9FB;
		border: 1px solid #E1E1E2;
	}
	td{
		padding: 8px;
		height: 10%;
		border: 1px solid #E1E1E2;
	}
	.row-target{
		cursor: pointer;
	}
	.row-target:hover{
		background-color: #ECECEF;
	}
	.release-prj-info-bg{
		position: absolute;
		display: flex;
		width: 100%;
		height: 100%;
		justify-content: center;
		align-items: center;
		z-index: 999;
		background: rgb(0, 0, 0, .3);
	}
	#release-prj-info-box{
		position: relative;
		width: 900px;
		height: 567px;
		background-color: #FFF;
	}
	#release-prj-info-top{
		width: 900px;
		height: 68px;
		padding: 25px 30px 0;
	}
	#release-prj-info-header{
		width: 840px;
		height: 43px;
		padding-bottom: 14px;
		font-size: 19px;
		color: #111;
		font-weight: 700;
		border-bottom: 1px solid #e6e6e6;
	}
	#release-prj-info-close-btn{
		position: absolute;
		top: 20px;
		right: 30px;
		width: 30px;
		height: 30px;
		cursor: pointer;
		background: url(https://flow.team/design2/flow_admin_2019/img/btn_popclose.gif) no-repeat center;
	}
	#release-prj-info-body{
		width: 900px;
		height: 469px;
		margin-bottom: 30px;
		padding: 0 30px;
		overflow-y: auto;
		overflow-x: hidden;
	}
	#release-prj-info-table1{
		width: 840px;
		border-collapse: collapse;
		border: none;
		text-align: left;
		margin-top: 10px;
	}
	#release-prj-info-table1 th{
		width: 150px;
		height: 43px;
		padding: 5px 0 6px;
		color: #4f545d;
		background-color: #FFF;
		border: none;
	}
	#release-prj-info-table1 td{
		width: 683px;
		font-size: 13px;
		padding: 5px 0 6px;
		border: none;
	}
	#release-prj-info-table1 input[type="text"]{
		width: 673px;
		height: 30px;
		background-color: #FFF;
		padding-left: 10px;
		font-size: 13px;
		border: 1px solid #e6e6e6;
		border-radius: 1px;
		outline: none;
	}
	#release-prj-info-table1 select{
		width: 72px;
		height: 32px;
		color: #333;
		font-size: 13px;
		border: 1px solid #e6e6e6;
		border-radius: 1px;
		outline: none;
	}
	#release-prj-info-table1 button{
		padding: 0 12px;
		height: 28px;
		line-height: 24px;
		cursor: pointer;
		font-size: 13px;
		font-weight: bold;
		border: 1px solid #c5c6cb;
		border-radius: 2px;
		text-align: center;
		background-color: #FFF;
	}
	#release-prj-info-table1 button:hover{
		color: #000;
		border-color: #999aa0;
	}
	#release-prj-info-table2{
		width: 840px;
		border-collapse: collapse;
		margin-top: 5px;
	}
	#release-prj-info-table2 th{
		height: 31px;
		background-color: #f9f9fb;
		padding: 5px 0 6px;
		color: #111;
		font-size: 13px;
	}
	#release-prj-info-table2 td{
		height: 49px;
		color: #111;
		font-size: 13px;
		padding: 8px;
	}
	#release-prj-info-table2 span{
		cursor: pointer;
	}
	#release-prj-info-table2 span:hover{
		font-weight: bold;
		text-decoration: underline;
	}
	#release-prj-info-table3{
		width: 840px;
		border-collapse: collapse;
		border: none;
		text-align: left;
		margin-top: 10px;
	}
	#release-prj-info-table3 th{
		width: 150px;
		height: 32px;
		font-size: 14px;
		padding: 5px 0 6px;
		background-color: #FFF;
		border: none;
	}
	#release-prj-info-table3 td{
		width: 683px;
		color: #4f545d;
		font-size: 13px;
		padding: 5px 0 6px;
		border: none;
	}
	#release-prj-info-table3 span {
		color: red;
	}
	#release-prj-info-table3 input[type="radio"]{
		cursor: pointer;
		width: 16px;
		height: 16px;
	}
	#release-prj-info-footer{
		position: relative;
		width: 833px;
		height: 36px;
		margin-top: 15px;
		text-align: center;
	}
	#release-prj-info-del-btn{
		position: absolute;
		bottom: 0;
		left: 0;
		cursor: pointer;
		width: 100px;
		height: 36px;
		line-height: 34px;
		font-size: 16px;
		color: #FFF;
		background: #d03737;
		border-radius: 2px;
		text-align: center;
	}
	#release-prj-info-alter-btn{
		cursor: pointer;
		color: #FFF;
		border: 1px solid #307cff;
		border-radius: 3px;
		background-color: #307cff;
		width: 120px;
		height: 36px;
		line-height: 34px;
		font-size: 16px;
		text-align: center;
		margin-right: 10px;
	}
	#release-prj-info-cancel-btn{
		cursor: pointer;
		width: 120px;
		height: 36px;
		line-height: 34px;
		font-size: 16px;
		color: #4c4c4c;
		border: 1px solid #c5c6cb;
		border-radius: 3px;
		text-align: center;
		background-color: #FFF;
	}
	.release-prj-add-admin-bg{
		position: absolute;
		display: flex;
		justify-content: center;
		align-items: center;
		z-index: 999;
		width: 100%;
		height: 100%;
		background: rgb(0, 0, 0, .6);
	}
	#release-prj-add-admin-box{
		width: 570px;
		height: 460px;
		padding-bottom: 20px;
		background-color: #FFF;
		border-radius: 5px;
	}
	#release-prj-add-admin-top{
		position: relative;
		display: flex;
		flex-direction: column;
		justify-content: space-between;
		width: 510px;
		height: 106px;
		margin: 25px 30px 0;
		padding-bottom: 14px;
		border-bottom: 1px solid #e6e6e6;
	}
	#release-prj-add-admin-header{
		width: 510px;
		height: 28px;
		color: #111;
		font-size: 19px;
		font-weight: 300;
	}
	#release-prj-add-admin-close-btn{
		position: absolute;
		top: 0;
		right: 0;
		cursor: pointer;
		width: 20px;
		height: 20px;
		background: url(https://flow.team/js/admin/assets/img/btn_popclose.gif);
	}
	#release-prj-add-admin-table1{
		border-collapse: collapse;
		border: none;
		width: 510px;
		height: 43px;
		text-align: left;
	}
	#release-prj-add-admin-table1 td{
		height: 43px;
		padding: 5px 0 6px;
		font-size: 13px;
		color: #4f545d;
		border: none;
	}
	#release-prj-add-admin-table1 select{
		width: 60px;
		height: 32px;
		font-size: 13px;
		border: 1px solid #e6e6e6;
		border-radius: 1px;
		color: #333;
		outline: none;
	}
	#release-prj-add-admin-table1 input[type="text"]{
		width: 150px;
		height: 30px;
		font-size: 13px;
		border: 1px solid #e6e6e6;
		border-radius: 1px;
		outline: none;
		padding-left: 10px;
	}
	#release-prj-add-admin-table1 button{
		cursor: pointer;
		padding: 0 20px;
		height: 30px;
		line-height: 28px;
		font-size: 14px;
		color: #3d4044;
		font-weight: bold;
		border: 1px solid #c5c6cb;
		border-radius: 2px;
		text-align: center;
		background-color: #FFF;
	}
	#release-prj-add-admin-table1 button:hover{
		color: #000;
		border-color: #999aa0;
	}
	#release-prj-add-admin-table2{
		width: 510px;
		border-collapse: collapse;
		margin: 20px auto;
	}
	#release-prj-add-admin-table2 th{
		height: 37px;
		font-size: 13px;
		color: #111;
		text-align: center;
	}
	#release-prj-add-admin-table2 td{
		height: 33px;
		padding: 8px;
		line-height: 16px;
		font-size: 13px;
		color: #111;
		border: 1px solid #e1e1e2;
	}
	#release-prj-add-admin-table2 span{
		cursor: pointer;
	}
	#release-prj-add-admin-table2 span:hover{
		font-weight: bold;
		text-decoration: underline;
	}
	#release-prj-add-admin-body{
		width: 510px;
		height: 256px;
		overflow: auto;
		border-bottom: 1px solid #e6e6e6;
		margin: 0 auto;
	}
	#release-prj-add-admin-footer{
		width: 570px;
		height: 36px;
		margin-top: 15px;
		text-align: center;
	}
	#release-prj-add-admin-check-btn{
		cursor: pointer;
		color: #FFF;
		border: 1px solid #307cff;
		border-radius: 3px;
		background-color: #307cff;
		width: 120px;
		height: 36px;
		line-height: 34px;
		font-size: 16px;
		text-align: center;
	}
	#release-prj-add-admin-cancel-btn{
		cursor: pointer;
		width: 120px;
		height: 36px;
		line-height: 34px;
		font-size: 16px;
		color: #4c4c4c;
		border: 1px solid #c5c6cb;
		border-radius: 3px;
		text-align: center;
		margin-left: 15px;
		background-color: #FFF;
	}
	.release-prj-del-bg{
		position: absolute;
		display: flex;
		justify-content: center;
		align-items: center;
		z-index: 999;
		width: 100%;
		height: 100%;
		background: rgb(0, 0, 0, .6);
	}
	#release-prj-del-box{
		width: 380px;
		height: 153px;
		background-color: #FFF;
		border-radius: 7px;
	}
	#release-prj-del-top{
		position: relative;
		width: 380px;
		height: 43px;
		background-color: #f4f4f4;
		border-radius: 7px 7px 0 0;
	}
	#release-prj-del-close-btn{
		position: absolute;
		top: 15px;
		right: 15px;
		width: 14px;
		height: 14px;
		background: url(https://flow.team/design2/img_rn/btn/btn_layerstyle4_close2.png?1);
		cursor: pointer;
	}
	#release-prj-del-body{
		width: 380px;
		height: 110px;
		padding: 20px;
	}
	#release-prj-del-body p{
		color: #4f545d;
		font-size: 14px;
		text-align: center;
	}
	#release-prj-del-btn-box{
		width: 340px;
		height: 50px;
		padding-top: 20px;
		text-align: center;
	}
	#release-prj-del-cancel-btn{
		width: 153px;
		height: 30px;
		font-size: 14px;
		color: #4c4c4c;
		font-weight: bold;
		border: 1px solid rgb(201, 201, 201);
		border-radius: 2px;
		background: #FFF;
		margin-right: 10px;
		cursor: pointer;
	}
	#release-prj-del-check-btn{
		width: 153px;
		height: 30px;
		font-size: 14px;
		color: #FFF;
		border: 1px solid rgb(201, 201, 201);
		background-color: rgb(48, 124, 255);
		font-weight: bold;
		border-radius: 2px;
		cursor: pointer;
	}
</style>
</head>
<body>
	<div class="all-container">
		<div class="release-prj-info-bg" style="display: none">
			<div id="release-prj-info-box">
				<div id="release-prj-info-top">
					<div id="release-prj-info-header">
						공개 프로젝트 정보
						<div id="release-prj-info-close-btn"></div>
					</div>
				</div>
				<div id="release-prj-info-body">
					<table id="release-prj-info-table1">
						<tr>
							<th>카테고리</th>
							<td>
								<select id="openProjectCategorySelect">
									<c:forEach var="dto" items="${categoryList }">
										<option value="${dto.categoryIdx }">${dto.name }</option>
									</c:forEach>
								</select>
							</td>
						</tr>
						<tr>
							<th>프로젝트명</th>
							<td><input type="text" id="openProjectNameInput" placeholder="프로젝트명을 입력하세요"/></td>
						</tr>
						<tr>
							<th>관리자</th>
							<td><button>추가</button></td>
						</tr>
					</table>
					<table id="release-prj-info-table2">
						<tr>
							<th>관리자 이름</th>
							<th>이메일</th>
							<th>부서</th>
							<th>휴대폰 번호</th>
							<th>관리자</th>
						</tr>
					</table>
					<table id="release-prj-info-table3">
						<tr>
							<th>글 작성 권한</th>
							<td><label><input type="radio" name="writingGrant" value="0" checked/>&nbsp;전체</label>&nbsp;&nbsp;<label><input type="radio" name="writingGrant" value="1"/>&nbsp;관리자만 글 작성 가능</label></td>
						</tr>
						<tr>
							<th>댓글 작성</th>
							<td><label><input type="radio" name="commentGrant" value="0" checked/>&nbsp;전체</label>&nbsp;&nbsp;<label><input type="radio" name="commentGrant" value="1"/>&nbsp;관리자만</label></td>
						</tr>
						<tr>
							<th>글 조회</th>
							<td><label><input type="radio" name="postViewGrant" value="0" checked/>&nbsp;전체</label>&nbsp;&nbsp;<label><input type="radio" name="postViewGrant" value="1"/>&nbsp;관리자 + 글 작성 본인만</label>&nbsp;<span>※ 등록된 게시물의 조회 권한은 변경되지 않음(직접 변경 필요)</span></td>
						</tr>
						<tr>
							<th>글 수정</th>
							<td><label><input type="radio" name="editPostGrant" value="0"/>&nbsp;전체</label>&nbsp;&nbsp;<label><input type="radio" name="editPostGrant" value="1" checked/>&nbsp;관리자 + 글 작성 본인만</label>&nbsp;&nbsp;<label><input type="radio" name="editPostGrant" value="2"/>&nbsp;글 작성 본인만</label></td>
						</tr>
					</table>
					<div id="release-prj-info-footer">
						<button id="release-prj-info-del-btn">삭제</button>
						<button id="release-prj-info-alter-btn">수정</button>
						<button id="release-prj-info-cancel-btn">취소</button>
					</div>
				</div>
			</div>
		</div>
		<div class="release-prj-add-admin-bg" style="display: none">
			<div id="release-prj-add-admin-box">
				<div id="release-prj-add-admin-top">
					<div id="release-prj-add-admin-header">
						관리자 선택
						<div id="release-prj-add-admin-close-btn"></div>
					</div>
					<table id="release-prj-add-admin-table1">
						<tr>
							<td style="width: 70px;">
								<select id="memberSearchSelect">
									<option>이름</option>
									<option>이메일</option>
								</select>
							</td>
							<td style="width: 163px;">
								<input type="text" id="adminSearchInput"/>
							</td>
							<td>
								<button id="adminSearchBtn">검색</button>
							</td>
						</tr>
					</table>
				</div>
				<div id="release-prj-add-admin-body">
					<table id="release-prj-add-admin-table2">
						<tr>
							<th>이름</th>
							<th>이메일</th>
							<th>선택</th>
						</tr>
					</table>
				</div>
				<div id="release-prj-add-admin-footer">
					<button id="release-prj-add-admin-check-btn">확인</button>
					<button id="release-prj-add-admin-cancel-btn">취소</button>
				</div>
			</div>
		</div>
		<div class="release-prj-del-bg" style="display: none">
			<div id="release-prj-del-box">
				<div id="release-prj-del-top"><div id="release-prj-del-close-btn"></div></div>
				<div id="release-prj-del-body">
					<p>공개 프로젝트를 삭제하시겠습니까?</p>
					<div id="release-prj-del-btn-box">
						<button id="release-prj-del-cancel-btn">취소</button>
						<button id="release-prj-del-check-btn">확인</button>
					</div>
				</div>
			</div>
		</div>
		<div class="side-box">
			<div class="side-head">
				<div class="logo-box"><img src="https://flow.team/flow-renewal/assets/images/flow-logo-w.svg" alt="flow"></div>
			</div>
			<div class="side-body">
				<div class="scroll-menu">
					<h2>회사</h2>
					<div class="h3-box">
						<h3 id="admin-1">회사 정보</h3>
						<h3 id="admin-2">구성원 관리</h3>
						<h3 id="admin-3">구성원 초대</h3>
						<h3 id="admin-4"  style="display:none">조직도 관리</h3>
						<h3 id="admin-5">회사 바로가기 관리</h3>
					</div>
					<h2>프로젝트</h2>
					<div class="h3-box">
						<h3 id="admin-6">프로젝트 관리</h3>
						<h3 id="admin-7">회사 프로젝트 관리</h3>
						<h3 class="blue-h3">공개 프로젝트 관리</h3>
						<h3 id="admin-9">공개 프로젝트 카테고리</h3>
						<h3 id="admin-10">비활성화 프로젝트 관리</h3>
					</div>
					<h2>통계/리포트</h2>
					<div class="h3-box">
						<h3 id="admin-11">접속 통계</h3>
						<h3 id="admin-12">사용 통계</h3>
					</div>
					<h2>로그</h2>
					<div class="h3-box">
						<h3 id="admin-13">파일 다운로드 이력</h3>
						<h3 id="admin-14">관리자 변경 이력</h3>
					</div>
					<h2>감사</h2>
					<div class="h3-box">
						<h3 id="admin-15">채팅 감사</h3>
					</div>
				</div>
			</div>
			<div class="side-foot">
				<div class="footer"></div>
			</div>
		</div>
		<div class="main-box">
			<div class="main-title"><h1>공개 프로젝트 관리</h1></div>
			<div class="search-box">
				<form>
					<select>
						<option>프로젝트명</option>
					</select>
					<input type="text" name="input-text" class="input-text" placeholder="검색어를 입력해주세요"/>
					<input type="button" value="검색" id="openProjectSearchBtn" class="submit-btn"/>
				</form>
			</div>
			<table id="openProjectListTable">
				<tr>
					<th>카테고리명</th>
					<th>프로젝트명</th>
					<th>참여자</th>
					<th>게시물</th>
					<th>댓글</th>
					<th>최근 활동일</th>
					<th>개설일</th>
				</tr>
				<c:forEach var="dto" items="${openProjectList }">
					<tr class="row-target" data-idx="${dto.projectIdx }">
						<td>${dto.categoryName }</td>
						<td style="text-align: left;">${dto.pName }</td>
						<td>${dto.memberCnt }</td>
						<td>${dto.boardCnt }</td>
						<td>${dto.commentCnt }</td>
						<td>${dto.lastActivity }</td>
						<td>${dto.opDate }</td>
					</tr>
				</c:forEach>
				<c:choose>
					<c:when test="${openProjectList.size() == 0 }">
						<tr class="row-target">
							<td colspan="7">검색 결과가 없습니다.</td>
						</tr>
					</c:when>
				</c:choose>
			</table>
			<div class="back-wrqp">
				
			</div>
		</div>
	</div>
</body>
</html>