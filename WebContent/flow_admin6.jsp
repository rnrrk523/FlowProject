<%@page import="dto.PermissionSettingDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="dao.ProjectDao"%>
<%@page import="dto.ProjectsDto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dto.ProjectAdminDto"%>
<%@page import="dto.ProjectCommentCntDto"%>
<%@page import="dto.ProjectChatCntDto"%>
<%@page import="dto.DelProjectDto"%>
<%@page import="dto.MemberCompanyDepartmentDto"%>
<%@page import="dao.MemberDao"%>
<%-- <%
	int companyIdx = 1;
	int memberIdx = 2;
	ProjectDao pDao = new ProjectDao();
	MemberDao mDao = new MemberDao();
	ArrayList<ProjectsDto> projectList = pDao.getProjectInfo(companyIdx);
	ArrayList<DelProjectDto> delProjectList = pDao.getDelProjects(companyIdx);
	// PermissionSettingDto psDto = pDao.getPermissionSetting(projectIdx);
%> --%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>프로젝트 관리</title>
	<script src="js/jquery-3.7.1.min.js"></script>
	<script>
		let _this;
		
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
			$("#admin-7").click(function() {
				window.location.href = 'Controller?command=admin_page7&companyIdx='+${companyIdx}+'&memberIdx='+${memberIdx};
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
			
			/*정상 탭 클릭*/
			$(".normal-tab").click(function(){
				$(".delete-container").css('display', 'none');
				$(".normal-container").css('display', 'block');
				$(this).css('border-bottom', '4px solid #307CFF');
				$(".delete-tab").css('border-bottom', '1px solid #E7E7E9');
				$(".normal-tab").css('cursor', 'auto');
				$(".delete-tab").css('cursor', 'pointer');
			});
			/*삭제 탭 클릭*/
			$(".delete-tab").click(function() {
				$(".normal-container").css('display', 'none');
				$(".delete-container").css('display', 'block');
				$(this).css('border-bottom', '4px solid #307CFF');
				$(".normal-tab").css('border-bottom', '1px solid #E7E7E9');
				$(".normal-tab").css('cursor', 'pointer');
				$(".delete-tab").css('cursor', 'auto');
			});
			/*프로젝트 선택하기*/
			$(document).on("click", ".row", function() {
				_this = $(this).data("idx");
				$.ajax({
					type: 'post',
					url: 'showProjectInfoAjaxServlet',
					data: {"companyIdx":${companyIdx}, "projectIdx":_this},
					success: function(data) {
						$("#alter-project-name-input").val(data.pName);
						(data.writingGrant == 0) ? $('input[name="writing_grant"][value="0"]').prop('checked', true) : $('input[name="writing_grant"][value="1"]').prop('checked', true);
						(data.commentGrant == 0) ? $('input[name="comment_grant"][value="0"]').prop('checked', true) : $('input[name="comment_grant"][value="1"]').prop('checked', true);
						(data.postViewGrant == 0) ? $('input[name="post_view_grant"][value="0"]').prop('checked', true) : $('input[name="post_view_grant"][value="1"]').prop('checked', true);
						(data.editPostGrant == 0) ? $('input[name="edit_post_grant"][value="0"]').prop('checked', true) : ((data.editPostGrant == 1) ? $('input[name="edit_post_grant"][value="1"]').prop('checked', true) : $('input[name="edit_post_grant"][value="2"]').prop('checked', true));
					},
					error: function(r, s, e) {
						console.log(r.status);
						console.log(r.responseText);
						console.log(e);
					}
				});
				$.ajax({
					type: 'post',
					url: 'showProjectAdminInfoAjaxServlet',
					data: {"companyIdx":${companyIdx}, "projectIdx":_this},
					success: function(data) {
						$(".appendTr").remove();
						for(let i=0; i<=data.length-1; i++){
							let adminTr = '<tr class="appendTr" data-idx="'+data[i].participantIdx+'">' +
											'<td>'+data[i].affiliation+'</td>' +
											'<td>'+data[i].name+'</td>' +
											'<td>'+data[i].email+'</td>' +
											'<td>'+data[i].departmentName+'</td>' +
											'<td><span class="adminChangeBtn admin-red admin-clear-btn">관리자[해제]</span></td>' +
										'</tr>';
							$("#alter-project-table2").append(adminTr);
						}
					},
					error: function(r, s, e) {
						console.log(r.status);
						console.log(r.responseText);
						console.log(e);
					}
				})
				
				
				$(".alter-project-bg").css('display', 'flex');
			});
			/*프로젝트 수정창 관리자 추가 클릭*/
			$("#alter-project-admin-add-btn").click(function() {
				$.ajax({
					type: 'post',
					url: 'ProjectMemberListAjaxServlet',
					data: {"projectIdx":_this},
					success: function(data) {
						$(".projectMemberTr").remove();
						for(let i=0; i<=data.length-1; i++){
							let newTr = '<tr class="projectMemberTr" data-idx="'+data[i].idx+'">' +
											'<td>'+data[i].name+'</td>' +
											'<td>'+data[i].email+'</td>';
											if(data[i].adminYN == 'Y'){
												newTr += '<td><span class="adminChangeBtn admin-red">관리자[해제]</span></td>';
											}else{
												newTr += '<td><span class="adminChangeBtn admin-blue">정상[선택]</span></td>';
											}
											newTr += '</tr>';
							$("#project-admin-add-table").append(newTr);
						}
					},
					error: function(r, s, e) {
						console.log(r.status);
						console.log(r.responseText);
						console.log(e);
					}
				})
				
				$(".project-admin-add-bg").css('display', 'flex');
			});
			/*관리자 선택창 검색하기*/
			$("#projectMemberSearchBtn").click(function() {
				let projectIdx = _this;
				let standard = $("#admin-search-select").val()=='name' ? '이름' : '이메일';
				let str = $("#admin-search-input").val();
				
				$.ajax({
					type: 'post',
					url: 'ProjectMemberSearchAjaxServlet',
					data: {"projectIdx":projectIdx, "standard":standard, "str":str},
					success: function(data) {
						$(".projectMemberTr").remove();
						for(let i=0; i<=data.length-1; i++){
							let newTr = '<tr class="projectMemberTr" data-idx="'+data[i].idx+'">' +
											'<td>'+data[i].name+'</td>' +
											'<td>'+data[i].email+'</td>';
											if(data[i].adminYN == 'Y'){
												newTr += '<td><span class="adminChangeBtn admin-red">관리자[해제]</span></td>';
											}else{
												newTr += '<td><span class="adminChangeBtn admin-blue">정상[선택]</span></td>';
											}
											newTr += '</tr>';
							$("#project-admin-add-table").append(newTr);
						}
					},
					error: function(r, s, e) {
						console.log(r.status);
						console.log(r.responseText);
						console.log(e);
					}
				})
			})
			$(document).ready(function() {
				/*관리자 선택창 관리자 변경버튼 클릭*/
				$(document).on("click", ".adminChangeBtn", function() {
					let memberIdx = $(this).parent().parent().data("idx");
					let state = $(this).hasClass('admin-red') ? ($(this).hasClass('admin-clear-btn') ? 'clear' : 'red') : 'blue';
					let change = false;
					$.ajax({
						type: 'post',
						url: 'adminChangeAjaxServlet',
						data: {"companyIdx":${companyIdx}, "projectIdx":_this, "memberIdx":memberIdx, "state":state},
						success : function(data) {
							if(state == 'red' || state == 'clear'){
								if(data.adminCnt <= 1){
									alert("※ 최소 1명 이상의 관리자가 필요합니다.");
								}else{
									change = true;
									alert("관리자목록에서 해제되었습니다.");
									$(".appendTr").remove();
									for(let i=0; i<=data.length-1; i++){
										let adminTr = '<tr class="appendTr" data-idx="'+data[i].idx+'">' +
														'<td>'+data[i].affiliation+'</td>' +
														'<td>'+data[i].name+'</td>' +
														'<td>'+data[i].email+'</td>' +
														'<td>'+data[i].departmentName+'</td>' +
														'<td><span class="adminChangeBtn admin-red admin-clear-btn">관리자[해제]</span></td>' +
													'</tr>';
										$("#alter-project-table2").append(adminTr);
									}
								}
							}else{
								change = true;
								alert("관리자목록에 추가되었습니다.");
								$(".appendTr").remove();
								for(let i=0; i<=data.length-1; i++){
									let adminTr = '<tr class="appendTr" data-idx="'+data[i].idx+'">' +
													'<td>'+data[i].affiliation+'</td>' +
													'<td>'+data[i].name+'</td>' +
													'<td>'+data[i].email+'</td>' +
													'<td>'+data[i].departmentName+'</td>' +
													'<td><span class="adminChangeBtn admin-red admin-clear-btn">관리자[해제]</span></td>' +
												'</tr>';
									$("#alter-project-table2").append(adminTr);
								}
							}
							$("#admin-search-select").val('name');
							$("#admin-search-input").val("");
							$(".project-admin-add-bg").css('display', 'none');
						},
						error: function(r, s, e) {
							console.log(r.status);
							console.log(r.responseText);
							console.log(e);
						}
					})
					if(change){
						if(state == 'red'){
							$(this).removeClass('admin-red');
							$(this).addClass('admin-blue');
							$(this).text('정상[선택]');
						}else{
							$(this).removeClass('admin-blue');
							$(this).addClass('admin-red');
							$(this).text('관리자[해제]');
						}
					}
				})
			})
			
			/*관리자 선택창 닫기&취소*/
			$("#project-admin-header-close-btn").click(function() {
				$("#admin-search-select").val('name');
				$("#admin-search-input").val("");
				$(".project-admin-add-bg").css('display', 'none');
			});
			$("#project-admin-add-cancel-btn").click(function() {
				$("#admin-search-select").val('name');
				$("#admin-search-input").val("");
				$(".project-admin-add-bg").css('display', 'none');
			});
			/*프로젝트 정보 창 닫기&취소*/
			$("#alter-project-close-btn").click(function() {
				$(".alter-project-bg").css('display', 'none');
			});
			$("#alter-project-cancel-btn").click(function() {
				$(".alter-project-bg").css('display', 'none');
			});
			/*프로젝트 삭제버튼 클릭*/
			$("#alter-project-del-btn").click(function() {
				$(".row").each(function() {
					if($(this).data("idx") == _this){
						if($(this).find("td:nth-child(6)").text() >= 1){
							$("#project-del-body").find('p').text("게시글이 있는 프로젝트입니다.정말 삭제하시겠습니까?");
						}else{
							$("#project-del-body").find('p').text("프로젝트를 삭제하시겠습니까?");
						}
					}
				})
				$(".project-del-bg").css('display', 'flex');
			});
			/*프로젝트 삭제창 닫기&취소*/
			$("#project-del-close-btn").click(function() {
				$(".project-del-bg").css('display', 'none');
			});
			$("#project-del-cancel-btn").click(function() {
				$(".project-del-bg").css('display', 'none');
			});
			/*삭제된 프로젝트 선택*/
			$(document).on("click", ".del-t-row", function() {
				_this = $(this).parent().data("idx");
				let pName = $(this).parent().find('td:nth-child(2)').text();
				$("#restore-prj-body").find("p").text(pName+'를 복구하시겠습니까?');
				$.ajax({
					type: 'post',
					url: 'DelProjectInfoAjaxServlet',
					data: {"projectIdx":_this},
					success: function(data) {
						console.log(data);
						$(".delProjectInfoTr").remove();
						for(let i=0; i<=data.length-1; i++){
							let newTr = '<tr class="delProjectInfoTr">' +
											'<td>'+data[i].name+'</td>' +
											'<td>'+data[i].email+'</td>' +
											'<td>'+data[i].departmentName+'</td>' +
											'<td>'+data[i].phone+'</td>';
											if(data[i].adminYN == 'Y'){
												newTr += '<td>관리자</td>';
											}else{
												newTr += '<td>정상</td>';
											}
											newTr += '</tr>';
							$("#del-prj-info-show-table").append(newTr);
						}
					},
					error: function(r, s, e) {
						console.log(r.status);
						console.log(r.responseText);
						console.log(e);
					}
				})
				let prjName = $(this).parent().find('td:nth-child(2)').text();
				$("#del-prj-info-show-prjname").find('div:nth-child(2)').text(prjName);
				
				$(".del-prj-info-show-bg").css('display', 'flex');
			});
			/*삭제된 프로젝트 정보창 닫기&확인(취소)*/
			$("#del-prj-info-show-close-btn").click(function() {
				$(".del-prj-info-show-bg").css('display', 'none');
			});
			$("#del-prj-info-show-check-btn").click(function() {
				$(".del-prj-info-show-bg").css('display', 'none');
			});
			/*프로젝트 복구 클릭*/
			$(document).on("click", ".restore", function() {
				_this = $(this).parent().parent().data("idx");
				let pName = $(this).parent().parent().find('td:nth-child(2)').text();
				$("#restore-prj-body").find("p").text(pName+'를 복구하시겠습니까?');
				$(".restore-prj-bg").css('display', 'flex');
			});
			$("#del-prj-info-show-restore-btn").click(function() {
				
				$(".restore-prj-bg").css('display', 'flex');
			});
			/*프로젝트 복구 알림창 확인 클릭*/
			$("#restore-prj-check-btn").click(function() {
				projectRestore(_this);
			})
			function projectRestore(pIdx){
				$.ajax({
					type: 'post',
					url: 'ProjectRestoreAjaxServlet',
					data: {
						"projectIdx":pIdx,
						"changerIdx":${memberIdx}
					},
					success: function() {
						alert("프로젝트를 복구 완료했습니다.");
						location.reload();
					},
					error: function(r, s, e) {
						console.log(r.status);
						console.log(r.responseText);
						console.log(e);
					}
				})
				$(".restore-prj-bg").css('display', 'flex');
			}
			/*프로젝트 복구알림창 닫기&취소*/
			$("#restore-prj-close-btn").click(function() {
				$(".restore-prj-bg").css('display', 'none');
			});
			$("#restore-prj-cancel-btn").click(function() {
				$(".restore-prj-bg").css('display', 'none');
			});
			/*프로젝트 완전삭제 클릭*/
			$("#del-prj-info-show-absDel-btn").click(function() {
				let prjName = $("#del-prj-info-show-prjname").find('div:nth-child(2)').text();
				$('#absolute-del-body').find('span').text(prjName);
				
				$(".absolute-del-bg").css('display', 'flex');
			});
			/*프로젝트 완전삭제 취소*/
			$("#absolute-del-cancel-btn").click(function() {
				$('#absolute-del-checkbox').prop('checked', false);
				$(".absolute-del-bg").css('display', 'none');
			});
			/*프로젝트 완전삭제창 체크버튼*/
			$("#absolute-del-checkbox").click(function() {
				if($(this).prop('checked')){
					$("#absolute-del-check-btn").css('background-color', '#4451ff');
					$("#absolute-del-check-btn").css('color', '#FFF');
				}else{
					$("#absolute-del-check-btn").css('background-color', '#ccc');
					$("#absolute-del-check-btn").css('color', '#666');
				}
			});
			/*삭제 탭 페이지에서 완전삭제 버튼 클릭*/
			$(".delete-btn").click(function() {
				let checkCnt = $('.checkbox:checked').length;
				if(checkCnt!=0){
					$("#absolute-del-body").find('span').text(checkCnt+"개의 ");
					$(".absolute-del-bg").css('display', 'flex');
				}else{
					alert("삭제할 프로젝트를 선택해주세요.");
				}
			});
			/*프로젝트 검색하기*/
			$("#searchBtn").click(function() {
				let str = $(this).prev().val();
				$.ajax({
					type: 'post',
					url: 'ProjectSearchAjaxServlet',
					data: {"companyIdx":${companyIdx}, "str":str},
					success: function(data) {
						$(".row").remove();
						if(data.length != 0){
							for(let i=0; i<=data.length-1; i++){
								let row = '<tr class="row" data-idx="'+data[i].pIdx+'">' +
									'<td style="text-align: left;">'+data[i].pName+'</td>';
									if(data[i].adminList.length > 1){
										row += '<td>'+data[i].adminList[0].name+' 외 '+data[i].adminList.length-1+'명</td>';
									}else {
										row += '<td>'+data[i].adminList[0].name+'</td>';
									}
									row += '<td>'+data[i].pmCnt+'</td>' +
									'<td>'+data[i].empCnt+'</td>' +
									'<td>'+data[i].outCnt+'</td>' +
									'<td>'+data[i].boardCnt+'</td>' +
									'<td>'+data[i].commentCnt+'</td>' +
									'<td>'+data[i].chatCnt+'</td>' +
									'<td>'+data[i].scheduleCnt+'</td>' +
									'<td>'+data[i].taskCnt+'</td>' +
									'<td>'+data[i].lastActivity+'</td>' +
									'<td>'+data[i].openingDate+'</td>' +
								'</tr>';
								
								$(".normal-table").append(row);
							}
						}else{
							let row = '<tr class="row">' +
										'<td colspan="12">결과값이 존재하지 않습니다.</td>' +
										'</tr>';
							
							$(".normal-table").append(row);
						}
					},
					error: function(r, s, e) {
						console.log(r.status);
						console.log(r.responseText);
						console.log(e);
					}
				})
			})
			/*프로젝트 삭제창 확인 버튼 클릭*/
			$("#project-del-check-btn").click(function() {
				let projectIdx = _this;
				$.ajax({
					type: 'post',
					url: 'ProjectDeleteAjaxServlet',
					data: {
						"memberIdx":${memberIdx}, 
						"projectIdx":projectIdx
					},
					success: function() {
						alert("프로젝트가 삭제되었습니다.");
						location.reload();
					},
					error: function(r, s, e) {
						console.log(r.status);
						console.log(r.responseText);
						console.log(e);
					}
				})
			})
			/*프로젝트 정보 수정창 저장버튼 클릭 */
			$("#alter-project-record-btn").click(function() {
				let projectIdx = _this;
				let pName = $("#alter-project-name-input").val();
				let writingGrant = $('input[name="writing_grant"]:checked').val();
				let commentGrant = $('input[name="comment_grant"]:checked').val();
				let postViewGrant = $('input[name="post_view_grant"]:checked').val();
				let editPostGrant = $('input[name="edit_post_grant"]:checked').val();
				$.ajax({
					type: 'post',
					url: 'alterProjectAjaxServlet',
					data: {
						"projectIdx":projectIdx,
						"pName":pName,
						"writingGrant":writingGrant,
						"commentGrant":commentGrant,
						"postViewGrant":postViewGrant,
						"editPostGrant":editPostGrant
					},
					success: function() {
						alert("프로젝트 정보가 수정되었습니다.");
						location.reload();
					},
					error: function(r, s, e) {
						console.log(r.status);
						console.log(r.responseText);
						console.log(e);
					}
				})
			})
			/*프로젝트 완전삭제물음창 확인버튼클릭*/
			$("#absolute-del-check-btn").click(function() {
				let color = $(this).css('background-color');
				if(color == 'rgb(68, 81, 255)'){
					let str = $(this).parent().prev().find('span').text();
					let subStr = str.substring(str.length-3);
					
					/*지정된 프로젝트 수*/
					let cnt = str.replace(subStr, '');
					
					if(subStr == "개의 "){
						/*여러 프로젝트가 대상일때*/
						$('.checkbox:checked').each(function() {
							let projectIdx = $(this).parent().parent().data("idx");
							$.ajax({
								type: 'post',
								url: 'ProjectAbsoluteDelAjaxServlet',
								data: {
									"projectIdx":projectIdx,
									"changerIdx":${memberIdx}
								},
								success: function() {},
								error: function(r, s, e) {
									console.log(r.status);
									console.log(r.responseText);
									console.log(e);
								}
							})
						})
						alert(cnt+"개의 프로젝트가 삭제되었습니다.");
						location.reload();
					}else{
						/*대상이 하나일때*/
						$.ajax({
							type: 'post',
							url: 'ProjectAbsoluteDelAjaxServlet',
							data: {
								"projectIdx":_this,
								"changerIdx":${memberIdx}
							},
							success: function() {
								alert("1개의 프로젝트가 삭제되었습니다.");
								location.reload();
							},
							error: function(r, s, e) {
								console.log(r.status);
								console.log(r.responseText);
								console.log(e);
							}
						})
					}
				}
			})
			/*삭제탭에서 프로젝트 검색하기*/
			$("#delSearchBtn").click(function() {
				let str = $(this).prev().val();
				$.ajax({
					type: 'post',
					url: 'DelProjectSearchAjaxServlet',
					data: {"companyIdx":${companyIdx}, "str":str},
					success: function(data) {
						console.log(data);
						$(".del-row").remove();
						if(data.length != 0){
							for(let i=0; i<=data.length-1; i++){
								let newTr = '<tr class="del-row" data-idx="'+data[i].projectIdx+'">' +
												'<td><input type="checkbox" class="checkbox"></td>' +
												'<td class="del-t-row">'+data[i].pName+'</td>';
												if(data[i].adminList.length > 1){
													newTr += '<td class="del-t-row">'+data[i].adminList[0].name+' 외 '+data[i].adminList.length-1+'명</td>';
												}else {
													newTr += '<td class="del-t-row">'+data[i].adminList[0].name+'</td>';
												}
												newTr += '<td class="del-t-row">'+data[i].pmCnt+'</td>' +
												'<td class="del-t-row">'+data[i].lastActivity+'</td>' +
												'<td class="del-t-row">'+data[i].openingDate+'</td>' +
												'<td class="del-t-row">'+data[i].deleteDate+'</td>' +
												'<td class="del-t-row">'+data[i].delName+'<br/>'+data[i].delEmail+'</td>' +
												'<td><span class="restore">[복구]</span></td>' +
											'</tr>';
								$("#delProjectTable").append(newTr);
								
							}
						}else{
							let newTr = '<tr class="del-row">' +
											'<td colspan="9">결과값이 존재하지 않습니다.</td>' +
											'</tr>';
							$("#delProjectTable").append(newTr);
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
	.tab-box{
		display: flex;
		width: 1600px;
		height: 41px;
		margin-top: 30px;
		font-size: 15px;
		font-weight: bold;
		border-bottom: 1px solid #C5C6CB;
	}
	.normal-tab{
		width: 120px;
		height: 40px;
		line-height: 38px;
		border: 1px solid #E7E7E9;
		border-radius: 7px 0 0 0;
		text-align: center;
		border-bottom: 4px solid #307CFF;
	}
	.delete-tab{
		width: 120px;
		height: 40px;
		line-height: 38px;
		border: 1px solid #E7E7E9;
		border-radius: 0 7px 0 0;
		text-align: center;
		cursor: pointer;
	}
	.search-box{
		display: flex;
		justify-content: space-between;
		align-items: center;
		width: 1600px;
		height: 30px;
		color: #333;
		margin-top: 15px;
	}
	.search-text{
		width: 280px;
		height: 30px;
		padding-left: 10px;
		font-size: 13px;
		border: 1px solid #E6E6E6;
		border-radius: 1px;
		outline: none;
	}
	.search-text::placeholder{
		color: lightgray;
	}
	.submit-btn{
		height: 30px;
		line-height: 29px;
		padding: 0 20px;
		margin-left: 3px;
		font-weight: bold;
		border: 1px solid #C5C6CB;
		border-radius: 2px;
		background-color: #FFF;
		color: #3D4044;
		cursor: pointer;
	}
	.submit-btn:hover{
		color: #000;
		border-color: #999aa0;
	}
	.excel-down{
		color: #4C80D6;
		font-size: 12px;
		padding: 0 0 1px 21px;
		background-color: #FFF;
		cursor: pointer;
		text-decoration: underline;
		line-height: 16px;
	}
	.excel-down::before{
		content: url('https://flow.team/design2/flow_admin_2019/img/ico_down.png');
	}
	.excel-down:hover{
		font-weight: bold;
	}
	.normal-table{
		width: 1600px;
		border-collapse: collapse;
		border: 1px solid #E1E1E2;
		font-size: 13px;
		color: #111;
		margin-top: 15px;
	}
	th{
		height: 37px;
		background-color: #F9F9FB;
		border: 1px solid #E1E1E2;
		text-align: center;
	}
	td{
		line-height: 16px;
		padding: 8px 8px 8px 10px;
		border: 1px solid #E1E1E2;
		text-align: center;
	}
	.delete-container{
		display: none;
	}
	.search-box > div{
		display: flex;
		align-items: center;
	}
	.delete-btn{
		height: 30px;
		line-height: 28px;
		color: #FFF;
		background-color: #D03737;
		margin-left: 7px;
		padding: 0 20px;
		font-weight: bold;
		border: 1px solid #C5C6CB;
		border-radius: 2px;
		cursor: pointer;
		text-align: center;
	}
	.delete-btn:hover{
		border-color: #999aa0;
	}
	.delete-info{
		width: 15px;
		height: 17px;
		color: #999;
		font-size: 10px;
		font-weight: 800;
		background-color: #FFF;
		margin: 2px 0 0 4px;
		border: 1px solid #999;
		border-radius: 50%;
		text-align: center;
		cursor: pointer;
	}
	.delete-table{
		margin-top: 15px;
		width: 1600px;
		border-collapse: collapse;
		font-size: 13px;
		font-weight: bold;
	}
	.checkbox{
		width: 33px;
		height: 16px;
		cursor: pointer;
	}
	.row{
		cursor: pointer;
	}
	.row:hover{
		background-color: #ECECEF;
	}
	.restore{
		color: #307CFF;
		font-weight: normal;
	}
	.restore:hover{
		font-weight: bold;
		text-decoration: underline;
	}
	.alter-project-bg{
		position: absolute;
		display: flex;
		justify-content: center;
		align-items: center;
		width: 100%;
		height: 100%;
		z-index: 99;
		background: rgb(0, 0, 0, .3);
	}
	#alter-project-box{
		width: 900px;
		background-color: #FFF;
		height: 622px;
	}
	#alter-project-header{
		width: 900px;
		height: 68px;
		padding: 25px 30px 0;
		font-size: 19px;
		color: #111;
		font-weight: 700;
	}
	#alter-project-header > div:first-of-type{
		display: flex;
		justify-content: space-between;
		align-items: center;
		padding-bottom: 14px;
		border-bottom: 1px solid #E6E6E6;
	}
	#alter-project-close-btn{
		cursor: pointer;
		width: 30px;
		height: 30px;
		background: url(https://flow.team/design2/flow_admin_2019/img/btn_popclose.gif) no-repeat center;
		border-radius: 1px;
	}
	#alter-project-content-box{
		width: 900px;
		margin-bottom: 30px;
		padding: 0 30px;
		overflow-y: auto;
	}
	#alter-project-table1{
		margin-top: 10px;
		border-collapse: collapse;
		border: none;
		font-size: 14px;
	}
	#alter-project-table1 th, #alter-project-table1 td{
		padding: 5px 0 6px;
		width: 150px;
		height: 41px;
		border: none;
		text-align: left;
		background-color: #FFF;
		font-size: 14px;
		color: #4F545D;
	}
	#alter-project-table1 input{
		width: 673px;
		height: 30px;
		padding-left: 10px;
		font-size: 13px;
		border: 1px solid #E6E6E6;
		border-radius: 1px;
		outline:none;
	}
	#alter-project-admin-add-btn{
		cursor: pointer;
		padding: 0 12px;
		height: 28px;
		line-height: 24px;
		font-size: 13px;
		color: #3d4044;
		font-weight: bold;
		border: 1px solid #C5C6CB;
		border-radius: 2px;
		text-align: center;
		background-color: #FFF;
	}
	#alter-project-admin-add-btn:hover{
		color: #000;
		border-color: #999aa0;
	}
	#alter-project-table2{
		border-collapse: collapse;
		width: 833px;
	}
	#alter-project-table2 th{
		color: #111;
		font-size: 13px;
		height: 31px;
		padding: 5px 0 6px;
		background-color: #F9F9FB;
	}
	#alter-project-table2 td{
		color: #111;
		font-size: 13px;
		padding: 8px;
		height: 49px;
	}
	.admin-clear-btn{
		cursor: pointer;
		color: #D03737;
		font-weight: 600;
	}
	.admin-clear-btn:hover{
		font-weight: bold !important;
		text-decoration: underline !important;
	}
	.admin-select-btn{
		cursor: pointer;
		color: #307cff;
	}
	.admin-select-btn:hover{
		font-weight: bold !important;
		text-decoration: underline !important;
	}
	#alter-project-table3 {
		margin-top: 10px;
		border-collapse: collapse;
		border: none;
		width: 833px;
	}
	#alter-project-table3 th{
		background-color: #FFF;
		width: 150px;
		height: 32px;
		padding: 5px 0 6px;
		font-size: 14px;
		font-weight: bold;
		border: none;
		text-align: left;
	}
	#alter-project-table3 td{
		background-color: #FFF;
		width: 683px;
		height: 32px;
		padding: 5px 0 6px;
		font-size: 13px;
		border: none;
		text-align: left;
	}
	#alter-project-table3 input[type="radio"]{
		margin: -2px 0 0;
		width: 16px;
		height: 16px;
	}
	#alter-project-table3 label {
		cursor: pointer;
	}
	#alter-project-table3 td > div{
		display: flex;
		align-items: center;
	}
	#alter-project-btn-box{
		position: relative;
		display: flex;
		justify-content: center;
		align-items: center;
		margin-top: 15px;
		text-align: center;
		width: 833px;
		height: 36px;
	}
	#alter-project-del-btn{
		position: absolute;
		bottom: 0;
		left: 0;
		cursor: pointer;
		width: 100px;
		height: 36px;
		color: #FFF;
		font-size: 16px;
		background-color: #D03737;
		border-radius: 2px;
		text-align: center;
	}
	#alter-project-record-btn{
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
		margin-right: 5px;
	}
	#alter-project-cancel-btn{
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
	.del-row:hover{
		background-color: #ECECEF;
		cursor: pointer;
	}
	.project-admin-add-bg{
		position: absolute;
		display: flex;
		justify-content: center;
		align-items: center;
		width: 100%;
		height: 100%;
		background: rgb(0, 0, 0, .6);
		z-index: 100;
	}
	#project-admin-add-box{
		width: 570px;
		height: 460px;
		padding-bottom: 20px;
		background-color: #FFF;
		border-radius: 5px;
	}
	#project-admin-top{
		display: flex;
		flex-direction: column;
		justify-content: space-between;
		width: 510px;
		height: 106px;
		margin: 25px 30px 0;
		padding-bottom: 14px;
		border-bottom: 1px solid #e6e6e6;
	}
	#project-admin-header{
		display: flex;
		justify-content: space-between;
		align-items: center;
		width: 510px;
		height: 28px;
		color: #111;
		font-size: 19px;
	}
	#project-admin-header-close-btn{
		width: 20px;
		height: 20px;
		cursor: pointer;
		background: url(https://flow.team/js/admin/assets/img/btn_popclose.gif) no-repeat center;
	}
	#project-admin-search-box{
		display: flex;
		align-items: center;
		width: 510px;
		height: 43px;
		padding: 5px 0 6px;
	}
	#project-admin-search-box select{
		width: 60px;
		height: 32px;
		color: #333;
		font-size: 13px;
		outline: none;
		border: 1px solid #e6e6e6;
		border-radius: 1px;
		margin-right: 10px;
	}
	#project-admin-search-box input {
		width: 150px;
		height: 30px;
		color: #333;
		background: #FFF;
		padding-left: 10px;
		border: 1px solid #e6e6e6;
		border-radius: 1px;
		outline: none;
		margin-right: 10px;
	}
	#project-admin-search-box button {
		cursor: pointer;
		color: #000;
		border: 1px solid #999aa0;
		padding: 0 20px;
		height: 30px;
		line-height: 28px;
		font-size: 14px;
		font-weight: bold;
		border: 1px solid #c5c6cb;
		border-radius: 2px;
		text-align: center;
		background-color: #FFF;
	}
	#project-admin-search-box button:hover{
		color: #000;
		border-color: #999aa0;
	}
	#project-admin-add-table{
		width: 510px;
		border-collapse: collapse;
		margin: 0 auto;
	}
	#project-admin-add-table th{
		height: 37px;
		background-color: #f9f9fb;
		color: #111;
		font-size: 13px;
	}
	#project-admin-add-table td{
		height: 33px;
		color: #111;
		font-size: 13px;
		padding: 8px;
		background-color: #FFF !important;
	}
	.admin-red{
		cursor: pointer;
		color: #d03737;
		font-weight: 600;
	}
	.admin-red:hover{
		font-weight: bold;
		text-decoration: underline;
	}
	.admin-blue{
		cursor: pointer;
		color: #307cff;
	}
	.admin-blue:hover{
		font-weight: bold;
		text-decoration: underline;
	}
	#project-admin-add-body{
		margin: 0 auto;
		width: 510px;
		height: 240px;
		border-bottom: 1px solid #e6e6e6;
		overflow-y: auto;
	}
	#project-admin-add-btn-box{
		margin-top: 15px;
		text-align: center;
		width: 510px;
		margin: 15px auto 0;
	}
	#project-admin-add-check-btn{
		width: 120px;
		height: 36px;
		color: #FFF;
		font-size: 16px;
		background-color: #307CFF;
		cursor: pointer;
		border-radius: 3px;
		line-height: 34px;
		margin-right: 10px;
	}
	#project-admin-add-cancel-btn{
		cursor: pointer;
		height: 36px;
		width: 120px;
		line-height: 34px;
		font-size: 16px;
		color: #4c4c4c;
		border: 1px solid #c5c6cb;
		border-radius: 3px;
		text-align: center;
		background-color: #FFF;
	}
	.project-del-bg{
		position: absolute;
		display: flex;
		justify-content: center;
		align-items: center;
		width: 100%;
		height: 100%;
		z-index: 999;
		background: rgb(0, 0, 0, .6);
	}
	#project-del-box{
		width: 380px;
		height: 153px;
		background-color: #FFF;
		border-radius: 7px;
	}
	#project-del-header{
		position: relative;
		width: 380px;
		height: 43px;
		background-color: #f4f4f4;
		border-radius: 7px 7px 0 0;
	}
	#project-del-close-btn{
		position: absolute;
		top: 15px;
		right: 15px;
		width: 14px;
		height: 14px;
		cursor: pointer;
		background-image: url(https://flow.team/design2/img_rn/btn/btn_layerstyle4_close2.png?1);
	}
	#project-del-body{
		width: 380px;
		height: 110px;
		padding: 20px;
	}
	#project-del-body p{
		text-align: center;
		width: 340px;
		height: 20px;
		font-size: 14px;
		color: #4f545d;
	}
	#project-del-btn-box{
		width: 340px;
		height: 50px;
		padding-top: 20px;
		text-align: center;
	}
	#project-del-cancel-btn{
		width: 153px;
		height: 30px;
		background-color: #FFF;
		margin-right: 10px;
		color: #4c4c4c;
		font-size: 14px;
		font-weight: bold;
		border: 1px solid rgb(201, 201, 201);
		border-radius: 2px;
		cursor: pointer;
	}
	#project-del-check-btn{
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
	.del-prj-info-show-bg{
		position: absolute;
		display: flex;
		justify-content: center;
		align-items: center;
		z-index: 999;
		width: 100%;
		height: 100%;
		background: rgb(0, 0, 0, .3);
	}
	#del-prj-info-show-box{
		width: 900px;
		height: 381px;
		background-color: #FFF;
	}
	#del-prj-info-show-top{
		width: 900px;
		height: 68px;
		padding: 25px 30px 0;
	}
	#del-prj-info-show-header{
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
	#del-prj-info-show-close-btn{
		width: 30px;
		height: 30px;
		cursor: pointer;
		background: url(https://flow.team/design2/flow_admin_2019/img/btn_popclose.gif) no-repeat center;
	}
	#del-prj-info-show-body{
		position: relative;
		left: 0;
		width: 900px;
		height: 283px;
		margin-bottom: 30px;
		padding: 0 30px;
		overflow-y: auto;
	}
	#del-prj-info-show-prjname{
		display: flex;
		align-items: center;
		margin-top: 10px;
		margin-bottom: 5px;
	}
	#del-prj-info-show-prjname div:nth-child(1){
		width: 150px;
		height: 31px;
		font-size: 14px;
		padding: 5px 0 6px;
		text-align: left;
		font-weight: bold;
	}
	#del-prj-info-show-prjname div:nth-child(2){
		width: 690px;
		height: 31px;
		font-size: 14px;
		padding: 5px 0 6px;
		text-align: left;
		font-size: 13px;
	}
	#del-prj-info-show-table{
		width: 840px;
		border-collapse: collapse;
		color: #333;
		font-size: 13px;
	}
	#del-prj-info-show-table th{
		background-color: #f9f9fb;
		padding: 5px 0 6px;
		height: 31px;
	}
	#del-prj-info-show-table td{
		background-color: #FFF;
		padding: 8px;
		height: 49px;
	}
	#del-prj-info-show-footer{
		display: flex;
		justify-content: space-between;
		align-items: center;
		width: 840px;
		height: 36px;
		margin-top: 20px;
	}
	#del-prj-info-show-foot-left{
		display: flex;
		justify-content: space-between;
		align-items: center;
		width: 233px;
		height: 36px;
	}
	#del-prj-info-show-absDel-btn{
		width: 100px;
		height: 36px;
		color: #FFF;
		font-size: 16px;
		background-color: #d03737;
		cursor: pointer;
		line-height: 36px;
		border: 1px solid #c5c6cb;
		border-radius: 3px;
		text-align: center;
	}
	#del-prj-info-show-restore-btn{
		width: 120px;
		height: 36px;
		color: #FFF;
		font-size: 16px;
		background-color: #307CFF;
		cursor: pointer;
		line-height: 36px;
		border: 1px solid #307CFF;
		border-radius: 3px;
		text-align: center;
	}
	#del-prj-info-show-check-btn{
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
	.del-row td:nth-child(1){
		padding: 8px;
	}
	.del-row td:nth-child(2){
		text-align: left;
	}
	.restore-prj-bg{
		position: absolute;
		display: flex;
		justify-content: center;
		align-items: center;
		width: 100%;
		height: 100%;
		z-index: 999;
		background: rgb(0, 0, 0, .3);
	}
	#restore-prj-box{
		width: 380px;
		height: 153px;
		background-color: #FFF;
		border-radius: 7px;
	}
	#restore-prj-header{
		position: relative;
		width: 380px;
		height: 43px;
		background-color: #f4f4f4;
		padding: 11px 16px 0;
		border-radius: 7px 7px 0 0;
		color: #111;
		font-size: 16px;
	}
	#restore-prj-close-btn{
		position: absolute;
		top: 15px;
		right: 15px;
		cursor: pointer;
		background-image: url(https://flow.team/design2/img_rn/btn/btn_layerstyle4_close2.png?1);
		width: 14px;
		height: 14px;
	}
	#restore-prj-body{
		width: 380px;
		height: 110px;
		padding: 20px;
	}
	#restore-prj-body p{
		width: 340px;
		height: 20px;
		color: #4f545d;
		font-size: 14px;
	}
	#restore-prj-btn-box{
		width: 340px;
		height: 50px;
		padding-top: 20px;
		text-align: center;
	}
	#restore-prj-cancel-btn{
		width: 153px;
		height: 30px;
		color: #4c4c4c;
		background-color: #FFF;
		font-size: 14px;
		margin-right: 10px;
		font-weight: bold;
		border: 1px solid rgb(201, 201, 201);
		border-radius: 2px;
		cursor: pointer;
	}
	#restore-prj-check-btn{
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
	.absolute-del-bg{
		position: absolute;
		display: flex;
		justify-content: center;
		align-items: center;
		width: 100%;
		height: 100%;
		z-index: 999;
		background: rgb(0, 0, 0, .6);
	}
	#absolute-del-box{
		width: 600px;
		height: 201px;
		background-color: #FFF;
	}
	#absolute-del-header{
		width: 600px;
		height: 44px;
		background-color: #f0f0f0;
		padding: 10px;
		font-size: 16px;
		color: #4f545d;
	}
	#absolute-del-body{
		width: 600px;
		height: 107px;
		padding: 10px 10px 10px 15px;
	}
	#absolute-del-body p{
		width: 573px;
		height: 50px;
		color: #4f545d;
		font-size: 1em;
		padding: 10px 0 20px;
		font-weight: 900;
	}
	#absolute-del-body div{
		width: 573px;
		height: 37.2px;
		color: #FF0000;
		font-size: 14px;
		padding: 5px 0 10px;
		font-weight: 600;
	}
	#absolute-del-body input[type="checkbox"]{
		width: 16px;
		height: 16px;
		cursor: pointer;
		outline: none;
	}
	#absolute-del-footer{
		text-align: center;
		padding-bottom: 20px;
		width: 600px;
		height: 48px;
	}
	#absolute-del-cancel-btn{
		background-color: #FFF;
		padding: 0 10px;
		font-weight: bold;
		border: 1px solid black;
		border-radius: 3px;
		width: 60px;
		height: 28px;
		cursor: pointer;
		margin-right: 10px;
	}
	#absolute-del-check-btn{
		background-color: #ccc;
		color: #666;
		cursor: pointer;
		padding: 0 10px;
		font-weight: bold;
		border: 1px solid black;
		border-radius: 3px;
		width: 60px;
		height: 28px;
	}
</style>
<body>
	<div class="all-container">
		<div class="alter-project-bg" style="display: none;">
			<div id="alter-project-box">
				<div id="alter-project-header">
					<div>
						<div>프로젝트 정보</div>
						<div id="alter-project-close-btn"></div>
					</div>
				</div>
				<div id="alter-project-content-box">
					<form>
						<table id="alter-project-table1">
							<tr>
								<th>프로젝트명</th>
								<td><input type="text" id="alter-project-name-input" name="alterProjectName" placeholder="프로젝트명을 입력하세요"/></td>
							</tr>
							<tr>
								<th>관리자</th>
								<td><button type="button" id="alter-project-admin-add-btn">추가</button></td>
							</tr>
						</table>
						<table id="alter-project-table2">
							<tr>
								<th>직원/외부인</th>
								<th>사용자명</th>
								<th>이메일</th>
								<th>부서</th>
								<th>관리자</th>
							</tr>
						</table>
						<table id="alter-project-table3">
							<tr>
								<th>글 작성 권한</th>
								<td>
									<div>
										<label><input type="radio" name="writing_grant" value="0" checked/>전체</label> &nbsp;&nbsp;
										<label><input type="radio" name="writing_grant" value="1"/>관리자만 글 직성 가능</label>
									</div>
								</td>
							</tr>
							<tr>
								<th>댓글 작성 권한</th>
								<td>
									<div>
										<label><input type="radio" name="comment_grant" value="0" checked/>전체</label> &nbsp;&nbsp;
										<label><input type="radio" name="comment_grant" value="1"/>관리자만</label>
									</div>
								</td>
							</tr>
							<tr>
								<th>글 조회 권한</th>
								<td>
									<div>
										<label><input type="radio" name="post_view_grant" value="0" checked/>전체</label> &nbsp;&nbsp;
										<label><input type="radio" name="post_view_grant" value="1"/>관리자+글 작성 본인만</label>
									</div>
								</td>
							</tr>
							<tr>
								<th>글 수정 권한</th>
								<td>
									<div>
										<label><input type="radio" name="edit_post_grant" value="0"/>전체</label> &nbsp;&nbsp;
										<label><input type="radio" name="edit_post_grant" value="1" checked/>관리자+글 작성 본인만</label> &nbsp;&nbsp;
										<label><input type="radio" name="edit_post_grant" value="2"/>글 작성 본인만</label>
									</div>
								</td>
							</tr>
						</table>
						<div id="alter-project-btn-box">
							<button type="button" id="alter-project-del-btn">삭제</button>
							<button type="button" id="alter-project-record-btn">저장</button>
							<button type="button" id="alter-project-cancel-btn">취소</button>
						</div>
					</form>
				</div>
			</div>
		</div>
		<div class="project-admin-add-bg" style="display: none;">
			<div id="project-admin-add-box">
				<div id="project-admin-top">
					<div id="project-admin-header">
						<div>관리자 선택</div>
						<div id="project-admin-header-close-btn"></div>
					</div>
					<div id="project-admin-search-box">
						<select id="admin-search-select">
							<option value="name">이름</option>
							<option value="email">이메일</option>
						</select>
						<input id="admin-search-input" type="text"/>
						<button id="projectMemberSearchBtn">검색</button>
					</div>
				</div>
				<div id="project-admin-add-body">
					<table id="project-admin-add-table">
						<tr>
							<th>이름</th>
							<th>아이디</th>
							<th>선택</th>
						</tr>
					</table>
				</div>
				<div id="project-admin-add-btn-box">
					<button id="project-admin-add-check-btn">확인</button>
					<button id="project-admin-add-cancel-btn">취소</button>
				</div>
			</div>
		</div>
		<div class="project-del-bg" style="display: none;">
			<div id="project-del-box">
				<div id="project-del-header"><div id="project-del-close-btn"></div></div>
				<div id="project-del-body">
					<p>게시글이 있는 프로젝트입니다.정말 삭제하시겠습니까?</p>
					<div id="project-del-btn-box">
						<button id="project-del-cancel-btn">취소</button>
						<button id="project-del-check-btn">확인</button>
					</div>
				</div>
			</div>
		</div>
		<div class="del-prj-info-show-bg" style="display: none;">
			<div id="del-prj-info-show-box">
				<div id="del-prj-info-show-top">
					<div id="del-prj-info-show-header">
						<div>프로젝트 정보</div>
						<div id="del-prj-info-show-close-btn"></div>
					</div>
				</div>
				<div id="del-prj-info-show-body">
					<div id="del-prj-info-show-prjname">
						<div>프로젝트명</div>
						<div>협업툴 만들기 프로젝트</div>
					</div>
					<table id="del-prj-info-show-table">
						<tr>
							<th>참여자명</th>
							<th>이메일</th>
							<th>부서</th>
							<th>휴대폰 번호</th>
							<th>관리자</th>
						</tr>
					</table>
					<div id="del-prj-info-show-footer">
						<div id="del-prj-info-show-foot-left">
							<button id="del-prj-info-show-absDel-btn">완전 삭제</button>
							<button id="del-prj-info-show-restore-btn">복구</button>
						</div>
						<div><button id="del-prj-info-show-check-btn">확인</button></div>
					</div>
				</div>
			</div>
		</div>
		<div class="restore-prj-bg" style="display: none;">
			<div id="restore-prj-box">
				<div id="restore-prj-header">
					알림
					<div id="restore-prj-close-btn"></div>
				</div>
				<div id="restore-prj-body">
					<p>협업툴 만들기 프로젝트 프로젝트를 복구하시겠습니까?</p>
					<div id="restore-prj-btn-box">
						<button id="restore-prj-cancel-btn">취소</button>
						<button id="restore-prj-check-btn">확인</button>
					</div>
				</div>
			</div>
		</div>
		<div class="absolute-del-bg" style="display: none;">
			<div id="absolute-del-box">
				<div id="absolute-del-header">완전 삭제</div>
				<div id="absolute-del-body">
					<p><span>협업툴 만들기 프로젝트</span> 프로젝트를 정말 삭제하시겠습니까?</p>
					<div>
						<label><input id="absolute-del-checkbox" type="checkbox"/> 삭제되면 복구가 불가능하며 개발사는 그에 따른 책임을 지지 않습니다.</label>
					</div>
				</div>
				<div id="absolute-del-footer">
					<button id="absolute-del-cancel-btn">취소</button>
					<button id="absolute-del-check-btn">확인</button>
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
						<h3 class="blue-h3">프로젝트 관리</h3>
						<h3 id="admin-7">회사 프로젝트 관리</h3>
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
			<div class="main-title"><h1>프로젝트 관리</h1></div>
			<div class="tab-box">
				<div class="normal-tab">정상</div>
				<div class="delete-tab">삭제</div>
			</div>
			<div class="normal-container">
				<div class="search-box">
					<div>
						<input type="text" name="search-text" class="search-text" placeholder="검색어를 입력해주세요">
						<input type="button" value="검색" id="searchBtn" class="submit-btn">
					</div>
					<button class="excel-down"> 엑셀 다운로드</button>
				</div>
			<table class="normal-table">
				<tr>
					<th style="width: 223.8px;">프로젝트명</th>
					<th style="width: 81.38px;">관리자</th>
					<th style="width: 81.38px;">참여자</th>
					<th style="width: 81.38px;">임직원</th>
					<th style="width: 81.38px;">외부인</th>
					<th style="width: 81.38px;">게시물</th>
					<th style="width: 81.38px;">댓글</th>
					<th style="width: 81.38px;">채팅</th>
					<th style="width: 81.38px;">일정</th>
					<th style="width: 81.38px;">업무</th>
					<th style="width: 81.38px;">최근 활동일</th>
					<th style="width: 81.45px;">개설일</th>
				</tr>
				<c:forEach var="dto" items="${projectList}" varStatus="status">
		            <c:set var="projectInfo" value="${projectInfoList[status.index]}" />
		            <tr class="row" data-idx="${dto.pIdx}">
		                <td style="text-align: left;">${dto.pName}</td>
		                <td>
		                    <c:choose>
		                        <c:when test="${projectInfo.adminCnt > 1}">
		                            ${projectInfo.adminName} 외 ${projectInfo.adminCnt - 1}명
		                        </c:when>
		                        <c:otherwise>
		                            ${projectInfo.adminName}
		                        </c:otherwise>
		                    </c:choose>
		                </td>
		                <td>${dto.pmCnt}</td>
		                <td>${projectInfo.memberCnt}</td>
		                <td>${projectInfo.outsiderCnt}</td>
		                <td>${projectInfo.boardCnt}</td>
		                <td>${projectInfo.commentCnt}</td>
		                <td>${projectInfo.chatCnt}</td>
		                <td>${projectInfo.scheduleCnt}</td>
		                <td>${projectInfo.taskCnt}</td>
		                <td>${projectInfo.lastActivity}</td>
		                <td>${projectInfo.openingDate}</td>
		            </tr>
		        </c:forEach>
				<c:choose>
					<c:when test="${projectList.size() == 0 }">
						<tr class="row">
							<td colspan="12">결과값이 존재하지 않습니다.</td>
						</tr>
					</c:when>
				</c:choose>
			</table>
			</div>
			<div class="delete-container">
				<div class="search-box">
					<div>
						<input type="text" name="search-text" class="search-text" placeholder="검색어를 입력해주세요">
						<input type="submit" value="검색" id="delSearchBtn" class="submit-btn">
						<div class="delete-btn">완전 삭제</div>
						<div class="delete-info">i</div>
					</div>
					<button class="excel-down"> 엑셀 다운로드</button>
				</div>
				<table class="delete-table" id="delProjectTable">
					<tr>
						<th style="width: 50px;"></th>
						<th style="width: 319.8px;">프로젝트</th>
						<th style="width: 175.59px;">관리자</th>
						<th style="width: 175.59px;">전체 참여자</th>
						<th style="width: 175.59px;">최근 활동일</th>
						<th style="width: 175.59px;">개설일</th>
						<th style="width: 175.59px;">삭제일</th>
						<th style="width: 175.59px;">삭제 유저명</th>
						<th style="width: 175.64px">비고</th>
					</tr>
					<c:forEach var="dto" items="${delProjectList}" varStatus="status">
			            <c:set var="adminInfo" value="${projectAdminInfoList[status.index]}" />
			            <tr class="del-row" data-idx="${dto.projectIdx}">
			                <td><input type="checkbox" class="checkbox"></td>
			                <td class="del-t-row">${dto.pName}</td>
			                <td class="del-t-row">
			                    <c:choose>
			                        <c:when test="${adminInfo.adminCnt > 1}">
			                            ${adminInfo.adminName} 외 ${adminInfo.adminCnt - 1}명
			                        </c:when>
			                        <c:otherwise>
			                            ${adminInfo.adminName}
			                        </c:otherwise>
			                    </c:choose>
			                </td>
			                <td class="del-t-row">${dto.participantCnt}</td>
			                <td class="del-t-row">${dto.lastActivity}</td>
			                <td class="del-t-row">${dto.openingDate}</td>
			                <td class="del-t-row">${dto.deleteDate}</td>
			                <td class="del-t-row">
			                    ${adminInfo.memberInfo.name}<br/>
			                    ${adminInfo.memberInfo.email}
			                </td>
			                <td><span class="restore">[복구]</span></td>
			            </tr>
			        </c:forEach>
					<%-- <%
					for(DelProjectDto dto : delProjectList) { 
						ArrayList<ProjectAdminDto> adminList = pDao.getProjectAdminInfo(companyIdx, dto.getProjectIdx());
						int adminCnt = adminList.size();
						String adminName = adminList.get(0).getName();
						MemberCompanyDepartmentDto memberInfo = mDao.getMemberInfo(dto.getDelMemberIdx());
					%>
					<%} %> --%>
					<c:choose>
						<c:when test="${delProjectList.size() == 0 }">
							<tr>
								<td colspan="9">결과값이 존재하지 않습니다.</td>
							</tr>
						</c:when>
					</c:choose>
				</table>
			</div>
		</div>
	</div>
</body>
</html>