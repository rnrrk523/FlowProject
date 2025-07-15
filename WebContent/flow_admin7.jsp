<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="dto.CompanyProjectDto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.ProjectDao"%>
<%@page import="dto.MemberCompanyDepartmentDto"%>
<%@page import="dao.MemberDao"%>
<%-- <%
	int memberIdx = 1;
	int companyIdx = 1;
	MemberDao mDao = new MemberDao();
	MemberCompanyDepartmentDto mDto = mDao.getMemberInfo(memberIdx);
	ProjectDao pDao = new ProjectDao();
	ArrayList<CompanyProjectDto> comProjectList = pDao.getCompanyProjects(companyIdx);
%> --%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회사 프로젝트 관리</title>
	<script src="js/jquery-3.7.1.min.js"></script>
	<script>
		let _this;
		let _prevPName;
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
			$("#admin-8").click(function() {
				window.location.href = 'Controller?command=admin_page8&companyIdx='+${companyIdx}+'&memberIdx='+${memberIdx};
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
			/*회사 프로젝트 추가 클릭*/
			$(".add-btn").click(function() {
				$("#com-prj-name-input").val("");
				$('input[type="radio"][value="0"]').prop('checked', true);
				$('input[name="add-edit_post_grant"][value="1"]').prop('checked', true);
				$(".add-com-prj-bg").css('display', 'flex');
			});
			/*회사 프로젝트 추가창에서 저장버튼 클릭*/
			$("#add-com-prj-record-btn").click(function() {
				let addName = $("#com-prj-name-input").val();
				if(addName == "") {
					alert("프로젝트명을 입력하세요.");
					return;
				}
				let addWritingGrant = $('input[name="add-writing_grant"]:checked').val();
				let addCommentGrant = $('input[name="add-comment_grant"]:checked').val();
				let addPostViewGrant = $('input[name="add-post_view_grant"]:checked').val();
				let addEditPostGrant = $('input[name="add-edit_post_grant"]:checked').val();
				
				$.ajax({
					type: 'post',
					url: 'addComProjectAjaxServlet',
					data: {
						"companyIdx":${companyIdx},
						"memberIdx":${memberIdx},
						"pName":addName,
						"writingGrant":addWritingGrant,
						"commentGrant":addCommentGrant,
						"postViewGrant":addPostViewGrant,
						"editPostGrant":addEditPostGrant
					},
					success: function() {
						alert("회사 프로젝트가 등록되었습니다.");
						location.reload();
					},
					error: function(r, s, e) {
						
					}
				});
			})
			/*회사 프로젝트 정보창 닫기&취소*/
			$("#add-com-prj-close-btn").click(function() {
				$(".add-com-prj-bg").css('display', 'none');
			});
			$("#add-com-prj-cancel-btn").click(function() {
				$(".add-com-prj-bg").css('display', 'none');
			});
			/*프로젝트 선택*/
			$(document).on("click", ".row-target", function() {
				_this = $(this).data("idx");
				_prevPName = $(this).find('td:nth-child(3)').text();
				let projectIdx = $(this).data("idx");
				$.ajax({
					type: 'post',
					url: 'showProjectInfoAjaxServlet',
					data: {"projectIdx":projectIdx},
					success: function(data) {
						console.log(data);
						$("#select-com-prj-name-input").val(data.pName);
						$('input[name="writing_grant"][value="'+data.writingGrant+'"]').prop('checked', true);
						$('input[name="comment_grant"][value="'+data.commentGrant+'"]').prop('checked', true);
						$('input[name="post_view_grant"][value="'+data.postViewGrant+'"]').prop('checked', true);
						$('input[name="edit_post_grant"][value="'+data.editPostGrant+'"]').prop('checked', true);
					},
					error: function(r, s, e) {
						console.log(r.status);
						console.log(r.responseText);
						console.log(e);
					}
				})
				$.ajax({
					type: 'post',
					url: 'comProjectAdminAjaxServlet',
					data: {"companyIdx":${companyIdx}, "projectIdx":projectIdx},
					success: function(data) {
						console.log(data);
						$(".adminTr").remove();
						for(let i=0; i<=data.length-1; i++) {
							let newTr = '<tr class="adminTr" data-idx="'+data[i].idx+'">' +
											'<td>'+data[i].name+'</td>' +
											'<td>'+data[i].email+'</td>' +
											'<td>'+data[i].departmentName+'</td>' +
											'<td>'+data[i].phone+'</td>' +
											'<td><span class="adminClearBtn">[해제]</span></td>' +
										'</tr>';
							$("#select-com-prj-table2").append(newTr);
						}
					},
					error: function(r, s, e) {
						console.log(r.status);
						console.log(r.responseText);
						console.log(e);
					}
				})
				$(".select-com-prj-bg").css('display', 'flex');
			});
			/*회사 프로젝트 수정창에서 관리자 해제버튼 클릭*/
			$(document).on("click", ".adminClearBtn", function() {
				let trCnt = $(".adminTr").length;
				let idx = $(this).parent().parent().data("idx");
				if(trCnt == 1){
					alert("※ 최소 1명 이상의 관리자가 필요합니다.");
				}else{
					$.ajax({
						type: 'post',
						url: 'comProjectAdminAddSelectAjaxServlet',
						data: {"projectIdx":_this, "memberIdx":idx},
						success: function() {
							$.ajax({
								type: 'post',
								url: 'comProjectAdminAjaxServlet',
								data: {"companyIdx":${companyIdx}, "projectIdx":_this},
								success: function(data) {
									console.log(data);
									$(".adminTr").remove();
									for(let i=0; i<=data.length-1; i++) {
										let newTr = '<tr class="adminTr" data-idx="'+data[i].idx+'">' +
														'<td>'+data[i].name+'</td>' +
														'<td>'+data[i].email+'</td>' +
														'<td>'+data[i].departmentName+'</td>' +
														'<td>'+data[i].phone+'</td>' +
														'<td><span class="adminClearBtn">[해제]</span></td>' +
													'</tr>';
										$("#select-com-prj-table2").append(newTr);
									}
								},
								error: function(r, s, e) {
									console.log(r.status);
									console.log(r.responseText);
									console.log(e);
								}
							})
						},
						error: function(r, s, e) {
							console.log(r.status);
							console.log(r.responseText);
							console.log(e);
						}
					})
				}
			})
			/*회사 프로젝트 정보창 닫기&취소*/
			$("#select-com-prj-close-btn").click(function() {
				$(".select-com-prj-bg").css('display', 'none');
			});
			$("#select-com-prj-cancel-btn").click(function() {
				$(".select-com-prj-bg").css('display', 'none');
			});
			/*회사 프로젝트 정보 창 관리자 추가버튼 클릭*/
			$("#select-com-prj-admin-add-btn").click(function() {
				$.ajax({
					type: 'post',
					url: 'comProjectAdminAddAjaxServlet',
					data: {"projectIdx":_this},
					success: function(data) {
						$(".comProjectAdminTr").remove();
						for(let i=0; i<=data.length-1; i++){
							let newTr = '<tr class="comProjectAdminTr" data-idx="'+data[i].idx+'">' +
											'<td>'+data[i].name+'</td>' +
											'<td>'+data[i].email+'</td>' +
											'<td><span class="admin-select">[선택]</span></td>' +
										'</tr>';
							$("#com-add-admin-table2").append(newTr);
						}
					},
					error: function(r, s, e) {
						console.log(r.status);
						console.log(r.responseText);
						console.log(e);
					}
				})
				
				$(".com-add-admin-bg").css('display', 'flex');
			});
			/*관리자 선택창 닫기&취소*/
			$("#com-add-admin-close-btn").click(function() {
				$(".com-add-admin-bg").css('display', 'none');
			});
			$("#com-add-admin-cancel-btn").click(function() {
				$(".com-add-admin-bg").css('display', 'none');
			});
			/*관리자 선택창에서 선택버튼 클릭*/
			$(document).on("click", ".admin-select", function() {
				let memberIdx = $(this).parent().parent().data("idx");
				$.ajax({
					type: 'post',
					url: 'comProjectAdminAddSelectAjaxServlet',
					data: {"projectIdx":_this, "memberIdx":memberIdx},
					success: function() {
						$.ajax({
							type: 'post',
							url: 'comProjectAdminAjaxServlet',
							data: {"companyIdx":${companyIdx}, "projectIdx":_this},
							success: function(data) {
								console.log(data);
								$(".adminTr").remove();
								for(let i=0; i<=data.length-1; i++) {
									let newTr = '<tr class="adminTr" data-idx="'+data[i].idx+'">' +
													'<td>'+data[i].name+'</td>' +
													'<td>'+data[i].email+'</td>' +
													'<td>'+data[i].departmentName+'</td>' +
													'<td>'+data[i].phone+'</td>' +
													'<td><span class="adminClearBtn">[해제]</span></td>' +
												'</tr>';
									$("#select-com-prj-table2").append(newTr);
								}
							},
							error: function(r, s, e) {
								console.log(r.status);
								console.log(r.responseText);
								console.log(e);
							}
						})
					},
					error: function(r, s, e) {
						console.log(r.status);
						console.log(r.responseText);
						console.log(e);
					}
				})
				$(".com-add-admin-bg").css('display', 'none');
			});
			/*회사 프로젝트 삭제버튼 클릭*/
			$("#select-com-prj-del-btn").click(function() {
				$(".com-prj-del-bg").css('display', 'flex');
			});
			/*회사 프로젝트 삭제알림창 닫기&취소*/
			$("#com-prj-del-close-btn").click(function() {
				$(".com-prj-del-bg").css('display', 'none');
			});
			$("#com-prj-del-cancel-btn").click(function() {
				$(".com-prj-del-bg").css('display', 'none');
			});
			/*회사 프로젝트 삭제알림창에서 확인버튼 클릭*/
			$("#com-prj-del-check-btn").click(function() {
				$.ajax({
					type: 'post',
					url: 'ProjectDeleteAjaxServlet',
					data: {
						"projectIdx":_this, 
						"memberIdx":${memberIdx}
					},
					success: function() {
						alert("회사 프로젝트가 삭제 되었습니다.");
						location.reload();
					},
					error: function(r, s, e) {
						console.log(r.status);
						console.log(r.responseText);
						console.log(e);
					}
				})
			})
			/*회사 프로젝트 검색하기*/
			$("#projectSearchbtn").click(function() {
				let str = $(this).prev().val();
				$.ajax({
					type: 'post',
					url: 'companyProjectSearchAjaxServlet',
					data: {"companyIdx":${companyIdx}, "str":str},
					success: function(data) {
						console.log(data);
						$(".row-target").remove();
						if(data.length != 0){
							for(let i=0; i<=data.length-1; i++){
								let newTr = '<tr class="row-target">' +
												'<td>'+data[i].lastActivity+'</td>' +
												'<td>'+data[i].openingDate+'</td>' +
												'<td style="text-align: left;">'+data[i].pName+'</td>' +
												'<td>'+data[i].boardCnt+'</td>' +
												'<td>'+data[i].commentCnt+'</td>' +
												'<td>'+data[i].writer+'</td>' +
											'</tr>';
								$("#companyProjectTable").append(newTr);
							}
						}else{
							let newTr = '<tr class="row-target">' +
											'<td colspan="6">결과값이 존재하지 않습니다.</td>' +
										'</tr>';
							$("#companyProjectTable").append(newTr);
						}
					},
					error: function(r, s, e) {
						console.log(r.status);
						console.log(r.responseText);
						console.log(e);
					}
				})
			});
			/*프로젝트 수정창에서 수정버튼 클릭*/
			$("#select-com-prj-alter-btn").click(function() {
				let pName = $("#select-com-prj-name-input").val();
				let nameChangeYN = pName != _prevPName;
				let writingGrant = $('input[name="writing_grant"]:checked').val();
				let commentGrant = $('input[name="comment_grant"]:checked').val();
				let postViewGrant = $('input[name="post_view_grant"]:checked').val();
				let editPostGrant = $('input[name="edit_post_grant"]:checked').val();
				let normalChangeYN = $('#normalChangeYN').prop('checked') == true ? 'Y' : 'N';
				$.ajax({
					type: 'post',
					url: 'comProjectAlterAjaxServlet',
					data: {
						"projectIdx":_this,
						"pName":pName,
						"writingGrant":writingGrant,
						"commentGrant":commentGrant,
						"postViewGrant":postViewGrant,
						"editPostGrant":editPostGrant,
						"normalChangeYN":normalChangeYN,
						"nameChangeYN":nameChangeYN,
						"prevPName":_prevPName,
						"changerIdx":${memberIdx}
					},
					success: function() {
						alert("회사 프로젝트 정보가 수정되었습니다.");
						location.reload();
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
</head>
<style>
	*{
		padding: 0;
		margin: 0;
		box-sizing: border-box;
		border: none;
		letter-spacing: -0.7px;
	}
	.all-container{
		position: relaive;
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
		border-bottom: 1px solid #E6E6E6;
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
	.add-btn{
		width: 70px;
		padding: 0 15px;
		margin-top: 8px;
		height: 32px;
		line-height: 30px;
		font-weight: bold;
		color: #3D4044;
		cursor: pointer;
		border: 1px solid #C5C6CB;
		border-radius: 2px;
	}
	.add-btn::before{
		content: "+";
	}
	.add-btn:hover{
		color: #000;
		border-color: #999aa0;
	}
	table{
		width: 1600px;
		border: 1px solid #E1E1E2;
		text-align: center;
		color: #111;
		border-collapse: collapse;
		margin-top: 10px;
	}
	th{
		width: 16.6%;
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
	.add-com-prj-bg{
		position: absolute;
		display: flex;
		justify-content: center;
		align-items: center;
		z-index: 999;
		width: 100%;
		height: 100%;
		background-color: rgb(0, 0, 0, .3);
	}
	#add-com-prj-box{
		width: 900px;
		height: 510px;
		background-color: #FFF;
	}
	#add-com-prj-top{
		width: 900px;
		height: 68px;
		padding: 25px 30px 0px;
	}
	#add-com-prj-header{
		display: flex;
		justify-content: space-between;
		align-items: center;
		width: 840px;
		height: 43px;
		padding-bottom: 14px;
		font-weight: 700;
		border-bottom: 1px solid #e6e6e6;
	}
	#add-com-prj-title{
		color: #111;
		font-size: 19px;
		height: 28px;
	}
	#add-com-prj-close-btn{
		width: 30px;
		height: 30px;
		cursor: pointer;
		background: url(https://flow.team/design2/flow_admin_2019/img/btn_popclose.gif) no-repeat center;
	}
	#add-com-prj-body{
		width: 900px;
		padding: 0 30px;
		margin-bottom: 30px;
	}
	#com-prj-info-table1{
		width: 840px;
		border-collapse: collapse;
		border: none;
		text-align: left;
	}
	#com-prj-info-table1 th{
		width: 150px;
		padding: 5px 0 6px;
		font-size: 14px;
		color: #4f545d;
		border: none;
		background-color: #FFF;
	}
	#com-prj-info-table1 td{
		width: 690px;
		padding: 5px 0 6px;
		font-size: 13px;
		color: #4f545d;
		border: none;
	}
	#com-prj-name-input{
		width: 680px;
		height: 30px;
		background-color: #FFF;
		padding-left: 10px;
		outline: none;
		border: 1px solid #e6e6e6;
		border-radius: 1px;
	}
	#com-prj-info-table2{
		width: 840px;
		border-collapse: collapse;
	}
	#com-prj-info-table2 th{
		height: 31px;
		background-color: #f9f9fb;
		padding: 5px 0 6px;
		color: #111;
		font-size: 13px;
	}
	#com-prj-info-table2 td{
		height: 33px;
		color: #111;
		font-size: 13px;
		padding: 8px;
	}
	#com-prj-info-table3{
		width: 840px;
		border-collapse: collapse;
		border: none;
		text-align: left;
	}
	#com-prj-info-table3 th{
		width: 150px;
		height: 32px;
		font-size: 14px;
		background-color: #FFF;
		border:none;
		padding: 5px 0 6px;
		font-weight: bold;
	}
	#com-prj-info-table3 td{
		width: 690px;
		height: 32px;
		color: #4f545d;
		font-size: 13px;
		padding: 5px 0 6px;
		border: none;
	}
	#com-prj-info-table3-span{
		color: red;
		font-size: 13px;
	}
	#add-com-prj-footer{
		text-align: center;
		width: 840px;
		height: 36px;
		margin-top: 15px;
	}
	#add-com-prj-record-btn{
		cursor: pointer;
		color: #FFF;
		border: 1px solid #307cff;
		background-color: #307cff;
		width: 120px;
		height: 36px;
		line-height: 34px;
		font-size: 16px;
		border-radius: 3px;
		text-align: center;
	}
	#add-com-prj-cancel-btn{
		cursor: pointer;
		color: #4c4c4c;
		border: 1px solid #c5c6cb;
		border-radius: 3px;
		text-align: center;
		width: 120px;
		height: 36px;
		line-height: 34px;
		background-color: #FFF;
		margin-left: 15px;
	}
	.select-com-prj-bg{
		position: absolute;
		display: flex;
		justify-content: center;
		align-items: center;
		width: 100%;
		height: 100%;
		background: rgb(0, 0, 0, .3);
		z-index: 999;
	}
	#select-com-prj-box{
		background-color: #FFF;
		width: 900px;
		height: 557px;
	}
	#select-com-prj-top{
		width: 900px;
		height: 68px;
		padding: 25px 30px 0;
	}
	#select-com-prj-header{
		display: flex;
		justify-content: space-between;
		align-items: center;
		width: 840px;
		height: 43px;
		padding-bottom: 14px;
		font-size: 19px;
		color: #111;
		font-weight: 700;
		border-bottom: 1px solid #e6e6e6;
	}
	#select-com-prj-close-btn{
		width: 30px;
		height: 30px;
		cursor: pointer;
		background: url(https://flow.team/design2/flow_admin_2019/img/btn_popclose.gif) no-repeat center;
	}
	#select-com-prj-body{
		width: 900px;
		height: 459px;
		margin-bottom: 30px;
		padding: 0 30px;
		overflow-y: auto;
		overflow-x: hidden;
	}
	#select-com-prj-table1{
		width: 840px;
		border-collapse: collapse;
		border: none;
		text-align: left;
	}
	#select-com-prj-table1 th{
		width: 150px;
		height: 41px;
		padding: 5px 0 6px;
		font-size: 14px;
		font-weight: bold;
		color: #4f545d;
		background-color: #FFF;
		border: none;
	}
	#select-com-prj-table1 td{
		width: 683px;
		padding: 5px 0 6px;
		border: none;
	}
	#select-com-prj-name-input{
		width: 673px;
		height: 30px;
		background-color: #FFF;
		padding-left: 10px;
		font-size: 13px;
		border-radius: 1px;
		border: 1px solid #e6e6e6;
	}
	#select-com-prj-admin-add-btn{
		cursor: pointer;
		color: #3d4044;
		border: 1px solid #c5c6cb;
		padding: 0 12px;
		height: 28px;
		line-height: 24px;
		font-size: 13px;
		font-weight: bold;
		border-radius: 2px;
		text-align: center;
		background-color: #FFF;
	}
	#select-com-prj-admin-add-btn:hover{
		color: #000;
		border: 1px solid #999aa0;
	}
	#select-com-prj-table2{
		width: 840px;
		border-collapse: collapse;
	}
	#select-com-prj-table2 th{
		height: 31px;
		background-color: #f9f9fb;
		padding: 5px 0 6px;
		font-size: 13px;
		color: #111;
	}
	#select-com-prj-table2 td{
		height: 49px;
		color: #111;
		font-size: 13px;
		padding: 8px;
		line-height: 16px;
	}
	#select-com-prj-table2 span{
		cursor: pointer;
	}
	#select-com-prj-table2 span:hover{
		font-weight: bold;
		text-decoration: underline;
	}
	#select-com-prj-table3{
		width: 840px;
		border-collapse: collapse;
		border: none;
		text-align: left;
	}
	#select-com-prj-table3 th{
		background-color: #FFF;
		border: none;
		width: 150px;
		height: 32px;
		font-size: 14px;
		padding: 5px 0 6px;
		color: 4f545d;
	}
	#select-com-prj-table3 td{
		border: none;
		width: 683px;
		color: #4f545d;
		font-size: 13px;
		padding: 5px 0 6px;
	}
	#select-com-prj-table3 span {
		color: red;
		font-size: 13px;
	}
	#select-com-prj-table3 input[type="radio"]{
		width: 16px;
		height: 16px;
	}
	#last-tr{
		border-top: 1px solid black;
	}
	#last-tr input[type="checkbox"]{
		width: 16px;
		height: 16px;
		cursor: pointer;
		border: 1px solid #b2b2b2;
		border-radius: 1px;
	}
	#select-com-prj-footer{
		position: relative;
		width: 833px;
		height: 36px;
		margin-top: 15px;
		text-align: center;
	}
	#select-com-prj-del-btn{
		position: absolute;
		bottom: 0;
		left: 0;
		width: 100px;
		height: 36px;
		line-height: 34px;
		font-size: 16px;
		color: #FFF;
		background-color: #d03737;
		border-radius: 2px;
		text-align: center;
		cursor: pointer;
	}
	#select-com-prj-alter-btn{
		cursor: pointer;
		color: #FFF;
		border: 1px solid #307cff;
		background-color: #307cff;
		width: 120px;
		height: 36px;
		line-height: 36px;
		font-size: 16px;
		border-radius: 3px;
		text-align: center;
	}
	#select-com-prj-cancel-btn{
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
		margin-left: 10px;
	}
	.com-add-admin-bg{
		position: absolute;
		display: flex;
		justify-content: center;
		align-items: center;
		z-index: 999;
		width: 100%;
		height: 100%;
		background: rgb(0, 0, 0, .6);
	}
	#com-add-admin-box{
		width: 570px;
		height: 460px;
		padding-bottom: 20px;
		background-color: #FFF;
		border-radius: 5px;
	}
	#com-add-admin-top{
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
	#com-add-admin-header{
		width: 510px;
		height: 28px;
		color: #111;
		font-size: 19px;
		font-weight: 300;
	}
	#com-add-admin-close-btn{
		position: absolute;
		top: 0;
		right: 0;
		cursor: pointer;
		width: 20px;
		height: 20px;
		background: url(https://flow.team/js/admin/assets/img/btn_popclose.gif);
	}
	#com-add-admin-table1{
		border-collapse: collapse;
		border: none;
		width: 510px;
		height: 43px;
		text-align: left;
	}
	#com-add-admin-table1 td{
		height: 43px;
		padding: 5px 0 6px;
		font-size: 13px;
		color: #4f545d;
		border: none;
	}
	#com-add-admin-table1 select{
		width: 60px;
		height: 32px;
		font-size: 13px;
		border: 1px solid #e6e6e6;
		border-radius: 1px;
		color: #333;
		outline: none;
	}
	#com-add-admin-table1 input[type="text"]{
		width: 150px;
		height: 30px;
		font-size: 13px;
		border: 1px solid #e6e6e6;
		border-radius: 1px;
		outline: none;
		padding-left: 10px;
	}
	#com-add-admin-table1 button{
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
	#com-add-admin-table1 button:hover{
		color: #000;
		border-color: #999aa0;
	}
	#com-add-admin-table2{
		width: 510px;
		border-collapse: collapse;
		margin: 20px auto;
	}
	#com-add-admin-table2 th{
		height: 37px;
		font-size: 13px;
		color: #111;
		text-align: center;
	}
	#com-add-admin-table2 td{
		height: 33px;
		padding: 8px;
		line-height: 16px;
		font-size: 13px;
		color: #111;
		border: 1px solid #e1e1e2;
	}
	#com-add-admin-table2 span{
		cursor: pointer;
	}
	#com-add-admin-table2 span:hover{
		font-weight: bold;
		text-decoration: underline;
	}
	#com-add-admin-body{
		width: 510px;
		height: 256px;
		overflow: auto;
		border-bottom: 1px solid #e6e6e6;
		margin: 0 auto;
	}
	#com-add-admin-footer{
		width: 570px;
		height: 36px;
		margin-top: 15px;
		text-align: center;
	}
	#com-add-admin-check-btn{
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
	#com-add-admin-cancel-btn{
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
	.com-prj-del-bg{
		position: absolute;
		display: flex;
		justify-content: center;
		align-items: center;
		width: 100%;
		height: 100%;
		z-index: 999;
		background: rgb(0, 0, 0, .5);
	}
	#com-prj-del-box{
		width: 380px;
		height: 153px;
		background-color: #FFF;
		border-radius: 7px;
	}
	#com-prj-del-header{
		position: relative;
		width: 380px;
		height: 43px;
		background-color: #f4f4f4;
		border-radius: 7px 7px 0 0;
	}
	#com-prj-del-close-btn{
		position: absolute;
		top: 15px;
		right: 15px;
		width: 14px;
		height: 14px;
		background: url(https://flow.team/design2/img_rn/btn/btn_layerstyle4_close2.png?1);
		cursor: pointer;
	}
	#com-prj-del-body{
		width: 380px;
		height: 110px;
		padding: 20px;
	}
	#com-prj-del-body p{
		text-align: center;
		width: 340px;
		height: 20px;
		font-size: 14px;
	}
	#com-prj-del-footer{
		width: 340px;
		height: 50px;
		padding-top: 20px;
		text-align: center;
	}
	#com-prj-del-cancel-btn{
		width: 153px;
		height: 30px;
		font-size: 14px;
		font-weight: bold;
		border: 1px solid rgb(201, 201, 201);
		border-radius: 2px;
		background-color: #FFF;
		cursor: pointer;
		margin-right: 10px;
	}
	#com-prj-del-check-btn{
		width: 153px;
		height: 30px;
		color: #FFF;
		border: 1px solid rgb(201, 201, 201);
		background-color: rgb(48, 124, 255);
		font-size: 14px;
		font-weight: bold;
		border-radius: 2px;
		cursor: pointer;
	}
</style>
<body>
	<div class="all-container">
		<div class="add-com-prj-bg" style="display: none;">
			<div id="add-com-prj-box">
				<div id="add-com-prj-top">
					<div id="add-com-prj-header">
						<div id="add-com-prj-title">회사 프로젝트 정보</div>
						<div id="add-com-prj-close-btn"></div>
					</div>
				</div>
				<div id="add-com-prj-body">
					<table id="com-prj-info-table1">
						<tr>
							<th>프로젝트명</th>
							<td><input id="com-prj-name-input" type="text" placeholder="프로젝트명을 입력하세요."/></td>
						</tr>
						<tr>
							<th>관리자</th>
							<td></td>
						</tr>
					</table>
					<table id="com-prj-info-table2">
						<tr>
							<th>관리자 이름</th>
							<th>이메일</th>
							<th>부서</th>
							<th>휴대폰 번호</th>
						</tr>
						<tr id="writerTr">
							<td>${mDto.name }</td>
							<td>${mDto.email }</td>
							<td>${mDto.departmentName }</td>
							<td>${mDto.phone }</td>
						</tr>
					</table>
					<table id="com-prj-info-table3">
						<tr>
							<th>글작성 권한</th>
							<td><label><input type="radio" name="add-writing_grant" value="0" checked/>전체</label>&nbsp;&nbsp;<label><input type="radio" name="add-writing_grant" value="1"/>관리자만 글 작성 가능</label></td>
						</tr>
						<tr>
							<th>댓글 작성</th>
							<td><label><input type="radio" name="add-comment_grant" value="0" checked/>전체</label>&nbsp;&nbsp;<label><input type="radio" name="add-comment_grant" value="1"/>관리자만</label></td>
						</tr>
						<tr>
							<th>글 조회</th>
							<td><label><input type="radio" name="add-post_view_grant" value="0" checked/>전체</label>&nbsp;&nbsp;<label><input type="radio" name="add-post_view_grant" value="1"/>관리자 + 글 작성 본인만</label>&nbsp;&nbsp;<span id="com-prj-info-table3-span">※ 등록된 게시물의 조회 권한은 변경되지 않음(직접 변경 필요)</span></td>
						</tr>
						<tr>
							<th>글 수정</th>
							<td><label><input type="radio" name="add-edit_post_grant" value="0"/>전체</label>&nbsp;&nbsp;<label><input type="radio" name="add-edit_post_grant" value="1" checked/>관리자 + 글 작성 본인만</label>&nbsp;&nbsp;<label><input type="radio" name="add-edit_post_grant" value="2"/>글 작성 본인만</label></td>
						</tr>
					</table>
					<div id="add-com-prj-footer">
						<button id="add-com-prj-record-btn">저장</button>
						<button id="add-com-prj-cancel-btn">취소</button>
					</div>
				</div>
			</div>
		</div>
		<div class="select-com-prj-bg" style="display: none;">
			<div id="select-com-prj-box">
				<div id="select-com-prj-top">
					<div id="select-com-prj-header">
						<p>회사 프로젝트 정보</p>
						<div id="select-com-prj-close-btn"></div>
					</div>
				</div>
				<div id="select-com-prj-body">
					<table id="select-com-prj-table1">
						<tr>
							<th>프로젝트명</th>
							<td><input id="select-com-prj-name-input" type="text" placeholder="프로젝트명을 입력하세요"/></td>
						</tr>
						<tr>
							<th>관리자</th>
							<td><button id="select-com-prj-admin-add-btn">추가</button></td>
						</tr>
					</table>
					<table id="select-com-prj-table2">
						<tr>
							<th>관리자 이름</th>
							<th>이메일</th>
							<th>부서</th>
							<th>휴대폰 번호</th>
							<th>관리자</th>
						</tr>
					</table>
					<table id="select-com-prj-table3">
						<tr>
							<th>글 작성 권한</th>
							<td><label><input type="radio" name="writing_grant" value="0" checked/>&nbsp;전체</label>&nbsp;&nbsp;<label><input type="radio" name="writing_grant" value="1"/>&nbsp;관리자만 글 작성 가능</label></td>
						</tr>
						<tr>
							<th>댓글 작성</th>
							<td><label><input type="radio" name="comment_grant" value="0" checked/>&nbsp;전체</label>&nbsp;&nbsp;<label><input type="radio" name="comment_grant" value="1"/>&nbsp;관리자만</label></td>
						</tr>
						<tr>
							<th>글 조회</th>
							<td><label><input type="radio" name="post_view_grant" value="0" checked/>&nbsp;전체</label>&nbsp;&nbsp;<label><input type="radio" name="post_view_grant" value="1"/>&nbsp;관리자만 + 글 작성 본인만</label>&nbsp;&nbsp;<span>※ 등록된 게시물의 조회 권한은 변경되지 않음(직접 변경 필요)</span></td>
						</tr>
						<tr>
							<th>글 수정</th>
							<td><label><input type="radio" name="edit_post_grant" value="0"/>&nbsp;전체</label>&nbsp;&nbsp;<label><input type="radio" name="edit_post_grant" value="1" checked/>&nbsp;관리자만 + 글 작성 본인만</label>&nbsp;&nbsp;<label><input type="radio" name="edit_post_grant" value="2"/>글 작성 본인만</label></td>
						</tr>
						<tr id="last-tr">
							<th>일반 프로젝트 변경</th>
							<td><label><input type="checkbox" id="normalChangeYN"/>&nbsp;&nbsp;<span>※ 회사 프로젝트를 더 이상 운영하지 않을 때 사용합니다 (회사 프로젝트 복원 불가)</span></label></td>
						</tr>
					</table>
					<div id="select-com-prj-footer">
						<button id="select-com-prj-del-btn">삭제</button>
						<button id="select-com-prj-alter-btn">수정</button>
						<button id="select-com-prj-cancel-btn">취소</button>
					</div>
				</div>
			</div>
		</div>
		<div class="com-add-admin-bg" style="display: none;">
			<div id="com-add-admin-box">
				<div id="com-add-admin-top">
					<div id="com-add-admin-header">
						관리자 선택
						<div id="com-add-admin-close-btn"></div>
					</div>
					<table id="com-add-admin-table1">
						<tr>
							<td style="width: 70px;">
								<select>
									<option>이름</option>
									<option>이메일</option>
								</select>
							</td>
							<td style="width: 163px;">
								<input type="text"/>
							</td>
							<td>
								<button>검색</button>
							</td>
						</tr>
					</table>
				</div>
				<div id="com-add-admin-body">
					<table id="com-add-admin-table2">
						<tr>
							<th>이름</th>
							<th>이메일</th>
							<th>선택</th>
						</tr>
					</table>
				</div>
				<div id="com-add-admin-footer">
					<button id="com-add-admin-check-btn">확인</button>
					<button id="com-add-admin-cancel-btn">취소</button>
				</div>
			</div>
		</div>
		<div class="com-prj-del-bg" style="display: none;">
			<div id="com-prj-del-box">
				<div id="com-prj-del-header"><div id="com-prj-del-close-btn"></div></div>
				<div id="com-prj-del-body">
					<p>회사 프로젝트를 삭제하시겠습니까?</p>
					<div id="com-prj-del-footer">
						<button id="com-prj-del-cancel-btn">취소</button>
						<button id="com-prj-del-check-btn">확인</button>
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
						<h3 class="blue-h3">회사 프로젝트 관리</h3>
						<h3 id="admin-8">공개 프로젝트 관리</h3>
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
			<div class="main-title"><h1>회사 프로젝트 관리</h1></div>
			<div class="search-box">
				<form>
					<select>
						<option>프로젝트명</option>
					</select>
					<input type="text" name="input-text" class="input-text" placeholder="검색어를 입력해주세요"/>
					<input type="button" value="검색" id="projectSearchbtn" class="submit-btn"/>
				</form>
			</div>
			<div><div class="add-btn"><span>추가</span></div></div>
			<table id="companyProjectTable">
				<tr>
					<th>최근 활동일</th>
					<th>개설일</th>
					<th>프로젝트명</th>
					<th>게시물</th>
					<th>댓글</th>
					<th>작성자 아이디</th>
				</tr>
				<c:forEach var="dto" items="${comProjectList }">
					<tr class="row-target" data-idx="${dto.projectIdx }">
						<td>${dto.lastActivity }</td>
						<td>${dto.openingDate }</td>
						<td style="text-align: left;">${dto.pName }</td>
						<td>${dto.boardCnt }</td>
						<td>${dto.commentCnt }</td>
						<td>${dto.writer }</td>
					</tr>
				</c:forEach>
				<c:choose>
					<c:when test="${comProjectList.size() == 0 }">
						<tr class="row-target">
							<td colspan="6">결과값이 존재하지 않습니다.</td>
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