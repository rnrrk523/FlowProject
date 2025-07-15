<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page import="dao.MemberDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dto.MemberCompanyDepartmentDto"%>
<%-- <%
	int companyIdx = 1;
//	int companyIdx = Integer.parseInt(request.getParameter("companyIdx"));
	int memberIdx = 2;
	MemberDao dao = new MemberDao();
	ArrayList<MemberCompanyDepartmentDto> memberInfoList = dao.getAllMembersAvailable(companyIdx);
	ArrayList<MemberCompanyDepartmentDto> stopUseMemberList = dao.getStopUseMember(companyIdx);
	ArrayList<MemberCompanyDepartmentDto> waitJoinStateMemberList = dao.getWaitJoinStateMember(companyIdx);
%> --%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>구성원 관리</title>
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
	<script>
		let _this;
		$(function() {
			/*페이지 이동*/
			$("#admin-1").click(function() {
				window.location.href = 'Controller?command=admin_page1&companyIdx='+${companyIdx}+'&memberIdx='+${memberIdx};
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
			$(".tab1").click(function() {
				$(this).css('border-bottom', '4px solid #307cff');
				$(this).css('font-weight', 'bold');
				$(this).css('cursor', 'default');
				
				$(".tab2").css('border-bottom', '1px solid #e7e7e9');
				$(".tab2").css('font-weight', 'normal');
				$(".tab2").css('cursor', 'pointer');
				
				$(".tab3").css('border-bottom', '1px solid #e7e7e9');
				$(".tab3").css('font-weight', 'normal');
				$(".tab3").css('cursor', 'pointer');
				
				$(".table-wrap1").css('display', 'block');
				$(".table-wrap2").css('display', 'none');
				$(".table-wrap3").css('display', 'none');
				
				$("#input-search").val("");
			});
			/*이용중지 탭 클릭*/
			$(".tab2").click(function() {
				$(this).css('border-bottom', '4px solid #307cff');
				$(this).css('font-weight', 'bold');
				$(this).css('cursor', 'default');
				
				$(".tab1").css('border-bottom', '1px solid #e7e7e9');
				$(".tab1").css('font-weight', 'bold');
				$(".tab1").css('cursor', 'pointer');
				
				$(".tab3").css('border-bottom', '1px solid #e7e7e9');
				$(".tab3").css('font-weight', 'bold');
				$(".tab3").css('cursor', 'pointer');
				
				$(".table-wrap1").css('display', 'none');
				$(".table-wrap2").css('display', 'block');
				$(".table-wrap3").css('display', 'none');
				
				$("#input-search").val("");
			});
			/*가입대기 탭 클릭*/
			$(".tab3").click(function() {
				$(this).css('border-bottom', '4px solid #307cff');
				$(this).css('font-weight', 'bold');
				$(this).css('cursor', 'default');
				
				$(".tab1").css('border-bottom', '1px solid #e7e7e9');
				$(".tab1").css('font-weight', 'bold');
				$(".tab1").css('cursor', 'pointer');
				
				$(".tab2").css('border-bottom', '1px solid #e7e7e9');
				$(".tab2").css('font-weight', 'bold');
				$(".tab2").css('cursor', 'pointer');
				
				$(".table-wrap1").css('display', 'none');
				$(".table-wrap2").css('display', 'none');
				$(".table-wrap3").css('display', 'block');
				
				$("#input-search").val("");
			});
			/*구성원 등록버튼 클릭*/
			$(".memberPlusBtn").click(function() {
				let nowDisplay = $(this).parent().next().css('display');
				if(nowDisplay == 'none'){
					$(this).parent().next().css('display', 'block');
				}else{
					$(this).parent().next().css('display', 'none');
				}
			});
			/*구성원 개별 등록버튼 클릭*/
			$("#member-add-individual-btn").click(function() {
				$(".member-add-bg").css('display', 'flex');
			});
			/*사용자 등록 창 닫기*/
			$(".member-add-close-btn").click(function() {
				$("#member-add-content-wrap").find('input[type="text"]').val("");
				$("#member-add-content-wrap").find('input[type="email"]').val("");
				$("#member-add-content-wrap").find('input[type="password"]').val("");
				$(".member-add-bg").css('display', 'none');
			});
			$("#member-add-cancel-btn").click(function() {
				$("#member-add-content-wrap").find('input[type="text"]').val("");
				$("#member-add-content-wrap").find('input[type="email"]').val("");
				$("#member-add-content-wrap").find('input[type="password"]').val("");
				$(".member-add-bg").css('display', 'none');
			});
			/*멤버 클릭*/
			$(document).on("click", ".member-select", function() {
				let nmae = $(this).parent().find('td:nth-child(2)').text();
				let email = $(this).parent().find('td:nth-child(5)').text();
				let departmentNmae = $(this).parent().find('td:nth-child(3)').text();
				let position = $(this).parent().find('td:nth-child(4)').text();
				let phone = $(this).parent().find('td:nth-child(6)').text();
				
				$("#alter-name").val(nmae);
				$("#member-alter-email-box").text(email);
				$("#alter-department").val(departmentNmae);
				$("#alter-position").val(position);
				$("#alter-phone").val(phone);
				
				_this = $(this).parent();
				$(".member-alter-bg").css('display', 'flex');
			});
			/*비밀번호 초기화 버튼 클릭*/
			$("#member-alter-pw-reset").click(function() {
				$(".reset-pw-bg").css('display', 'flex');
			});
			/*비밀번호 초기화 물음창 닫기*/
			$("#reset-pw-close-btn").click(function() {
				$(".reset-pw-bg").css('display', 'none');
			});
			/*비밀번호 초기화 물음창 취소*/
			$("#reset-pw-cancel-btn").click(function() {
				$(".reset-pw-bg").css('display', 'none');
			});
			/*비밀번호 초기화 물음창 확인*/
			$("#reset-pw-check-btn").click(function() {
				$(".reset-pw-bg").css('display', 'none');
				/*비밀번호 초기화 메소드 실행*/
				$("#member-alter-pw-reset").data("yn", 'Y');
			});
			/*수정창 닫기&취소*/
			$("#member-alter-close-btn").click(function() {
				$("#member-alter-content-box").find('input[type="text"]').val("");
				$(".member-alter-bg").css('display', 'none');
				
				$("#member-alter-pw-reset").data("yn", 'N');
			});
			$("#member-alter-cancel-btn").click(function() {
				$("#member-alter-content-box").find('input[type="text"]').val("");
				$(".member-alter-bg").css('display', 'none');
				
				$("#member-alter-pw-reset").data("yn", 'N');
			});
			/*수정창 저장하기*/
			$("#member-alter-record-btn").click(function() {
				let name = $("#alter-name").val();
				let departmentName = $("#alter-department").val();
				let position = $("#alter-position").val();
				let phone = $("#alter-phone").val();
				let pwResetYN = $("#member-alter-pw-reset").data("yn");
				let memberIdx = $(_this).data("idx");
				
				$(_this).find('td:nth-child(2)').text(name);
				$(_this).find('td:nth-child(3)').text(departmentName);
				$(_this).find('td:nth-child(4)').text(position);
				$(_this).find('td:nth-child(6)').text(phone);
				
				$.ajax({
					type: 'post',
					url: 'memberAlterAjax',
					data: {"pwResetYN":pwResetYN, "companyIdx":${companyIdx}, "memberIdx":memberIdx, "name":name, "departmentName":departmentName, "position":position, "phone":phone},
					success: function(){alert("수정되었습니다.");},
					eroor: function(r, s, e){
						console.log(r.status);
						console.log(r.responseText);
						console.log(e);
					}
				})
				
				$(".member-alter-bg").css('display', 'none');
			});
			/*이용중지 클릭*/
			$(".state-td").click(function() {
				_this = $(this).parent();
				
				$(".recheck-box").find("p").text("이용중지 처리하시겠습니까?");
				$(".use-stop-bg").css('display', 'flex');
			});
			/*이용중지 취소 클릭*/
			$("#recheck-cancel-btn").click(function() {
				$(".use-stop-bg").css('display', 'none');
			});
			/*이용중지 확인/해제 클릭*/
			$("#recheck-check-btn").click(function() {
				let idx = _this.parent().data("idx");
				$.ajax({
					type: 'post',
					url: 'useStopAjaxServlet',
					data: {
						"memberIdx":idx,
						"changerIdx":${memberIdx}
					},
					success: function() {
						location.reload();
						alert("수정이 완료되었습니다.");
					},
					error: function(r, s, e) {
						console.log(r.status);
						console.log(r.responseText);
						console.log(e);
					}
				})
			});
			/*이용중지 해제 클릭*/
			$(".use-stop-cancel-btn").click(function() {
				_this = $(this).parent();
				
				$(".recheck-box").find("p").text("이용중지 해제하시겠습니까?");
				$(".use-stop-bg").css('display', 'flex');		
			})
			/*관리자 삭제 클릭*/
			$(document).on("click", ".admin-td", function() {
				let _this = $(this);
				let yn = $(this).parent().text().charAt(0);
				let memberIdx = $(this).parent().parent().data("idx");
				let name = $(this).parent().parent().find('td:nth-child(2)').text();
				let email = $(this).parent().parent().find('td:nth-child(5)').text();
				if(memberIdx == ${memberIdx}){
					alert("본인이 본인 스스로 할 수 없습니다.");
				}else{
					$.ajax({
						type: 'post',
						url: 'adminChangeAjax',
						data: {
							"memberIdx":memberIdx,
							"name":name,
							"email":email,
							"yn":yn,
							"changerIdx":${memberIdx}
						},
						success: function(){
							if(yn == 'Y'){
								_this.parent().html('N <span class="admin-td">[지정]</span>');
							}else if(yn == 'N'){
								_this.parent().html('Y <span class="admin-td" style="color: red;">[삭제]</span>');
							}
						},
						error: function(r, s, e){
							console.log(r.status);
							console.log(r.responseText);
							console.log(e);
						}
					})
				}
			});
			/*구성원 일괄 등록/수정버튼 클릭*/
			$("#member-add-batch-btn").click(function() {
				$(".member-add-window").css('display', 'none');
				$(".main-box").css('display', 'none');
				$(".batch-container").css('display', 'block');
			});
			/*일괄등록 페이지에서 구성원 관리로 돌아가기*/
			$("#back-arrow-btn").click(function() {
				$(".main-box").css('display', 'block');
				$(".batch-container").css('display', 'none');
			});
			/*가입 대기탭에서  승인하기*/
			$(document).on("click", ".approval-btn", function() {
				let memberIdx = $(this).parent().parent().data("idx");
				$.ajax({
					type: 'post',
					url: 'memberApprovalAjaxServlet',
					data: {
						"changerIdx":${memberIdx},
						"memberIdx":memberIdx
					},
					success: function() {
						alert("승인 되었습니다.");
						location.reload();
					},
					error: function() {
						console.log(r.status);
						console.log(r.responseText);
						console.log(e);
					}
				})
			})
			/*가입 대기탭에서  거절하기*/
			$(document).on("click", ".refusal-btn", function() {
				let memberIdx = $(this).parent().parent().data("idx");
				$.ajax({
					type: 'post',
					url: 'memberRefusalAjaxServlet',
					data: {
						"memberIdx":memberIdx,
						"changerIdx":${memberIdx}
					},
					success: function() {
						alert("거절 되었습니다.");
						location.reload();
					},
					error: function() {
						console.log(r.status);
						console.log(r.responseText);
						console.log(e);
					}
				})
			})
			/*검색하기*/
			$(document).on("click", "#submit-btn", function() {
				let standard = $(this).prev().prev().val();
				let str = $(this).prev().val();
				let stateStr;
				if($(".table-wrap1").css('display') == 'block') {
					stateStr = '이용가능';
				}else if($(".table-wrap2").css('display') == 'block') {
					stateStr = '이용중지';
				}else if($(".table-wrap3").css('display') == 'block') {
					stateStr = '가입대기';
				}
				$.ajax({
					type: 'post',	
					data: {"companyIdx":${companyIdx}, "standard":standard, "str":str, "stateStr":stateStr},
					url: 'memberSearch2Ajax',
					success: function(data){
						console.log(data);
						if(stateStr == '이용가능'){
							$(".remove-tr1").remove();
							if(data.length != 0){
								for(let i=0; i<=data.length-1; i++){
									let appendContent = '<tr class="member-info-tr remove-tr1" data-idx="'+data[i].memberIdx+'">' +
															'<td class="member-select">'+data[i].companyName+'</td>' +
															'<td class="member-select">'+data[i].name+'</td>';
															if(data[i].departmentName != null){
																appendContent += '<td class="member-select">'+data[i].departmentName+'</td>';
															}else{
																appendContent += '<td class="member-select"></td>';
															}
															if(data[i].position != null){
																appendContent += '<td class="member-select">'+data[i].position+'</td>';
															}else{
																appendContent += '<td class="member-select"></td>';
															}
															appendContent += '<td class="member-select">'+data[i].email+'</td>';
															if(data[i].phone != null){
																appendContent += '<td class="member-select">'+data[i].phone+'</td>';
															}else{
																appendContent += '<td class="member-select"></td>';
															}
															appendContent += '<td>'+data[i].hireDate+'</td>'+
															'<td>정상 <span class="state-td" style="color: black;">[이용중지]</span></td>';
															if(data[i].adminYN == 'Y'){
																appendContent += '<td>'+data[i].adminYN+" <span class=\"admin-td\" style=\"color: red;\">[삭제]</span>"+'</td>';
															}else if(data[i].adminYN == 'N') {
																appendContent += '<td>'+data[i].adminYN+" <span class=\"admin-td\">[지정]</span>"+'</td>';
															}
															appendContent += '</tr>';
									$(".table1").append(appendContent);
								}
							}else{
								let appendContent = '<tr class="nothing-tr remove-tr1">' +
														'<td colspan="9">결과값이 존재하지 않습니다.</td>' +
													'</tr>';
								$(".table1").append(appendContent);
							}
						}else if(stateStr == '이용중지') {
							$(".remove-tr2").remove();
							if(data.length != 0){
								for(let i=0; i<=data.length-1; i++){
									let appendContent = '<tr class="remove-tr2">' +
															'<td>'+data[i].companyName+'</td>' +
															'<td>'+data[i].name+'</td>';
															if(data[i].departmentName != null){
																appendContent += '<td>'+data[i].departmentName+'</td>';
															}else{
																appendContent += '<td></td>';
															}
															if(data[i].position != null){
																appendContent += '<td>'+data[i].position+'</td>';
															}else{
																appendContent += '<td></td>';
															}
															appendContent += '<td>'+data[i].email+'</td>';
															if(data[i].phone != null){
																appendContent += '<td>'+data[i].phone+'</td>';
															}else{
																appendContent += '<td></td>';
															}
															appendContent += '<td>'+data[i].hireDate+'</td>'+
															'<td>이용중지 <span id="use-stop-cancel-btn">[해제]</span></td>'+
															'<td></td>'+
															'<td><span id="member-del-btn">삭제</span></td>';
															appendContent += '</tr>';
									$(".table2").append(appendContent);
								}
							}else{
								let appendContent = '<tr class="nothing-tr remove-tr2">' +
														'<td colspan="9">결과값이 존재하지 않습니다.</td>' +
													'</tr>';
								$(".table2").append(appendContent);
							}
						}else if(stateStr == '가입대기') {
							$(".remove-tr3").remove();
							if(data.length != 0){
								for(let i=0; i<=data.length-1; i++){
									let appendContent = '<tr class="remove-tr3" data-idx="'+data[i].memberIdx+'">' +
															'<td>'+data[i].name+'</td>';
															appendContent += '<td>'+data[i].email+'</td>';
															appendContent += '<td>'+data[i].hireDate+'</td>'+
															'<td><span class="approval-btn">[승인]</span> <span class="refusal-btn">[거절]</span></td>';
															appendContent += '</tr>';
									$(".table3").append(appendContent);
								}
							}else{
								let appendContent = '<tr class="nothing-tr remove-tr3">' +
														'<td colspan="4">결과값이 존재하지 않습니다.</td>' +
													'</tr>';
								$(".table3").append(appendContent);
							}
						}
					},
					error: function(r, s, e) {
						console.log(r.status);
						console.log(r.responseText);
						console.log(e);
					}
				});
			});
			/*구성원 등록 저장하기*/
			$("#member-add-record-btn").click(function() {
				let name = $("#member-add-input-name").val();
				let email = $("#member-add-input-email").val();
				let pw = $("#member-add-input-pw").val();
				let department = $("#member-add-input-department").val();
				let position = $("#member-add-input-position").val();
				let phone = $("#member-add-input-phone").val();
				
				$.ajax({
					type: 'post',
					url: 'memberAddAjax',
					data: {
						"companyIdx":${companyIdx}, 
						"name":name, "email":email, 
						"pw":pw, "department":department,
						"position":position, 
						"phone":phone,
						"changerIdx":${memberIdx}
					},
					success: function(data) {
						if(data.addYN){
							alert("등록 되었습니다.");
						}else{
							alert("등록의 실패하였습니다.");
						}
						location.reload();
					},
					error: function(r, s, e){
						console.log(r.status);
						console.log(r.responseText);
						console.log(e);
					}
				})
			})
			/*구성원 삭제버튼 클릭*/
			$(".member-del-btn").click(function() {
				_this = $(this).parent().parent().data("idx");
				let name = $(this).parent().parent().find("td:nth-child(2)").text();
				$("#member-del-name").text(name);
				$(".member-del-bg").css('display', 'flex');
			})
			/*구성원 삭제창에서 삭제버튼 클릭*/
			$("#member-del-remove-btn").click(function() {
				let memberIdx = _this;
				if($(this).hasClass('member-del-on-btn')){
					$.ajax({
						type: 'post',
						url: 'memberDeleteAjaxServlet',
						data: {
							"memberIdx":memberIdx,
							"changerIdx":${memberIdx}
						},
						success: function(data) {
							location.reload();
							alert("'"+data.email+"'삭제처리하였습니다.");
						},
						error: function(r, s, e) {
							console.log(r.status);
							console.log(r.responseText);
							console.log(e);
						}
					})
				}
			})
			$(document).ready(function() {
				$('.member-del-agree').change(function() {
					let allChecked = $(".member-del-agree").length === $('input.member-del-agree:checked').length;
					
					if(allChecked) {
						$("#member-del-remove-btn").addClass('member-del-on-btn');
					}else{
						$("#member-del-remove-btn").removeClass('member-del-on-btn');
					}
				})
			})
			/*구성원 삭제창 닫기*/
			$("#member-del-cancel-btn").click(function() {
				$(".member-del-agree").each(function() {
					$(this).prop('checked', false);
				})
				$("#member-del-remove-btn").removeClass('member-del-on-btn');
				$(".member-del-bg").css('display', 'none');
			})
			/*구성원 일괄등록 -> 행추가*/
			$("#col-add-btn").click(function() {
				let newRow = '<tr class="newTr">' +
								'<td><input type="checkbox" class="select-member-row-checkbox"/></td>' +
								'<td><input class="essential input-err" type="text"/></td>' +
								'<td><input class="essential input-err" type="email"/></td>' +
								'<td><input type="text"/></td>' +
								'<td><input type="text"/></td>' +
								'<td><input type="text"/></td>' +
							'</tr>';
				$("#batch-table").append(newRow);
				
			})
			/*등록가능한 row수 카운트*/
			$("button").on("click", function(event){
				let ALL_cnt = $('.newTr').length;
				let OK_cnt = $('.classOK').length;
				let NOT_OK_cnt = (ALL_cnt)-(OK_cnt);
				
				$("#batch-tuple-cnt").text(ALL_cnt);
				$("#OK-Cnt").text(OK_cnt);
				$(".NOT-Cnt").text(NOT_OK_cnt);
			})
			$(document).ready(function() {
				/*구성원 일괄등록 -> 모든행 선택*/
				$("#checkbox-th").change(function() {
					if($(this).is(':checked')){
						$('.select-member-row-checkbox').prop('checked', true);
					}else{
						$('.select-member-row-checkbox').prop('checked', false);
					}
				})
				/*input태그의 형식체크*/
				$(document).on('change', '.essential', function() {
					let nullCheck = $(this).val() !== "";
					if(this.validity.valid && nullCheck){
						$(this).removeClass('input-err');
					}else{
						$(this).addClass('input-err');
					}
					/*형식에 맞는 row의 class부여*/
					$('.newTr').each(function() {
						let cnt = $(this).find('.input-err').length;
						
						if(cnt === 0){
							$(this).addClass('classOK');
							let ALL_cnt = $('.newTr').length;
							let OK_cnt = $('.classOK').length;
							let NOT_OK_cnt = (ALL_cnt)-(OK_cnt);
							
							$("#batch-tuple-cnt").text(ALL_cnt);
							$("#OK-Cnt").text(OK_cnt);
							$(".NOT-Cnt").text(NOT_OK_cnt);
						}else{
							$(this).removeClass('classOK');
							let ALL_cnt = $('.newTr').length;
							let OK_cnt = $('.classOK').length;
							let NOT_OK_cnt = (ALL_cnt)-(OK_cnt);
							
							$("#batch-tuple-cnt").text(ALL_cnt);
							$("#OK-Cnt").text(OK_cnt);
							$(".NOT-Cnt").text(NOT_OK_cnt);
						}
					})
				})
			})
			/*구성원 일괄등록 -> 행삭제*/
			$("#batch-del-btn").click(function() {
				$('input.select-member-row-checkbox:checked').each(function() {
					$(this).parent().parent().remove();
				})
				$("#checkbox-th").prop('checked', false);
				
				let ALL_cnt = $('.newTr').length;
				let OK_cnt = $('.classOK').length;
				let NOT_OK_cnt = (ALL_cnt)-(OK_cnt);
				
				$("#batch-tuple-cnt").text(ALL_cnt);
				$("#OK-Cnt").text(OK_cnt);
				$(".NOT-Cnt").text(NOT_OK_cnt);
			})
			/*구성원 일괄등록 -> 등록*/
			$("#batch-add-btn").click(function() {
				let pass =  $('.newTr').length === $('.classOK').length;
				if(pass){
					$('.newTr').each(function() {
						let trName = $(this).find('td:nth-child(2)').find('input').val();
						let trEmail = $(this).find('td:nth-child(3)').find('input').val();
						let trPhone = $(this).find('td:nth-child(4)').find('input').val();
						let trDepartmentIdx = $(this).find('td:nth-child(5)').find('input').val();
						let trPosition = $(this).find('td:nth-child(6)').find('input').val();
						
						$.ajax({
							type: 'post',
							url: 'memberBatchRegisterServlet',
							data: {"companyIdx":${companyIdx}, "name":trName, "email":trEmail, "phone":trPhone, "departmentIdx":trDepartmentIdx, "position":trPosition},
							success: function() {},
							error: function(r, s, e) {}
						})
					})
					alert("등록이 완료 되었습니다.");
					location.reload();
				}else{
					alert("등록 불가능한 행이 존재합니다.");
				}
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
	h1{
		color: #111;
		font-size: 19px;
	}
	.main-box{
		padding: 21px 30px 25px 30px;
		width: 1600px;
	}
	.main-title{
		width: 1120px;
		height: 39px;
		padding-bottom: 14px;
	}
	.info-box{
		width: 1600px;
		height: 146px;
		margin-bottom: 20px;
		padding: 15px 130px 15px 20px;
		background-color: #f9f9fb;
		border-top: 1px solid #e6e6e6;
	}
	li{
		font-size: 12px;
		letter-spacing: -1px;
		height: 24px;
	}
	.list-in{
		list-style-type: none;
		margin-left: 10px;
	}
	.list-in::before{
		content: "*";
		margin-right: 2px;
	}
	.tab-box{
		display: flex;
		width: 1600px;
		height: 41px;
		margin-top: 30px;
		border-bottom: 1px solid #c5c6cb;
	}
	.tab1{
		width: 120px;
		height: 100%;
		margin-right: -1px;
		text-align: center;
		border-radius: 7px 0 0 0;
		line-height: 38px;
		border: 1px solid #e7e7e9;
		border-bottom: 4px solid #307cff;
		font-weight: bold;
		cursor: default;
	}
	.tab2{
		width: 120px;
		height: 100%;
		margin-right: -1px;
		text-align: center;
		line-height: 38px;
		border: 1px solid #e7e7e9;
		cursor: pointer;
	}
	.tab3{
		width: 120px;
		height: 100%;
		margin-right: -1px;
		text-align: center;
		border-radius: 0 7px 0 0;
		line-height: 38px;
		border: 1px solid #e7e7e9;
		cursor: pointer;
	}
	#use-cnt::before{
		content: "(";
	}
	#use-cnt::after{
		content: ")";
	}
	#stop-cnt::before{
		content: "(";
	}
	#stop-cnt::after{
		content: ")";
	}
	#join-cnt::before{
		content: "(";
	}
	#join-cnt::after{
		content: ")";
	}
	.table-search-box{
		position: relative;
		display: flex;
		justify-content: space-between;
		margin-top: 15px;
		width: 1600px;
		font-size: 14px;
	}
	.left-div{
		display: flex;
		justify-content: space-between;
		width: 401px;
		height: 32px;
	}
	.right-div{
		display: flex;
	}
	#excelDownBtn{
		display: inline-block;
		cursor: pointer;
		line-height: 16px;
		font-size: 12px;
		color: #4C80D6;
		margin: 0px 15px 0px 0px;
		padding: 7px 0px 1px 21px;
	}
	#excelDownBtn::before{
		content: url('https://flow.team/design2/flow_admin_2019/img/ico_down.png');
	}
	.memberPlusBtn{
		width: 111px;
		height: 32px;
		color: #3D4044;
		font-size: 14px;
		font-weight: bold;
		line-height: 29px;
		padding: auto;
		border: 1px solid #c5c6cb;
		border-radius: 2px;
		text-align: center;
		cursor: pointer;
	}
	.memberPlusBtn:hover{
		color: #000;
		border: 1px solid #999aa0;
	}
	.select-box{
		width: 100px;
		height: 32px;
		border: 1px solid #E6E6E6;
		outline: none;
	}
	#input-search{
		width: 220px;
		height: 30px;
		font-size: 13px;
		border: 1px solid #E6E6E6;
		padding-left: 10px;
		line-height: 1.4em;
		outline: none;
	}
	#input-search::placeholder{
		color: lightgray;
	}
	#submit-btn{
		width: 68px;
		height: 30px;
		padding: 0px 20px;
		border: 1px solid #C5C6CB;
		border-radius: 2px;
		background-color: #FFF;
		line-height: 28px;
		font-weight: bold;
		line-height: 28px;
		text-align: center;
		cursor: pointer;
	}
	.table-box{
		margin-top: 30px;
		width: 1600px;
	}
	.member-info-tr {
		cursor: pointer;
	}
	.member-info-tr:hover{
		background-color: #ECECEF;
	}
	table{
		border-collapse: collapse;
		width: 1600px;
		text-align: center;
		font-size: 13px;
		border: 1px solid #e7e7e9;
		color: #111;
	}
	th{
		height: 37px;
		background-color: #f9f9fb;
		border: 1px solid #e7e7e9;
	}
	td{
		padding: 8px;
		height: 49px;
		border: 1px solid #e7e7e9;
	}
	#th-company1::after{
		content: "▲";
		font-size: 10px;
	}
	#th-name1::after{
		content: "▼";
		font-size: 10px;
	}
	#th-name3::after{
		content: "▲";
		font-size: 10px;
	}
	#th-department1::after{
		content: "▼";
		font-size: 10px;
	}
	#th-position1::after{
		content: "▼";
		font-size: 10px;
	}
	#th-email1::after{
		content: "▼";
		font-size: 10px;
	}
	#th-phone1::after{
		content: "▼";
		font-size: 10px;
	}
	#th-hireDate1::after{
		content: "▼";
		font-size: 10px;
	}
	#th-admin1::after{
		content: "▼";
		font-size: 10px;
	}
	.th1 > th{
		width: 11.11%;
	}
	.th2 > th{
		width: 10%;
	}
	.th3 > th{
		width: 25%;
	}
	.member-add-window{
		position: absolute;
		top: 37px;
		right: 0;
		width: 132px;
		height: 66px;
		padding: 5px 0;
		background-color: #FFF;
		text-align: center;
		border: 1px solid #C5C6CB;
		border-radius: 2px;
	}
	.member-add-window p{
		font-size: 13px;
		cursor: pointer;
		color: #333;
		height: 27px;
		line-height: 27px;
	}
	.member-add-window p:hover{
		background-color: #ECECEF;
	}
	.member-add-bg{
		position: absolute;
		display: flex;
		justify-content: center;
		align-items: center;
		width: 100%;
		height: 100%;
		background: rgb(0, 0, 0, .3);
		z-index: 999;
	}
	.member-add-box{
		width: 500px;
		height: 594px;
		padding: 25px 30px 30px;
		background-color: #FFF;
	}
	#member-add-header{
		display: flex;
		justify-content: space-between;
		align-items: center;
		width: 440px;
		height: 43px;
		padding-bottom: 14px;
		font-weight: 700;
		border-bottom: 1px solid rgb(230, 230, 230);
	}
	#member-add-header h1{
		color: #111;
		font-size: 19px;
	}
	#member-add-header div{
		background: url(https://flow.team/design2/flow_admin_2019/img/btn_popclose.gif) no-repeat center center;
		width: 30px;
		height: 30px;
		cursor: pointer;
	}
	#member-add-content-wrap{
		width: 440px;
		height: 415px;
		margin-top: 10px;
	}
	#ess-info, #add-info{
		width: 440px !important;
	}
	.member-add-input {
		width: 335px;
		height: 30px;
		padding-left: 10px;
		background-color: #FFF;
		font-size: 13px;
		border: 1px solid rgb(230, 230, 230);
		border-radius: 1px;
		outline: none;
		
	}
	#member-add-content-wrap table{
		border-collapse: collapse;
		border: none;
		border-spacing: 10px;
	}
	#member-add-content-wrap td{
		border: none;
		padding: 5px 0 6px;
	}
	#ess-info th{
		width: 100px;
		height: 41px !important;
		font-size: 14px;
		padding: 5px 0 6px;
		text-align: left;
		font-weight: bold;
		border: none;
		background-color: #FFF;
	}
	#ess-info td{
		height: 41px !important;
	}
	#add-info th{
		width: 100px;
		height: 41px !important;
		font-size: 14px;
		padding: 5px 0 6px;
		text-align: left;
		font-weight: bold;
		border: none;
		background-color: #FFF;
	}
	#add-info td{
		height: 41px !important;
	}
	#member-add-content-wrap p {
		width: 440px;
		height: 24px;
		font-size: 13px;
		line-height: 24px;
	}
	.member-add-mini-info{
		width: 440px;
		height: 20px;
		color: #307CFF;
		font-size: 14px;
		font-weight: bold;
		margin-bottom: 10px;
	}
	.hr{
		width: 440px;
		height: 1px;
		margin: 20px 0;
		border-bottom: 1px solid rgb(230, 230, 230);
	}
	#member-add-record-btn{
		cursor: pointer;
		color: #FFF;
		background-color: rgb(48, 124, 255);
		width: 120px;
		height: 36px;
		font-size: 16px;
		border: 1px solid rgb(197, 198, 203);
		border-radius: 3px;
	}
	#member-add-cancel-btn{
		cursor: pointer;
		color: #333;
		background-color: #FFF;
		width: 120px;
		height: 36px;
		font-size: 16px;
		margin-left: 10px;
		border: 1px solid rgb(197, 198, 203);
		border-radius: 3px;
	}
	#member-add-btn-box{
		display: flex;
		justify-content: center;
		align-items: center;
		margin-top: 30px;
	}
	#add-info {
		margin-bottom: 20px;
	}
	.member-alter-bg{
		position: absolute;
		display: flex;
		justify-content: center;
		align-items: center;
		width: 100%;
		height: 100%;
		background: rgb(0, 0, 0, .3);
		z-index: 999;
	}
	#member-alter-box{
		width: 500px;
		padding: 25px 30px 30px;
		background-color: #FFF;
	}
	#member-alter-header{
		display: flex;
		justify-content: space-between;
		align-items: center;
		padding-bottom: 14px;
		border-bottom: 1px solid rgb(230, 230, 230);
	}
	#member-alter-header div:first-child{
		font-size: 19px;
		color: #111;
		font-weight: 700;
	}
	#member-alter-close-btn{
		background: url(https://flow.team/design2/flow_admin_2019/img/btn_popclose.gif) no-repeat center center;
		width: 30px;
		height: 30px;
		cursor: pointer;
	}
	#member-alter-content-box{
		margin-top: 10px;
	}
	.alter-input{
		width: 335px;
		height: 30px;
		background-color: #FFF;
		padding-left: 10px;
		font-size: 13px;
		border: 1px solid rgb(230, 230, 230);
		border-radius: 1px;
		color: #333;
		outline: none;
	}
	.member-alter-mini-title{
		width: 440px;
		height: 20px;
		color: #307CFF;
		font-size: 14px;
		font-weight: bold;
		margin-bottom: 10px;
	}
	#member-alter-ess-info, #member-alter-add-info{
		border: none;
		text-align: left;
		width: 440px !important;
	}
	#member-alter-add-info{
		margin-bottom: 20px;
	}
	#member-alter-ess-info th{
		background-color: #FFF;
		border: none;
		width: 100px !important;
		height: 41px !important;
	}
	#member-alter-ess-info td{
		background-color: #FFF;
		border: none;
		height: 41px !important;
	}
	#member-alter-add-info th{
		background-color: #FFF;
		border: none;
		width: 100px !important;
		height: 41px !important;
	}
	#member-alter-add-info td{
		background-color: #FFF;
		border: none;
		height: 41px !important;
	}
	#member-alter-email-box{
		width: 335px;
		height: 30px;
		padding-left: 10px;
		font-size: 13px;
		border: 1px solid rgb(230, 230, 230);
		border-radius: 1px;
		background-color: #EFEFEF4D;
		line-height: 28px;
	}
	#member-alter-pw-reset{
		font-size: 14px;
		color: #333;
		cursor: pointer;
	}
	#member-alter-pw-reset:hover{
		font-weight: bold;
		text-decoration: underline;
	}
	#member-alter-content-box p{
		width: 440px;
		height: 24px;
		font-size: 13px;
	}
	.member-alter-btn-box{
		width: 440px;
		height: 36px;
		margin-top: 30px;
		text-align: center;
	}
	#member-alter-record-btn{
		width: 120px;
		height: 36px;
		color: #FFF;
		font-size: 16px;
		background-color: #307CFF;
		cursor: pointer;
		border: 1px solid rgb(197, 198, 203);
		border-radius: 3px;
	}
	#member-alter-cancel-btn{
		width: 120px;
		height: 36px;
		color: #333;
		font-size: 16px;
		background-color: #FFF;
		margin-left: 10px;
		cursor: pointer;
		border: 1px solid rgb(197, 198, 203);
		border-radius: 3px;
	}
	.state-td:hover{
		font-weight: bold;
		text-decoration: underline;
		cursor: pointer;
	}
	.admin-td:hover{
		font-weight: bold;
		text-decoration: underline;
		cursor: pointer;
	}
	.use-stop-bg{
		position: absolute;
		display: flex;
		justify-content: center;
		align-items: center;
		width: 100%;
		height: 100%;
		background: rgb(0, 0, 0, .6);
		z-index: 999;
	}
	.recheck-box{
		width: 450px;
		height: 133px;
		background-color: #FFF;
		padding: 20px;
		border-radius: 10px;
	}
	.recheck-box p{
		width: 410px;
		height: 20px;
		margin: 12px 0 25px;
		text-align: center;
		font-size: 14px;
	}
	#recheck-btn-box {
		display: flex;
		justify-content: center;
		align-items: center;
		width: 410px;
		height: 36px;
	}
	#recheck-cancel-btn{
		width: 193px;
		height: 36px;
		color: #555;
		font-size: 13px;
		line-height: 34px;
		border: 1px solid #DDD;
		border-radius: 4px;
		cursor: pointer;
		text-align: center;
	}
	#recheck-check-btn{
		color: #FFF;
		background-color: #6449fc;
		margin-left: 8px;
		width: 193px;
		height: 36px;
		line-height: 34px;
		border: 1px solid #DDD;
		border-radius: 4px;
		font-size: 13px;
		cursor: pointer;
		text-align: center;
	}
	.batch-container{
		position: relative;
		padding: 21px 30px 25px 30px;
		background-color: #FFF;
	}
	#batch-header{
		padding-bottom: 14px;
		display: flex;
		align-items: center;
		border-bottom: 1px solid #E6E6E6;
		width: 1600px;
		height: 39px;
	}
	#back-arrow-btn{
		width: 20px;
		height: 20px;
		margin-right: 10px;
		background: url(https://flow.team/design2/flow_admin_2019/img/ico_popup_back.svg) no-repeat center center;
		cursor: pointer;
	}
	#batch-info-box{
		background-color: #F9F9FB;
		margin-top: 20px;
		padding: 15px 130px 15px 20px;
		width: 1600px;
		height: 126px;
	}
	#batch-info-box p {
		font-size: 12px;
		line-height: 24px;
		color: #4C4D4E;
	}
	#batch-info-box p::before{
		content: '•';
		font-size: 16px;
		margin-right: 8px;
	}
	#batch-info-box span{
		line-height: 24px;
		font-size: 12px;
		color: #4C4D4E;
		margin-left: 10px;
	}
	#file-registration-box{
		width: 1600px;
		height: 96px;
		padding-top: 25px;
		padding-bottom: 15px;
	}
	#file-registration-box > div{
		display: flex;
		align-items: center;
		width: 1600px;
		height: 32px;
	}
	#batch-file-input-btn{
		color: #FFF;
		background-color: #307CFF;
		padding: 0 10px;
		height: 30px;
		line-height: 28px;
		font-size: 14px;
		font-weight: bold;
		border: 1px solid #307CFF;
		border-radius: 2px;
		cursor: pointer;
		margin-left: 5px;
	}
	#batch-excel-down-btn{
		padding: 0 10px;
		height: 30px;
		line-height: 20px !important;
		font-size: 14px;
		color: #4C4C4C;
		font-weight: bold;
		border: 1px solid #C9C9C9;
		border-radius: 2px;
		background-color: #FFF;
		cursor: pointer;
		text-align: center;
		margin-left: 5px;
	}
	#batch-excel-down-btn::before{
		display: inline-block;
		content: "";
		width: 16px;
		height: 16px;
		margin: 7px 5px 0 0;
		background: url(https://flow.team/img/ico/ico_download_admin.png) no-repeat;
	}
	#batch-file-input{
		cursor: pointer;
		border: 1px solid #E6E6E6;
		border-radius: 1px;
		width: 300px;
		height: 32px;
		background-color: #FFF;
		padding-left: 10px;
		font-size: 13px;
		color: #C7C7CC;
		outline: none;
		text-align: left;
	}
	#file-registration-box p{
		font-size: 13px;
		color: #A2A2A2;
		margin-top: 5px;
	}
	#table-filter-btn-box{
		display: flex;
		justify-content: space-between;
		align-items: center;
		font-size: 14px;
		width: 1600px;
	}
	#batch-excel-menu{
		margin-bottom: 8px;
		height: 30px;
	}
	#col-add-btn, #batch-del-btn{
		padding: 0 10px;
		height: 30px;
		line-height: 28px;
		font-size: 14px;
		color: #4C4C4C;
		font-weight: bold;
		border: 1px solid #C9C9C9;
		border-radius: 2px;
		background-color: #FFF;
		text-align: center;
		cursor: pointer;
	}
	#batch-add-btn{
		color: #FFF;
		border: 1px solid #307CFF;
		background-color: #307CFF;
		border-radius: 2px;
		padding: 0 10px;
		height: 30px;
		line-height: 28px;
		font-size: 14px;
		font-weight: bold;
		text-align: center;
		cursor: pointer;
	}
	.red{
		color: red;
	}
	#table-filter-btn-box input[type="checkbox"]{
		width: 16px;
		height: 16px;
	}
	#table-filter-btn-box label{
		margin: -6px 0 0 12px;
	}
	#table-filter-btn-box > div:nth-child(1){
		float: left;
		height: 20px;
	}
	.bold-span{
		font-weight: bold;
	}
	#batch-table{
		width: 1600px !important;
		border-collapse: collapse;
	}
	#batch-table th{
		width: 196.13px;
		height: 37px;
	}
	#batch-table input[type="text"],
	#batch-table input[type="email"]{
		width: 179.13px;
		height: 30px;
		background-color: #FFF;
		padding-left: 10px;
		border: none;
	}
	#batch-table input[type="checkbox"]{
		width: 13px;
		height: 13px;
	}
	#checkbox-th{
		width: 16px !important;
		height: 16px !important;
	}
	.input-err{
		border: 2px solid red !important;
	}
	.reset-pw-bg{
		position: absolute;
		display: flex;
		justify-content: center;
		align-items: center;
		width: 100%;
		height: 100%;
		background: rgb(0, 0, 0, .6);
		z-index: 999;
	}
	#reset-pw-box{
		width: 380px;
		height: 153px;
		background-color: #FFF;
		border-radius: 8px;
	}
	#reset-pw-header{
		display: flex;
		justify-content: space-between;
		align-items: center;
		width: 380px;
		height: 43px;
		color: #111;
		font-size: 16px;
		padding: 16px;
		background-color: #F4F4F4;
		border-radius: 8px 8px 0 0;
	}
	#reset-pw-body{
		width: 380px;
		height: 110px;
		padding: 20px;
	}
	#reset-pw-body p{
		text-align: center;
		font-size: 14px;
		color: #4F545D;
	}
	#reset-pw-btn-box{
		display: flex;
		justify-content: center;
		align-items: center;
		width: 340px;
		height: 36px;
		margin-top: 15px;
		text-align: center;
	}
	#reset-pw-cancel-btn{
		margin-right: 10px;
		width: 153px;
		height: 30px;
		font-size: 14px;
		color: rgb(76, 76, 76);
		font-weight: bold;
		border: 1px solid rgb(201, 201, 201);
		border-radius: 2px;
		background-color: rgb(255, 255, 255);
		cursor: pointer;
	}
	#reset-pw-check-btn{
		color: rgb(255, 255, 255);
		border: 1px solid rgb(201, 201, 201);
		background-color: rgb(48, 124, 255);
		width: 153px;
		height: 30px;
		font-size: 14px;
		font-weight: bold;
		border-radius: 2px;
		cursor: pointer;
	}
	#reset-pw-close-btn{
		width: 14px;
		height: 14px;
		background-image: url(https://flow.team/design2/img_rn/btn/btn_layerstyle4_close2.png?1);
		cursor: pointer;
	}
	.member-del-btn{
		color: red;
		cursor: pointer;
	}
	.member-del-btn:hover{
		font-weight: bold !important;
		text-decoration: underline !important;
	}
	.use-stop-cancel-btn{
		cursor: pointer;
	}
	.use-stop-cancel-btn:hover{
		font-weight: bold !important;
		text-decoration: underline !important;
	}
	.approval-btn{
		color: blue;
		cursor: pointer;
		font-weight: bold !important;
	}
	.approval-btn:hover{
		text-decoration: underline;
	}
	.refusal-btn{
		color: red;
		cursor: pointer;
		font-weight: bold !important;
	}
	.refusal-btn:hover{
		text-decoration: underline;
	}
	.member-del-bg{
		position: absolute;
		display: flex;
		justify-content: center;
		align-items: center;
		width: 100%;
		height: 100%;
		background: rgb(0, 0, 0, .6);
		z-index: 999;
	}
	#member-del-box{
		position: relative;
		width: 600px;
		border: 1px solid grey;
		background-color: #FFF;
		font-size: 1em;
	}
	#member-del-header{
		font-size: 16px;
		background-color: #f0f0f0;
		padding: 10px;
	}
	#member-del-body{
		padding: 10px 10px 10px 15px;
	}
	#member-del-title{
		font-weight: 900;
		padding: 10px 0 20px 0;
		font-size: 14px;
	}
	.member-del-check-row{
		padding: 5px 0 10px 0;
		font-size: 14px;
	}
	.member-del-check-row input{
		width: 16px;
		height: 16px;
		border: 1px solid #b2b2b2;
		border-radius: 1px;
		cursor: pointer;
	}
	#member-del-footer{
		text-align: center;
		padding: 0 0 20px 0;
	}
	#member-del-cancel-btn{
		cursor: pointer;
		background-color: #FFF;
		width: 60px;
		padding: 0 10px;
		font-weight: bold;
		border: 1px solid black;
		border-radius: 3px;
		height: 28px;
		color: #333;
	}
	#member-del-remove-btn{
		margin-left: 10px;
		cursor: normal;
		background-color: #ccc;
		color: #666;
		width: 60px;
		padding: 0 10px;
		font-weight: bold;
		border: 1px solid black;
		border-radius: 3px;
		height: 28px;
	}
	.member-del-on-btn{
		background-color: #4451ff !important;
		color: #FFF !important;
	}
</style>
<body>
	<div class="all-container">
		<div class="member-add-bg" style="display: none;">
			<div class="member-add-box">
				<div id="member-add-header">
					<h1>사용자 등록</h1>
					<div class="member-add-close-btn"></div>
				</div>
				<div id="member-add-content-wrap">
					<p class="member-add-mini-info">필수정보</p>
					<table id="ess-info">
						<tr>
							<th>이름*</th>
							<td><input id="member-add-input-name" name="name" type="text"
								placeholder="이름을 입력해주세요." class="member-add-input"/></td>
						</tr>
						<tr>
							<th>이메일*</th>
							<td><input id="member-add-input-email" name="email"
								type="email" placeholder="이메일을 입력해주세요." class="member-add-input"/></td>
						</tr>
						<tr>
							<th>비밀번호*</th>
							<td><input id="member-add-input-pw" name="pw"
								type="password" placeholder="8자 이상, 숫자/문자/특수기호를 포함해야합니다." class="member-add-input"/></td>
						</tr>
					</table>
					<div class="hr"></div>
					<p class="member-add-mini-info">추가정보</p>
					<table id="add-info">
						<tr>
							<th>부서명</th>
							<td><input id="member-add-input-department" name="departmentName"
								type="text" placeholder="부서명을 입력해주세요." class="member-add-input"/></td>
						</tr>
						<tr>
							<th>직급</th>
							<td><input id="member-add-input-position" name="position"
								type="text" placeholder="직급을 입력해주세요." class="member-add-input"/></td>
						</tr>
						<tr>
							<th>휴대폰 번호</th>
							<td><input id="member-add-input-phone" name="phone" type="text"
								placeholder="숫자만 입력해주세요." class="member-add-input"/></td>
						</tr>
					</table>
					<p>※ 사용자 등록 후, "이메일 주소/비밀번호" 입력하여 로그인 가능합니다.</p>
					<p>※ 비밀번호는 웹화면 [설정>비밀번호 변경] 메뉴에서 추후 변경할 수 있습니다.</p>
					<div id="member-add-btn-box">
						<button type="submit" id="member-add-record-btn">저장</button>
						<button type="button" id="member-add-cancel-btn">취소</button>
					</div>
				</div>
			</div>
		</div>
		<div class="member-alter-bg" style="display: none;">
			<div id="member-alter-box">
				<div id="member-alter-header">
					<div>수정</div>
					<div id="member-alter-close-btn"></div>
				</div>
				<div id="member-alter-content-box">
					<div class="member-alter-mini-title">필수정보</div>
					<table id="member-alter-ess-info">
						<tr>
							<th>이름*</th>
							<td><input class="alter-input" id="alter-name" type="text" placeholder="이름을 입력해주세요."/></td>
						</tr>
						<tr>
							<th>이메일*</th>
							<td><div id="member-alter-email-box"></div></td>
						</tr>
						<tr>
							<th>비밀번호*</th>
							<td><span id="member-alter-pw-reset" data-yn="N">[초기화]</span></td>
						</tr>
					</table>
					<div class="hr"></div>
					<div class="member-alter-mini-title">추가정보</div>
					<table id="member-alter-add-info">
						<tr>
							<th>부서명</th>
							<td><input class="alter-input" id="alter-department" type="text" placeholder="부서명을 입력해주세요."/></td>
						</tr>
						<tr>
							<th>직급</th>
							<td><input class="alter-input" id="alter-position" type="text" placeholder="직급을 입력해주세요."/></td>
						</tr>
						<tr>
							<th>휴대폰 번호</th>
							<td><input class="alter-input" id="alter-phone" type="text" placeholder="숫자만 입력해주세요."/></td>
						</tr>
					</table>
					<p>※ 사용자 등록 후, "이메일 주소/비밀번호" 입력하여 로그인 가능합니다.</p>
					<p>※ 비밀번호는 웹화면 [설정>비밀번호 변경] 메뉴에서 추후 변경할 수 있습니다.</p>
				</div>
				<div class="member-alter-btn-box">
					<button id="member-alter-record-btn">저장</button>
					<button id="member-alter-cancel-btn">취소</button>
				</div>
			</div>
		</div>
		<div class="use-stop-bg" style="display: none;">
			<div class="recheck-box">
				<p>이용중지 처리하시겠습니까?</p>
				<div id="recheck-btn-box">
					<div id="recheck-cancel-btn">취소</div>
					<div id="recheck-check-btn">확인</div>
				</div>
			</div>
		</div>
		<div class="reset-pw-bg" style="display: none;">
			<div id="reset-pw-box">
				<div id="reset-pw-header">
					<div>비밀번호를 초기화 하시겠습니까?</div>
					<div id="reset-pw-close-btn"></div>
				</div>
				<div id="reset-pw-body">
					<p>초기 비밀번호는 'team123~!' 로 세팅됩니다.</p>
					<div id="reset-pw-btn-box">
						<button id="reset-pw-cancel-btn">취소</button>
						<button id="reset-pw-check-btn">확인</button>
					</div>
				</div>
			</div>
		</div>
		<div class="member-del-bg" style="display: none;">
			<div id="member-del-box">
				<div id="member-del-header">구성원 삭제 (계정 삭제)</div>
				<div id="member-del-body">
					<div id="member-del-title">'<span id="member-del-name">권민재</span>' 구성원을 삭제하시겠습니까?</div>
					<div class="member-del-check-row"><label><input type="checkbox" class="member-del-agree"/> 구성원 삭제 시, 해당 구성원은 더 이상 서비스를 사용할 수 없습니다.</label></div>
					<div class="member-del-check-row"><label><input type="checkbox" class="member-del-agree"/> 해당 구성원이 등록한 게시물 및 파일들은 자동으로 삭제되지 않습니다.</label></div>
					<div class="member-del-check-row" style="border-bottom: 1px solid black;"><label><input type="checkbox" class="member-del-agree"/> 구성원 삭제 이력은 [관리자 변경이력] 메뉴에서 확인할 수 있습니다.</label></div>
					<div class="member-del-check-row"><label><input type="checkbox" class="member-del-agree"/> <span style="font-weight: 600; color: red;">구성원 삭제 시, 해당 계정은 즉시 삭제 처리 되며, 복원이 불가함을 확인 했습니다.</span></label></div>
				</div>
				<div id="member-del-footer">
					<button id="member-del-cancel-btn">취소</button>
					<button id="member-del-remove-btn">삭제</button>
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
						<h3 class="blue-h3">구성원 관리</h3>
						<h3 id="admin-3">구성원 초대</h3>
						<h3 id="admin-4"  style="display:none">조직도 관리</h3>
						<h3 id="admin-5">회사 바로가기 관리</h3>
					</div>
					<h2>프로젝트</h2>
					<div class="h3-box">
						<h3 id="admin-6">프로젝트 관리</h3>
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
			<div class="main-title"><h1>구성원 관리</h1></div>
			<div class="info-box">
				<strong>가이드</strong>
				<ul>
					<li class="list">구성원 계정을 관리할 수 있습니다. (계정 등록/삭제, 가입 승인/거절, 정보 수정, 비밀번호 초기화 등)</li>
					<li class="list-in">단, 타 서비스와 계정 정보를 연동하는 기업의 경우에는 연동된 서비스에서 관리해 주셔야 합니다.</li>
					<li class="list">구성원을 이용중지 처리 또는 이용중지 해제하여 접속 가능 여부를 관리할 수 있습니다.</li>
					<li class="list">등록된 구성원 중 관리자를 추가 지정/해제할 수 있습니다. 관리자로 지정된 구성원에게는 ‘어드민’ 접속 권한이 생기며, 서비스와 관련된 안내(결제/공지 등)를 받게 됩니다.</li>
				</ul>
			</div>
			<div class="tab-box">
				<div class="tab1"><span>정상</span><span id="use-cnt">${memberInfoList.size() }</span></div>
				<div class="tab2"><span>이용중지</span><span id="stop-cnt">${stopUseMemberList.size() }</span></div>
				<div class="tab3"><span>가입대기</span><span id="join-cnt">${waitJoinStateMemberList.size() }</span></div>
			</div>
			<div class="table-search-box">
				<div class="left-div">
					<select class="select-box">
						<option>이름</option>
						<option>부서</option>
						<option>직책</option>
						<option>이메일</option>
						<option>휴대폰</option>
					</select>
					<input type="text" name="searchText" placeholder="검색어를 입력해주세요" id="input-search">
					<input type="button" value="검색" id="submit-btn">
				</div>
				<div class="right-div">
					<a id="excelDownBtn"><span style="text-decoration: underline;"> 엑셀 다운로드</span></a>
					<div class="memberPlusBtn">+ 구성원 등록</div>
				</div>
				<div class="member-add-window" style="display: none;">
					<p id="member-add-individual-btn">구성원 개별 등록</p>
					<p id="member-add-batch-btn">구성원 일괄 등록/수정</p>
				</div>
			</div>
			<div class="table-wrap1">
				<div class="table-box">
					<table class="table1">
						<tr class="th1">
							<th id="th-company1">회사 </th>
							<th id="th-name1">이름 </th>
							<th id="th-department1">부서 </th>
							<th id="th-position1">직책 </th>
							<th id="th-email1">이메일 </th>
							<th id="th-phone1">휴대폰 번호 </th>
							<th id="th-hireDate1">가입일 </th>
							<th>상태</th>
							<th id="th-admin1">관리자 </th>
						</tr>
						<c:forEach var="dto" items="${memberInfoList }">
							<tr class="member-info-tr remove-tr1" data-idx="${dto.memberIdx }">
								<td class="member-select">${dto.companyName }</td>
								<td class="member-select">${dto.name }</td>
								<td class="member-select"><c:choose><c:when test="${dto.departmentName != null }">${dto.departmentName }</c:when></c:choose></td>
								<td class="member-select"><c:choose><c:when test="${dto.position != null }">${dto.position }</c:when></c:choose></td>
								<td class="member-select">${dto.email }</td>
								<td class="member-select"><c:choose><c:when test="${dto.phone != null }">${dto.phone }</c:when></c:choose></td>
								<td>${fn:substring(dto.hireDate, 0, 16)}</td>
								<td>정상 <span class="state-td" style="color: black;">[이용중지]</span></td>
								<td>${dto.adminYN } <c:choose><c:when test="${dto.adminYN.toString() eq 'Y' }"><span class="admin-td" style="color: red;">[삭제]</span></c:when><c:when test="${dto.adminYN.toString() eq 'N' }"><span class="admin-td">[지정]</span></c:when></c:choose></td>
							</tr>
						</c:forEach>
						<c:choose>
							<c:when test="${memberInfoList.size() == 0 }">
								<tr class="nothing-tr">
									<td colspan="9">결과값이 존재하지 않습니다.</td>
								</tr>
							</c:when>
						</c:choose>
					</table>
				</div>
			</div>
			<div class="table-wrap2" style="display: none;">
				<div class="table-box">
					<table class="table2">
						<tr class="th2">
							<th id="th-company1">회사</th>
							<th id="th-name1">이름</th>
							<th id="th-department1">부서</th>
							<th id="th-position1">직책</th>
							<th id="th-email1">이메일</th>
							<th id="th-phone1">휴대폰 번호</th>
							<th id="th-hireDate1">가입일</th>
							<th>상태</th>
							<th id="th-admin1">관리자</th>
							<th>삭제</th>
						</tr>
						<c:forEach var="dto" items="${stopUseMemberList }">
							<tr class="remove-tr2" data-idx="${dto.memberIdx }">
								<td>${dto.companyName }</td>
								<td>${dto.name }</td>
								<td><c:choose><c:when test="${dto.departmentName != null }">${dto.departmentName }</c:when></c:choose></td>
								<td><c:choose><c:when test="${dto.position != null }">${dto.position }</c:when></c:choose></td>
								<td>${dto.email }</td>
								<td><c:choose><c:when test="${dto.phone != null }">${dto.phone }</c:when></c:choose></td>
								<td>${dto.hireDate }</td>
								<td>이용중지 <span class="use-stop-cancel-btn">[해제]</span></td>
								<td></td>
								<td><span class="member-del-btn">삭제</span></td>
							</tr>
						</c:forEach>
						<c:choose>
							<c:when test="${stopUseMemberList.size() == 0 }">
								<tr class="nothing-tr">
									<td colspan="10">결과값이 존재하지 않습니다.</td>
								</tr>
							</c:when>
						</c:choose>
					</table>
				</div>
			</div>
			<div class="table-wrap3" style="display: none;">
				<div class="table-box">
					<table class="table3">
						<tr class="th3">
							<th id="th-name3">이름</th>
							<th id="th-email1">이메일</th>
							<th id="th-hireDate1">가입 요청일</th>
							<th>설정</th>
						</tr>
						<c:forEach var="dto" items="${waitJoinStateMemberList }">
							<tr class="remove-tr3" data-idx="${dto.memberIdx }">
								<td>${dto.name }</td>
								<td>${dto.email }</td>
								<td>${dto.hireDate }</td>
								<td><span class="approval-btn">[승인]</span> <span class="refusal-btn">[거절]</span></td>
							</tr>
						</c:forEach>
						<c:choose>
							<c:when test="${waitJoinStateMemberList.size() == 0 }">
								<tr class="nothing-tr">
									<td colspan="4">결과값이 존재하지 않습니다.</td>
								</tr>
							</c:when>
						</c:choose>
					</table>
				</div>
			</div>
		</div>
		<div class="batch-container" style="display: none;">
			<div id="batch-header">
				<div id="back-arrow-btn"></div>
				<h1>구성원 일괄 등록/수정</h1>
			</div>
			<div id="batch-info-box">
				<p>1회 최대 200명까지 등록할 수 있습니다.</p>
				<p>구성원 등록 시, 개별 사용자에게 가입 완료 메일이 발송됩니다.</p>
				<p>조직도 내 구성원은 '이름 오름차순'으로 기본 정렬되며, 관리자가 추가 정보를 입력하면 순서를 변경할 수 있습니다.</p>
				<span>   (노출 순서 우선 순위 : ①정렬 순서 ②입사년월 ③이름)</span>
			</div>
			<div id="file-registration-box">
				<div>
					<input id="batch-file-input" type="button" value="xlsx 파일만 업로드 가능합니다."/>
					<button id="batch-file-input-btn">파일 등록</button>
					<button id="batch-excel-down-btn">엑셀 양식 다운로드</button>
				</div>
				<p>※ 파일등록 시, 해당 엑셀 표로 아래 표가 초기화됩니다.</p>
			</div>
			<div id="table-filter-btn-box">
				<div><span class="bold-span">전체</span> <span class="bold-span" id="batch-tuple-cnt">0</span><span class="all-span">건</span> ( <span id="OK-Cnt">0</span>건 등록 가능, <span class="red NOT-Cnt">0</span><span class="red">건</span> 등록 불가능 ) <label><input type="checkbox"/>등록 불가능한 행 모아보기</label></div>
				<div id="batch-excel-menu">
					<button id="col-add-btn">행 추가</button>
					<button id="batch-del-btn">삭제</button>
					<button id="batch-add-btn">등록</button>
				</div>
			</div>
			<table id="batch-table">
				<tr>
					<th style="width: 30px !important;"><input id="checkbox-th" type="checkbox"/></th>
					<th>이름</th>
					<th>이메일</th>
					<th>휴대폰 번호</th>
					<th>부서코드</th>
					<th>직책</th>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>