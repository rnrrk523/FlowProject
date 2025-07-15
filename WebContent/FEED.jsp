<%@page import="dto.dto.ProjectUserFolder"%>
<%@page import="dao.ChattingDao"%>
<%@page import="dto.ChatRoomListDto"%>
<%@page import="dao.ProjectDao"%>
<%@page import="dto.ProjectMemberListDto"%>
<%@page import="dto.TaskMangerViewProjectDto"%>
<%@page import="dto.TaskGroupViewDto"%>
<%@page import="dao.TaskALLDao"%>
<%@page import="dto.BoardEmotionDto"%>
<%@page import="dto.BoardCommentViewDto"%>
<%@page import="dto.BoardWorkViewDto"%>
<%@page import="dto.ScheduleCountDto"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="dto.BoardScheduleDto"%>
<%@page import="dto.TaskManagerDto"%>
<%@page import="dto.MyboardViewTaskDto"%>
<%@page import="dto.ProjectMemberViewDto"%>
<%@page import="dto.ProjectAdminDto"%>
<%@page import="dto.BoardPostViewDto"%>
<%@page import="dto.BoardTopFixedDto"%>
<%@page import="dto.MemberProjectFolderDto"%>
<%@page import="dao.BoardALLDao"%>
<%@page import="dao.MemberDao"%>
<%@page import="dto.MemberDto"%>
<%@page import="dto.MyProjectViewDto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dto.ProjectViewProjecIdxDto"%>
<%@page import="dao.ProjectALLDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	MemberDao dao = new MemberDao();
	ProjectALLDao pdao = new ProjectALLDao();
	BoardALLDao bdao = new BoardALLDao();
	TaskALLDao tdao = new TaskALLDao();
	ChattingDao cdao = new ChattingDao();
	int companyIdx = (Integer)request.getAttribute("companyIdx");
	int projectIdx = (Integer)request.getAttribute("projectIdx");
	int memberIdx = (Integer)request.getAttribute("memberIdx");
	int colornum = (Integer)request.getAttribute("colornum");
	int readCount = (Integer)request.getAttribute("readCount");
	int projectmember = (Integer)request.getAttribute("projectmember");
	int projectOutsidermember = (Integer)request.getAttribute("projectOutsidermember");
	int projectNoNadminmember = (Integer)request.getAttribute("projectNoNadminmember");
	int projectadminmember = (Integer)request.getAttribute("projectadminmember");
	int projectColor = (Integer)request.getAttribute("projectColor");
	String email = (String)request.getAttribute("loginemail");
	String name = (String)request.getAttribute("name");
	String StateMessage = (String)request.getAttribute("StateMessage");
	String profile = (String)request.getAttribute("profile");
	String hometab = (String)request.getAttribute("hometab");
	ArrayList<MemberDto> Mlist = (ArrayList<MemberDto>)request.getAttribute("Mlist");
	ArrayList<MemberDto> Mlist1 = (ArrayList<MemberDto>)request.getAttribute("Mlist1");
	ArrayList<MemberDto> Mlist2 = (ArrayList<MemberDto>)request.getAttribute("Mlist2");
	ArrayList<MemberDto> Mlist3 = (ArrayList<MemberDto>)request.getAttribute("Mlist3");
	ArrayList<MemberDto> Olist = (ArrayList<MemberDto>)request.getAttribute("Olist");
	ArrayList<MemberDto> CMlist = (ArrayList<MemberDto>)request.getAttribute("CMlist");
	ArrayList<ChatRoomListDto> Clist = (ArrayList<ChatRoomListDto>)request.getAttribute("Clist");
	ArrayList<ProjectMemberListDto> pmList = (ArrayList<ProjectMemberListDto>)request.getAttribute("pmList");
	ArrayList<ProjectMemberViewDto> PAlist = (ArrayList<ProjectMemberViewDto>)request.getAttribute("PAlist");
	ArrayList<MyProjectViewDto> MPlist2 = (ArrayList<MyProjectViewDto>)request.getAttribute("MPlist");
	ArrayList<ProjectUserFolder> PUFlist = (ArrayList<ProjectUserFolder>)request.getAttribute("PUFlist");
	ProjectViewProjecIdxDto pvdto = (ProjectViewProjecIdxDto)request.getAttribute("pvdto");
	ProjectViewProjecIdxDto PVPdto = (ProjectViewProjecIdxDto)request.getAttribute("PVPdto");
	ProjectMemberViewDto PMdto2 = (ProjectMemberViewDto)request.getAttribute("PMdto2");
	ProjectViewProjecIdxDto pdto = (ProjectViewProjecIdxDto)request.getAttribute("pdto");
	char adminMy = ((String)request.getAttribute("adminMy")).charAt(0);
%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>2024-11-25</title>
</head>
	<link href='http://fonts.googleapis.com/css?family=Roboto:400,300,100,500,700' rel='stylesheet' type='text/css'>
	<link rel="stylesheet" href="css/2_Flow_Feed_2024-11-28.css"/>
	<link rel="stylesheet" href="css/2_Flow_TopAndLeft_20241126.css"/>
	<link rel="stylesheet" href="css/2_Flow_Createboard.css"/>
	<link rel="stylesheet" href="css/2_Flow_CreateProject.css"/>
	<link rel="stylesheet" href="css/Flow_calender.css"/>
	<link rel="stylesheet" href="css/Flow_live_alarm.css"/>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<!-- 데이트피커 -->
	<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/jquery-ui-timepicker-addon@1.6.3/dist/jquery-ui-timepicker-addon.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/jquery-ui-timepicker-addon@1.6.3/dist/jquery-ui-timepicker-addon.min.css">
	<script>
	let webSocketAlarm = new WebSocket("ws://114.207.245.107:9090//Project/Broadcasting");
		webSocketAlarm.onmessage = function(e) {
			//$("#div_message").append("<p>" + e.data + "</p>");
			
			if(e.data == 'NewAlarm') {
				alarmSearchfunc('N');
			}
		}
		webSocketAlarm.onopen = function(e){
			//alert("(알람)연결되었습니다.");
		}
		webSocketAlarm.onerror = function(e) {
			//alert("(알람)error!");
		}
        
        $(function() {
            $(".datetimepicker").datetimepicker({
                dateFormat: 'yy-mm-dd (D)', // 날짜 형식을 yy-mm-dd (요일)로 설정
                timeFormat: 'HH:mm',       // 시간 형식 설정
                beforeShowDay: function(date) {
                    let dayNames = ['일', '월', '화', '수', '목', '금', '토'];
                    let day = date.getDay();
                    let dayName = dayNames[day];
                    return [true, '', dayName]; // 요일 정보를 반환
                }
            });
        });
        
        /*실시간 알림Ajax*/
		/*알림검색 함수*/
		function alarmSearchfunc(_yn) {
			let str = $("#liveAlarmSearchInput").val();
			$.ajax({
				type: 'post',
				url: 'LiveAlarmSearchAjaxServlet',
				data: {
					"memberIdx":${memberIdx},
					"checkYN":_yn,
					"str":str
				},
				success: function(data) {
					console.log(data);
					$(".item-box").remove();
					for(let i=0; i<=data.length-1; i++) {
						let checkClass = data[i].checkYN == 'Y' ? '':'no-check';
						let newTr = '<div class="item-box '+checkClass+'" data-idx="'+data[i].coordinate+'" data-laidx="'+data[i].liveAlarmIdx+'" data-mention="'+data[i].mentionMeYN+'" data-myboard="'+data[i].myBoardYN+'" data-work="'+data[i].workYN+'">' +
										'<div class="live-alarm-prof" style="background-image: url('+data[i].writerProf+');"></div>' +
										'<div class="live-alarm-text-wrap">' +
											'<div class="live-alarm-row-1">' +
												'<div class="live-alarm-content-title">'+data[i].title+'</div>' +
												'<div class="content-write-date">'+data[i].alarmInfoDate+'</div>' +
											'</div>' +
											'<div class="content-mini-title">'+data[i].simpleContent+'</div>' +
											'<div class="live-alarm-main-content">'+data[i].fullContent+'</div>' +
										'</div>' +
									'</div>';
						$(".live-alarm-content").append(newTr);
						let count = $('.item-box.no-check').length;
						if(count > 0) {
							$("#show-live-alarm-btn").find('.badge').css('display','block');
						} else {
							$("#show-live-alarm-btn").find('.badge').css('display','none');
						}
					}
				},
				error: function(r, s, e) {
					console.log(r.status);
					console.log(r.responseText);
					console.log(e);
				}
			})
		}
    </script>
	<script>
        $.datepicker.regional['ko'] = {
            closeText: '닫기',
            prevText: '이전',
            nextText: '다음',
            currentText: '오늘',
            monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
            monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
            dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'],
            dayNamesShort: ['일','월','화','수','목','금','토'],
            dayNamesMin: ['일','월','화','수','목','금','토'],
            weekHeader: '주',
            dateFormat: 'yy-mm-dd',
            firstDay: 0,
            isRTL: false,
            showMonthAfterYear: true,
            yearSuffix: '년'
        };
        $.datepicker.setDefaults($.datepicker.regional['ko']);
        
        $(function() {
            $(".datetimepicker").datetimepicker({
                dateFormat: 'yy-mm-dd (D)', // 날짜 형식을 yy-mm-dd (요일)로 설정
                timeFormat: 'HH:mm',       // 시간 형식 설정
                beforeShowDay: function(date) {
                    let dayNames = ['일', '월', '화', '수', '목', '금', '토'];
                    let day = date.getDay();
                    let dayName = dayNames[day];
                    return [true, '', dayName]; // 요일 정보를 반환
                }
            });
        });
    </script>
	<script>
		$(function(){
			let _prevStartDate;
			let _prevEndDate; 
			let startDate = "";
			 let endDate = "";
			 let Taskpriority = 5;
			 let taskGroupIdx = 0;
			$(document).ready(function() {
		        $.ajax({
		            type: 'POST',
		            url: 'ReadBoardInFeedAjax',
		            data: {
		                projectIdx: <%=projectIdx%>,
		                memberIdx: <%=memberIdx%>
		            },
		            success: function(data) {
		                console.log(data);
		                $('.feed-board').each(function(){
		                	for(let i = 0;  i<data.length; i++) {
			                	if($(this).data('bno')==data[i].boardIdx) {
			                		$(this).find('.read-cnt-member').text(data[i].readCount);
			                	}
		                	}
		                });
		            },
		            error: function(r, s, e) {
		                console.log(e);
		                alert("오류");
		            }
		        });
			});
			$(document).on('click','.left_items_color',function(){
		    	  let moveprojectIdx = $(this).data("pno");
		    	  $.ajax ({
		    			type: 'post',
		    	        url: 'MoveprojectAjax',
		    	        data: {
		    	            pno : moveprojectIdx
		    	        },
		    	        success: function(data) {
		    	        	console.log(data);
		    	        	var url = "";
		    	        	if(data.hometab=="피드") {
		    	        		url = "Controller?command=FEED";
		    	        	}
							if(data.hometab=="업무") {
								url = "Controller?command=Task";    	    	        		
							}
							if(data.hometab=="캘린더") {
								url = "Controller?command=project_calendar";
							}
							var form = $('<form>', {
			                    'action': url,
			                    'method': 'POST'
			                });

			                form.append($('<input>', {
			                    'type': 'hidden',
			                    'name': 'projectIdx',
			                    'value': moveprojectIdx
			                }));

			                $('body').append(form);
			                form.submit();
		    	        		
		    	        },
		    	        error: function(r, s, e) {
		    	        	console.log(r.status);
		    	        	console.log(e);
		    	        }
		    		});
		      });
			$(document).on('click','.left_items',function(){
		    	  let movefolderIdx = $(this).data("fno");
		    	  if(movefolderIdx >= 0) {
	   	        	var url = "Controller?command=ProjectFolder";
						
					var form = $('<form>', {
	                    'action': url,
	                    'method': 'POST'
	                });

	                form.append($('<input>', {
	                    'type': 'hidden',
	                    'name': 'folderIdx',
	                    'value': movefolderIdx
	                }));

	                $('body').append(form);
	                form.submit();
		    	  }
		      });
			let inviteCount = 0;
			let label = [];
			let labeldel= [];
			//전체멤버뛰우기
			$(document).ready(function() {
			    $(document).on('keyup','.project-member-search', function() {
			        let searchMember = $('.project-member-search').val();
			        $.ajax({
			            type: 'POST',
			            url: 'MemberSearchAjax', 
			            data: {
			                searchMember: searchMember,
			                projectIdx: <%=projectIdx%>
			            },
			            error: function(r, s, e) {
			                console.log(e);
			            },
			            success: function(data) {
			                console.log(data);
			                $('.project-member-item').remove();
			                var memberData = "";
			                for (let i = 0; i < data.length; i++) {
			                    let memberData = "<li class=\"project-member-item\" data-mno=" + data[i].memberIdx + ">"+
			                                     "<div class=\"post-author\">" +
			                                     "<span class=\"profile-radius\" style=\"background-image: url('" + data[i].profileIMG + "');\"></span>" +
			                                     "<dl class=\"post-profile-text\">" +
			                                     "<dt>" +
			                                     "<strong class=\"author-name\">" + data[i].name + "</strong>" +
			                                     "<em class=\"author-position\">" + data[i].position + "</em>" +
			                                     "</dt>" +
			                                     "<dd>" +
			                                     "<strong class=\"author-company\">" + data[i].companyName + "</strong>" +
			                                     "<em class=\"author-department\">" + data[i].departmentName + "</em>" +
			                                     "</dd>" +
			                                     "</dl>" +
			                                     "</div>";
			                    if (data[i].memberIdx == <%= memberIdx %>) {
			                        if (data[i].adminYN == 'Y') {
			                            memberData += "<div class=\"project-admin active\">관리자</div>" +
			                                          "<button class=\"project-other-option-btn\">" +
			                                          "<span></span><span></span><span></span>" +
			                                          "</button>" +
			                                          "<div class=\"project-other-option-layer\">" +
			                                          "<div><button class=\"project-other-option-exit\">나가기</button></div>";

			                            <% if (adminMy == 'Y') { %>
			                                memberData += "<button class=\"project-other-option-admin\">관리자 해제</button>";
			                            <% } %>
			                            memberData += "</div></div>";
			                        } else {
			                            memberData += "<div class=\"project-admin\">관리자</div>" +
			                                          "<button class=\"project-other-option-btn\">" +
			                                          "<span></span><span></span><span></span>" +
			                                          "</button>" +
			                                          "<div class=\"project-other-option-layer\">" +
			                                          "<div><button class=\"project-other-option-exit\">나가기</button></div>";

			                            <% if (adminMy == 'Y') { %>
			                                memberData += "<button class=\"project-other-option-admin\">관리자 지정</button>";
			                            <% } %>
			                            memberData += "</div></div>";
			                        }
			                    } else {
			                        if (data[i].adminYN == 'Y') {
			                            memberData += "<div class=\"project-admin active\">관리자</div>";
			                            <% if (adminMy == 'Y') { %>
			                                memberData += "<button class=\"project-other-option-btn\">" +
			                                              "<span></span><span></span><span></span>" +
			                                              "</button>" +
			                                              "<div class=\"project-other-option-layer\">" +
			                                              "<div><button class=\"project-other-option-exit\">내보내기</button></div>" +
			                                              "<div><button class=\"project-other-option-admin\">관리자 해제</button></div>" +
			                                              "</div>";
			                            <% } %>
			                        } else {
			                            memberData += "<div class=\"project-admin\">관리자</div>";
			                            <% if (adminMy == 'Y') { %>
			                                memberData += "<button class=\"project-other-option-btn\">" +
			                                              "<span></span><span></span><span></span>" +
			                                              "</button>" +
			                                              "<div class=\"project-other-option-layer\">" +
			                                              "<div><button class=\"project-other-option-exit\">내보내기</button></div>" +
			                                              "<div><button class=\"project-other-option-admin\">관리자 해제</button></div>" +
			                                              "</div>";
			                            <% } %>
			                        }
			                    }
			                }
			                    memberData += "</li>";
			                    $('.project_member-layer-area').append(memberData);
			                }
			        });
			    });
			}); 
			let url = "";
			$('.taskcontent').click(function(){
				 url = 'Controller?command=Task';
				 var form = $('<form>', {
	                    'action': url,
	                    'method': 'POST'
	                });
				 form.append($('<input>', {
	                    'type': 'hidden',
	                    'name': 'projectIdx',
	                    'value': <%=projectIdx%>
	             }));

	                $('body').append(form);
	                form.submit();
			});
			$('.calendercontent').click(function(){
				 url = 'Controller?command=project_calendar';
				 var form = $('<form>', {
	                    'action': url,
	                    'method': 'POST'
	                });
				 form.append($('<input>', {
	                    'type': 'hidden',
	                    'name': 'projectIdx',
	                    'value': <%=projectIdx%>
	             }));

	                $('body').append(form);
	                form.submit();
			});
			$('.alarmtext').click(function(){
				 url = 'Controller?command=project_alarm';
				 var form = $('<form>', {
	                    'action': url,
	                    'method': 'POST'
	                });
				 form.append($('<input>', {
	                    'type': 'hidden',
	                    'name': 'projectIdx',
	                    'value': <%=projectIdx%>
	             }));

	                $('body').append(form);
	                form.submit();
			});
			$('#myproject').click(function(){
				 location.href = 'Controller?command=Myprojects';
			});
			$('#dashboard').click(function(){
				location.href = 'Controller?command=Dashboard';
			});
			
			$('.star-button').click(function() {
				event.stopPropagation(); 
	    	    var btn = $(this).hasClass('active') ? 'N' : 'Y';   
	    	    if($(this).hasClass('active')) {
	    	    	$(this).removeClass('active');
	    	    } else {
	    	    	$(this).addClass('active');
	    	    }
	    	    $.ajax({
	    	        type: 'post',
	    	        url: 'StarButtonAJAX',
	    	        data: {
	    	            pno: <%=projectIdx%>,
	    	            idx: <%= memberIdx %>,
	    	            btn: btn
	    	        },
	    	        success: function(data) {
	    	        	console.log(data);
	    	        	
	    	        },
	    	        error: function(r, s, e) {
	    	        	alert("[에러] code:" + r.status 
		    					+ " , message:" + r.responseText
		    					+ " , error:" + e);
	    	        }
	    	    });
	    	});
			$('.black_box').click(function() {
		    	$('.create_area').css('display', 'flex');
		    	$('.create_project_title').text('프로젝트 만들기');
		    });
		    $('.project_explanation-input-btn').click(function() {
		    	$('.project_explanation-input-btn').css('display', 'none');
		    	$('.project_explanation-input').css('display', 'block');
		    });
		    let hometabeditIdx = 1;
			<%if(pvdto.getHomeTab()=="피드") { %>
				hometabeditIdx = 1;
	    	<%}%>
	    	<%if(pvdto.getHomeTab()=="업무") {%>
	    		hometabeditIdx = 2;
	    	<%}%>
	    	<%if(pvdto.getHomeTab()=="일정") {%>
	    		hometabeditIdx = 3;
	    	<%}%>
	    	<%if(pvdto.getHomeTab()=="파일") {%>
	    		hometabeditIdx = 4;
	    	<%}%>
		    let hometabIdx = 1;
		    $('.hometab-item').click(function() {
		    	$('.hometab-item').removeClass('active');
		    	$(this).addClass('active');
		    	if($('.hometab-item.active').attr('id') == 'feed') {
		    		$('.template-sample-img').removeClass('calander');
		    		$('.template-sample-img').removeClass('task');
		    		$('.template-sample-img').removeClass('file');
		    		$('.template-sample-img').addClass('feed');
		    		hometabIdx = 1;
		    		hometabeditIdx = 1;
		    	}
		    	if($('.hometab-item.active').attr('id') == 'tasks') {
		    		$('.template-sample-img').removeClass('feed');
		    		$('.template-sample-img').removeClass('calander');
		    		$('.template-sample-img').removeClass('file');
		    		$('.template-sample-img').addClass('task');
		    		hometabIdx = 2;
		    		hometabeditIdx = 2;
		    		
		    	}
		    	if($('.hometab-item.active').attr('id') == 'calander') {
		    		$('.template-sample-img').removeClass('file');
		    		$('.template-sample-img').removeClass('feed');
		    		$('.template-sample-img').removeClass('task');
		    		$('.template-sample-img').addClass('calander');
		    		hometabIdx = 3;
		    		hometabeditIdx = 3;
		    		
		    	}
		      });
		    let publicsedit = false;
		    <%if(pvdto.getCategoryIdx() >= 1) { %>
		    	publicsedit = true;
	    	<%} else { %>
	    		publicsedit = false;
	    	<% } %>
		    let adminedit = 'N';
	    	<%if(pvdto.getApprovalYN() == 'Y') { %>
	    		adminedit = 'Y';
			<%} else { %>
				adminedit = 'N';
			<% } %>
		    let admin = 'N';
		    let publics = false;
		    $('.company-public-toggle-btn').click(function() {
		        $(this).toggleClass('on');
		        if ($('#public-setting').hasClass('on')) {
		            $('.icon-template-earth').css('display', 'block');
		            $('.public-setting-content').css('display', 'block');
		            publics = true;
		            publicsedit = true;
		        } else {
		            $('.icon-template-earth').css('display', 'none');
		            $('.public-setting-content').css('display', 'none');
		            publics = false;
		            publicsedit = false;
		        }

		        if ($('#admin-lock-setting').hasClass('on')) {
		            $('.icon-template-lock').css('display', 'block');
		            admin = 'Y';
				    adminedit = 'Y';
		        } else {
		            $('.icon-template-lock').css('display', 'none');
		            admin = 'N';
				    adminedit = 'N';
		        }
		    });
		    $('.admin-setting-toggle-open').click(function() {
		    	$('.project-admin-more-option-area').css('display','block');
		    	$('.admin-setting-toggle-open').css('display', 'none');
		    	$('.admin-setting-toggle-close').css('display', 'block');
		    });
		    $('.admin-setting-toggle-close').click(function() {
		    	$('.project-admin-more-option-area').css('display','none');
		    	$('.admin-setting-toggle-close').css('display', 'none');
		    	$('.admin-setting-toggle-open').css('display', 'block');
		    });
		    $('.submit-project').click(function(){
		    	let title = $('.project-title-input').val();
		    	let explanation = $('.project_explanation-input').val();
		    	let titleLength = title.length;
		    	let editpublicIdx = <%=pvdto.getCategoryIdx()%>;
		    	let publicIdx = 0;
		    	let colornum = <%=colornum%>;
		    	let colorfix = '';
		    	if(colornum != 1) {
		    		colorfix = 'N';
		    	} else {
		    		colorfix = 'Y';
		    	}
		    	var findstr = '.authority-select-box option:selected';
		    	let selectedOption1 = $('.board-write-auth-element').find(findstr);
		    	let dataCode1 = selectedOption1.data('code');
		    	let selectedOption2 = $('.edit-auth-element').find(findstr);
		    	let dataCode2 = selectedOption2.data('code');
		    	let selectedOption3 = $('.view-auth-element').find(findstr);
		    	let dataCode3 = selectedOption3.data('code');
		    	let selectedOption4 = $('.comment-auth-element').find(findstr);
		    	let dataCode4 = selectedOption4.data('code');
		    	if(publics==true) {
		    		 var selectedOption = $('.company-category option:selected');
		             var dataCode = selectedOption.data('code');
		    		 publicIdx = dataCode;
		    	} else {
		    		publicIdx = 0;
		    	}
		    	if(publicsedit==true) {
		    		 var selectedOption = $('.company-category option:selected');
		             var dataCode = selectedOption.data('code');
		             editpublicIdx = dataCode;
		    	} else {
		    		editpublicIdx = 0;
		    	}
            	if($(this).parents('.create_project_value_area').find('.create_project_title').text().trim()=='프로젝트 만들기') {
            		alert("생성");
            		if(titleLength<1) {
        	    		alert('제목을 입력하시오.');
        	    	} else {
        	    		$.ajax({
        	    			type: 'POST',
        		            url: 'ProjectCreateAjax',
        		            data : {
        		            	title : title,
        		            	explanation : explanation,
        		            	hometabIdx : hometabIdx,
        		            	publicIdx : publicIdx,
        		            	adminvalue : admin,
        		            	dataCode1 : dataCode1,
        		            	dataCode2 : dataCode2,
        		            	dataCode3 : dataCode3,
        		            	dataCode4 : dataCode4,
        		            	idx : <%=memberIdx%>,
        		            	colorfix : colorfix
        		            },
        	    			success: function(data) {
        	    				console.log(data);
        		                alert("적용되었습니다");
        		                let url = "";
        		                if(data.hometab=="피드") {
        		                	url = 'Controller?command=FEED';
        		                }
        						if(data.hometab=="업무") {
        							url = 'Controller?command=Task';            	
        						}
        						if(data.hometab=="캘린더") {
        							 url = 'Controller?command=project_calendar';
        						}
        		                $('.create_area').css('display', 'none');
        		                var form = $('<form>', {
        		                    'action': url,
        		                    'method': 'POST'
        		                });

        		                form.append($('<input>', {
        		                    'type': 'hidden',
        		                    'name': 'projectIdx',
        		                    'value': data.projectIdx
        		                }));

        		                $('body').append(form);
        		                form.submit();
        		                
        	    			},
        	    			error: function(r, s, e) {
        		                console.log(r.status);
        		                console.log(e);
        		                alert("오류");
        		            }
        	    		});
        	    	}
            	} else {
            		alert("수정");
            		if(titleLength<1) {
        	    		alert('제목을 입력하시오.');
        	    	} else {
        	    		$.ajax({
        	    			type: 'POST',
        		            url: 'ProjectEditAjax',
        		            data : {
        		            	title : title,
        		            	explanation : explanation,
        		            	hometabIdx : hometabeditIdx,
        		            	publicIdx : editpublicIdx,
        		            	adminvalue : adminedit,
        		            	dataCode1 : dataCode1,
        		            	dataCode2 : dataCode2,
        		            	dataCode3 : dataCode3,
        		            	dataCode4 : dataCode4,
        		            	idx : <%=memberIdx%>,
        	    				projectIdx : <%=projectIdx%>
        		            },
        	    			success: function(data) {
        	    				console.log(data);
        		                alert("적용되었습니다");
        		                $('.create_area').css('display','none');
        		                $('.projecttitle').text(data.title);
        		                if(data.explanation != null) {
        		                	$('.project-description-content').text(data.explanation);
        		                } else {
        		                	$('.project-description-content').text('');
        		                }
        		                if(data.hometab=="피드") {
        		                	$('.feedcontent').find('.hometab').css('display','block');
        		                	$('.taskcontent').find('.hometab').css('display','none');
        		                	$('.calendercontent').find('.hometab').css('display','none');
        		                	$('.filecontent').find('.hometab').css('display','none');
        		                }
        						if(data.hometab=="업무") {
        							$('.feedcontent').find('.hometab').css('display','none');
        		                	$('.taskcontent').find('.hometab').css('display','block');
        		                	$('.calendercontent').find('.hometab').css('display','none');
        		                	$('.filecontent').find('.hometab').css('display','none');              	
        						}
        						if(data.hometab=="캘린더") {
        							$('.feedcontent').find('.hometab').css('display','none');
        		                	$('.taskcontent').find('.hometab').css('display','none');
        		                	$('.calendercontent').find('.hometab').css('display','block');
        		                	$('.filecontent').find('.hometab').css('display','none');
        						}
        						if(data.hometab=="파일") {
        							$('.feedcontent').find('.hometab').css('display','none');
        		                	$('.taskcontent').find('.hometab').css('display','none');
        		                	$('.calendercontent').find('.hometab').css('display','none');
        		                	$('.filecontent').find('.hometab').css('display','block');
        						}
        						if(data.adminvalue=='Y') {
        							$('.admin_project').css('display','inline-block');
        						} else {
        							$('.admin_project').css('display','none');
        						}
        						if(data.publicIdx>=1) {
        							$('.public_project').css('display','inline-block');
        						} else {
        							$('.public_project').css('display','none');
        						}
        	    			},
        	    			error: function(r, s, e) {
        		                console.log(r.status);
        		                console.log(e);
        		                alert("오류");
        		            }
        	    		});
        	    	}
            	}
            });
			//프로젝트 옵션 버튼
			$('.set-btn').click(function(){
				if($('.project-option-layer').css('display')=='none') {
					$('.project-option-layer').css('display','block');
				} else {
					$('.project-option-layer').css('display','none');
				}
			});
			//프로젝트 옵션 색상 설정 버튼
			$('#color-set').click(function() {
				$('.mainPop').css('display','block');
				$('.color-select-box').css('display','block');
				$('.project-option-layer').css('display','none');
			});
			let color = 0;
		    $('.color-item').find('input').click(function() {
		        if ($(this).is(':checked')) {
		        	color = $(this).parent().data('code');
		        }
		    });
		    let arr1 = [];
		 	arr1.push(<%=projectIdx%>);
		 	let arraylist1 = JSON.stringify(arr1);
			 $('.color-select-box').find('.submit-mainPop').click(function(){
			        $('.mainPop').css('display','none');
					$('.color-select-box').css('display','none');
			        $.ajax({
			            type: 'POST',
			            url: 'ColorSettingAjax',
			            contentType: 'application/json',
			            data: JSON.stringify({
			                idx: <%= memberIdx %>,
			                array: arraylist1, 
			                color: color 
			            }),
			            success: function(data) {
			                console.log(data);
			                alert("적용되었습니다");
			                data.projects.forEach(function(project) {
			                    let projectId = project.projectIdx; 
			                    let newColor = project.newColor;

			                    $('.color-box').removeClass(function(index, className) {
			                        return (className.match(/(^|\s)color-code-\S+/g) || []).join(' ');
			                    }).addClass('color-code-' + newColor); 
			                });
			            },
			            error: function(r, s, e) {
			                console.log(r.status);
			                console.log(e);
			            }
			        });
			    });
			$('.close-event').click(function() {
		    	 $('.mainPop').css('display', 'none');
	    	 	 $('.color-select-box').css('display', 'none');
	    	 	 $('.label-select').css('display','none');
		    });
		    $('.cancle-mainPop').click(function(){
		    	$('.mainPop').css('display', 'none');
	   	 	 	$('.color-select-box').css('display', 'none');
	   	 		$('.label-select').css('display','none');
		    });
		    //프로젝트 옵션 프로젝트 폴더 설정 버튼
		    $('#project-set').click(function() {
				$('.mainPop').css('display','block');
				$('.label-select').css('display','block');
				$('.project-option-layer').css('display','none');
			});
		    $('.label-set-item').click(function() {
		          if (!$(this).hasClass('active')) {
		              $(this).addClass('active');
		              var labeldata = $(this).parent().data('code');
		              for (let i = 0; i < labeldel.length; i++) {
			    	        if (labeldel[i] === labeldata) {
			    	          labeldel.splice(i, 1); 
			    	          i--;
			    	        }
				    	 }
		              label.push(labeldata); 
		              alert(label);
		              alert(labeldel);
		          } else {
		              $(this).removeClass('active');
		              var labeldata = $(this).parent().data('code');
		              for (let i = 0; i < label.length; i++) {
		    	        if (label[i] === labeldata) {
		    	          label.splice(i, 1); 
		    	          i--;
		    	        }
			    	 }
		             labeldel.push(labeldata); 
		             alert(label);
		             alert(labeldel);
		          }
		      });
		    $(document).ready(function() {
		    	  $('.label-set-item').each(function() {
		    	    if (!$(this).hasClass('active')) {
		    	      var labeldata = $(this).parent().data('code');
		    	      labeldel.push(labeldata); 
		    	    } else {
		    	      var labeldata = $(this).parent().data('code');
		    	      label.push(labeldata);
		    	    }
		    	  });
		    	  console.log(label);
		    	});
		    $('.label-select').find('.submit-mainPop').click(function(){
		        let arraylist1 = arr1; 
		        let labels = label; 
		        let labeldels = labeldel;

		        $('.mainPop').css('display', 'none');
		        $('.color-select-box').css('display', 'none');

		        $.ajax({
		            type: 'POST',
		            url: 'LabelSettingAjax',
		            contentType: 'application/json',
		            data: JSON.stringify({
		                idx: <%= memberIdx %>,    
		                array: arraylist1,       
		                label: labels, 
		                Nonlabel : labeldels
		            }),
		            success: function(data) {
		                console.log(data);
		                alert("적용되었습니다");
		            },
		            error: function(r, s, e) {
		                console.log(r.status);
		                console.log(e);
		                alert("오류");
		            }
		        });
		    });
		    //프로젝트 옵션 프로젝트 나가기 버튼
		    $('#project-exit-set').click(function() {
		    	$('.mainPop').css('display','block');
		    	$('.project-delete-area').css('display','block');
		    	$('.project-option-layer').css('display','none');
		    	$('.project-page-text').css('display','block');
		    	$('.project-page-text-value').css('display','block');
		    });
		    $('.project-page-cancle').click(function() {
		    	$('.mainPop').css('display','none');
		    	$('.project-delete-area').css('display','none');
		    	$('.project-page-text').css('display','none');
		    	$('.project-page-text-value').css('display','none');
		    	$('.project-page-text-values-1').css('display','none');
		    	$('.project-page-text-values').css('display','none');
		    });
		    $('#project-delete-set').click(function() {
		    	$('.mainPop').css('display','block');
		    	$('.project-delete-area').css('display','block');
		    	$('.project-option-layer').css('display','none');
		    	$('.project-page-exit-text').css('display','block');
		    	$('.project-page-text-values-1').css('display','block');
		    	$('.project-page-text-values').css('display','block');
		    });
		    //프로젝트 나가기 및 삭제
		    $('.project-page-submit').click(function(){
		    	if($(this).parents('.project-delete-box').find('.project-page-text').css('display')=='block') {
			    	location.href = "FEED-ExitAction.jsp?pno="+<%=projectIdx%>+"&memberIdx="+<%=memberIdx%>;
		    	} else if ($(this).parents('.project-delete-box').find('.project-page-exit-text').css('display')=='block') {
		    		location.href = "FEED-DeleteAction.jsp?pno="+<%=projectIdx%>+"&memberIdx="+<%=memberIdx%>;
		    	}
		    });
		    //프로젝트 수정 버튼
		    $('#project-edit-set').click(function(){
		    	$('.project-option-layer').css('display','none');
		    	$('.create_area').css('display', 'flex');
		    	$('.create_project_title').text('프로젝트 수정');
		    	$('.admin-setting-toggle-open').css('display','none');
		    	$('.admin-setting-toggle-close').css('display','block');
		    	$('.project-admin-more-option-area').css('display','block');
		    	$(".view-auth-element").find('.authority-select-box').prop('disabled',true);
		    	$('.add-option-info-value').css('display','block');
		    	$('.project-title-input').val('<%= pvdto.getProjectName() %>');
		    	<%if(pvdto.getProjectExplanation()==null) { %>
		    	<% } else { %>
		    		$('.project_explanation-input-btn').css('display','none');
			    	$('.project_explanation-input').css('display','block');
		    		$('.project_explanation-input').val('<%=pvdto.getProjectExplanation() %>');
		    	<% } %>
		    	<%if(pvdto.getHomeTab()=="피드") { %>
		    		$('.hometab-item').each(function() {
		    			$(this).removeClass('active');
			            if ($(this).attr('id') == 'feed') {
			                $(this).addClass('active');
			            }
		        	});
		    	<%}%>
		    	<%if(pvdto.getHomeTab()=="업무") {%>
			    	$('.hometab-item').each(function() {
		    			$(this).removeClass('active');
			            if ($(this).attr('id') == 'task') {
			                $(this).addClass('active');
			            }
		        	});
		    	<%}%>
		    	<%if(pvdto.getHomeTab()=="일정") {%>
			    	$('.hometab-item').each(function() {
		    			$(this).removeClass('active');
			            if ($(this).attr('id') == 'calander') {
			                $(this).addClass('active');
			            }
		        	});
		    	<%}%>
		    	<%if(pvdto.getHomeTab()=="파일") {%>
			    	$('.hometab-item').each(function() {
		    			$(this).removeClass('active');
			            if ($(this).attr('id') == 'file') {
			                $(this).addClass('active');
			            }
		        	});
		    	<%}%>
		    	<%if(pvdto.getCategoryIdx() >= 1) { %>
		    		$('.company-public-option').find('.company-public-toggle-btn').addClass('on');
		    		$('.public-setting-content').css('display','block');
		    		$(".company-category").find(".CATG<%=pvdto.getCategoryIdx()%>").prop("selected", true);
		    	<%} else { %>
		    		$(".company-category").find(".CATG1").prop("selected", true);
		    		$('.company-public-option').find('.company-public-toggle-btn').removeClass('on');
		    		$('.public-setting-content').css('display','none');
		    	<% } %>
		    	<%if(pvdto.getApprovalYN() == 'Y') { %>
		    		$('.company-admin-option').find('.company-public-toggle-btn').addClass('on');
	    		<%} else { %>
		    		$('.company-admin-option').find('.company-public-toggle-btn').removeClass('on');
	    		<% } %>
	    		$('.board-write-auth-element').find('option').filter(function() {
	    		    return $(this).data("code") == <%=pvdto.getWritingGrant()%>;
	    		}).prop("selected", true);
	    		$('.edit-auth-element').find('option').filter(function() {
	    		    return $(this).data("code") == <%=pvdto.getEditPostGrant()%>;
	    		}).prop("selected", true);
	    		$('.view-auth-element').find('option').filter(function() {
	    		    return $(this).data("code") == <%=pvdto.getPostViewGrant()%>;
	    		}).prop("selected", true);
	    		$('.comment-auth-element').find('option').filter(function() {
	    		    return $(this).data("code") == <%=pvdto.getCommentGrant()%>;
	    		}).prop("selected", true);
		    });
		    
            $('.close-btn').click(function() {
                $('.create_area').css('display', 'none');
                $('.project_explanation-input-btn').css('display', 'block');
                $('.project_explanation-input').css('display', 'none');
                $('.project_explanation-input').val('');
                $('.project-title-input').val('');
                $('.admin-setting-toggle-open').css('display', 'block');
                $('.admin-setting-toggle-close').css('display', 'none');
                $('.project-admin-more-option-area').css('display', 'none');
                $('.view-auth-element').find('.authority-select-box').prop('disabled', false);
                $('.add-option-info-value').css('display', 'none');
                $('.hometab-item').each(function() {
	    			$(this).removeClass('active');
		            if ($(this).attr('id') == 'feed') {
		                $(this).addClass('active');
		            }
	        	});
                $('.company-public-option').find('.company-public-toggle-btn').removeClass('on');
	    		$('.public-setting-content').css('display','none');
                $('.company-admin-option').find('.company-public-toggle-btn').removeClass('on');
                $(".company-category").find(".CATG1").prop("selected", true);
                $('.board-write-auth-element').find('option').filter(function() {
	    		    return $(this).data("code") == 0;
	    		}).prop("selected", true);
	    		$('.edit-auth-element').find('option').filter(function() {
	    		    return $(this).data("code") == 0;
	    		}).prop("selected", true);
	    		$('.view-auth-element').find('option').filter(function() {
	    		    return $(this).data("code") == 0;
	    		}).prop("selected", true);
	    		$('.comment-auth-element').find('option').filter(function() {
	    		    return $(this).data("code") == 0;
	    		}).prop("selected", true);
	    		$('.template-sample-img').removeClass('calander');
	    		$('.template-sample-img').removeClass('task');
	    		$('.template-sample-img').removeClass('file');
	    		$('.template-sample-img').addClass('feed');
            });
            
			//글 클릭시 해당 게시글 작성창 출력
			$('.create-txt').click(function(){
				let projectIdx = <%=projectIdx%>;
				$('.create-flow-background-1').css('display', 'block');
					if($(this).attr('id') == "writing") {
						$('.post-content-box-post').css('display', 'block');
						$('.create-tab-write').each(function() {
					    	if ($(this).attr('id') === 'crt-post') {
					        	$(this).addClass('on');
					    	}
						});
					}
				if($(this).attr('id') == "task") {
					$('.task-area').css('display', 'block');
					$('.create-tab-write').each(function() {
					    if ($(this).attr('id') === 'crt-task') {
					        $(this).addClass('on');
					    }
					});
				}
				if($(this).attr('id') == "schedule") {
					$('.schedule-add-content-box').css('display', 'block');
					$('.create-tab-write').each(function() {
					    if ($(this).attr('id') === 'crt-schedule') {
					        $(this).addClass('on');
					    }
					});
					let now = new Date();
					let nearestTenthMinute = getNearestTenthMinute(now);
					now.setMinutes(nearestTenthMinute);
					now.setSeconds(0);
					now.setMilliseconds(0);
					
					let year = now.getFullYear();
					let month = (now.getMonth() + 1).toString().padStart(2, '0');
					let day = now.getDate().toString().padStart(2, '0');
					let dayNames = ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'];
					let dayOfWeek = dayNames[now.getDay()];
					let formattedDate = year + '-' + month + '-' + day + ' (' + dayOfWeek.charAt(0) + '), ';
					
					let oneHourLater = new Date(now.getTime());
					oneHourLater.setHours(oneHourLater.getHours() +1);
					
					$("#startDateInput").val(formattedDate + now.toTimeString().substring(0, 5));
					$("#endDateInput").val(formattedDate + oneHourLater.toTimeString().substring(0, 5));
					$(".schedule-add-background").css('display', 'flex');
				}
			});
			// 현재시간 분 기준 반올림시키는 함수
			function getNearestTenthMinute(date) {
			    let minutes = date.getMinutes();
			    let remainder = minutes % 10;
			    let nearestTenthMinute = remainder >= 5 ? (minutes + (10 - remainder)) : (minutes - remainder);
				
			    // 만약 60분을 초과한다면 시간을 조정합니다.
			    if (nearestTenthMinute === 60) {
			        nearestTenthMinute = 0;
			        date.setHours(date.getHours() + 1);
			    }
				
			    return nearestTenthMinute;
			}
			$('.create-content').click(function() {
			    $('.create-flow-background-1').css('display', 'block');
			    if ($('.create-txt').attr('id') === "writing") {
			        $('.post-content-box-post').css('display', 'block');
			        $('.create-tab-write').removeClass('on');
			        if ($('.create-tab-write#crt-post').length) {
			            $('.create-tab-write#crt-post').addClass('on');
			        }
			    }
			});
			//프로젝트 검색문
		 	 $(document).on('keyup','.select-project-search', function() {
			  let search = $(this).val();
			  $.ajax({
				  type: 'POST',
		            url: 'MyProjectSearchAjax',
		            data: {
		            	search : search,
		            	memberIdx : <%=memberIdx%>
		            },
		            success: function(data) {
		                console.log(data);
		                $('.project-item').remove();
		                for(let i = 0; i<data.length; i++) {
			                let projectItem = "<li class=\"project-item\" data-pno="+data[i].ProjectIdx+"> "+
							" <div class=\"squre color-code-"+data[i].ProjectColor+"\"></div> "+
							" <p class=\"project-title-value\">"+data[i].ProjectName+"</p> "+
						 " </li>";
		                	
		                $('.select-project-list').prepend(projectItem);
		                }
		            },
		            error: function(r, s, e) {
		                console.log(r.status);
		                console.log(e);
		                alert("오류");
		            }
			  });
		  	});
			
			//버튼 클릭후 아무대나 눌러서 화면 닫는 문
			$(document).click(function(event) {
			    if (!$(event.target).closest('.manager-search-input, .search-manager-box').length) {
			        $('.search-manager-box').css('display', 'none');
			    }
			    if (!$(event.target).closest('.input-data-priority, .priority-layer').length) {
			    	$('.priority-layer').css('display', 'none');
			    }
			    if (!$(event.target).closest('.input-data-group, .task-group-list-layer').length) {
			    	$('.task-group-list-layer').css('display', 'none');
			    }
			    if (!$(event.target).closest('.state-btn, .state-layer').length) {
			    	$('.state-layer').css('display', 'none');
			    }
			    if (!$(event.target).closest('.create-private-btn, .create-post-option').length) {
			    	$('.create-post-option').css('display', 'none');
			    }
			    if (!$(event.target).closest('.select-project-btn, .search-post-project').length) {
			    	$('.search-post-project').css('display', 'none');
			    }
			});
			// 글 프로젝트 변경 
			$('.select-project-btn').click(function() {
				$('.search-post-project').css('display','block');
			});
			// 글 유형 버튼 클릭시 해당 글 유형으로 변경
			$('.create-tab-write').click(function() {
			    $('.create-tab-write').removeClass('on');
			    $(this).addClass('on');
			    if ($(this).attr('id') === 'crt-post') {
			        $('.post-content-box-post').css('display', 'block');
			        $('.task-area').css('display', 'none');
			        $('.schedule-add-content-box').css('display', 'none');
			    } else if ($(this).attr('id') === 'crt-task') {
			        $('.post-content-box-post').css('display', 'none');
			        $('.task-area').css('display', 'block');
			        $('.schedule-add-content-box').css('display', 'none');
			    } else if ($(this).attr('id') === 'crt-schedule') {
			    	$('.post-content-box-post').css('display', 'none');
			        $('.task-area').css('display', 'none');
			        $('.schedule-add-content-box').css('display', 'block');
			        let now = new Date();
					let nearestTenthMinute = getNearestTenthMinute(now);
					now.setMinutes(nearestTenthMinute);
					now.setSeconds(0);
					now.setMilliseconds(0);
					
					let year = now.getFullYear();
					let month = (now.getMonth() + 1).toString().padStart(2, '0');
					let day = now.getDate().toString().padStart(2, '0');
					let dayNames = ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'];
					let dayOfWeek = dayNames[now.getDay()];
					let formattedDate = year + '-' + month + '-' + day + ' (' + dayOfWeek.charAt(0) + '), ';
					
					let oneHourLater = new Date(now.getTime());
					oneHourLater.setHours(oneHourLater.getHours() +1);
					
					$("#startDateInput").val(formattedDate + now.toTimeString().substring(0, 5));
					$("#endDateInput").val(formattedDate + oneHourLater.toTimeString().substring(0, 5));
					$(".schedule-add-background").css('display', 'flex');
			    }
			});
			$(document).on('change', '#all-day-check', function() {
				let yn = $(this).prop('checked');
				if(yn) {
					_prevStartDate = $("#startDateInput").val().substring(14, $("#startDateInput").val().length);
					_prevEndDate = $("#endDateInput").val().substring(14, $("#endDateInput").val().length);
					
					$("#startDateInput").val($("#startDateInput").val().substring(0, 14));
					$("#endDateInput").val($("#endDateInput").val().substring(0, 14));
				}else {
					let onAllDayStartDate = $("#startDateInput").val() + _prevStartDate;
					let onAllDayEndDate = $("#endDateInput").val() + _prevEndDate;
					
					$("#startDateInput").val(onAllDayStartDate);
					$("#endDateInput").val(onAllDayEndDate);
				}
			});
			$(document).on('click', function() {
				if(!$(event.target).closest('#participantSelectTable').length && !$(event.target).closest("#member-add-input").length) {
					$("#participantSelectTable").css('display', 'none');
				}
			})
			$("#member-add-input").click(function() {
				$("#participantSelectTable").css('display', 'table');
			})
			/*일정작성창에서 참석자 지정하기*/
			$(".selectMemberItem").click(function() {
				let memberIdx = $(this).data("idx");
				let memberName = $(this).find(".participantName").text();
				let profImgUrl = $(this).find(".participantProfileImg").attr("src");
				let yn = true;
				$(".member-item-box").each(function() {
					if($(this).data("idx") == memberIdx) {
						yn = false;
					}
				});
				if(yn) {
					let newTr = '<span class="member-item-box" data-idx="'+memberIdx+'">' +
									'<img class="user-prof" src="'+profImgUrl+'"/>' +
									'<span>'+memberName+'</span>' +
									'<button type="button" class="participantRemoveBtn"></button>' +
								'</span>';
					
					$("#memberItemsWrap").append(newTr);
				}
				$("#participantSelectTable").css('display', 'none');
			})
			// 게시글 작성창 닫기
			$('.btn-close').click(function() {
			    const hideElements = [
			        '.create-flow-background-1', 
			        '.post-content-box-post', 
			        '.task-area', 
			        '.task-startdate-area', 
			        '.task-priority-area', 
			        '.task-group-area', 
			        '.task-progress-area', 
			        '.subtask-bottom-create-layer'
			    ];
			    $(hideElements.join(',')).css('display', 'none');
			
			    $('.create-tab-write, .task-state-btn').removeClass('on');
			    $('.task-state-btn.request').addClass('on');
			
			    $('.progress-bar').css({'width': '0%', 'background': 'green'});
			    $('.progress-text').text('0%');
			
			    const resetIcons = [
			        {selector: '.task-priority-area .icons', removeClasses: ['high', 'emergency', 'middle', 'low']},
			        {selector: '.priority-span-sub .icons', removeClasses: ['high', 'middle', 'low', 'emergency']}
			    ];
			    resetIcons.forEach(item => {
			        $(item.selector).removeClass(item.removeClasses.join(' '));
			    });
			    $('.manager-item').remove(); 
			    $('.task-priority-area .priority-text').text("");
			    $('.task-group-area .task-group-values').text("");
			    $('.task-startdate-area .input-data-text, .task-enddate-area .input-data-text').text("");
			    
			    $('.task-priority-area .board-remove-btn, .task-group-area .board-remove-btn, .task-startdate-area .board-remove-btn, .task-enddate-area .board-remove-btn').css('display', 'none');
			
			    $('.task-priority-area .input-data-priority, .task-group-area .input-data-group, .task-startdate-area .input-start-datas, .task-enddate-area .input-end-datas').css('display', 'inline-block');
				
			    
			    $('.state-btn').removeClass('progress feedback complete hold').addClass('request').text('요청');
			
			    $('.subtask-bottom-create-layer .subtask-menu-priorty .subtask-date-input-btn').css('display', 'inline-block');
			    $('.subtask-bottom-create-layer .subtask-menu-priorty .priority-span-sub').css('display', 'none');
				$('.postTitle').val('');
				$('.create-content-value').text('');
				$('.input-end-datas').val('');
				$('.input-start-datas').val('');
				$('.create-private-btn').text($('.private-option-full').text());
				$('.create-post-option').css('display','none');
				$('.create-private-btn').addClass('full');
				$('.create-private-btn').removeClass('admin');
				$('.post-content-box-post').css('display', 'none');
				$('.task-area').css('display', 'none');
				$('.schedule-add-content-box').css('display', 'none');
				Release = 'Y';
				$('#loaction-input').val('');
				$('.alarm-select').val('없음');
				$('.create-post').removeAttr('data-bno');
				$('.create-post').removeAttr('data-tno');
				$('.create-post').removeAttr('data-sno');
				$('.create-post-nav').css('display','flex');
				$('.create-post-title').text('게시글 작성');
				$('.member-item-box').each(function(){
				    if($(this).data('idx') != <%= memberIdx %>){
				        $(this).remove();
				    }
				});
			    $('.task-more-add-btn').css('display', 'block');
			    $('.select-list').remove();
			    $.ajax({
			    	type : "POST",
			    	url : "ProjectMemberSearchAJAX",
			    	data : {
			    		projectIdx : <%=projectIdx%>
			    	},
			    	success: function(data) {
		                console.log(data);
		                for(let i = 0; i<data.length; i++) {
			                let memberProfile = "<li class=\"select-list\" data-mno="+data[i].memberIdx+"> "+
							"	<div class=\"registration-list\">"+
							"	<div class=\"profile-img-box\" style=\"background-image: url('"+data[i].profileIMG+"')\"></div> "+
							"	<div class=\"profile-content-box\">"+
							"		<div class=\"profile-content1\">"+
							"			<div class=\"registration-name\">"+data[i].name+"</div>"+
							"			<span class=\"registration-position\">"+data[i].position+"</span>"+
							"		</div>"+
							"		<div class=\"profile-content2\">"+
							"			<div class=\"registration-company\">"+data[i].companyName+"</div>"+
							"			<div class=\"registration-team\">"+data[i].departmentName+"</div>"+
							"		</div>"+
							"	</div>"+
						"	</div>"+
					"	</li>";
						    $('.sub-manager-list-box').append(memberProfile);
		                }
		            },
		            error: function(r, s, e) {
		                console.log(r.status);
		                console.log(e);
		                alert("오류");
		            }
			    	
			    });
			});
			// 업무글 클릭시 상태변경
			let taskState = 1;
			$('.task-state-btn').click(function() {
			    $('.task-state-btn').removeClass('on');
			    $(this).addClass('on');
			    if($(this).hasClass('request')==true){
			    	taskState = 1;
			    }
			    if($(this).hasClass('progress')==true){
			    	taskState = 2;
			    }
			    if($(this).hasClass('feedback')==true){
			    	taskState = 3;
			    }
			    if($(this).hasClass('complete')==true){
			    	taskState = 4;
			    }
			    if($(this).hasClass('hold')==true){
			    	taskState = 5;
			    }
			});
			$('.task-state-btn.complete').click(function(){ 
				$('.progress-bar').css('width', '100%');
				$('.progress-bar').css('background', 'blue');
				$('.progress-text').text('100%');
			});
			//업무글 담당자 remove버튼 클릭시 담당자 삭제
			$('.manager-profile-remove').click(function(){
				$(this).parent().remove();
			});
			
			// 업무글 값 있을경우 display : none 안되게
			$('.task-startdate-area').each(function() {
		        var content = $('.input-data-text').text().trim();
		
		        if (content !== "") {
		            $(this).css('display', 'block');
		            $(this).find('.input-data').css('display', 'none');
		        } else {
		            $(this).css('display', 'none');
		            $(this).find('.input-data').css('display', 'inline-block'); 
		        }
		    });
			$('.task-priority-area').each(function() {
		        var content = $('.priority-text').text().trim();
		
		        if (content !== "") {
		            $(this).css('display', 'block'); 
		            $(this).find('.input-data-priority').css('display', 'none');
		        } else {
		            $(this).css('display', 'none');
		            $(this).find('.input-data-priority').css('display', 'inline-block');
		        }
		    });
			$('.task-group-area').each(function() {
		        var content = $('.task-group-value').text().trim(); 
		
		        if (content !== "") {
		            $(this).css('display', 'block'); 
		            $(this).find('.input-data-group').css('display', 'none');
		        } else {
		            $(this).css('display', 'none');
		            $(this).find('.input-data-group').css('display', 'inline-block');
		        }
		    });
			$('.task-progress-area').each(function() {
		        var content = $('.progress-text').text().trim(); 
		
		        if (content !== "0%") {
		            $(this).css('display', 'block');
		        } else {
		            $(this).css('display', 'none'); 
		        }
		    });
			// 업무글 모든 항목이 display :block상태일떄 더보기 버튼 삭제
			$('.create-task-content-group').each(function() {
	            if ($(this).find('.task-startdate-area').css('display') === 'block' &&
	            	$(this).find('.task-priority-area').css('display') === 'block' &&	
	            	$(this).find('.task-group-area').css('display') === 'block' &&
	            	$(this).find('.task-progress-area').css('display') === 'block'
	            	) {
	            	$('.task-more-add-btn').css('display','none');
	            } else {
	            	$('.task-more-add-btn').css('display','block');
	            }
		    });
			// 해당 글들에 데이터 입력시 데이터 추가버튼 none
			$('.task-enddate-area').each(function() {
		        var inputDataText = $(this).find('.input-data-text').text().trim(); 

		        if (inputDataText !== "") {
		            $(this).find('.input-data').css('display', 'none');
		            $(this).find('.board-remove-btn').css('display', 'inline-block');
		        } else {
		            $(this).find('.input-data').css('display', 'inline-block'); 
		            $(this).find('.board-remove-btn').css('display', 'none');
		        }
		    });
			//담당자 추가에 마우스커서 클릭시 출력버튼
			$('.manager-search-input').click(function() {
				if($('.search-manager-box').css('display')=='none') {
					$('.search-manager-box').css('display', 'block');
				} else {
					$('.search-manager-box').css('display', 'none');
				}
			});
			let memberValue = [];
			let mCount = 0;
			$('.select-list').each(function(){
				mCount = $('.select-list').length;
			});
			//업무 게시글 작성 담당자 선택
			$(document).on('click','.select-list', function() {
				mCount--;
				if(mCount==0) {
					$('.select-nulls').css('display','flex');
				}
				let mno = $(this).data("mno");
				memberValue.push(mno);
				$(this).remove();
				$.ajax({
					type : "post",
					url : "TaskCreateMemberSelectAjax",
					data : {
						memberIdx : mno
					},
					success: function(data) {
		                console.log(data);
						let memberBox = "<span class=\"manager-item\" data-mno="+data.memberIdx+">" +
							"	<span class=\"manager-profile-img\" style=\"background-image: url('"+data.profileImg+"');\"></span>" +
							"	<span class=\"manager-profile-name\">"+data.name+"</span> " +
							"	<button class=\"manager-profile-remove\"></button> " +
							" </span>";
						$('.task-area').find('.manager-group').prepend(memberBox);
					},
					 error: function(r, s, e) {
			                console.log(r.status);
			                console.log(e);
			                alert("오류");
			         }
				});
			});
			//엄무게시글 작성 담당자 삭제
			$(document).on('click','.manager-profile-remove',function(){
				let mno = $(this).parent().data("mno");
				let self = (this);
				$.ajax({
					type : "POST",
					url : "MemberViewAjax",
					data : {
						memberIdx : mno,
						projectIdx : <%=projectIdx%>
					},
					success: function(data) {
			            console.log(data);
						alert("성공");
						$(self).parents('.manager-item').remove();
						 var index = memberValue.indexOf(mno); 
					        if (index !== -1) {
					        	 memberValue.splice(index, 1);
					        }
						let memberProfile = "<li class=\"select-list\" data-mno="+data.memberIdx+"> "+
								"	<div class=\"registration-list\">"+
								"	<div class=\"profile-img-box\" style=\"background-image: url('"+data.profileIMG+"')\"></div> "+
								"	<div class=\"profile-content-box\">"+
								"		<div class=\"profile-content1\">"+
								"			<div class=\"registration-name\">"+data.name+"</div>"+
								"			<span class=\"registration-position\">"+data.position+"</span>"+
								"		</div>"+
								"		<div class=\"profile-content2\">"+
								"			<div class=\"registration-company\">"+data.companyName+"</div>"+
								"			<div class=\"registration-team\">"+data.departmentName+"</div>"+
								"		</div>"+
								"	</div>"+
							"	</div>"+
						"	</li>";
						$('.sub-manager-list-box').each(function(){
							$(this).prepend(memberProfile);
						});
						mCount++;
						if(mCount>0) {
							$('.select-nulls').css('display','none');
						}
					},
				    error: function(r, s, e) {
		                console.log(r.status);
		                console.log(e);
		                alert("오류");
		            }
				});
			});
			//업무 게시글 작성 담당자 검색
			$(document).on('keyup','.manager-search-input', function() {
				let searchManager = $(this).val();
				$.ajax({
		            type: 'POST',
		            url: 'MemberSearchAjax', 
		            data: {
		                searchMember: searchManager,
		                projectIdx: <%= projectIdx %>
		            },
		            error: function(r, s, e) {
		                console.log(e);
		            },
		            success: function(data) {
		                console.log(data);
		                $('.select-list').remove();
	                    mCount = $('.select-list').length;
	                    if(mCount==0) {
							$('.select-nulls').css('display','flex');
						}
		                var memberData = "";
		                for (let i = 0; i < data.length; i++) {
		                    if(!memberValue.includes(data[i].memberIdx)) {
		                    	memberData = "<li class=\"select-list\" data-mno="+data[i].memberIdx+"> "+
										"	<div class=\"registration-list\">"+
										"	<div class=\"profile-img-box\" style=\"background-image: url('"+data[i].profileIMG+"')\"></div> "+
										"	<div class=\"profile-content-box\">"+
										"		<div class=\"profile-content1\">"+
										"			<div class=\"registration-name\">"+data[i].name+"</div>"+
										"			<span class=\"registration-position\">"+data[i].position+"</span>"+
										"		</div>"+
										"		<div class=\"profile-content2\">"+
										"			<div class=\"registration-company\">"+data[i].companyName+"</div>"+
										"			<div class=\"registration-team\">"+data[i].departmentName+"</div>"+
										"		</div>"+
										"	</div>"+
									"	</div>"+
								"	</li>";
		                    }
		                    $('.sub-manager-list-box').prepend(memberData);
		                    mCount = $('.select-list').length;
			                if(mCount>0) {
								$('.select-nulls').css('display','none');
							} 
		                }
		            }
		        });
		    });
			 let weekdays = ["일", "월", "화", "수", "목", "금", "토"];
			 
			 $(document).on("focus", ".input-start-datas", function() {
				    if (!$(this).data("datepicker")) {
				        $(this).datepicker({
				            showOn: "focus",         
				            showAnim: "fadeIn",     
				            regional: 'kr',          
				            dateFormat: 'yy-mm-dd',  
				            onSelect: function(dateText, inst) {
				                var date = $(this).datepicker('getDate'); 
				                var dayOfWeek = date.getDay(); 
				                var formattedDate = dateText + " (" + weekdays[dayOfWeek] + ")";

				                $(this).val(formattedDate);

				                var $taskStartDateContent = $(this).closest('.data-content');
				                $taskStartDateContent.find(".input-data-text").text(formattedDate); 
				                $taskStartDateContent.next().css('display', 'inline-block'); 

				                $(this).hide(); 
				                startDate = dateText; 
				            }
				        });
				    }
				});
			 $(document).on("focus", ".input-end-datas", function() {
				    if (!$(this).data("datepicker")) {
				        $(this).datepicker({
				            showOn: "focus",         
				            showAnim: "fadeIn",      
				            regional: 'kr',         
				            dateFormat: 'yy-mm-dd',  
				            onSelect: function(dateText, inst) {
				                var date = $(this).datepicker('getDate');
				                if (date) {
				                    var dayOfWeek = date.getDay(); // 요일 계산
				                    var formattedDate = dateText + " (" + weekdays[dayOfWeek] + ")"; 

				                    
				                    $(this).val(formattedDate); 

				                    var $taskEndDateContent = $(this).closest('.data-content');
				                    $taskEndDateContent.find(".input-data-text").text(formattedDate);
				                    $taskEndDateContent.next().css('display', 'inline-block');

				                    $(this).hide();
				                    endDate = dateText;
				                    alert(endDate);
				                }
				            }
				        });
				    }
				});
			$('.task-group-items').click(function(){
				$('.task-group-list-layer').css('display','none');
				if($(this).data("code")!=0) {
					let title = $(this).find('.task-group-name-boxs').text();
					$('.input-data-group').css('display','none');
					$(this).parents('.task-group-area').find('.board-remove-btn').css('display','inline-block');
					$(this).parents('.task-group-area').find('.task-group-values').text(title);
					taskGroupIdx = $(this).data("code");
				} else {
					
				}
				
			});
			 
			//remove버튼 클릭시 해당 항목의 html 삭제후 추가버튼 출력
			$('.board-remove-btn').click(function() {
				if($(this).parents('.task-startdate-area')) {
					var parentslayer = $(this).parents('.task-startdate-area');
					$(parentslayer).find('.input-data-text').text("");
					$(parentslayer).find('.board-remove-btn').css('display','none');
					$(parentslayer).find('.input-data').css('display','inline-block');
					$(parentslayer).find('.input-start-datas').css('display', 'inline-block');
			        $(parentslayer).find('.input-start-datas').val("");
					startDate = "";
				}
				if($(this).parents('.task-enddate-area')) {
					var parentslayer = $(this).parents('.task-enddate-area');
					$(parentslayer).find('.input-data-text').text("");
					$(parentslayer).find('.board-remove-btn').css('display','none');
					$(parentslayer).find('.input-data').css('display','inline-block');
					$(parentslayer).find('.input-end-datas').css('display', 'inline-block');
			        $(parentslayer).find('.input-end-datas').val("");
					endDate = "";
				}
				if($(this).parents('.task-priority-area')) {
					var parentslayer = $(this).parents('.task-priority-area');
					$(parentslayer).find('.icons').removeClass('high');
					$(parentslayer).find('.icons').removeClass('emergency');
					$(parentslayer).find('.icons').removeClass('middle');
					$(parentslayer).find('.icons').removeClass('low');
					$(parentslayer).find('.priority-text').text("");
					$(parentslayer).find('.board-remove-btn').css('display','none');
					$(parentslayer).find('.input-data-priority').css('display','inline-block');
					Taskpriority = 0;
				}
				if($(this).parents('.task-group-area')) {
					var parentslayer = $(this).parents('.task-group-area');
					$(parentslayer).find('.task-group-values').text("");
					$(parentslayer).find('.board-remove-btn').css('display','none');
					$(parentslayer).find('.input-data-group').css('display','inline-block');
					taskGroupIdx = 0;
				}
			});
			//우선순위 추가 버튼 클릭시 해당 레이어창 출력
			$('.input-data-priority').click(function() {
				$(this).parent().find('.priority-layer').css('display','block');
			});
			$('.priority-span-sub').click(function() {
			    $(this).siblings('.priority-layers').css('display', 'block');
			});
			
			$('.priority-btn').click(function() {
				$('.input-data-priority').css('display','none');
				var priorityselect = $(this).parents('.task-priority-area');
					$(priorityselect).find('.icons').removeClass('high');
					$(priorityselect).find('.icons').removeClass('middle');
					$(priorityselect).find('.icons').removeClass('emergency');
					$(priorityselect).find('.icons').removeClass('low');
				if($(this).attr('id')=='low') {
					$(priorityselect).find('.icons').addClass('low');
					$(priorityselect).find('.priority-text').text("낮음");
					$(priorityselect).find('.board-remove-btn').css('display','inline-block');
					Taskpriority = 4;
				}
				if($(this).attr('id')=='middle') {
					$(priorityselect).find('.icons').addClass('middle');
					$(priorityselect).find('.priority-text').text("중간");
					$(priorityselect).find('.board-remove-btn').css('display','inline-block');
					Taskpriority = 3;
				}
				if($(this).attr('id')=='high') {
					$(priorityselect).find('.icons').addClass('high');
					$(priorityselect).find('.priority-text').text("높음");
					$(priorityselect).find('.board-remove-btn').css('display','inline-block');
					Taskpriority = 2;
				}
				if($(this).attr('id')=='emergency') {
					$(priorityselect).find('.icons').addClass('emergency');
					$(priorityselect).find('.priority-text').text("긴급");
					$(priorityselect).find('.board-remove-btn').css('display','inline-block');
					Taskpriority = 1;
				}
				$('.priority-layer').css('display','none');
			});
			//그룹추가 버튼
			$('.input-data-group').click(function(){
				$('.task-group-list-layer').css('display','block');
			});
			//클릭시 해당 그룹 추가 단 그룹 미지정 경우 그룹 추가x
			$('.task-group-item').click(function() {
				$('.task-group-list-layer').css('display', 'none');

			    if ($(this).attr('id') === 'none-group') {
			        return;
			    } else {
			        var text = $(this).text().trim(); 
			        $('.input-data-group').css('display', 'none');
			        $('.task-group-values').text(text);
			        $('.task-group-area').find('.board-remove-btn').css('display', 'inline-block');
			    }
			});
			// 진행도 증가
			let Taskprogress = 0;
			$('.progress-btn').click(function() {
				if($(this).find('em').text().trim() == '0%') {
					$('.progress-text').text("0%");
					$('.progress-bar').css('width', '0%');
					Taskprogress = 0;
				}
				if($(this).find('em').text().trim() == '10%') {
					$('.progress-text').text("10%");
					$('.progress-bar').css('width', '10%');
					$('.progress-bar').css('background', 'green');
					Taskprogress = 10;
				}
				if($(this).find('em').text().trim() == '20%') {
					$('.progress-text').text("20%");
					$('.progress-bar').css('width', '20%');
					$('.progress-bar').css('background', 'green');
					Taskprogress = 20;
				}
				if($(this).find('em').text().trim() == '30%') {
					$('.progress-text').text("30%");
					$('.progress-bar').css('width', '30%');
					$('.progress-bar').css('background', 'green');
					Taskprogress = 30;
				}
				if($(this).find('em').text().trim() == '40%') {
					$('.progress-text').text("40%");
					$('.progress-bar').css('width', '40%');
					$('.progress-bar').css('background', 'green');
					Taskprogress = 40;
				}
				if($(this).find('em').text().trim() == '50%') {
					$('.progress-text').text("50%");
					$('.progress-bar').css('width', '50%');
					$('.progress-bar').css('background', 'green');
					Taskprogress = 50;
				}
				if($(this).find('em').text().trim() == '60%') {
					$('.progress-text').text("60%");
					$('.progress-bar').css('width', '60%');
					$('.progress-bar').css('background', 'green');
					Taskprogress = 60;
				}
				if($(this).find('em').text().trim() == '70%') {
					$('.progress-text').text("70%");
					$('.progress-bar').css('width', '70%');
					$('.progress-bar').css('background', 'green');
					Taskprogress = 70;
				}
				if($(this).find('em').text().trim() == '80%') {
					$('.progress-text').text("80%");
					$('.progress-bar').css('width', '80%');
					$('.progress-bar').css('background', 'green');
					Taskprogress = 80;
				}
				if($(this).find('em').text().trim() == '90%') {
					$('.progress-text').text("90%");
					$('.progress-bar').css('width', '90%');
					$('.progress-bar').css('background', 'green');
					Taskprogress = 90;
				}
				if($(this).find('em').text().trim() == '100%') {
					$('.progress-text').text("100%");
					$('.progress-bar').css('width', '100%');
					$('.progress-bar').css('background', 'blue');
					Taskprogress = 100;
				}
				
			})
			
	
	
		    function toggleDisplay(layer) {
		        if (layer.css('display') === 'none') {
		            layer.css('display', 'block');
		        } else {
		            layer.css('display', 'none');
		        }
		    }
			  $('.search-manager-item').click(function () {
				  $(this).toggleClass('active');
				  
			  	const $btn = $(this).find('.select-manager-btn');
			    if ($btn.length > 0) { 
			       if (!$btn.hasClass('active')) {
			             $btn.addClass('active'); 
			             managerCount++;
			           } else {
			             $btn.removeClass('active'); 
			             managerCount--;
			           }
			          updateCount();
			       }
			   });
			 $('.task-manager-select-all-delete').click(function() {
		    	$('.select-manager-btn').removeClass('active');
		    	$('.search-manager-item').removeClass('active');	
		    		managerCount = 0;
		    		updateCount();
			 });
			 function updateCount() {
			     $('.select-manager-count').text(managerCount);
			 }
			 let Release = 'Y';
			 
			 let project = <%=projectIdx%>;
			 //게시글 작성시 프로젝트 변경
			$(document).on('click', '.project-item', function() {
				let projectTitle = $(this).find('.project-title-value').text();
				let colorCode = $(this).find('.squre').attr('class'); 
				let classes = colorCode.split(' ');
				let colorClass = classes.filter(function(className) {
				    return className !== 'squre'; 
				})[0]; 
				for (let i = 1; i <= 12; i++) {
				    $('.post-project-color').removeClass('color-code-' + i);
				}
				$('.post-project-color').addClass(colorClass);
				$('.post-project-title').text(projectTitle);
				project = $(this).data("pno");
			 });
			//제출 버튼 클릭
			$('.create-post-submit-btn').click(function(e) {
			    var inputTitleValue = $('.postTitle').val();
			    let type = "";
				let temporary = 'N';
				var titleText = $('.create-post-title').text().trim();
				if(titleText == '게시물 작성') {
				    if($('#crt-post').hasClass('on')) {
				    	let inputContentValue = $('.post-content-box-post').find('.create-content-value').text();
				    	if (inputContentValue == '') {
					        e.preventDefault(); 
					        alert("내용을 입력해주세요!");
					    } else {
					    	type = "글"; 
					    	$.ajax ({
					    		type: 'POST',
					            url: 'BoardTypePostCreateAjax',
					            data : {
					            	title : inputTitleValue,
					            	content : inputContentValue,
					            	memberIdx : <%=memberIdx%>,
					    			projectIdx : project,
					    			category : type,
					    			Release : Release,
					    			temporary : temporary
					            },
				    			success: function(data) {
				    				console.log(data);
					                alert("적용되었습니다");
					                location.reload();
				    			},
				    			error: function(r, s, e) {
					                console.log(r.status);
					                console.log(e);
					                alert("오류");
					            }				    		
					    	});
					    }
				    } 
				    if($('#crt-schedule').hasClass('on')) {
				    	let inputContentValue = $('.schedule-add-content-box').find('.create-content-value').text();
				    	if (inputContentValue == '') {
					        e.preventDefault(); 
					        alert("내용을 입력해주세요!");
					    } else {
						let startDate = $("#startDateInput").val();
						let endDate = $("#endDateInput").val();
						let allDayYN = $("#all-day-check").prop('checked') == true ? 'Y' : 'N';
						let locationStr = $("#loaction-input").val();
						let alarmType = $(".alarm-select").val();
						let memberIdxArray = [];
						$(".member-item-box").each(function(idx, element) {
							memberIdxArray[idx] = $(this).data("idx");
						})
						$.ajax({
							type: 'post',
							url: 'scheduleWriteRecordAjaxServlet',
							data: {
								"projectIdx":project,
								"writerIdx":<%=memberIdx%>,
								"title":inputTitleValue,
								"startDate":startDate,
								"endDate":endDate,
								"allDayYN":allDayYN,
								"memberIdxArray":memberIdxArray.join(),
								"content":inputContentValue,
								"location":locationStr,
								"alarmType":alarmType,
								"releaseYn":Release
							},
							success: function() {
								alert("등록되었습니다.");
								location.reload();
							},
							error: function(r, s, e) {
				                console.log(r.status);
				                console.log(e);
				                alert("오류");
				            }	
						})
					   }
				    }
				    if($('#crt-task').hasClass('on')) {
				    	let inputContentValue = $('.task-area').find('.create-content-value').text();
				    	if (inputContentValue == '') {
					        e.preventDefault(); 
					        alert("내용을 입력해주세요!");
					    } else {
					    	type = "업무"; 
					    	$.ajax ({
					    		type: 'POST',
					            url: 'BoardTypeTaskCreateAjax',
					            data : {
					            	title : inputTitleValue,
					            	content : inputContentValue,
					            	memberIdx : <%=memberIdx%>,
					    			projectIdx : project,
					    			category : type,
					    			Release : Release,
					    			temporary : temporary,
					    			startDate : startDate,
					    			endDate : endDate,
					    			Taskpriority : Taskpriority,
					            	taskGroupIdx : taskGroupIdx,
					            	taskState : taskState,
					            	Taskprogress : Taskprogress,
					            	memberValue : JSON.stringify(memberValue)
					            },
				    			success: function(data) {
				    				console.log(data);
					                alert("적용되었습니다");
					                location.reload();
				    			},
				    			error: function(r, s, e) {
					                console.log(r.status);
					                console.log(e);
					                alert("오류");
					            }				    		
					    	});
					    }
				    }
				} else if (titleText == '게시글 수정') {
					let boardIdx = $('.create-post').data("bno");
					 if($('#crt-post').hasClass('on')) {
					let inputContentValue = $('.post-content-box-post').find('.create-content-value').text();
					    	if (inputContentValue == '') {
						        e.preventDefault(); 
						        alert("내용을 입력해주세요!");
						    } else {
						    	type = "글"; 
						    	$.ajax ({
						    		type: 'POST',
						            url: 'BoardTypePostUpdateAjax',
						            data : {
						            	memberIdx : <%=memberIdx%>,
						            	title : inputTitleValue,
						            	content : inputContentValue,
						    			Release : Release,
						    			boardIdx : boardIdx
						            },
					    			success: function(data) {
					    				console.log(data);
						                alert("수정되었습니다");
						                location.reload();
					    			},
					    			error: function(r, s, e) {
						                console.log(r.status);
						                console.log(e);
						                alert("오류");
						            }				    		
						    	});
						    }
					 }
			    	if($('#crt-schedule').hasClass('on')) {
			    		let scheduleIdx = $('.create-post').data("sno");
			    		let inputContentValue = $('.schedule-add-content-box').find('.create-content-value').text();
				    	if (inputContentValue == '') {
					        e.preventDefault(); 
					        alert("내용을 입력해주세요!");
					    } else {
					    	let startDate = $("#startDateInput").val();
							let endDate = $("#endDateInput").val();
							let allDayYN = $("#all-day-check").prop('checked') == true ? 'Y' : 'N';
							let locationStr = $("#loaction-input").val();
							let alarmType = $(".alarm-select").val();
							let memberIdxArray = [];
							$(".member-item-box").each(function(idx, element) {
								memberIdxArray[idx] = $(this).data("idx");
							})
							$.ajax({
								type: 'post',
								url: 'scheduleUpdateAjaxServlet',
								data: {
									memberIdx : <%=memberIdx%>,
									"title":inputTitleValue,
									"startDate":startDate,
									"endDate":endDate,
									"allDayYN":allDayYN,
									"memberIdxArray":memberIdxArray.join(),
									"content":inputContentValue,
									"location":locationStr,
									"alarmType":alarmType,
									"releaseYn":Release,
									"boardIdx":boardIdx,
									"scheduleIdx":scheduleIdx
								},
								success: function() {
									alert("수정되었습니다.");
									location.reload();
								},
								error: function(r, s, e) {
					                console.log(r.status);
					                console.log(e);
					                alert("오류");
					            }	
							});
					    }
			    	}
		    	  if($('#crt-task').hasClass('on')) {
		    		  let taskIdx = $('.create-post').data("tno");
		    		 let  inputContentValue = $('.task-area').find('.create-content-value').text();
				    	if (inputContentValue == '') {
					        e.preventDefault(); 
					        alert("내용을 입력해주세요!");
					    } else {
					    	memberValue = [];
					    	$(".manager-item").each(function(idx, element) {
					    		memberValue[idx] = $(this).data("mno");
							})
					    	$.ajax ({
					    		type: 'POST',
					            url: 'BoardTypeTaskUpdateAjax',
					            data : {
					            	memberIdx : <%=memberIdx%>,
					            	title : inputTitleValue,
					            	content : inputContentValue,
					    			Release : Release,
					    			startDate : startDate,
					    			endDate : endDate,
					    			Taskpriority : Taskpriority,
					            	taskGroupIdx : taskGroupIdx,
					            	taskState : taskState,
					            	Taskprogress : Taskprogress,
					            	memberValue : memberValue.join(),
					            	boardIdx : boardIdx,
					            	taskIdx : taskIdx
					            },
				    			success: function(data) {
				    				console.log(data);
					                alert("수정되었습니다");
					                location.reload();
				    			},
				    			error: function(r, s, e) {
					                console.log(r.status);
					                console.log(e);
					                alert("오류");
					            }				    		
					    	});
					    }
		    	  }
				}
			});
			//전체공개 설정창
			$('.create-private-btn').click(function(event){
				if($('.create-post-option').css('display')=='none') {
					$('.create-post-option').css('display','block');
					if($(this).hasClass('off')) {
						$(this).removeClass('off');
						$(this).addClass('on');
					} else {
						$(this).removeClass('on');
						$(this).addClass('off');
					}
				} else {
					$('.create-post-option').css('display','none');
					if($(this).hasClass('off')) {
						$(this).removeClass('off');
						$(this).addClass('on');
					} else {
						$(this).removeClass('on');
						$(this).addClass('off');
					}
				}
				event.stopPropagation();
			});
			$('.private-option-full').click(function(){
				$('.create-private-btn').text($('.private-option-full').text());
				$('.create-post-option').css('display','none');
				$('.create-private-btn').addClass('full');
				$('.create-private-btn').removeClass('admin');
				Release = 'Y';
			});
			$('.private-option-admin').click(function(){
				$('.create-private-btn').text($('.private-option-admin').text());
				$('.create-post-option').css('display','none');
				$('.create-private-btn').addClass('admin');
				$('.create-private-btn').removeClass('full');
				Release = 'N';
			});
			//파일업로드
			$('.create-file-btn').click(function(event){
				if($('.upload-menu').css('display')=='none') {
					$('.upload-menu').css('display','block');
				} else {
					$('.upload-menu').css('display','none');
					
				}
			})
			//상단 고정 버튼
			$('.feed-board-fixbtn').click(function(){
				let bno = $(this).parents('.feed-board').data('bno');
				if($(this).find('.feed-board-fixbtn-img').hasClass("on")==true) {
					$(this).find('.feed-board-fixbtn-img').removeClass("on");
					$.ajax({
						type: 'POST',
				        url: 'BoardFixDelAjax',
				        data: {
				            boardIdx : bno
				        },
				        success: function(data) {
				            console.log(data);
				            alert("적용되었습니다.");
				            $('.item-fixed').each(function() {
				                if ($(this).data("bno") == bno) {
				                    $(this).remove();
				                }
				            });
				        },
				        error: function(r, s, e) {
				            console.log(r.status);
				            console.log(e);
				            alert("오류");
				        }
					});
				} else {
					$(this).find('.feed-board-fixbtn-img').addClass("on");
					$.ajax({
						type: 'POST',
				        url: 'BoardFixAjax',
				        data: {
				        	boardIdx : bno
				        },
				        success: function(data) {
				            console.log(data);
				            alert("적용되었습니다.");
				            let fixed = "";
				            $('.feed-board').each(function() {
				                if ($(this).data("bno") == bno) {
					            	if(data.category == '글') {
					            		fixed = " <li class = \"item-fixed\" id = \"post-fixed\" data-bno = "+bno+"> "+
												" <span class = \"pin-drag\"></span> "+
												" <a href=\"#board"+bno+"\"> "+
												"	<div class = \"fixed-box\"> " +
												"		<div class = \"fixed\" id = \"fixed-img\"> "+
												"			<div class = \"fixed-image-post\"></div> "+
												"		</div> "+
												"		<div class = \"fixed\" id = \"fixed-txt\" > "+
												"			<div class = \"fixed-content\"> "+
												"				<div class = \"fix-image\"></div> " +
												"				<div class = \"fixed-title\">"+data.title+"</div> " +
												"			</div> " +
												"		</div> " +
												"	</div> " +
											"	</a> " +
										" </li>";
					            	}
					            	if(data.category == "업무") {
					            		fixed = "<li class = \"item-fixed\" id = \"task-fixed\" data-bno = "+bno+">"+
										" <span class = \"pin-drag\"></span>"+
										" <a href=\"#board"+bno+"\")\">"+
										"	<div class = \"fixed-box\">"+
										"		<div class = \"fixed\" id = \"fixed-img\">"+
										"			<div class = \"fixed-image-task\"></div>"+
										"		</div>"+
										"		<div class = \"fixed\" id = \"fixed-txt\">"+
										"			<div class =\"fixed-content\">"+
										"				<div class = \"fix-image\"></div>"+
										"				<div class = \"fixed-title\">"+data.title+"</div>"+
										"			</div>"+
										"		</div>"+
										"		<div class = \"fixed\" id = \"fixed-value\">";
										if(data.state==1) {
											fixed += "<div class = \"fixed-state request\">요청</div>";
										}
										if(data.state==2) {
											fixed += "<div class = \"fixed-state progress\">진행</div>";
										}
										if(data.state==3) {
											fixed += "<div class = \"fixed-state feedback\">피드백</div>";
										}
										if(data.state==4) {
											fixed += "<div class = \"fixed-state complete\">완료</div>";
										}
										if(data.state==5) {
											fixed += "<div class = \"fixed-state hold\">보류</div>";
										}
										fixed += " </div>"+
										"	</div>"+
										"	</a>"+
									"	</li>";
										
					            	}
					            	if(data.category == "일정") {
					            		fixed = "<li class = \"item-fixed\" id = \"schedule-fixed\" data-bno = "+bno+"> "+
										" <span class = \"pin-drag\"></span>"+
										" <a href=\"#board"+bno+"\">"+
										"	<div class = \"fixed-box\">"+
										"		<div class = \"fixed\" id = \"fixed-img\">"+
										"			<div class = \"fixed-image-calander\"></div>"+
										"		</div>"+
										"		<div class = \"fixed\" id = \"fixed-txt\" >"+
										"			<div class = \"fixed-content\">"+
										"				<div class = \"fix-image\"></div>"+
										"				<div class = \"fixed-title\">"+data.title+"</div>"+
										"			</div>"+
										"			<div class = \"fixed-writedate\">"+
										"				<div class = \"fixed-date\">"+
										"					"+data.startDate+""+
										"					- "+
										"					"+data.endDate+""+
										"				</div>"+
										"			</div>"+
										"		</div>"+
										"		<div class = \"fixed\" id = \"fixed-value\"></div>"+
										"	</div>"+
									"	</a> "+
									" </li>";
					            	}
				                }
				            });
				            	
				            $('.fixed-body').prepend(fixed);
				        },
				        error: function(r, s, e) {
				            console.log(r.status);
				            console.log(e);
				            alert("오류");
				        }
					});
				}
			});
			//업무 항목 더보기 버튼
			$('.task-more-add-btn').click(function(){
				$(this).css('display', 'none');
				$('.task-startdate-area').css('display', 'flex');
				$('.task-priority-area').css('display', 'block');
				$('.task-group-area').css('display', 'block');
				$('.task-progress-area').css('display', 'block');
			});
			//게시물 더보기 버튼
			$('.feed-board-optionbtn').click(function(){
				if($(this).siblings('.board-setting-layer').css('display')=='none') {
					$(this).siblings('.board-setting-layer').css('display','block');
				} else {
					$(this).siblings('.board-setting-layer').css('display','none');
					
				}
			});
			//게시물 필터 버튼
			$('#entire-filter-btn').click(function(){
				if($('.feed-filter-layer').css('display')=='none') {
					$('.feed-filter-layer').css('display','block');
				} else {
					$('.feed-filter-layer').css('display','none');
				}
			});
			$('.check-menu-item').click(function() {
			    $('.check-menu-item').removeClass('active');
			    $('.feed-filter-layer').css('display','none');
			    
			    if(!$(this).hasClass('active')) {
			        $(this).addClass('active');
			        
			        let text = $(this).text();

			        $('.feed-board').each(function() {
			            var category = $(this).data('category'); // data-category 값 가져오기
			            
			            if (text == "전체") {
			                $(this).show();
			            } else if (category == text) {
			                $(this).show(); 
			            } else {
			                $(this).hide();
			            }
			        });
			    } else {
			        $(this).removeClass('active');
			        $('.feed-board').show();
			    }
			});
			$(document).ready(function() {
			    var $progressBar = $('.progress-bar');
			    if ($progressBar.width() === $progressBar.parent().width()) {
			        $progressBar.addClass('complete');
			    }
			});
			//피드 업무 게시물 상태 변경
			$('.task-btn').click(function(){
				let state = 0;
				let boardIdx = $(this).parents('.feed-board').data("bno");
				let taskIdx = $(this).parents('.feed-board').find('.task-num-cnt').find('em').text();
				if($(this).parents('.feed-board').data("bno") == boardIdx) {
					$(this).parent().find('.task-btn').removeClass('active');
					
					if($(this).hasClass('request')) {
						$(this).addClass('active');
						state = 1;
						$('.item-fixed').each(function() {
						    if ($(this).data("bno") == boardIdx) {
						    	$(this).find('.fixed-state').removeClass('request');
								$(this).find('.fixed-state').removeClass('progress');
								$(this).find('.fixed-state').removeClass('feedback');
								$(this).find('.fixed-state').removeClass('complete');
								$(this).find('.fixed-state').removeClass('hold');
						        $(this).find('.fixed-state').addClass('request');
						        $(this).find('.fixed-state').text('요청');
						    }
						});
					}if($(this).hasClass('progress')) {
						$(this).addClass('active');
						state = 2;
						$('.item-fixed').each(function() {
						    if ($(this).data("bno") == boardIdx) {
						    	$(this).find('.fixed-state').removeClass('request');
								$(this).find('.fixed-state').removeClass('progress');
								$(this).find('.fixed-state').removeClass('feedback');
								$(this).find('.fixed-state').removeClass('complete');
								$(this).find('.fixed-state').removeClass('hold');
						        $(this).find('.fixed-state').addClass('progress');
						        $(this).find('.fixed-state').text('진행');
						    }
						});
					}if($(this).hasClass('feedback')) {
						$(this).addClass('active');
						state = 3;
						$('.item-fixed').each(function() {
						    if ($(this).data("bno") == boardIdx) {
						    	$(this).find('.fixed-state').removeClass('request');
								$(this).find('.fixed-state').removeClass('progress');
								$(this).find('.fixed-state').removeClass('feedback');
								$(this).find('.fixed-state').removeClass('complete');
								$(this).find('.fixed-state').removeClass('hold');
						        $(this).find('.fixed-state').addClass('feedback');
						        $(this).find('.fixed-state').text('피드백');
						    }
						});
					}if($(this).hasClass('complete')) {
						$(this).addClass('active');
						state = 4;
						$(this).parents('.task-option-area').find('.progress-bars').css('width','100%');
						$(this).parents('.task-option-area').find('.progress-bars').css('background','blue');
						$(this).parents('.task-option-area').find('.progress-values').text("100%");
						$('.item-fixed').each(function() {
						    if ($(this).data("bno") == boardIdx) {
						    	$(this).find('.fixed-state').removeClass('request');
								$(this).find('.fixed-state').removeClass('progress');
								$(this).find('.fixed-state').removeClass('feedback');
								$(this).find('.fixed-state').removeClass('complete');
								$(this).find('.fixed-state').removeClass('hold');
						        $(this).find('.fixed-state').addClass('complete');
						        $(this).find('.fixed-state').text('완료');
						    }
						});
					}if($(this).hasClass('hold')) {
						$(this).addClass('active');
						state = 5;
						$('.item-fixed').each(function() {
						    if ($(this).data("bno") == boardIdx) {
						    	$(this).find('.fixed-state').removeClass('request');
								$(this).find('.fixed-state').removeClass('progress');
								$(this).find('.fixed-state').removeClass('feedback');
								$(this).find('.fixed-state').removeClass('complete');
								$(this).find('.fixed-state').removeClass('hold');
						        $(this).find('.fixed-state').addClass('hold');
						        $(this).find('.fixed-state').text('보류');
						    }
						});
					}
					$.ajax({
						type: 'POST',
				        url: 'TaskStateUpdateAjax',
				        data: {
				            taskIdx : taskIdx,
				            state : state
				        },
				        success: function(data) {
				            console.log(data);
				            alert("적용되었습니다.");
				        },
				        error: function(r, s, e) {
				            console.log(r.status);
				            console.log(e);
				            alert("오류");
				        }
					});
				}
			});
			//담당자 삭제
			$('.manager-remove-btn').click(function(){
				let memberIdx = $(this).prev().data("mno");
				let taskIdx = $(this).parents('.feed-board').find('.task-num-cnt').find('em').text();
				$(this).parent().remove();
				$.ajax({
					type: 'POST',
			        url: 'TaskManagerDeleteAjax',
			        data: {
			            taskIdx : taskIdx,
			            memberIdx : memberIdx
			        },
			        success: function(data) {
			            console.log(data);
			            alert("적용되었습니다.");
			        },
			        error: function(r, s, e) {
			            console.log(r.status);
			            console.log(e);
			            alert("오류");
			        }
				});
			})
			let managerCount = 0;
			let mnoValues = [];
			//담당자 추가 창 출력
			$('.change-task-manager').click(function(){
				$('.manager-add-header-text').text("담당자 변경");
				let taskIdx = $(this).parents('.feed-board').find('.task-num-cnt').find('em').text();
				$('.manager-add-section').attr('data-tno', taskIdx);
				$('.manager-add-section').css('display','block');
				$('.mainPop').css('display','block');
				
				$.ajax({
					type : "POST",
					url : "/Project/TaskManagerViewAjax",
					data : {
						taskIdx : taskIdx,
						projectIdx : <%=projectIdx%>
					},
					success: function(data) {
			            console.log(data);
						$('.board-manager-item').remove();
			            for(let i = 0; i<data.length; i++) {
				            var taskManager =  "";
				            if(data[i].ManagerYN == 'Y') {
				            	taskManager += " <li class = \"board-manager-item active\" data-mno="+data[i].memberIdx+">"
				            } else {
				            	taskManager += " <li class = \"board-manager-item\" data-mno="+data[i].memberIdx+">"
				            }
				            taskManager += " <div class = \"manager-check-select\"></div>" +
				            " <div class = \"post-author\">" +
				            " <span class = \"profile-radius\" style=\"background-image: url('"+data[i].profileImg+"');\"></span> " +
				            " <dl class = \"post-profile-text\">" +
				            " <dt> " +
							"		<strong class = \"author-name\">"+data[i].name+"</strong>" +
							"		<em class = \"author-position\">"+data[i].position+"</em>" +
							"	</dt>" +
							"	<dd>" +
							"		<strong class = \"author-company\">"+data[i].companyName+"</strong>" +
							"		<em class = \"author-department\">"+data[i].departmentName+"</em>" +
							"	</dd>" +
							" </div> " +
							" </li>";
			            	$('.board-manager-area').prepend(taskManager);
							let ManagerList = " <li class = \"task-manager-name\" data-mno="+data[i].memberIdx+">" +
					        " <span class = \"task-manager-img\" id = \"task-manager-img2\" style = \"background:url('"+data[i].profileImg+"'); no-repeat center center; background-size: cover;\"></span>" +
					        " <span class = \"task-manager-value\">"+data[i].name+"</span>" +
					        " <button class = \"manager-remove-btn\"></button> " +
							" </li> ";
							 if(data[i].ManagerYN == 'Y') {
					       		 $('.inviteManagerList').prepend(ManagerList);
							 }
			            }
			            managerCount = $('.board-manager-item.active').length;
						$('.board-manager-item').each(function(){
							if($(this).hasClass('active')) {
								$('.board-manager-selected-count').text(managerCount+"건 선택");
								mnoValues.push($(this).data('mno'));
						        if(managerCount > 0) {
						        	$('.managerListNull').css('display','none');
						        	$('.board-manager-selected-num').css('display','block');
						        	$('.inviteManagerList').css('display','block');
						        }
							}
						});
			        },
			        error: function(r, s, e) {
			            console.log(r.status);
			            console.log(e);
			            alert("오류");
			        }
				});
			});
			//참가자 출력
			$('.participant-change').click(function(){
				let scheduleIdx = $(this).parents('.feed-board').data("cno");
				$('.manager-add-section').attr('data-sno', scheduleIdx);
				$('.manager-add-section').css('display','block');
				$('.mainPop').css('display','block');
				$('.manager-add-header-text').text("참석자 변경");
				$.ajax({
					type : "POST",
					url : "/Project/ScheduleViewAjax",
					data : {
						scheduleIdx : scheduleIdx,
						projectIdx : <%=projectIdx%>
					},
					success: function(data) {
			            console.log(data);
						$('.board-manager-item').remove();
						for(let i=0; i<=data.length-1; i++) {
							let newTr;
							if(data[i].attendYN == 'Y') {
								newTr = '<li class="board-manager-item active" data-mno="'+data[i].memberIdx+'">';
							}else {
								newTr = '<li class="board-manager-item" data-mno="'+data[i].memberIdx+'">';
							}
								newTr += '<div class="manager-check-select"></div>' +
								           	'<div class="post-author">' +
									            '<span class="profile-radius" style="background-image: url(\''+data[i].prof+'\');"></span>' +
									            '<dl class="post-profile-text">' +
									            	'<dt>' +
														'<strong class="author-name">'+data[i].name+'</strong>' +
														'<em class="author-position">'+data[i].position+'</em>' +
													'</dt>' +
													'<dd>' +
														'<strong class = "author-company">'+data[i].cName+'</strong>' +
														'<em class = "author-department">'+data[i].dName+'</em>' +
													'</dd>' +
												'</dl>' +
											'</div>' +
										'</li>';
							$(".board-manager-area").append(newTr);
								let ManagerList = " <li class = \"task-manager-name\" data-mno="+data[i].memberIdx+">" +
											        " <span class = \"task-manager-img\" id = \"task-manager-img2\" style = \"background:url('"+data[i].prof+"'); no-repeat center center; background-size: cover;\"></span>" +
											        " <span class = \"task-manager-value\">"+data[i].name+"</span>" +
											        " <button class = \"manager-remove-btn\"></button> " +
												" </li> ";
							if(data[i].attendYN == 'Y') {
						        $('.inviteManagerList').prepend(ManagerList);
							}
						}
						managerCount = $('.board-manager-item.active').length;
						$('.board-manager-item').each(function(){
							if($(this).hasClass('active')) {
								$('.board-manager-selected-count').text(managerCount+"건 선택");
								mnoValues.push($(this).data('mno'));
						        if(managerCount > 0) {
						        	$('.managerListNull').css('display','none');
						        	$('.board-manager-selected-num').css('display','block');
						        	$('.inviteManagerList').css('display','block');
						        }
							}
						});
					},
			        error: function(r, s, e) {
			            console.log(r.status);
			            console.log(e);
			            alert("오류");
			        }
				});
			});
			//담당자 검색
			$(document).ready(function() {
			    $(document).on('keyup','.managerSearchBox', function() {
			    	let submitName = $(this).parents('.manager-add-section').find('.manager-add-header-text').text().trim();
				    if(submitName == "담당자 변경") {
			    	let taskIdx = $(this).parents('.manager-add-section').data('tno');
			    	let text = $(this).val();
			    	let mnoValues = []; 
				    $('.task-manager-name').each(function() {
				        var mno = $(this).data('mno');
				        mnoValues.push(mno);
				    });
				    $.ajax({
				    	type : "POST",
						url : "/Project/TaskManagerSearchAjax",
						data : {
							taskIdx : taskIdx,
							projectIdx : <%=projectIdx%>,
				    		search : text
						},
						success: function(data) {
							$('.board-manager-item').remove();
				            console.log(data);
				            for(let i = 0; i<data.length; i++) {
					            var taskManager =  "";
					            if (mnoValues.includes(data[i].memberIdx)) {
					                taskManager += " <li class = \"board-manager-item active\" data-mno=" + data[i].memberIdx + ">";
					            } else {
					                taskManager += " <li class = \"board-manager-item\" data-mno=" + data[i].memberIdx + ">";
					            }
					            taskManager += " <div class = \"manager-check-select\"></div>" +
					            " <div class = \"post-author\">" +
					            " <span class = \"profile-radius\" style=\"background-image: url('"+data[i].profileImg+"');\"></span> " +
					            " <dl class = \"post-profile-text\">" +
					            " <dt> " +
								"		<strong class = \"author-name\">"+data[i].name+"</strong>" +
								"		<em class = \"author-position\">"+data[i].position+"</em>" +
								"	</dt>" +
								"	<dd>" +
								"		<strong class = \"author-company\">"+data[i].companyName+"</strong>" +
								"		<em class = \"author-department\">"+data[i].departmentName+"</em>" +
								"	</dd>" +
								" </div> " +
								" </li>";
				            	$('.board-manager-area').prepend(taskManager);
				            }
						},
						error: function(r, s, e) {
				            console.log(r.status);
				            console.log(e);
				            alert("오류");
				        }
				    });
			    	
			    } else if(submitName == "참석자 변경") {
			    	let scheduleIdx = $(this).parents('.manager-add-section').data('sno');
			    	let text = $(this).val();
			    	let mnoValues = []; 
				    $('.task-manager-name').each(function() {
				        var mno = $(this).data('mno');
				        mnoValues.push(mno);
				    });
				    $.ajax({
				    	type : "POST",
						url : "/Project/ScheduleSearchAjax",
						data : {
							scheduleIdx : scheduleIdx,
							projectIdx : <%=projectIdx%>,
				    		search : text
						},
						success: function(data) {
							$('.board-manager-item').remove();
				            console.log(data);
				            for(let i = 0; i<data.length; i++) {
					            var taskManager =  "";
					            if (mnoValues.includes(data[i].memberIdx)) {
					                taskManager += " <li class = \"board-manager-item active\" data-mno=" + data[i].memberIdx + ">";
					            } else {
					                taskManager += " <li class = \"board-manager-item\" data-mno=" + data[i].memberIdx + ">";
					            }
					            taskManager += " <div class = \"manager-check-select\"></div>" +
					            " <div class = \"post-author\">" +
					            " <span class = \"profile-radius\" style=\"background-image: url('"+data[i].prof+"');\"></span> " +
					            " <dl class = \"post-profile-text\">" +
					            " <dt> " +
								"		<strong class = \"author-name\">"+data[i].name+"</strong>" +
								"		<em class = \"author-position\">"+data[i].position+"</em>" +
								"	</dt>" +
								"	<dd>" +
								"		<strong class = \"author-company\">"+data[i].cName+"</strong>" +
								"		<em class = \"author-department\">"+data[i].dName+"</em>" +
								"	</dd>" +
								" </div> " +
								" </li>";
				            	$('.board-manager-area').prepend(taskManager);
				            }
						},
						error: function(r, s, e) {
				            console.log(r.status);
				            console.log(e);
				            alert("오류");
				        }
				    });
			    }
			    });
			});
			//담당자 등록버튼 클릭 
			$('.managerSubmitbtn').click(function(){
				let submitName = $(this).parents('.manager-add-section').find('.manager-add-header-text').text().trim();
			    if(submitName == "담당자 변경") {
				let taskIdx = $(this).parents('.manager-add-section').data('tno');
				    $.ajax({
				    	type : "POST",
						url : "/Project/TaskManagerChangeAjax",
						data : {
							taskIdx : taskIdx,
							mnoValues : JSON.stringify(mnoValues)
						},
						success: function(data) {
							 console.log(data);
							 	$('.task-manager-name').remove();
								$('.manager-add-section').css('display','none');
								$('.mainPop').css('display','none');
							    $('.board-manager-item').removeClass('active');
							    managerCount = 0;
							    mnoValues = [];
							    $('.managerListNull').css('display','block');
					        	$('.board-manager-selected-num').css('display','none');
					        	$('.inviteManagerList').css('display','none');
					        	$('.managerSearchBox').val('');
					        	$('.feed-board').each(function() {
					                 let currentTaskIdx = $(this).find('.task-num-cnt em').text(); 
	
					                 if (currentTaskIdx == taskIdx) {
					                     for (let i = 0; i < data.length; i++) {
					                         let createmanager = " <span class='task-manager-name'>" +
					                             "<span class='task-manager-img' id='task-manager-img2' style = \"background:url('"+data[i].profileImg+"'); no-repeat center center; background-size: cover;\"></span>" +
					                             "<span class='task-manager-value' data-mno=" + data[i].memberIdx + ">" + data[i].name + "</span>" +
					                             "<button class='manager-remove-btn'></button>" +
					                             "</span>";
	
					                         $(this).find('.task-manager-area').prepend(createmanager);
					                     }
					                 }
					             });
						},
						error: function(r, s, e) {
				            console.log(r.status);
				            console.log(e);
				            alert("오류");
				        }
				    });
			    } else if (submitName == "참석자 변경"){
			    	let scheduleIdx = $(this).parents('.manager-add-section').data('sno');
			    	$.ajax({
			    		type : "POST",
						url : "/Project/ScheduleManagerChangeAjax",
						data : {
							scheduleIdx : scheduleIdx,
							mnoValues : JSON.stringify(mnoValues)
						},
						success: function(data) {
							 console.log(data);
							//$('.task-manager-name').remove();
							/* $('.manager-add-section').css('display','none');
							$('.mainPop').css('display','none');
						    $('.board-manager-item').removeClass('active');
						    managerCount = 0;
						    mnoValues = [];
						    $('.managerListNull').css('display','block');
				        	$('.board-manager-selected-num').css('display','none');
				        	$('.inviteManagerList').css('display','none');
				        	$('.managerSearchBox').val('');
				        	$('.feed-board').each(function() {
			        			let currentScheduleIdx = $(this).data("cno");
			        			if(currentScheduleIdx == scheduleIdx) {
				        		$(this).find(".participant-img-box").find("span").remove();
			        				for (let i = 0; i < data.length; i++) {
					        			let participant = "<span class=\"participant1-img\"></span>";
					        			$(this).find('.participant-img-box').prepend(participant);
			        				}
			        			}
				        	}); */
				        	location.reload();	
						},
						error: function(r, s, e) {
				            console.log(r.status);
				            console.log(e);
				            alert("오류");
				        }
			    	});
			    }
			});
			//업무매니저 등록및 삭제
			$(document).on('click', '.board-manager-item', function() {
				let memberIdx = $(this).data("mno");
				let name = $(this).find('.author-name').text();
				let mno = $(this).data("mno");
			    if (!$(this).hasClass('active')) {
			        $(this).addClass('active');
			        managerCount++;
			        mnoValues.push(mno);
			       	$('.board-manager-selected-count').text(managerCount+"건 선택");
			        if(managerCount > 0) {
			        	$('.managerListNull').css('display','none');
			        	$('.board-manager-selected-num').css('display','block');
			        	$('.inviteManagerList').css('display','block');
			        }
			        let backgroundImage = $(this).find('.profile-radius').css('background-image');
			        backgroundImage = backgroundImage.replace(/^url\(["']?/, '').replace(/["']?\)$/, '');
			        let ManagerList = "<li class=\"task-manager-name\" data-mno=" + memberIdx + ">" +
			            " <span class=\"task-manager-img\" id=\"task-manager-img2\" style=\"background:url(" + backgroundImage + ") no-repeat center center; background-size: cover;\"></span>" +
			            " <span class=\"task-manager-value\">" + name + "</span>" +
			            " <button class=\"manager-remove-btn\"></button>" +
			            "</li>";
			        $('.inviteManagerList').prepend(ManagerList);
			    } else {
			        $(this).removeClass('active');
			        var index = mnoValues.indexOf(mno); 
			        if (index !== -1) {
			            mnoValues.splice(index, 1);
			        }
			        $('.task-manager-name').each(function(){
				    	if($(this).data("mno")==memberIdx) {
				    		$(this).remove();
				    	}
			        });
			        managerCount--;  // 카운트 감소
			        $('.board-manager-selected-count').text(managerCount+"건 선택");
			        if(managerCount == 0) {
			        	$('.managerListNull').css('display','block');
			        	$('.board-manager-selected-num').css('display','none');
			        	$('.inviteManagerList').css('display','none');
			        }
			    }
			});
			//업무 매니저 삭제
			$(document).on('click', '.manager-remove-btn', function() {
				let memberIdx = $(this).parent().data("mno");
				if($(this).parent().data("mno") == memberIdx) {
					$(this).parent().remove();
				}
				$('.board-manager-item').each(function(){
					if($(this).data("mno")==memberIdx) {
						$(this).removeClass('active');	
					}
				});
				 managerCount--;
				 var index = mnoValues.indexOf(memberIdx); 
			        if (index !== -1) {
			            mnoValues.splice(index, 1);
			        }
				 $('.board-manager-selected-count').text(managerCount+"건 선택");
				 if(managerCount == 0) {
			        	$('.managerListNull').css('display','block');
			        	$('.board-manager-selected-num').css('display','none');
			        	$('.inviteManagerList').css('display','none');
			     }
			});
			//업무 매니저 전체삭제
			$('.board-manager-selected-all-delete').click(function(){
		        $('.task-manager-name').remove();
		        $('.board-manager-item').removeClass('active');
		        mnoValues = [];
		        managerCount = 0;
		        $('.managerListNull').css('display','block');
	        	$('.board-manager-selected-num').css('display','none');
	        	$('.inviteManagerList').css('display','none');
			});
			//x버튼클릭
			$('.manager-add-close').click(function(){
				$(this).parents('.manager-add-section').find('.task-manager-name').remove();
				$('.manager-add-section').css('display','none');
				$('.mainPop').css('display','none');
			    $('.board-manager-item').removeClass('active');
			    managerCount = 0;
			    $('.managerListNull').css('display','block');
	        	$('.board-manager-selected-num').css('display','none');
	        	$('.inviteManagerList').css('display','none');
	        	$('.managerSearchBox').val('');
			});
			//업무의 카테고리마다의 삭제버튼
			$('.remove-btn').click(function() {
			    let taskIdx = $(this).parents('.feed-board').find('.task-num-cnt').find('em').text();
			    var $removeButton = $(this); 
			
			    if ($removeButton.closest('.task-start-date-content').length > 0) {
			        $removeButton.prev().find('.task-date-name').text('');
			        $removeButton.parent().prev().css('display', 'flex');
			        $removeButton.css('display', 'none');
			
			        $.ajax({
			            type: "POST",
			            url: "TaskStartDateDELAjax",
			            data: { taskIdx: taskIdx },
			            success: function(data) {
			                console.log(data);
			                alert("변경되었습니다");
			                var $inputStartData = $removeButton.closest('.task-start-date-content').find('.input-start-data.datepicker');
			                $inputStartData.show();  
			                $inputStartData.val(''); 
			            },
			            error: function(r, s, e) {
			                console.log(r.status);
			                console.log(e);
			                alert("오류");
			            }
			        });
			    }
			    if ($removeButton.closest('.task-date-content').length > 0) {
			    	$removeButton.prev().find('.task-date-name').text('');
			        $removeButton.parent().prev().css('display', 'flex');  
			        $removeButton.css('display', 'none'); 
			
			        $.ajax({
			            type: "POST",
			            url: "TaskEndDateDELAjax",
			            data: { taskIdx: taskIdx },
			            success: function(data) {
			                console.log(data);
			                alert("변경되었습니다");
			                $('.task-date-content').each(function() {
			                	var $inputEndData = $(this).find('.input-end-data.datepicker');
			                    $inputEndData.show(); 
			                    $inputEndData.val('');
			                });
			            },
			            error: function(r, s, e) {
			                console.log(r.status);
			                console.log(e);
			                alert("오류");
			            }
			        });
			    }
			    if ($removeButton.closest('.task-priority-content').length > 0) {
			    	$removeButton.prev().css('display','none');
			    	$removeButton.prev().find('.priority').removeClass('high');
			    	$removeButton.prev().find('.priority').removeClass('middle');
			    	$removeButton.prev().find('.priority').removeClass('low');
			    	$removeButton.prev().find('.priority').removeClass('emergency');
			    	$removeButton.prev().prev().css('display','inline-block');
			    	$removeButton.css('display', 'none');
			    	$.ajax({
			    		type: "POST",
			            url: "TaskPriorityDelAjax",
			            data: { 
			            	taskIdx: taskIdx
			            },
			            success: function(data) {
			                console.log(data);
			                alert("변경되었습니다");
			            },
			            error: function(r, s, e) {
			                console.log(r.status);
			                console.log(e);
			                alert("오류");
			            }
			    	});
			    }
			    if ($removeButton.prev('.task-group-content').length > 0) {
			    	$removeButton.css('display', 'none');
			    	$removeButton.prev().css('display','none');
			    	$removeButton.prev().find('.task-group-name').text('');
			    	$removeButton.prev().prev().css('display','inline-block');
			    	$.ajax({
			    		type: "POST",
			            url: "TaskGroupDelAjax",
			            data: { 
			            	taskIdx: taskIdx
			            },
			            success: function(data) {
			                console.log(data);
			                alert("변경되었습니다");
			                
			            },
			            error: function(r, s, e) {
			                console.log(r.status);
			                console.log(e);
			                alert("오류");
			            }
			    	});
			    }
			});
			//시작일 선택,마감일 선택
				$(document).on("focus", ".input-start-data", function() {
				    if (!$(this).data("datepicker")) { 
				    	let taskIdx = $(this).parents('.feed-board').find('.task-num-cnt').find('em').text();
				        $(this).datepicker({
				            dateFormat: "yy-mm-dd", 
				            showOn: "focus", 
				            buttonImageOnly: false, 
				            buttonImage: "",
				            showAnim: "fadeIn",
				            onSelect: function(dateText, inst) {
				                var date = $(this).datepicker('getDate'); 
				                var dayOfWeek = date.getDay(); 
				                var formattedDate = dateText + " (" + weekdays[dayOfWeek] + ")";
				                var $taskStartDateContent = $(this).closest('.task-start-date-content');
				                var $taskOptionArea = $taskStartDateContent.closest('.task-option-area');
				                $taskStartDateContent.find(".task-date-name").text(formattedDate); 
				                $taskStartDateContent.find(".task-start-date-value").css('display', 'inline-block'); 
				                $taskStartDateContent.find(".remove-btn").css('display', 'inline-block'); 
				                $(this).hide();
				                $.ajax({
				                	type: "POST",
						            url: "TaskStartDateUpdateAjax",
						            data: { 
						            	taskIdx: taskIdx,
						            	date : dateText
							        },
					                success: function(data) {
						                console.log(data);
						                
						            },
						            error: function(r, s, e) {
						                console.log(r.status);
						                console.log(e);
						                alert("오류");
						            }
				               });
				            }
				        });
				    }
				});
				//마감일지정
				$(document).on("focus", ".input-end-data", function() {
				    let taskIdx = $(this).parents('.feed-board').find('.task-num-cnt').find('em').text();

				    if (!$(this).data("datepicker")) { 
				        $(this).datepicker({
				            dateFormat: "yy-mm-dd", 
				            showOn: "focus", 
				            buttonImageOnly: false, 
				            buttonImage: "",
				            showAnim: "fadeIn",
				            onSelect: function(dateText, inst) {
				                var date = $(this).datepicker('getDate'); 
				                var dayOfWeek = date.getDay(); 
				                var formattedDate = dateText + " (" + weekdays[dayOfWeek] + ")";

				                var currentDate = new Date();
				                var selectedDate = new Date(dateText);
				                
				                var $taskEndDateContent = $(this).closest('.task-date-content');
				                var $taskDateName = $taskEndDateContent.find(".task-date-name");

				                if (selectedDate <= currentDate) {
				                    $taskDateName.css("color", "red"); 
				                } else {
				                    $taskDateName.css("color", "");
				                }

				                $taskDateName.text(formattedDate);
				                $taskEndDateContent.find(".task-end-date-value").css('display', 'inline-block');
				                $taskEndDateContent.find(".remove-btn").css('display', 'inline-block'); 
				                $(this).hide();

				                $.ajax({
				                    type: "POST",
				                    url: "TaskEndDateUpdateAjax",
				                    data: { 
				                        taskIdx: taskIdx,
				                        date: dateText
				                    },
				                    success: function(data) {
				                        console.log(data);
				                    },
				                    error: function(r, s, e) {
				                        console.log(r.status);
				                        console.log(e);
				                        alert("오류");
				                    }
				                });
				            }
				        });
				    }
				});
			//우선순위 출력
			$('.input-task-btn').click(function(){
				if($(this).next().next().next().css('display')=='none') {
					$(this).next().next().next().css('display','block');
				} else {
					$(this).next().next().next().css('display','none');
				}
			});
			$('.priority-layer-btn').click(function(){
				$(this).parent().css('display','none');
				let taskIdx = $(this).parents('.feed-board').find('.task-num-cnt').find('em').text();
				let code = 0;
				$(this).parent().prev().prev().prev().css('display','none');
				$(this).parent().prev().prev().css('display','inline-block');
				$(this).parent().prev().css('display','inline-block');
				$(this).parent().prev().prev().find('.task-priority-value').css('display','inline-block');
				if($(this).data("code")==1) {
					code = 1;
					$(this).parent().prev().prev().find('.priority').addClass('emergency');
					$(this).parent().prev().prev().find('.task-priority-value').text('긴급');
				}
				if($(this).data("code")==2) {
					code = 2;
					$(this).parent().prev().prev().find('.priority').addClass('high');
					$(this).parent().prev().prev().find('.task-priority-value').text('높음');
				}
				if($(this).data("code")==3) {
					code = 3;
					$(this).parent().prev().prev().find('.priority').addClass('middle');
					$(this).parent().prev().prev().find('.task-priority-value').text('중간');
				}
				if($(this).data("code")==4) {
					code = 4;
					$(this).parent().prev().prev().find('.priority').addClass('low');
					$(this).parent().prev().prev().find('.task-priority-value').text('낮음');
				}
				$.ajax({
					type: "POST",
                    url: "TaskPrioritySetAjax",
                    data: { 
                        taskIdx: taskIdx,
                        code : code
                    },
                    success: function(data) {
                        console.log(data);
                    },
                    error: function(r, s, e) {
                        console.log(r.status);
                        console.log(e);
                        alert("오류");
                    }
				});
			});
			//닫기
			$('.managerReturnMainbtn').click(function(){
				$(this).parents('.manager-add-section').find('.task-manager-name').remove();
				$('.manager-add-section').css('display','none');
				$('.mainPop').css('display','none');
			    $('.board-manager-item').removeClass('active');
			    mnoValues = [];
			    managerCount = 0;
			    $('.managerListNull').css('display','block');
	        	$('.board-manager-selected-num').css('display','none');
	        	$('.inviteManagerList').css('display','none');
	        	$('.managerSearchBox').val('');
			});
			//게시글 업무 그룹지정
			$('.input-task-btn').click(function(event) {
			    var taskGroupLayer = $(this).closest('.task-group').find('.task-group-list-layers');
			    $('.task-group-list-layers').not(taskGroupLayer).css('display', 'none');
			    taskGroupLayer.css('display', 'block');
			    event.stopPropagation();
			});
			$(document).click(function() {
			    $('.task-group-list-layers').css('display', 'none');
			});
			$('.input-task-btn').click(function(event) {
			    event.stopPropagation();
			});
			$('.task-group-item').click(function(){
				let taskIdx = $(this).parents('.feed-board').find('.task-num-cnt').find('em').text();
				let taskGroupIdx = $(this).data("code");
				let taskGroupName = $(this).find('.task-group-name-box').text();
				var $taskGroup = $(this);
				$.ajax({
					type: "POST",
                    url: "TaskGroupSetAjax",
                    data: { 
                        taskIdx: taskIdx,
                        taskGroupIdx : taskGroupIdx
                    },
                    success: function(data) {
                        console.log(data);
                        alert("변경되었습니다.");
                        if(taskGroupIdx!=0) {
	                        $taskGroup.parents('.task-group-list-layers').prev().css('display', 'inline-block');
	                        $taskGroup.parents('.task-group-list-layers').prev().prev().css('display', 'inline-block');
	                        $taskGroup.parents('.task-group-list-layers').prev().prev().find('.task-group-name').text(taskGroupName);
	                        $taskGroup.parents('.task-group-list-layers').prev().prev().prev().css('display', 'none');
                        }
                    },
                    error: function(r, s, e) {
                        console.log(r.status);
                        console.log(e);
                        alert("오류");
                    }
				});
			});
			//진척도
			$('.progress-btns').click(function() {
				let taskIdx = $(this).parents('.feed-board').find('.task-num-cnt').find('em').text();
				let progressValue = $(this).data("progress-value");
				if($(this).find('em').text().trim() == '0%') {
					$(this).parent().next().text("0%");
					$(this).parent().prev().css('width', '0%');
				}
				if($(this).find('em').text().trim() == '10%') {
					$(this).parent().next().text("10%");
					$(this).parent().prev().css('width', '10%');
					$(this).parent().prev().css('background', 'green');
				}
				if($(this).find('em').text().trim() == '20%') {
					$(this).parent().next().text("20%");
					$(this).parent().prev().css('width', '20%');
					$(this).parent().prev().css('background', 'green');
				}
				if($(this).find('em').text().trim() == '30%') {
					$(this).parent().next().text("30%");
					$(this).parent().prev().css('width', '30%');
					$(this).parent().prev().css('background', 'green');
				}
				if($(this).find('em').text().trim() == '40%') {
					$(this).parent().next().text("40%");
					$(this).parent().prev().css('width', '40%');
					$(this).parent().prev().css('background', 'green');
				}
				if($(this).find('em').text().trim() == '50%') {
					$(this).parent().next().text("50%");
					$(this).parent().prev().css('width', '50%');
					$(this).parent().prev().css('background', 'green');
				}
				if($(this).find('em').text().trim() == '60%') {
					$(this).parent().next().text("60%");
					$(this).parent().prev().css('width', '60%');
					$(this).parent().prev().css('background', 'green');
				}
				if($(this).find('em').text().trim() == '70%') {
					$(this).parent().next().text("70%");
					$(this).parent().prev().css('width', '70%');
					$(this).parent().prev().css('background', 'green');
				}
				if($(this).find('em').text().trim() == '80%') {
					$(this).parent().next().text("80%");
					$(this).parent().prev().css('width', '80%');
					$(this).parent().prev().css('background', 'green');
				}
				if($(this).find('em').text().trim() == '90%') {
					$(this).parent().next().text("90%");
					$(this).parent().prev().css('width', '90%');
					$(this).parent().prev().css('background', 'green');
				}
				if($(this).find('em').text().trim() == '100%') {
					$(this).parent().next().text("100%");
					$(this).parent().prev().css('width', '100%');
					$(this).parent().prev().css('background', 'blue');
				}
				$.ajax({
					type: "POST",
                    url: "TaskProgressSetAjax",
                    data: { 
                        taskIdx: taskIdx,
                        progress : progressValue
                    },
                    success: function(data) {
                        console.log(data);
                        alert("변경되었습니다.");
                    },
                    error: function(r, s, e) {
                        console.log(r.status);
                        console.log(e);
                        alert("오류");
                    }
				})
			})
			let pmnoValues = [];
			//초대하기 화면 출력
			$('.private').click(function(){
				$('.project-invite-area').css('display','block');
				$('.mainPop').css('display','block');
			});
			//초대하기 닫기 버튼 클릭
			$('.invite-close').click(function(){
				$('.project-invite-area').css('display','none');
				$('.mainPop').css('display','none');
				$('.invite-flow-section').css('display','none');
				$('.invite-email').css('display','none');
			    $('.invite-member-item').removeClass('active');
			    inviteCount = 0;
			    pmnoValues = [];
			    $('.inviteMemberListNull').css('display','block');
		       	$('.project-invite-selected-num').css('display','none');
		       	$('.inviteTargetList').css('display','none');
		        $('.invite-employees').addClass('on');
				 $('.invite-outsider').removeClass('on');
				 $('.project-invite-employees').css('display','block');
				 $('.project-invite-outsider').css('display','none');
			})
			// 초대선택화면으로 이동
			$('.return-btn-invite-main').click(function(){
				$('.project-invite-area').css('display','block');
				$('.invite-flow-section').css('display','none');
				$('.invite-email').css('display','none');
			    $('.invite-member-item').removeClass('active');
			    inviteCount = 0;
			    $('.inviteMemberListNull').css('display','block');
		       	$('.project-invite-selected-num').css('display','none');
		       	$('.inviteTargetList').css('display','none');
		       	$('.invite-email-value').val(""); 
		        $('.invite-email-list').empty(); 
		        pmnoValues = [];
		        $('.invite-email-value-input').text("");
		        $('.invite-employees').addClass('on');
				 $('.invite-outsider').removeClass('on');
				 $('.project-invite-employees').css('display','block');
				 $('.project-invite-outsider').css('display','none');
			});
			//플로우 프로그램으로초대
			$('.flowInvite').click(function(){
				$('.invite-flow-section').css('display','block');
				$('.project-invite-area').css('display','none');
				
			});
			//플로우 프로그램으로초대끄기
			$('.returnMainbtn').click(function(){
				$('.invite-flow-section').css('display','none');
				$('.mainPop').css('display','none');
				$('.invite-email').css('display','none');
			    $('.invite-member-item').removeClass('active');
			    inviteCount = 0;
			    $('.inviteMemberListNull').css('display','block');
		       	$('.project-invite-selected-num').css('display','none');
		       	$('.inviteTargetList').css('display','none');
		       	
		       	$('.invite-email-value').val(""); 
		        $('.invite-email-list').empty(); 
		        pmnoValues = [];
		        $('.invite-email-value-input').text("");
		        $('.invite-employees').addClass('on');
				 $('.invite-outsider').removeClass('on');
				 $('.project-invite-employees').css('display','block');
				 $('.project-invite-outsider').css('display','none');
			});
			//클립보드에 초대장 링크 복사
			$('.copyInviteUrl').click(function(){
				const copyText = "http://114.207.245.107:9090//Project/Controller?command=AccountMemberShip&companyIdx="+<%=companyIdx%>; 
			    const temp = document.createElement("textarea");
			    temp.value = copyText;
			    document.body.appendChild(temp);
			    temp.select();
			    document.execCommand("copy");
			    document.body.removeChild(temp);
			    alert("초대 링크가 복사되었습니다.");
			})
			$('#inviteURL').click(function(){
				const copyText = "http://114.207.245.107:9090//Project/alarm_broadcasting//Project/Controller?command=AccountMemberShip&companyIdx="+<%=companyIdx%>; 
			    const temp = document.createElement("textarea");
			    temp.value = copyText;
			    document.body.appendChild(temp);
			    temp.select();
			    document.execCommand("copy");
			    document.body.removeChild(temp);
			    alert("초대 링크가 복사되었습니다.");
			});
			//플로우 프로그램 초대시 체크 on
			$(document).on('click', '.invite-member-item', function() {
				let mno = $(this).data("mno");
				let name = $(this).find('.author-name').text().trim();
			    if (!$(this).hasClass('active')) {
			        $(this).addClass('active');
			        inviteCount++;
			        pmnoValues.push(mno);
			       	$('.project-select-member-count').text(inviteCount+"건 선택");
			        if(inviteCount > 0) {
			        	$('.inviteMemberListNull').css('display','none');
			        	$('.project-invite-selected-num').css('display','block');
			        	$('.inviteTargetList').css('display','block');
			        }
			        let backgroundImage = $(this).find('.profile-radius').css('background-image');
			        backgroundImage = backgroundImage.replace(/^url\(["']?/, '').replace(/["']?\)$/, '');
			        let ManagerList = " <li class = \"task-manager-name\" data-mno="+mno+">" +
			        " <span class = \"task-manager-img\" id = \"task-manager-img2\" style=\"background:url(" + backgroundImage + ") no-repeat center center; background-size: cover;\"></span>" +
			        " <span class = \"task-manager-value\">"+name+"</span>" +
			        " <button class = \"manager-remove-btn\"></button> " +
					" </li> ";
			        $('.invite-flow-section').find('.inviteTargetList').prepend(ManagerList);
			    } else {
			        $(this).removeClass('active');
			        var index = pmnoValues.indexOf(mno); 
			        if (index !== -1) {
			        	pmnoValues.splice(index, 1);
			        }
			        $('.task-manager-name').each(function(){
				    	if($(this).data("mno")==mno) {
				    		$(this).remove();
				    	}
			        });
			        inviteCount--;  // 카운트 감소
			        $('.project-select-member-count').text(inviteCount+"건 선택");
			        if(inviteCount == 0) {
			        	$('.inviteMemberListNull').css('display','block');
			        	$('.project-invite-selected-num').css('display','none');
			        	$('.inviteTargetList').css('display','none');
			        }
			    }
			});
			 $(document).on('keyup','.inviteSearchBox', function() {
			    	let text = $(this).val();
			    	let pmnoValues = []; 
				    $('.task-manager-name').each(function() {
				        var mno = $(this).data('mno');
				        pmnoValues.push(mno);
				    });
				    if($('.invite-employees').hasClass('on')) {
					    $.ajax({
					    	type : "POST",
							url : "/Project/InviteSearchAjax",
							data : {
								companyIdx : <%=companyIdx%>,
					    		search : text
							},
							success: function(data) {
								$('.invite-member-item').remove();
					            console.log(data);
					            for(let i = 0; i<data.length; i++) {
						            var taskManager =  "";
						            if (pmnoValues.includes(data[i].memberIdx)) {
						                taskManager += " <li class = \"invite-member-item active\" data-mno=" + data[i].memberIdx + ">";
						            } else {
						                taskManager += " <li class = \"invite-member-item\" data-mno=" + data[i].memberIdx + ">";
						            }
						            taskManager += " <div class = \"invite-check-select\"></div>" +
						            " <div class = \"post-author\">" +
						            " <span class = \"profile-radius\" style=\"background-image: url('"+data[i].profileImg+"');\"></span> " +
						            " <dl class = \"post-profile-text\">" +
						            " <dt> " +
									"		<strong class = \"author-name\">"+data[i].name+"</strong>" +
									"		<em class = \"author-position\">"+data[i].position+"</em>" +
									"	</dt>" +
									"	<dd>" +
									"		<strong class = \"author-company\">"+data[i].companyName+"</strong>" +
									"		<em class = \"author-department\">"+data[i].departmentName+"</em>" +
									"	</dd>" +
									" </div> " +
									" </li>";
					            	$('.project-invite-member-area').prepend(taskManager);
					            }
							},
							error: function(r, s, e) {
					            console.log(r.status);
					            console.log(e);
					            alert("오류");
					        }
					    });
				    } else {
				    	 $.ajax({
						    	type : "POST",
								url : "/Project/InviteOutSiderSearchAjax",
								data : {
									memberIdx : <%=memberIdx%>,
									companyIdx : <%=companyIdx%>,
						    		search : text
								},
								success: function(data) {
									$('.invite-member-item').remove();
						            console.log(data);
						            for(let i = 0; i<data.length; i++) {
							            var taskManager =  "";
							            if (pmnoValues.includes(data[i].memberIdx)) {
							                taskManager += " <li class = \"invite-member-item active\" data-mno=" + data[i].memberIdx + ">";
							            } else {
							                taskManager += " <li class = \"invite-member-item\" data-mno=" + data[i].memberIdx + ">";
							            }
							            taskManager += " <div class = \"invite-check-select\"></div>" +
							            " <div class = \"post-author\">" +
							            " <span class = \"profile-radius\" style=\"background-image: url('"+data[i].profileImg+"');\"></span> " +
							            " <dl class = \"post-profile-text\">" +
							            " <dt> " +
										"		<strong class = \"author-name\">"+data[i].name+"</strong>" +
										"		<em class = \"author-position\">"+data[i].position+"</em>" +
										"	</dt>" +
										"	<dd>" +
										"		<strong class = \"author-company\">"+data[i].companyName+"</strong>" +
										"		<em class = \"author-department\">"+data[i].departmentName+"</em>" +
										"	</dd>" +
										" </div> " +
										" </li>";
						            	$('.project-invite-member-area').prepend(taskManager);
						            }
								},
								error: function(r, s, e) {
						            console.log(r.status);
						            console.log(e);
						            alert("오류");
						        }
						    });
				    }
			});
			 $('.invite-outsider').click(function(){
				 $(this).addClass('on');
				 $('.invite-employees').removeClass('on');
				 $('.project-invite-employees').css('display','none');
				 $('.project-invite-outsider').css('display','block');
			 });
			 $('.invite-employees').click(function(){
				 $(this).addClass('on');
				 $('.invite-outsider').removeClass('on');
				 $('.project-invite-employees').css('display','block');
				 $('.project-invite-outsider').css('display','none');
			 });
			//전체삭제 
			$('.project-select-member-all-delete').click(function(){
				$('.all-select').text('전체 선택');
				$('.invite-member-item').removeClass('active');
				inviteCount = 0;
				$('.inviteMemberListNull').css('display','block');
	        	$('.project-invite-selected-num').css('display','none');
	        	$('.inviteTargetList').css('display','none');
	        	pmnoValues = [];
			});
			//프로젝트 참가멤버 전체보기 클릭시 출력
			$('.allview-btn').click(function(){
				$('.mainPop').css('display','block');
				$('.project_member-layer-box').css('display','block');
			});
			$('.project_member-close-btn').click(function(){
				$('.mainPop').css('display','none');
				$('.project_member-layer-box').css('display','none');
			})
			$(document).ready(function() {
				 $(document).on('click','.project-other-option-btn',function(){
					if($(this).parent().find('.project-other-option-layer').css('display')=='none') {
						$('.project-other-option-btn').parent().find('.project-other-option-layer').css('display','none');
						$(this).parent().find('.project-other-option-layer').css('display','block');
					} else {
						$(this).parent().find('.project-other-option-layer').css('display','none');
					}
				});
			});
			$('.inviteSubmitbtn').click(function(){
				$.ajax({
					type : "post",
					url : "InviteProjectAjax",
					data : {
						pmnoValues : JSON.stringify(pmnoValues),
						projectIdx : <%=projectIdx%>
					},
					success: function(data) {
			            console.log(data);
			            location.reload();
					},
					error: function(r, s, e) {
			            console.log(r.status);
			            console.log(e);
			            alert("오류");
			        }
				});
			});
			//관리자 지정, 해제
	        let adminCount = <%=projectadminmember%>;
	        let nonadminCount = <%=projectNoNadminmember%>;
	        let outsiderCount = <%=projectOutsidermember%>;
			$('.project-member-item').each(function(){
			    var $this = $(this);
			    let memberIdx = $this.data("mno");
			    $this.find('.project-other-option-admin').click(function(){
			        var $admin = $this.find('.project-admin');
			        var $optionText = $this.find('.project-other-option-admin');
			        $this.find('.project-other-option-layer').css('display','none');
			        if ($admin.hasClass('active')) {
			        	if(adminCount<=1) {
			        		alert('프로젝트 관리자는 최소 한명이 존재해야합니다.');
			        	} else {
				            $.ajax({
				            	type : "POST",
				            	url : "ProjectAdminUpdateAjax",
				            	data : {
				            		projectIdx : <%=projectIdx%>,
				            		memberIdx : memberIdx,
				            		admin : 'N'
				            	},
				            	success: function(data) {
						            console.log(data);
						            alert("적용되었습니다.");
						            $admin.removeClass('active');
						            $optionText.text('관리자로 지정');
						            adminCount--;
						            $('.member-header.admin').find('.m-headercnt').text(adminCount);
						            $('.member-body').filter(function() {
						                return $(this).data('mno') === memberIdx;
						            }).remove();
						            if(<%=pdto.getCompanyIdx()%> != data.CompanyIdx ) {
						            	outsiderCount++;
						            	if(outsiderCount>0) {
						            		$('.outsider-member-list').css('display','block');
						            		$('.member-header.outsider').css('display','block');
						            	}
						            	$('.member-header.outsider').find('.m-headercnt').text(outsiderCount);
						            	let memberValue = "<div class=\"member-body\" data-mno="+data.memberIdx+">"+
														"		<div class=\"m-profile\">"+
														"		<div class=\"profile1-img\" style=\"float: left;\"></div>"+
														"		<dl class=\"post-profile-text\" style=\"float: left;margin: 0px;margin-left: 10px;\">"+
														"			<dt>"+
														"				<strong class=\"author-name\">"+data.name+"</strong>"+
														"				<em class=\"author-position\">"+data.position+"</em>"+
														"			</dt>"+
														"			<dd>"+
														"				<strong class=\"author-company\">"+data.compnayName+"</strong>"+
														"				<em class=\"author-department\">"+data.departmentName+"</em>"+
														"			</dd>"+
														"		</dl>"+
														"	</div>"+
														"	<button class=\"m-chat\" type=\"button\">"+
														"		<div class=\"chat-img\"></div>"+
														"	</button>"+
													"	</div>";
											$('.outsider-member-list').append(memberValue);
						            } else {
						            	nonadminCount++;
						            	if(nonadminCount>0) {
						            		$('.nonadmin-member-list').css('display','block');
						            		$('.member-header.nonadmin').css('display','block');
						            	}
						            	$('.member-header.nonadmin').find('.m-headercnt').text(nonadminCount);
						            	let memberValue = "<div class=\"member-body\" data-mno="+data.memberIdx+">"+
														"		<div class=\"m-profile\">"+
														"		<div class=\"profile1-img\" style=\"float: left;\"></div>"+
														"		<dl class=\"post-profile-text\" style=\"float: left;margin: 0px;margin-left: 10px;\">"+
														"			<dt>"+
														"				<strong class=\"author-name\">"+data.name+"</strong>"+
														"				<em class=\"author-position\">"+data.position+"</em>"+
														"			</dt>"+
														"			<dd>"+
														"				<strong class=\"author-company\">"+data.compnayName+"</strong>"+
														"				<em class=\"author-department\">"+data.departmentName+"</em>"+
														"			</dd>"+
														"		</dl>"+
														"	</div>"+
														"	<button class=\"m-chat\" type=\"button\">"+
														"		<div class=\"chat-img\"></div>"+
														"	</button>"+
													"	</div>";
						            	$('.nonadmin-member-list').append(memberValue);
						            }
						            
						        },
						        error: function(r, s, e) {
						            console.log(r.status);
						            console.log(e);
						            alert("오류");
						        }
				            });
			        	}
			        } else {
			        	$.ajax({
			            	type : "POST",
			            	url : "ProjectAdminUpdateAjax",
			            	data : {
			            		projectIdx : <%=projectIdx%>,
			            		memberIdx : memberIdx,
			            		admin : 'Y'
			            	},
			            	success: function(data) {
					            console.log(data);
					            alert("적용되었습니다.");
					            $admin.addClass('active');
					            $optionText.text('관리자 해제');
					            $('.member-body').filter(function() {
					                return $(this).data('mno') === memberIdx;
					            }).remove();
					            if(<%=pdto.getCompanyIdx()%> != data.CompanyIdx ) {
					            	outsiderCount--;
					            	if(outsiderCount==0) {
					            		$('.outsider-member-list').css('display','none');
					            		$('.member-header.outsider').css('display','none');
					            	}
					            	$('.member-header.outsider').find('.m-headercnt').text(outsiderCount);
					            	
					            } else {
					            	nonadminCount--;
					            	if(nonadminCount==0) {
					            		$('.nonadmin-member-list').css('display','none');
					            		$('.member-header.nonadmin').css('display','none');
					            	}
					            	$('.member-header.nonadmin').find('.m-headercnt').text(nonadminCount);
					            }
					            let memberValue = "<div class=\"member-body\" data-mno="+data.memberIdx+">"+
													"		<div class=\"m-profile\">"+
													"		<div class=\"profile1-img\" style=\"float: left;\"></div>"+
													"		<dl class=\"post-profile-text\" style=\"float: left;margin: 0px;margin-left: 10px;\">"+
													"			<dt>"+
													"				<strong class=\"author-name\">"+data.name+"</strong>"+
													"				<em class=\"author-position\">"+data.position+"</em>"+
													"			</dt>"+
													"			<dd>"+
													"				<strong class=\"author-company\">"+data.compnayName+"</strong>"+
													"				<em class=\"author-department\">"+data.departmentName+"</em>"+
													"			</dd>"+
													"		</dl>"+
													"	</div>"+
													"	<button class=\"m-chat\" type=\"button\">"+
													"		<div class=\"chat-img\"></div>"+
													"	</button>"+
												"	</div>";
								adminCount++;
								$('.member-header.admin').find('.m-headercnt').text(adminCount);
					            $('.admin-member-list').append(memberValue);
					        },
					        error: function(r, s, e) {
					            console.log(r.status);
					            console.log(e);
					            alert("오류");
					        }
			            });
			        }
			    });
			    //프로젝트 나가기, 내보내기
			    $this.find('.project-other-option-exit').click(function(){
			    	if($(this).text().trim()=='나가기') {
			    		if ("Y".equals(PMdto2.getAdminYN())) {
				    		if(adminCount==1){
				    			alert('프로젝트 관리자는 최소 한명이 존재해야합니다.');
				    		} else {
				    			location.href = "ExitAction.jsp?mno=" + memberIdx + "&pno=" + <%=projectIdx%>;
				    		}
			    		} else {
			    			location.href = "ExitAction.jsp?mno=" + memberIdx + "&pno=" + <%=projectIdx%>;
			    		}
			    	} else {
			    		$.ajax({
			    			type : "POST",
			    			url : "ProjectMemberExportAjax",
			    			data : {
			    				memberIdx : memberIdx,
			    				ProjectIdx : <%=projectIdx%>
			    			},
			    			success: function(data) {
					            console.log(data);
					            if(data.admin == 'Y'){
					            	adminCount--;
					            	$('.member-header.admin').find('.m-headercnt').text(adminCount);
					            } else {
	 					            if(<%=pdto.getCompanyIdx()%> != data.CompanyIdx ) {
						            	outsiderCount--;
						            	$('.member-header.outsider').find('.m-headercnt').text(outsiderCount);
						            	if(outsiderCount==0) {
						            		$('.outsider-member-list').css('display','none');
						            		$('.member-header.outsider').css('display','none');
						            	}
						            }
						            else {
						            	nonadminCount--;
						            	if(nonadminCount==0) {
						            		$('.nonadmin-member-list').css('display','none');
						            		$('.member-header.nonadmin').css('display','none');
						            	}
						            	$('.member-header.nonadmin').find('.m-headercnt').text(nonadminCount);
						            }
					            }
					            $this.remove();
					            $('.member-body').filter(function() {
					                return $(this).data('mno') === memberIdx;
					            }).remove();
			    			},
			    			error: function(r, s, e) {
					            console.log(r.status);
					            console.log(e);
					            alert("오류");
					        }
			    		});
			    	}
			    });
			});
			 function fnMove(seq){
			        var offset = $("#fixed" + seq).offset();
			        $('html, body').animate({scrollTop : offset.top}, 400);
			 }
			 //게시물 삭제
			 $('.board-set-item-del').click(function() {
			    let bno = $(this).parents('.feed-board').data('bno');
			    $.ajax({
			    	type: 'POST',
			        url: 'BoardDeleteAjax',
			        data: {
			        	boardIdx : bno
			        },
				    success: function(data) {
			            console.log(data);
			            alert("적용되었습니다.");
			            location.reload();
			        },
			        error: function(r, s, e) {
			            console.log(r.status);
			            console.log(e);
			            alert("오류");
			        }
			    });
			});
			 $('.board-set-item-edit').click(function(){
				 $(this).parents('.board-setting-layer').css('display','none');
				 let boardIdx = $(this).parents('.feed-board').data("bno");
				 let category = $(this).parents('.feed-board').data("category");
				$('.create-flow-background-1').css('display', 'block');
				$('.create-post').attr('data-bno', boardIdx);
				$('.create-post-nav').css('display','none');
				$('.create-post-title').text('게시글 수정');
				if(category == "글") {
					$('.post-content-box-post').css('display', 'block');
					$('.create-tab-write').each(function() {
				    	if ($(this).attr('id') === 'crt-post') {
				        	$(this).addClass('on');
				    	}
					});
					$.ajax({
						type : "POST",
						url : "PostCategoryAjax",
						data : {
							boardIdx : boardIdx
						},
						success: function(data) {
				            console.log(data);
				            $('.postTitle').val(data.title);
				            $('.post-content-box-post').find('.create-content-value').text(data.content);
				            if(data.releaseYN == 'Y') {
				    				$('.create-private-btn').text($('.private-option-full').text());
				    				$('.create-private-btn').addClass('full');
				    				$('.create-private-btn').removeClass('admin');
				    				Release = 'Y';
				            } else {
				    				$('.create-private-btn').text($('.private-option-admin').text());
				    				$('.create-private-btn').addClass('admin');
				    				$('.create-private-btn').removeClass('full');
				    				Release = 'N';
				            	
				            }
				        },
				        error: function(r, s, e) {
				            console.log(r.status);
				            console.log(e);
				            alert("오류");
				        }
						
					});
				} else if(category == "업무") {
					$('.task-area').css('display', 'block');
					$('.create-tab-write').each(function() {
					    if ($(this).attr('id') === 'crt-task') {
					        $(this).addClass('on');
					    }
					});
					$.ajax({
						type : "POST",
						url : "TaskCategoryAjax",
						data : {
							boardIdx : boardIdx
						},
						success: function(data) {
				            console.log(data);
				            $('.create-post').attr('data-tno', data.TaskIdx);
				            $('.postTitle').val(data.title);
				            $('.task-area').find('.create-content-value').text(data.content);
				            if(data.releaseYN == 'Y') {
				    				$('.create-private-btn').text($('.private-option-full').text());
				    				$('.create-private-btn').addClass('full');
				    				$('.create-private-btn').removeClass('admin');
				    				Release = 'Y';
				            } else {
				    				$('.create-private-btn').text($('.private-option-admin').text());
				    				$('.create-private-btn').addClass('admin');
				    				$('.create-private-btn').removeClass('full');
				    				Release = 'N';
				            }
				            $('.task-area').find('.task-state-btn').removeClass('on');
				            if(data.State == 1) {
				            	taskState = 1;
				            	$('.task-area').find('.task-state-btn.request').addClass('on');
				            } else if (data.State == 2) {
				            	taskState = 2;
				            	$('.task-area').find('.task-state-btn.progress').addClass('on');
				            } else if (data.State == 3) {
				            	taskState = 3;
				            	$('.task-area').find('.task-state-btn.feedback').addClass('on');
				            } else if (data.State == 4) {
				            	taskState = 4;
				            	$('.task-area').find('.task-state-btn.complete').addClass('on');
				            } else if (data.State == 5) {
				            	taskState = 5;
				            	$('.task-area').find('.task-state-btn.hold').addClass('on');
				            }
					        var daysOfWeek = ["일", "월", "화", "수", "목", "금", "토"];
				            if(data.StartDate != null) {
				           	 	$('.task-startdate-area').find('.input-start-datas').val(data.StartDate);
				           		$('.task-startdate-area').find('.input-start-datas').css('display','none');
				           		function formatStartDate(startDateString) {
				           		    var startDateObj = new Date(startDateString);
				           		    var formattedStartDate = startDateString + " (" + daysOfWeek[startDateObj.getDay()] + ")";
				           		    return formattedStartDate;
				           		}
				           		var startDate = data.StartDate.substring(0, 10);  
				           		var formattedStartDate = formatStartDate(startDate);
				           		$('.task-startdate-area').find('.input-data-text').text(formattedStartDate);
				           		$('.task-startdate-area').find('.board-remove-btn').css('display','inline-block');
				            }
							if(data.EndDate != null) {
				            	$('.task-enddate-area').find('.input-end-datas').val(data.EndDate);
				            	$('.task-enddate-area').find('.input-end-datas').css('display','none');
				            	function formatEndDate(endDateString) {
				            	    var endDateObj = new Date(endDateString);
				            	    var formattedEndDate = endDateString + " (" + daysOfWeek[endDateObj.getDay()] + ")";
				            	    return formattedEndDate;
				            	}
				            	var endDate = data.EndDate.substring(0, 10);
				            	var formattedEndDate = formatEndDate(endDate);
				            	$('.task-enddate-area').find('.input-data-text').text(formattedEndDate);
				            	$('.task-enddate-area').find('.board-remove-btn').css('display','inline-block');
				            }
								var priorityFind = $('.create-post').find('.task-priority-area');
								priorityFind.find('.icons').removeClass('high');
								priorityFind.find('.task-priority-area').find('.icons').removeClass('middle');
								priorityFind.find('.task-priority-area').find('.icons').removeClass('emergency');
								priorityFind.find('.task-priority-area').find('.icons').removeClass('low');
								if(data.Priority == 5) {
								$('.input-data-priority').css('display','inline-block');
									Taskpriority = 5;
								} else if(data.Priority == 4) {
								$('.input-data-priority').css('display','none');
									priorityFind.find('.icons').addClass('low');
									priorityFind.find('.priority-text').text("낮음");
									priorityFind.find('.board-remove-btn').css('display','inline-block');
									Taskpriority = 4;
								} else if(data.Priority == 3) {
								$('.input-data-priority').css('display','none');
									priorityFind.find('.icons').addClass('middle');
									priorityFind.find('.priority-text').text("중간");
									priorityFind.find('.board-remove-btn').css('display','inline-block');
									Taskpriority = 3;
								} else if(data.Priority == 2) {
								$('.input-data-priority').css('display','none');
									priorityFind.find('.icons').addClass('high');
									priorityFind.find('.priority-text').text("높음");
									priorityFind.find('.board-remove-btn').css('display','inline-block');
									Taskpriority = 2;
								} else if(data.Priority == 1) {
								$('.input-data-priority').css('display','none');
									priorityFind.find('.icons').addClass('emergency');
									priorityFind.find('.priority-text').text("긴급");
									priorityFind.find('.board-remove-btn').css('display','inline-block');
									Taskpriority = 1;
								}
								if(data.TaskGroupIdx != 0) {
									$('.create-post').find('.task-group-area').find('.input-data-group').css('display','none');
									$('.create-post').find('.task-group-area').find('.task-group-values').text(data.TaskGroupName);
									taskGroupIdx = data.TaskGroupIdx;
									$('.create-post').find('.task-group-area').find('.board-remove-btn').css('display','inline-block');
								}
								$('.create-post').find('.progress-bar').css('width',data.Progress+'%');
								$('.create-post').find('.progress-text').text(data.Progress+'%');
								if(data.Progress == 100) {
									$('.create-post').find('.progress-bar').css('background','blue');
								} else {
									$('.create-post').find('.progress-bar').css('background','green');
								}
								for(let i = 0; i<data.array1.length; i++) {
									let memberBox = "<span class=\"manager-item\" data-mno="+data.array1[i].memberIdx+">" +
									"	<span class=\"manager-profile-img\" style=\"background-image: url('"+data.array1[i].ProfileImg+"');\"></span>" +
									"	<span class=\"manager-profile-name\">"+data.array1[i].Name+"</span> " +
									"	<button class=\"manager-profile-remove\"></button> " +
									" </span>";
								    $('.select-list').each(function(){
								    	if($(this).data("mno") == data.array1[i].memberIdx) {
								    		$(this).remove();	
								    	}
								    });
									$('.manager-group').append(memberBox);
								    
				                }
				        },
				        error: function(r, s, e) {
				            console.log(r.status);
				            console.log(e);
				            alert("오류");
				        }
						
					});
				} else if(category == "일정") {
					$('.schedule-add-content-box').css('display', 'block');
					$('.create-tab-write').each(function() {
					    if ($(this).attr('id') === 'crt-schedule') {
					        $(this).addClass('on');
					    }
					});
					$.ajax({
						type : "POST",
						url : "ScheduleCategoryAjax",
						data : {
							boardIdx : boardIdx
						},
						success: function(data) {
				            console.log(data);
				            $('.postTitle').val(data.title);
				            $('.schedule-add-content-box').find('.create-content-value').text(data.content);
				            $('.create-post').attr('data-sno', data.ScheduleIdx);
				            if(data.releaseYN == 'Y') {
				    				$('.create-private-btn').text($('.private-option-full').text());
				    				$('.create-private-btn').addClass('full');
				    				$('.create-private-btn').removeClass('admin');
				    				Release = 'Y';
				            } else {
				    				$('.create-private-btn').text($('.private-option-admin').text());
				    				$('.create-private-btn').addClass('admin');
				    				$('.create-private-btn').removeClass('full');
				    				Release = 'N';
				            	
				            }
				            if(data.location != 'null') {
				           		$('#loaction-input').val(data.location);
				            }
				            if (data.AllDayYN == 'Y') {
				                $('#all-day-check').prop('checked', true);
				                let prevStartDate = $("#startDateInput").val().substring(14, $("#startDateInput").val().length);
								let prevEndDate = $("#endDateInput").val().substring(14, $("#endDateInput").val().length);
								
								$("#startDateInput").val($("#startDateInput").val().substring(0, 14));
								$("#endDateInput").val($("#endDateInput").val().substring(0, 14));
				            } else {
				                $('#all-day-check').prop('checked', false);
				                let onAllDayStartDate = $("#startDateInput").val() + _prevStartDate;
								let onAllDayEndDate = $("#endDateInput").val() + _prevEndDate;
								
								$("#startDateInput").val(onAllDayStartDate);
								$("#endDateInput").val(onAllDayEndDate);
				            }
				            
				            let startDate = new Date(data.StartDate);  // data.startDate를 Date 객체로 변환
				            let endDate = new Date(data.EndDate);      // data.endDate를 Date 객체로 변환

				            // 가장 가까운 10분 단위로 시작일을 설정하는 함수
				            function getNearestTenthMinute(date) {
				                let minutes = date.getMinutes();
				                let nearestTenth = Math.floor(minutes / 10) * 10;
				                return nearestTenth;
				            }

				            // 시작일을 10분 단위로 맞추기
				            let nearestTenthMinute = getNearestTenthMinute(startDate);
				            startDate.setMinutes(nearestTenthMinute);
				            startDate.setSeconds(0);
				            startDate.setMilliseconds(0);

				            // 날짜 포맷 설정 (시작일)
				            let year = startDate.getFullYear();
				            let month = (startDate.getMonth() + 1).toString().padStart(2, '0');
				            let day = startDate.getDate().toString().padStart(2, '0');
				            let dayNames = ['일', '월', '화', '수', '목', '금', '토'];
				            let dayOfWeek = dayNames[startDate.getDay()];
				            let formattedStartDate = year + '-' + month + '-' + day + ' (' + dayOfWeek + ') ';

				            // 시간:분 포맷 설정 (시작일)
				            let startHours = startDate.getHours().toString().padStart(2, '0');
				            let startMinutes = startDate.getMinutes().toString().padStart(2, '0');
				            let formattedStartTime = startHours + ':' + startMinutes;

				            // 종료일 포맷 설정 (종료일)
				            let endYear = endDate.getFullYear();
				            let endMonth = (endDate.getMonth() + 1).toString().padStart(2, '0');
				            let endDay = endDate.getDate().toString().padStart(2, '0');
				            let endDayOfWeek = dayNames[endDate.getDay()];
				            let formattedEndDate = endYear + '-' + endMonth + '-' + endDay + ' (' + endDayOfWeek + ') ';

				            // 시간:분 포맷 설정 (종료일)
				            let endHours = endDate.getHours().toString().padStart(2, '0');
				            let endMinutes = endDate.getMinutes().toString().padStart(2, '0');
				            let formattedEndTime = endHours + ':' + endMinutes;

				            // 시작일과 종료일 입력값 설정
				            $("#startDateInput").val(formattedStartDate + formattedStartTime);
				            $("#endDateInput").val(formattedEndDate + formattedEndTime);

				            // 배경 설정
				            $(".schedule-add-background").css('display', 'flex');
				            switch (data.AlarmType) {
					            case 0:
					                $('.alarm-select').val("없음");
					                break;
					            case 1:
					                $('.alarm-select').val("10분 전 미리 알림");
					                break;
					            case 2:
					                $('.alarm-select').val("30분 전 미리 알림");
					                break;
					            case 3:
					                $('.alarm-select').val("1 시간 전 미리 알림");
					                break;
					            case 4:
					                $('.alarm-select').val("2 시간 전 미리 알림");
					                break;
					            case 5:
					                $('.alarm-select').val("3 시간 전 미리 알림");
					                break;
					            case 6:
					                $('.alarm-select').val("1일 전 미리 알림");
					                break;
					            case 7:
					                $('.alarm-select').val("2일 전 미리 알림");
					                break;
					            case 8:
					                $('.alarm-select').val("7일 전 미리 알림");
					                break;
					            default:
					                $('.alarm-select').val("없음");
					                break;
					        }
				            $('.member-item-box').remove();
				            for(let i = 0; i<data.array1.length; i++) {
								let newTr = '<span class="member-item-box" data-idx="'+data.array1[i].memberIdx+'">' +
												'<img class="user-prof" src="'+data.array1[i].ProfileImg+'"/>' +
												'<span>'+data.array1[i].Name+'</span>' +
												'<button type="button" class="participantRemoveBtn"></button>' +
											'</span>';
								
								$("#memberItemsWrap").append(newTr);
				            }
				        },
				        error: function(r, s, e) {
				            console.log(r.status);
				            console.log(e);
				            alert("오류");
				        }
						
					});
				}
			 });
			 $(document).on('click','.participantRemoveBtn',function(){
				$(this).parents('.member-item-box').remove(); 
			 });
			 //북마크 버튼 클릭시
			$('.bookmark-btn').click(function(){
					 let boardIdx = $(this).parents('.feed-board').data("bno");
				 if(!$(this).find('.bookmark-icon').hasClass('on')) {
					 $(this).find('.bookmark-icon').addClass('on');
					 $.ajax({
						type: 'POST',
				        url: 'BookmarkaddAjax',
				        data: {
				            boardIdx: boardIdx,
				            memberIdx : <%=memberIdx%>
				        },
				        success: function(data) {
				            console.log(data);
				            alert("적용되었습니다.");
				        },
				        error: function(r, s, e) {
				            console.log(r.status);
				            console.log(e);
				            alert("오류");
				        }
					 });
				 } else {
					 $(this).find('.bookmark-icon').removeClass('on');
					 $.ajax({
							type: 'POST',
					        url: 'BookmarkremoveAjax',
					        data: {
					            boardIdx: boardIdx,
					            memberIdx : <%=memberIdx%>
					        },
					        success: function(data) {
					            console.log(data);
					            alert("적용되었습니다.");
					        },
					        error: function(r, s, e) {
					            console.log(r.status);
					            console.log(e);
					            alert("오류");
					        }
						 });
				 }
			});
			//좋아요 버튼 클릭시
			$(document).on('click', '.emotion-btn', function() {
				let $this = $(this); 
				var emotion = $(this).parents('.main-option-btn').find('.emotion-layer');
				if($(this).hasClass('on')) {
					let boardIdx = $(this).parents('.feed-board').data("bno");
					$(this).removeClass('on');
					$(this).find('.emotion-icon').removeClass('on');
					$.ajax({
						type: 'POST',
				        url: 'BoardEmotionDeleteAjax',
				        data: {
				            boardIdx: boardIdx,
				            memberIdx : <%=memberIdx%>
				        },
				        success: function(data) {
				            console.log(data);
				            let url = $this.parents('.board-main-option-left');
			            	if($this.find('.emotion-text').text().trim() != '좋아요') {
			            		$this.find('.emotion-text').text('좋아요');
			            	}
				            for(let i = 0; i<data.length; i++) {
				                if (data[i].totalcount > 1) {
				                   	url.find('.emotion-writer-cnt').text('+' + data[i].totalcount);
				                } else if (data[i].totalcount <= 1) {
				                	url.find('.emotion-writer-cnt').text('');
				                }
				                if (data[i].totalcount == 0) {
				                	url.find('.emotion-writer-name').text('');
				                }
					           
					            if(data[i].EmotionType==1 && data[i].countEmotion == 0) {
					            	url.find('.emotion1').remove();
					            }if(data[i].EmotionType==2 && data[i].countEmotion == 0) {
					            	url.find('.emotion2').remove();
					            }if(data[i].EmotionType==3 && data[i].countEmotion == 0) {
					            	url.find('.emotion3').remove();
					            }if(data[i].EmotionType==4 && data[i].countEmotion == 0) {
					            	url.find('.emotion4').remove();
					            }if(data[i].EmotionType==5 && data[i].countEmotion == 0) {
					            	url.find('.emotion5').remove();
					            }
				            }
				            
				        },
				        error: function(r, s, e) {
				            console.log(r.status);
				            console.log(e);
				            alert("오류");
				        }
					});
				} else {
					if($(emotion).css('display')=='none') {
						$(emotion).css('display','block');
					} else {
						$(emotion).css('display','none');
					}
				}
			});
			//좋아요 상세보기
			$('.board-emotion-group').click(function(){
				$('.mainPop').css('display','block');
				$('.emotion-all-check').css('display','flex');
				boardIdx = $(this).parents('.feed-board').data("bno");

			    $.ajax({
			        type: 'POST',
			        url: 'BoardEmotionViewAjax',
			        data: {
			            boardIdx: boardIdx,
			        },
			        
			        success: function(data) {
			            console.log(data);
			            $('.emotion-check-item').remove();
			            for(let i = 0; i<data.length; i++) {
			            var memberBoard = " <li class = \"emotion-check-item\"> " +
						" <div class=\"post-author\"> ";
			            if(data[i].emotionType2 == 1) {
			            	memberBoard += "<i class=\"emotion1\" style = \""+
			            "	margin-top: 18px; "+
						"    width: 30px; " +
						"    height: 30px; " +
						"    margin-right: 15px; " +
						"    display: inline-block; " +
						"    vertical-align: middle; " +
						"    background-position: -26px -101px;\" " +
					    " ></i>";
			            } else if(data[i].emotionType2 == 2) {
			            	memberBoard += "<i class=\"emotion1\" style = \""+
				            "	margin-top: 18px; "+
							"    width: 30px; " +
							"    height: 30px; " +
							"    margin-right: 15px; " +
							"    display: inline-block; " +
							"    vertical-align: middle; " +
							"    background-position: -82px -101px;\" " +
						    " ></i>";
			            } else if(data[i].emotionType2 == 3) {
			            	memberBoard += "<i class=\"emotion1\" style = \""+
				            "	margin-top: 18px; "+
							"    width: 30px; " +
							"    height: 30px; " +
							"    margin-right: 15px; " +
							"    display: inline-block; " +
							"    vertical-align: middle; " +
							"    background-position: -138px -101px;\" " +
						    " ></i>";
			            } else if(data[i].emotionType2 == 4) {
			            	memberBoard += "<i class=\"emotion1\" style = \""+
				            "	margin-top: 18px; "+
							"    width: 30px; " +
							"    height: 30px; " +
							"    margin-right: 15px; " +
							"    display: inline-block; " +
							"    vertical-align: middle; " +
							"    background-position: -194px -101px;\" " +
						    " ></i>";
			            } else if(data[i].emotionType2 == 5) {
			            	memberBoard += "<i class=\"emotion1\" style = \""+
				            "	margin-top: 18px; "+
							"    width: 30px; " +
							"    height: 30px; " +
							"    margin-right: 15px; " +
							"    display: inline-block; " +
							"    vertical-align: middle; " +
							"    background-position: -250px -101px;\" " +
						    " ></i>";
			            }
			            memberBoard +="        	<span class = \"profile-radius\" style=\"background-image: url('"+data[i].profileImg+"');\"></span> " +
						"            <dl class = \"post-profile-text\"> "     +
						"				<dt> " +
						"					<strong class = \"author-name\">"+data[i].name+"</strong> "+
						"				</dt> "+
						"			</dl> "+
						"       </div> "+
						"	</li>";
							$('.emotion-participants-list').each(function() {
							       $(this).prepend(memberBoard);
							});
							$('.emotion-total-count-value').text(data[i].totalcount);
							if(data[i].emotionType == 1) {
								$('.total-emotion-item').each(function(){
									if($(this).data("code")==1) {
										$(this).addClass('on');
										$(this).find('.emotion-count-value').text(data[i].countemotion);
									}
								});
							}if(data[i].emotionType == 2) {
								$('.total-emotion-item').each(function(){
									if($(this).data("code")==2) {
										$(this).addClass('on');
										$(this).find('.emotion-count-value').text(data[i].countemotion);
									}
								});
							}if(data[i].emotionType == 3) {
								$('.total-emotion-item').each(function(){
									if($(this).data("code")==3) {
										$(this).addClass('on');
										$(this).find('.emotion-count-value').text(data[i].countemotion);
									}
								});
							}if(data[i].emotionType == 4) {
								$('.total-emotion-item').each(function(){
									if($(this).data("code")==4) {
										$(this).addClass('on');
										$(this).find('.emotion-count-value').text(data[i].countemotion);
									}
								});
							}if(data[i].emotionType == 5) {
								$('.total-emotion-item').each(function(){
									if($(this).data("code")==5) {
										$(this).addClass('on');
										$(this).find('.emotion-count-value').text(data[i].countemotion);
									}
								});
							}
							
							
			            }	
			        },
			        error: function(r, s, e) {
			            console.log(r.status);
			            console.log(e);
			            alert("오류");
			        }
			    });
			});
			//좋아요 입력
			$('.emotion-item').click(function() {
			  let code = 0;
			  let $this = $(this); 
			  $('.emotion-layer').css('display', 'none');
			  let boardIdx = $this.parents('.feed-board').data("bno"); 
			  if ($this.data("code") == 1) {
			      code = 1;
			  }
			  if ($this.data("code") == 2) {
			      code = 2;
			  }
			  if ($this.data("code") == 3) {
			      code = 3;
			  }
			  if ($this.data("code") == 4) {
			      code = 4;
			  }
			  if ($this.data("code") == 5) {
			      code = 5;
			  }
			  $.ajax({
			      type: 'POST',
			      url: 'BoardEmotionAddAjax',
			      data: {
			          boardIdx: boardIdx,
			          code: code,
			          memberIdx: <%=memberIdx%>
			        },
			        success: function(data) {
			            console.log(data);
			            let url = $this.parents('.board-main-option-left');
			            if (data.totalcount != 0) {
			                url.find('.emotion-writer-cnt').text('+' + data.totalcount);
			            } else {
			                url.find('.emotion-writer-name').text(data.name);
			            }
			
			            let emotion = ''; 
			
			            if (data.emotionType == 1) {
			                if (url.find('.board-emotion-group > .emotion1').length == 0) {
			                    emotion = "<div class=\"emotion1\"></div>";
			                }
			                url.find('.emotion-text').text('좋아요');
			            }
			            if (data.emotionType == 2) {
			                if (url.find('.board-emotion-group > .emotion2').length == 0) {
			                    emotion = "<div class=\"emotion2\"></div>";
			                }
			                url.find('.emotion-text').text('부탁해요');
			            }
			            if (data.emotionType == 3) {
			                if (url.find('.board-emotion-group > .emotion3').length == 0) {
			                    emotion = "<div class=\"emotion3\"></div>"; 
			                }
			                url.find('.emotion-text').text('힘들어요');
			            }
			            if (data.emotionType == 4) {
			                if (url.find('.board-emotion-group > .emotion4').length == 0) {
			                    emotion = "<div class=\"emotion4\"></div>"; 
			                }
			                url.find('.emotion-text').text('훌륭해요');
			            }
			            if (data.emotionType == 5) {
			                if (url.find('.board-emotion-group > .emotion5').length == 0) {
			                    emotion = "<div class=\"emotion5\"></div>"; 
			                }
			                url.find('.emotion-text').text('감사해요');
			            }
			            $this.parents('.main-option-btn').find('.emotion-icon').addClass('on');
						$this.parents('.main-option-btn').find('.emotion-btn').addClass('on');
			            url.find('.board-emotion-group').prepend(emotion);
			        },
			        error: function(r, s, e) {
			            console.log(r.status);
			            console.log(e);
			            alert("오류");
			        }
			    });
			});
			$('.emotion-close-btn').click(function(){
				$('.mainPop').css('display','none');
				$('.emotion-all-check').css('display','none');
			});
			$('.comment-delete').click(function(){
				var del = confirm('삭제하시겠습니까?');
				if(del) {
					let commentIdx = $(this).parents('.comment-content-box').data("idx");
							$(this).parents('.comment-content-box').remove();
					$.ajax({
						type : "POST",
						url : "CommentDelAjax",
						data : {
							commentIdx : commentIdx
						},
						success: function(data) {
				            console.log(data);
				            alert("적용되었습니다.")
						},
					 	error: function(r, s, e) {
				            console.log(r.status);
				            console.log(e);
				            alert("오류");
				        }
					});
				} else {
					
				}
			});
			//댓글 수정문
			$('.comment-modify').click(function(){
				let value = $(this).parents('.comment-content-mainbox').find('.mainbox-content-area').find('div').text().trim();
				$(this).parents('.comment-content-mainbox').css('display','none');
				$(this).parents('.comment-content-mainbox').next().css('display','block');
				$(this).parents('.comment-content-mainbox').next().find('.input-comment-box').addClass('update');
				$(this).parents('.comment-content-mainbox').next().find('.input-comment-box').text(value);
			});
			let boardIdx = 0;
			$('.main-option-cnt').click(function() {
			    $('.mainPop').css('display', 'block');
			    $('.read-check').css('display', 'flex');
			    
			    boardIdx = $(this).parents('.feed-board').data("bno");

			    $.ajax({
			        type: 'POST',
			        url: 'BoardReadAjax',
			        data: {
			            boardIdx: boardIdx,
			            projectIdx : <%=projectIdx%>
			        },
			        success: function(data) {
			            console.log(data);
			            $('.reader-item').remove();
			            for(let i = 0; i<data.length; i++) {
			            var memberBoard = "<li class = \"reader-item\"> " +
						"		<div class=\"post-author\">" +
						"		<span class=\"profile-radius\" style=\"background-image: url('"+data[i].profileImg+"');\"></span> " +
						"		<dl class=\"post-profile-text\"> " +
						"			<dt> " + 
						"				<strong class=\"author-name\">"+data[i].name+"</strong> " +
						"				<em class=\"author-position\">"+data[i].position+"</em> " +
						"			</dt> " +
						"			<dd> " +
						"				<strong class=\"author-company\">"+data[i].companyName+"</strong> " +
						"				<em class=\"author-department\">"+data[i].departmentName+"</em> " +
						"			</dd> " +
						"		</dl> " +
						"		<div class=\"read-section\"> " +
						"			<strong id=\"readText\">읽음</strong> " +
		        		"			<p>"+data[i].readDate.substring(0, 16)+"</p> " + 
		        		"		</div> " +
						" 	</div>" +
						" </li> ";
						$('.reader-list').each(function() {
						    if ($(this).data("category") == "read") {
						        $(this).prepend(memberBoard);
						    }
						});
						$('.read-tab-item').each(function() {
						    if ($(this).data("code") == "read") {
						        $(this).text("읽음("+data[i].readCount+")");
						    } else {
						    	 $(this).text("미확인("+data[i].nonReadCount+")");
						    }
						});
			            }	
			        },
			        error: function(r, s, e) {
			            console.log(r.status);
			            console.log(e);
			            alert("오류");
			        }
			    });
			});
			$('.read-close-btn').click(function(){
				$('.mainPop').css('display','none');
				$('.read-check').css('display','none');
			});
			$('.read-tab-item').click(function() {
			    $('.read-tab-item').removeClass('on');
			    $(this).addClass('on');
			    
			    var code = $(this).data("code");

			    if (code == 'read') {
			        $('.reader-list').each(function() {
			            if ($(this).data("category") == "read") {
			                $(this).css('display', 'block');
			            } else {
			                $(this).css('display', 'none');
			            }
			        });
			    } else {
			        $('.reader-list').each(function() {
			            if ($(this).data("category") == "not-read") {
			                $(this).css('display', 'block');
			                $.ajax({
			                    type: 'POST',
			                    url: 'BoardNotReadAjax',
			                    data: {
			                        boardIdx: boardIdx,
			                        projectIdx: <%=projectIdx%> 
			                    },
			                    success: function(data) {
			                        console.log(data);

			                        $('.reader-list').each(function() {
			                            if ($(this).data("category") == "not-read") {
			                                $(this).find('.reader-item').remove();
			                            }
			                        });

			                        for (let i = 0; i < data.length; i++) {
			                            var memberBoard = "<li class=\"reader-item\"> " +
			                                "<div class=\"post-author\">" +
			                                "<span class=\"profile-radius\" style=\"background-image: url('"+data[i].profileImg+"');\"></span>" +
			                                "<dl class=\"post-profile-text\">" +
			                                "<dt>" +
			                                "<strong class=\"author-name\">" + data[i].name + "</strong>" +
			                                "<em class=\"author-position\">" + data[i].position + "</em>" +
			                                "</dt>" +
			                                "<dd>" +
			                                "<strong class=\"author-company\">" + data[i].companyName + "</strong>" +
			                                "<em class=\"author-department\">" + data[i].departmentName + "</em>" +
			                                "</dd>" +
			                                "</dl>" +
			                                "</div>" +
			                                "</li>";

			                            $('.reader-list').each(function() {
			                                if ($(this).data("category") == "not-read") {
			                                    $(this).prepend(memberBoard);
			                                }
			                            });
			                        }
			                    },
			                    error: function(r, s, e) {
			                        console.log(r.status);
			                        console.log(e);
			                        alert("오류");
			                    }
			                });
			            } else {
			                $(this).css('display', 'none');
			            }
			        });
			    }
			});
			$(document).ready(function() {
			    $(document).on('keyup','.read-search', function() {
			        let searchMember = $('.read-search').val();
			        $('.read-tab-item').each(function() {
			            if ($(this).hasClass("on") && $(this).data("code") == "read") {
			            	$.ajax({
			            		 type: 'POST',
				                    url: 'BoardReadSearchAjax',
				                    data: {
				                        boardIdx: boardIdx,
				                        name: searchMember 
				                    },
				                    success: function(data) {
				                        console.log(data);
				                        $('.reader-item').remove();
							            for(let i = 0; i<data.length; i++) {
							            var memberBoard = "<li class = \"reader-item\"> " +
										"		<div class=\"post-author\">" +
										"		<span class=\"profile-radius\" style=\"background-image: url('"+data[i].profileImg+"');\"></span> " +
										"		<dl class=\"post-profile-text\"> " +
										"			<dt> " + 
										"				<strong class=\"author-name\">"+data[i].name+"</strong> " +
										"				<em class=\"author-position\">"+data[i].position+"</em> " +
										"			</dt> " +
										"			<dd> " +
										"				<strong class=\"author-company\">"+data[i].companyName+"</strong> " +
										"				<em class=\"author-department\">"+data[i].departmentName+"</em> " +
										"			</dd> " +
										"		</dl> " +
										"		<div class=\"read-section\"> " +
										"			<strong id=\"readText\">읽음</strong> " +
						        		"			<p>"+data[i].readDate.substring(0, 16)+"</p> " + 
						        		"		</div> " +
										" 	</div>" +
										" </li> ";
										$('.reader-list').each(function() {
										    if ($(this).data("category") == "read") {
										        $(this).prepend(memberBoard);
										    }
										});
							            }
				                    },
				                    error: function(r, s, e) {
				                        console.log(r.status);
				                        console.log(e);
				                        alert("오류");
				                    }
			            	});	
			            } else if ($(this).hasClass("on") && $(this).data("code") == "unread") {
			            	$.ajax({
			            		 type: 'POST',
				                    url: 'BoardNonReadSearchAjax',
				                    data: {
				                        boardIdx: boardIdx,
				                        name: searchMember,
				                        projectIdx: <%=projectIdx%> 
				                    },
				                    success: function(data) {
				                        console.log(data);
				                        $('.reader-list').each(function() {
				                            if ($(this).data("category") == "not-read") {
				                                $(this).find('.reader-item').remove();
				                            }
				                        });

				                        for (let i = 0; i < data.length; i++) {
				                            var memberBoard = "<li class=\"reader-item\"> " +
				                                "<div class=\"post-author\">" +
				                                "		<span class=\"profile-radius\" style=\"background-image: url('"+data[i].profileImg+"');\"></span> " +
				                                "<dl class=\"post-profile-text\">" +
				                                "<dt>" +
				                                "<strong class=\"author-name\">" + data[i].name + "</strong>" +
				                                "<em class=\"author-position\">" + data[i].position + "</em>" +
				                                "</dt>" +
				                                "<dd>" +
				                                "<strong class=\"author-company\">" + data[i].companyName + "</strong>" +
				                                "<em class=\"author-department\">" + data[i].departmentName + "</em>" +
				                                "</dd>" +
				                                "</dl>" +
				                                "</div>" +
				                                "</li>";

				                            $('.reader-list').each(function() {
				                                if ($(this).data("category") == "not-read") {
				                                    $(this).prepend(memberBoard);
				                                }
				                            });
							            }
				                    },
				                    error: function(r, s, e) {
				                        console.log(r.status);
				                        console.log(e);
				                        alert("오류");
				                    }
			            	});	
			            }
			        });
			    });
			});
			    $('.input-file-btn').click(function() {
			    	$(this).parent().find('.fileInput').click();
			    });
			    //댓글
			    $('.input-comment-box').on('keydown', function(e) {
			        if (e.keyCode === 13 && !e.shiftKey) {
			            e.preventDefault();  
			            
			            if(!$(this).hasClass('update')) {
				            if (comment !== '') {
				            var comment = $(this).html().trim();  
				            let boardIdx = $(this).parents('.feed-board').data("bno");
				                console.log('댓글 전송:', comment);
				                $.ajax({
					                type: 'POST',
					                url: 'CommentCreateAjax',
					                data: {
					                	boardIdx : boardIdx,
					                    comment: comment,
					                    memberIdx: <%=memberIdx%>
					                },
					                success: function(data) {
				                        console.log(data);
					                    location.reload();
					                },
					                error: function(r, s, e) {
				                        console.log(r.status);
				                        console.log(e);
				                        alert("오류");
				                    }
					            });
				               
				            } else {
				                console.log('댓글을 입력하세요.');
				            }
			            } else {
				            if (comment !== '') {
				            var comment = $(this).html().trim();  
				            let boardIdx = $(this).parents('.feed-board').data("bno");
				            let commentIdx = $(this).parents('.comment-content-box').data("idx");
				                console.log('댓글 전송:', comment);
				                $.ajax({
					                type: 'POST',
					                url: 'CommentUpdateAjax',
					                data: {
					                	commentIdx : commentIdx,
					                    comment: comment,
					                },
					                success: function(data) {
				                        console.log(data);
					                    location.reload();
					                },
					                error: function(r, s, e) {
				                        console.log(r.status);
				                        console.log(e);
				                        alert("오류");
				                    }
					            });
				               
				            } else {
				                console.log('댓글을 입력하세요.');
				            }
			            }
			        }
			    });
			    $('.Attendance-btn').click(function(){
			    	$(this).addClass('on');
			    	let cno = $(this).parents('.feed-board').data("cno");
			    	let finds = $(this).parents('.board-main-bottom-schedule');
			    	finds.find('.NonAttendance-btn').removeClass('on');
			    	finds.find('.Undecided-btn').removeClass('on');
			    	$.ajax({
			    		type : "Post",
			    		url : 'ScheduleAttendSelectAjax',
			    		data: {
							"memberIdx":<%=memberIdx%>,
							"str":"참석",
							"scheduleIdx":cno
						},
						success: function(data) {
							console.log(data);
							$('.feed-board-1').each(function(){
								$(this).find('.participant-state-appearance').find('.participan-cnt').text(data.Count1);
								$(this).find('.participant-state-nonappearance').find('.participan-cnt').text(data.Count2);
								$(this).find('.participant-state-Undecided').find('.participan-cnt').text(data.Count3);
								$(this).find('.participant1-img').each(function() {
							        if ($(this).data("mno") == <%=memberIdx%>) {
							            $(this).removeClass('nonappearance'); 
							            $(this).removeClass('Undecided'); 
							            $(this).addClass('Attendance'); 
							        }
							    });
							});
						},
						error: function(r, s, e) {
							console.log(r.status);
							console.log(r.responseText);
							console.log(e);
						}
			    	});
			    });
			    $('.NonAttendance-btn').click(function(){
			    	$(this).addClass('on');
			    	let cno = $(this).parents('.feed-board').data("cno");
			    	let finds = $(this).parents('.board-main-bottom-schedule');
			    	finds.find('.Attendance-btn').removeClass('on');
			    	finds.find('.Undecided-btn').removeClass('on');
			    	$.ajax({
			    		type : "Post",
			    		url : 'ScheduleAttendSelectAjax',
			    		data: {
							"memberIdx":<%=memberIdx%>,
							"str":"불참",
							"scheduleIdx":cno
						},
						success: function(data) {
							console.log(data);
							$('.feed-board-1').each(function(){
								$(this).find('.participant-state-appearance').find('.participan-cnt').text(data.Count1);
								$(this).find('.participant-state-nonappearance').find('.participan-cnt').text(data.Count2);
								$(this).find('.participant-state-Undecided').find('.participan-cnt').text(data.Count3);
								$(this).find('.participant1-img').each(function() {
							        if ($(this).data("mno") == <%=memberIdx%>) {
							            $(this).addClass('nonappearance'); 
							            $(this).removeClass('Undecided'); 
							            $(this).removeClass('Attendance'); 
							        }
							    });
							});
						},
						error: function(r, s, e) {
							console.log(r.status);
							console.log(r.responseText);
							console.log(e);
						}
			    	});
			    });
			    $('.Undecided-btn').click(function(){
			    	$(this).addClass('on');
			    	let cno = $(this).parents('.feed-board').data("cno");
			    	let finds = $(this).parents('.board-main-bottom-schedule');
			    	finds.find('.NonAttendance-btn').removeClass('on');
			    	finds.find('.Attendance-btn').removeClass('on');
			    	$.ajax({
			    		type : "Post",
			    		url : 'ScheduleAttendSelectAjax',
			    		data: {
							"memberIdx":<%=memberIdx%>,
							"str":"미정",
							"scheduleIdx":cno
						},
						success: function(data) {
							console.log(data);
							$('.feed-board-1').each(function(){
								$(this).find('.participant-state-appearance').find('.participan-cnt').text(data.Count1);
								$(this).find('.participant-state-nonappearance').find('.participan-cnt').text(data.Count2);
								$(this).find('.participant-state-Undecided').find('.participan-cnt').text(data.Count3);
								$(this).find('.participant1-img').each(function() {
							        if ($(this).data("mno") == <%=memberIdx%>) {
							            $(this).removeClass('nonappearance'); 
							            $(this).addClass('Undecided'); 
							            $(this).removeClass('Attendance'); 
							        }
							    });
							});
						},
						error: function(r, s, e) {
							console.log(r.status);
							console.log(r.responseText);
							console.log(e);
						}
			    	});
			    });
			    //채팅
			    $(document).click(function(event) {
				    if (!$(event.target).closest('.side-chat').length && 
				        !$(event.target).is('#chat') && 
				        !$(event.target).closest('.invite-chat-section').length) {
				        
				        $('.chatTab').addClass('on');
				        $('.contactTab').removeClass('on');
				        $('#ChatUl').css('display', 'block');
				        $('.chat-search').val('');
				        $('#ContactUl').css('display', 'none');
				        $('.side-chat').hide();
				    }
				});
			    $('.chat-search').on('keypress', function(e) {
			    	if($('.chatTab').hasClass('on')) {
				        if (e.which === 13) {
				            e.preventDefault(); 
				            const keyword = $(this).val();
				            $('#ChatUl').find('.chatting-item').remove();
				            $.ajax({
				            	type : "post",
				            	url : "ChatSearchAJAX",
				            	data : {
				            		search : keyword,
				            		memberIdx : <%=memberIdx%>
				            	},
				            	success: function(data) {
				    				console.log(data);
					                for(let i = 0; i<data.length; i++) {
					                	let search = "<li class = \"chatting-item\" data-chno = "+data[i].chatRoomIdx+">"+
													"		<div class = \"chatting-item-main\">"+
													"		<div class = \"chatting-room-img\">"+
													"			<div class = \"profile-img\" style = \"background-image: url('https://team-0aanf8.flow.team/flowImg/FLOW_202104235852152_d5111f66-1d9c-4806-bdff-bbcde78d0546.png?width=400&height=400'), url('https://team-0aanf8.flow.team/flowImg/FLOW_202104235852152_d5111f66-1d9c-4806-bdff-bbcde78d0546.png'), url('/flow-renewal/assets/images/profile-default.svg');\"></div>"+
													"		</div>"+
													"		<div class = \"chatting-room-author\">"+
													"			<p>"+
													"				<strong class = \"chat-title\">"+data[i].chatRoomName+"</strong>"+
													"				<span class = \"chat-count\" style = \"display:none\"></span>"+
													"			</p>"+
													"			<p class = \"chat-author-gray\">"+
													"				<span class = \"last-chat\">"+data[i].Conversation+"</span>"+
													"			</p>"+
													"		</div>"+
													"		<div class = \"Chatting-room-more-setting\">"+
													"			<div class = \"last-chat-date\">"+data[i].amPm+" "+data[i].time+"</div>"+
													"		</div>"+
													"	</div>"+
												"	</li>";
												$('#ChatUl').append(search);
					                }
				    			},
				    			error: function(r, s, e) {
					                console.log(r.status);
					                console.log(e);
					                alert("오류");
					            }
				            });
				        }
			    	} else if($('.contactTab').hasClass('on')) {
			    		 if (e.which === 13) {
					            e.preventDefault(); 
					            const keyword = $(this).val();
					            $('#ContactUl').find('.participant-item').remove();
					            $.ajax({
					            	type : "post",
					            	url : "ChatMemberSearchAJAX",
					            	data : {
					            		search : keyword,
					            		memberIdx : <%=memberIdx%>,
					            		companyIdx : <%=companyIdx%>
					            	},
					            	success: function(data) {
					    				console.log(data);
					    				for(let i = 0; i<data.length; i++) {
					    					let search = "<li class = \"participant-item\" data-mno = "+data[i].memberIdx+">"+
														"			<div class = \"posts-author\">"+
														"			<span class=\"profile-img\" style=\"background-image: url('"+data[i].url+"');\"></span>"+
														"			<dl class=\"post-author-info\">"+
														"                <dt>"+
														"                    <strong class=\"post-name\">"+data[i].name+"</strong>"+
														"                    <em class=\"position\">"+data[i].position+"</em>"+
														"                </dt>"+
														"                <dd>"+
														 "                   <strong class=\"company-name\">"+data[i].companyName+"</strong>"+
														 "                   <span class=\"department-name\">"+data[i].departmentName+"</span>"+
														 "               </dd>"+
														 "           </dl>"+
														"		</div>"+
														"		<button class = \"participant-chat-button\">"+
														"			<i class = \"chat-img\></i>"+
														"		</button>"+
														"	</li>";
											$('#ContactUl').append(search);
					    				}
					    			},
					    			error: function(r, s, e) {
						                console.log(r.status);
						                console.log(e);
						                alert("오류");
						            }
					            });
					        }
			    	}
			    });
				$('#chat').click(function(event) {
					if($('.side-chatting-room').css('display') == 'block') {
						$('.side-chatting-room').css('display','none');
						$('.Chat-more-menu-layer').css('display','none');
						$('.Chat-Setting-layer').css('display','none');
					}
				    $('.side-chat').show(); 
				    event.stopPropagation();  
				});
				
				$('.side-chat').click(function(event) {
				    event.stopPropagation(); 
				});
				$('.side-chat-menu-close').click(function(){
					$('.chatTab').addClass('on');
					$('.contactTab').removeClass('on');
			    	$('#ChatUl').css('display','block');
			    	$('.chat-search').val('');
					$('#ContactUl').css('display','none');
			    	$('.side-chat').hide();
				});
				let chatName;
				$('#ChatUl').on('click','.chatting-item',function(){
			        let chno = $(this).data("chno");
			        $.ajax({
			        	type : "post",
			        	url : "ChattingRoomContentsAjax",
			        	data : {
			        		chatRoomIdx : chno,
			        		companyIdx : <%=companyIdx%>
			        	},
			        	success: function(data) {
				            console.log(data);
				        $('.chat-participants-item').remove();
				        $('.message-item').remove();
				        $('.side-chat').css('display', 'none');
				        $('.side-chatting-room').css('display', 'block');
				        $('.side-chatting-room').attr('data-chno', chno);
				        $('.side-chatting-room').attr('data-pno', data.projectIdx);
				        $('.Chat-name').text(data.chatRoomName);
				        $('.setting-chat-Name').text(data.chatRoomName);
				        $('.change-chat-title-input').val(data.chatRoomName);
				        chatName = data.chatRoomName;
				        $('.chat-room-member-count').text(data.count);
				        if(data.projectIdx != 0) {
				        	$('.ChatInviteButton').text('프로젝트 바로가기');
				        } else {
				        	$('.ChatInviteButton').text('초대하기');
				        }
				        $('.chat-participant-count').text('('+data.count+')');
					        for(let i = 0; i<data.array1.length; i++) {
					        	let Profile = "<li class=\"chat-participants-item\" data-mno = "+data.array1[i].memberIdx+">"+
												 "		<div class=\"chat-post-author\">"+
												 "		<span class=\"chat-profile-radius\" style=\"background-image: url('"+data.array1[i].profileImg+"');\"></span>"+
												 "		<dl class=\"chat-post-profile-text\" style=\"width : 180px;\">"+
												 "			<dt>"+
												 "				<strong class=\"chat-author-name\">"+data.array1[i].name+"</strong>"+
												"				<em class=\"chat-author-position\">"+data.array1[i].position+"</em>"+
												 "			</dt>"+
												"			<dd>"+
												"				<strong class=\"chat-author-company\">"+data.array1[i].companyName+"</strong>"+
												"				<em class=\"chat-author-department\">"+data.array1[i].departmentName+"</em>"+
												"			</dd>"+
												"		</dl>"+
												"	</div>"+
												"	<div class=\"chat-participants-more-btn\">"+
												"		<button class=\"chat-btn-icon\"></button>"+
												"	</div>"+
												" </li>";
												$('.chat-participants-list').append(Profile);
					        }
					        for(let i = 0; i<data.array4.length; i++) {
					        	let chat;
					        	$('.chat-date span').text(data.array4[0].InputDate);
					        	if(data.array4[i].WriterIdx != <%=memberIdx%>) {
					        		chat = "<li class=\"message-item left-section\" data-cno = "+data.array4[i].ChatIdx+">"+
											"	<div class=\"chat-left\">"+
											"		<div class=\"chat-text-write\">"+
											"			<div class=\"left-box\">"+
											"				<div class=\"chat-text\">"+
											"					<div class=\"chat-value\">"+data.array4[i].Conversation+"</div>"+
											"				</div>"+
											"			</div>"+
											"			<div class=\"left-box\">"+
											"				<div class=\"chat-btns\" style=\"display:inline-block\"> "+
											"					<div class=\"chat-btns-bottom\"> "+
											"						<div class=\"chat-user-time\">"+data.array4[i].InputDateTime+"</div> "+
											"					</div> "+
											"				</div> "+
											"			</div> "+
											"		</div> "+
											"	</div> "+
											" </li>";
					        	} else {
					        		chat = "<li class=\"message-item right-section\" data-cno = "+data.array4[i].ChatIdx+">"+
											"	<div class=\"chat-right\">"+
											"		<div class=\"chat-text-write\">"+
											"			<div class=\"right-box\">"+
											"				<div class=\"chat-text\">"+
											"					<div class=\"chat-value\">"+data.array4[i].Conversation+"</div>"+
											"				</div>"+
											"			</div>"+
											"			<div class=\"right-box\">"+
											"				<div class=\"chat-btns\" style=\"display:inline-block\">"+
											"					<div class=\"chat-btns-bottom\">"+
											"						<div class=\"chat-user-time\">"+data.array4[i].InputDateTime+"</div>"+
											"					</div> "+
											"				</div> "+
											"			</div> "+
											"		</div> "+
											"	</div> "+
											" </li>";
					        	}
					        	$('.chatting-room-message').append(chat);
					        	
						        if(data.array4[i].DateComparison == 'Y') {
						        	let date = "<div class=\"chat-date\">"
											"		<span>"+data.array4[i].InputDate+"</span>"
											"	</div>";
						        	$('.chatting-room-message').append(date);
						        } else {
						        	
						        }
						        var chatRoomMessage = $('.chatting-room-message')[0];
						        chatRoomMessage.scrollTop = chatRoomMessage.scrollHeight;
					        }
			        	},
			        	error: function(r, s, e) {
			                console.log(r.status);
			                console.log(e);
			                alert("오류");
			            }
			        });
			    });
			    $(document).click(function(e) {
			        if (!$(e.target).closest('.side-chatting-room').length && !$(e.target).closest('.chatting-item-main').length) {
			            $('.side-chatting-room').css('display', 'none'); 
			        }
			    });
			    $('.side-chatting-room').click(function(e) {
			        e.stopPropagation(); 
			    });
				$('.chatBtn').click(function(){
					$('.chatTab').addClass('on');
					$('.contactTab').removeClass('on');
					$('#ChatUl').css('display','block');
					$('#ContactUl').css('display','none');
				});
				$('.contactBtn').click(function(){
					$('.chatTab').removeClass('on');
					$('.contactTab').addClass('on');
					$('#ChatUl').css('display','none');
					$('#ContactUl').css('display','block');
				});
			    let chatCount = 0;
				let chatmnoValues = [];
			    //새채팅 생성
			    $('.new-chat-create-btn').click(function(){
			    	$('.mainPop').css('display','block');
			    	$('.invite-chat-section').css('display','block');
			    	$('.invite-member-items').removeClass('active');
			  		$('.task-manager-name').each(function(){
				    		$(this).remove();
			        });
			  		chatmnoValues = [];
			        chatCount=0;  // 카운트 감소
			        $('.board-manager-selected-count').text(chatCount+"건 선택");
			        if(chatCount == 0) {
			        	$('.chatinviteMemberListNull').css('display','block');
			        	$('.chat-invite-selected-num').css('display','none');
			        	$('.inviteTargetList').css('display','none');
			        }
			    });
			    $('.invite-chat-close').click(function(){
			    	$('.invitechatSearchBox').val("");
			    	$('.mainPop').css('display','none');
			    	$('.invite-chat-section').css('display','none');
			    	$('.invite-member-items').removeClass('active');
			  		$('.task-manager-name').each(function(){
				    		$(this).remove();
			        });
			  		chatmnoValues = [];
			        chatCount=0;  
			        $('.board-manager-selected-count').text(chatCount+"건 선택");
			        if(chatCount == 0) {
			        	$('.chatinviteMemberListNull').css('display','block');
			        	$('.chat-invite-selected-num').css('display','none');
			        	$('.inviteTargetList').css('display','none');
			        }
			        var enterEvent = new KeyboardEvent('keyup', {
			            bubbles: true,
			            cancelable: true,
			            key: 'Enter',
			            keyCode: 13, 
			            code: 'Enter',
			            which: 13
			        });
			        
			        $('.invitechatSearchBox')[0].dispatchEvent(enterEvent);
			        $('.invite-chat-employees').addClass('on');
			    	$('.invite-chat-outsider').removeClass('on');
			    	$('.chat-invite-employees').css('display','block');
			    	$('.chat-invite-outsider').css('display','none');
			        $('.invitechatSearchBox')[0].dispatchEvent(enterEvent);
			    });
			    $('.chatreturnMainbtn').click(function(){
			    	$('.invitechatSearchBox').val("");
			    	$('.mainPop').css('display','none');
			    	$('.invite-chat-section').css('display','none');
			    	$('.invite-member-items').removeClass('active');
			  		$('.task-manager-name').each(function(){
				    		$(this).remove();
			        });
			  		chatmnoValues = [];
			        chatCount=0;  
			        $('.board-manager-selected-count').text(chatCount+"건 선택");
			        if(chatCount == 0) {
			        	$('.chatinviteMemberListNull').css('display','block');
			        	$('.chat-invite-selected-num').css('display','none');
			        	$('.inviteTargetList').css('display','none');
			        }
			        var enterEvent = new KeyboardEvent('keyup', {
			            bubbles: true,
			            cancelable: true,
			            key: 'Enter',
			            keyCode: 13, 
			            code: 'Enter',
			            which: 13
			        });
			        
			        $('.invitechatSearchBox')[0].dispatchEvent(enterEvent);
			        $('.invite-chat-employees').addClass('on');
			    	$('.invite-chat-outsider').removeClass('on');
			    	$('.chat-invite-employees').css('display','block');
			    	$('.chat-invite-outsider').css('display','none');
			        $('.invitechatSearchBox')[0].dispatchEvent(enterEvent);
			    });
			    $('.invite-chat-outsider').click(function(){
			    	$('.invite-chat-employees').removeClass('on');
			    	$('.invite-chat-outsider').addClass('on');
			    	$('.chat-invite-employees').css('display','none');
			    	$('.chat-invite-outsider').css('display','block');
			    });
			    $('.invite-chat-employees').click(function(){
			    	$('.invite-chat-employees').addClass('on');
			    	$('.invite-chat-outsider').removeClass('on');
			    	$('.chat-invite-employees').css('display','block');
			    	$('.chat-invite-outsider').css('display','none');
			    });
			  //채팅 등록및 삭제
				$(document).on('click', '.invite-member-items', function() {
					let memberIdx = $(this).data("mno");
					let name = $(this).find('.author-name').text();
					let mno = $(this).data("mno");
				    if (!$(this).hasClass('active')) {
				        $(this).addClass('active');
				        chatCount++;
				        chatmnoValues.push(mno);
				       	$('.project-select-member-count').text(chatCount+"건 선택");
				        if(chatCount > 0) {
				        	$('.chatinviteMemberListNull').css('display','none');
				        	$('.chat-invite-selected-num').css('display','block');
				        	$('.inviteTargetList').css('display','block');
				        }
				        let ManagerList = " <li class = \"task-manager-name\" data-mno="+memberIdx+">" +
				        " <span class = \"task-manager-img\" id = \"task-manager-img2\"></span>" +
				        " <span class = \"task-manager-value\">"+name+"</span>" +
				        " <button class = \"manager-remove-btn\"></button> " +
						" </li> ";
				        $('.inviteTargetList').prepend(ManagerList);
				    } else {
				        $(this).removeClass('active');
				        var index = chatmnoValues.indexOf(mno); 
				        if (index !== -1) {
				        	chatmnoValues.splice(index, 1);
				        }
				        $('.task-manager-name').each(function(){
					    	if($(this).data("mno")==memberIdx) {
					    		$(this).remove();
					    	}
				        });
				        chatCount--;  // 카운트 감소
				        $('.board-manager-selected-count').text(chatCount+"건 선택");
				        if(chatCount == 0) {
				        	$('.chatinviteMemberListNull').css('display','block');
				        	$('.chat-invite-selected-num').css('display','none');
				        	$('.inviteTargetList').css('display','none');
				        }
				    }
				});
			  	$('.chat-select-member-all-delete').click(function(){
			  		$('.invite-member-items').removeClass('active');
			  		$('.task-manager-name').each(function(){
				    		$(this).remove();
			        });
			  		chatmnoValues = [];
			        chatCount=0;  // 카운트 감소
			        $('.board-manager-selected-count').text(chatCount+"건 선택");
			        if(chatCount == 0) {
			        	$('.chatinviteMemberListNull').css('display','block');
			        	$('.chat-invite-selected-num').css('display','none');
			        	$('.inviteTargetList').css('display','none');
			        }
			  	});
			  	$(document).ready(function() {
				    $(document).on('keyup','.invitechatSearchBox', function() {
					    if($('.invite-chat-outsider').hasClass('on')) {
				    	let text = $(this).val();
				    	let chatmnoValues = []; 
					    $('.task-manager-name').each(function() {
					        var mno = $(this).data('mno');
					        chatmnoValues.push(mno);
					    });
					    $.ajax({
					    	type : "POST",
							url : "/Project/ChatOutSiderSearchAjax",
							data : {
								companyIdx : <%=companyIdx%>,
								memberIdx : <%=memberIdx%>,
					    		search : text
							},
							success: function(data) {
								$('.invite-member-items').remove();
					            console.log(data);
					            for(let i = 0; i<data.length; i++) {
						            var taskManager =  "";
						            if (chatmnoValues.includes(data[i].memberIdx)) {
						                taskManager += " <li class = \"invite-member-items active\" data-mno=" + data[i].memberIdx + ">";
						            } else {
						                taskManager += " <li class = \"invite-member-items\" data-mno=" + data[i].memberIdx + ">";
						            }
						            taskManager += " <div class = \"chat-invite-check-select\"></div>" +
						            " <div class = \"post-author\">" +
						            " <span class = \"profile-radius\" style=\"background-image: url('"+ data[i].profileImg +"');\"></span> " +
						            " <dl class = \"post-profile-text\">" +
						            " <dt> " +
									"		<strong class = \"author-name\">"+data[i].name+"</strong>" +
									"		<em class = \"author-position\">"+data[i].position+"</em>" +
									"	</dt>" +
									"	<dd>" +
									"		<strong class = \"author-company\">"+data[i].companyName+"</strong>" +
									"		<em class = \"author-department\">"+data[i].departmentName+"</em>" +
									"	</dd>" +
									" </div> " +
									" </li>";
					            	$('.chat-invite-outsider').find('.chat-invite-member-area').append(taskManager);
					            }
							},
							error: function(r, s, e) {
					            console.log(r.status);
					            console.log(e);
					            alert("오류");
					        }
					    });
				    	
				    } else if($('.invite-chat-employees').hasClass('on')) {
				    	let text = $(this).val();
				    	let chatmnoValues = []; 
					    $('.task-manager-name').each(function() {
					        var mno = $(this).data('mno');
					        chatmnoValues.push(mno);
					    });
					    $.ajax({
					    	type : "POST",
							url : "/Project/ChatCompanyMemberSearchAjax",
							data : {
								companyIdx : <%=companyIdx%>,
					    		search : text
							},
							success: function(data) {
								$('.invite-member-items').remove();
					            console.log(data);
					            for(let i = 0; i<data.length; i++) {
						            var taskManager =  "";
						            if (chatmnoValues.includes(data[i].memberIdx)) {
						                taskManager += " <li class = \"invite-member-items active\" data-mno=" + data[i].memberIdx + ">";
						            } else {
						                taskManager += " <li class = \"invite-member-items\" data-mno=" + data[i].memberIdx + ">";
						            }
						            taskManager += " <div class = \"chat-invite-check-select\"></div>" +
						            " <div class = \"post-author\">" +
						            " <span class = \"profile-radius\" style=\"background-image: url('"+ data[i].profileImg +"');\"></span> " +
						            " <dl class = \"post-profile-text\">" +
						            " <dt> " +
									"		<strong class = \"author-name\">"+data[i].name+"</strong>" +
									"		<em class = \"author-position\">"+data[i].position+"</em>" +
									"	</dt>" +
									"	<dd>" +
									"		<strong class = \"author-company\">"+data[i].companyName+"</strong>" +
									"		<em class = \"author-department\">"+data[i].departmentName+"</em>" +
									"	</dd>" +
									" </div> " +
									" </li>";
									$('.chat-invite-employees').find('.chat-invite-member-area').append(taskManager);
					            }
							},
							error: function(r, s, e) {
					            console.log(r.status);
					            console.log(e);
					            alert("오류");
					        }
					    });
				    }
				   });
			   });
			  	
			  	//채팅방 생성
			  	$('.chatinviteSubmitbtn').click(function(){
	  		if(chatCount>=3) {
		  		$.ajax({
			    	type : "POST",
					url : "/Project/CreateChatAjax",
					data : {
						chatmnoValues : JSON.stringify(chatmnoValues),
						MemberIdx : <%=memberIdx%>
					},
					success: function(data) {
						 console.log(data);
						 	$('.task-manager-name').remove();
							$('.invite-chat-section').css('display','none');
							$('.mainPop').css('display','none');
						    $('.invite-member-item').removeClass('active');
						    chatCount = 0;
						    chatmnoValues = [];
						    $('.board-manager-selected-count').text(chatCount+"건 선택");
				        	$('.chatinviteMemberListNull').css('display','block');
				        	$('.chat-invite-selected-num').css('display','none');
				        	$('.inviteTargetList').css('display','none');
				        	$('.invitechatSearchBox').val('');
				        	 var enterEvent = new KeyboardEvent('keyup', {
				 	            bubbles: true,
				 	            cancelable: true,
				 	            key: 'Enter',
				 	            keyCode: 13, 
				 	            code: 'Enter',
				 	            which: 13
				 	        });
				 	        $('.invitechatSearchBox')[0].dispatchEvent(enterEvent);
				 	        $('.invite-chat-employees').addClass('on');
				 	    	$('.invite-chat-outsider').removeClass('on');
				 	    	$('.chat-invite-employees').css('display','block');
				 	    	$('.chat-invite-outsider').css('display','none');
				 	        $('.invitechatSearchBox')[0].dispatchEvent(enterEvent);
				 	       $('.Chat-more-menu-layer').css('display','none');
				        	$('.chatting-item').remove();
				        	$('.chat-participants-item').remove();
					        $('.message-item').remove();
					        $('.side-chat').css('display', 'none');
					        $('.side-chatting-room').css('display', 'block');
					        $('.side-chatting-room').attr('data-chno', data.chatRoomIdx);
					        $('.Chat-name').text(data.chatRoomName);
					        $('.setting-chat-Name').text(data.chatRoomName);
					        $('.change-chat-title-input').val(data.chatRoomName);
					        chatName = data.chatRoomName;
					        $('.chat-room-member-count').text(data.count);
					        $('.ChatInviteButton').text('초대하기');
					        $('.chat-participant-count').text('('+data.count+')');
						        for(let i = 0; i<data.array1.length; i++) {
						        	let Profile = "<li class=\"chat-participants-item\" data-mno = "+data.array1[i].memberIdx+">"+
													 "		<div class=\"chat-post-author\">"+
													 "		<span class=\"chat-profile-radius\" style=\"background-image: url('"+data.array1[i].profileImg+"');\"></span>"+
													 "		<dl class=\"chat-post-profile-text\" style=\"width : 180px;\">"+
													 "			<dt>"+
													 "				<strong class=\"chat-author-name\">"+data.array1[i].name+"</strong>"+
													"				<em class=\"chat-author-position\">"+data.array1[i].position+"</em>"+
													 "			</dt>"+
													"			<dd>"+
													"				<strong class=\"chat-author-company\">"+data.array1[i].companyName+"</strong>"+
													"				<em class=\"chat-author-department\">"+data.array1[i].departmentName+"</em>"+
													"			</dd>"+
													"		</dl>"+
													"	</div>"+
													"	<div class=\"chat-participants-more-btn\">"+
													"		<button class=\"chat-btn-icon\"></button>"+
													"	</div>"+
													" </li>";
													$('.chat-participants-list').append(Profile);
						        }
						        for(let i = 0; i<data.array2.length; i++) {
						        	let chat = "<li class = \"chatting-item\" data-chno = "+data.array2[i].chatRoomIdx+">"+
												"	<div class = \"chatting-item-main\">"+
												"		<div class = \"chatting-room-img\">"+
												"			<div class = \"profile-img\" style = \"background-image: url('https://team-0aanf8.flow.team/flowImg/FLOW_202104235852152_d5111f66-1d9c-4806-bdff-bbcde78d0546.png?width=400&height=400'), url('https://team-0aanf8.flow.team/flowImg/FLOW_202104235852152_d5111f66-1d9c-4806-bdff-bbcde78d0546.png'), url('/flow-renewal/assets/images/profile-default.svg');\"></div>"+
												"		</div>"+
												"		<div class = \"chatting-room-author\">"+
												"			<p>"+
												"				<strong class = \"chat-title\">"+data.array2[i].chatRoomName+"</strong>"+
												"				<span class = \"chat-count\" style = \"display:none\"></span>"+
												"			</p>"+
												"			<p class = \"chat-author-gray\">"+
												"				<span class = \"last-chat\">"+data.array2[i].Conversation+"</span>"+
												"			</p>"+
												"		</div>"+
												"		<div class = \"Chatting-room-more-setting\">"+
															" </div> "+
														"	<div class = \"last-chat-date\">"+data.array2[i].amPm+" "+data.array2[i].time+"</div> "+
													"	</div> "+
												"	</div> "+
											"	</li> ";
											$('#ChatUl').append(chat);
						        }
						        for(let i = 0; i<data.array4.length; i++) {
						        	let chat;
						        	$('.chat-date span').text(data.array4[0].InputDate);
						        	if(data.array4[i].WriterIdx != <%=memberIdx%>) {
						        		chat = "<li class=\"message-item left-section\" data-cno = "+data.array4[i].ChatIdx+">"+
												"	<div class=\"chat-left\">"+
												"		<div class=\"chat-text-write\">"+
												"			<div class=\"left-box\">"+
												"				<div class=\"chat-text\">"+
												"					<div class=\"chat-value\">"+data.array4[i].Conversation+"</div>"+
												"				</div>"+
												"			</div>"+
												"			<div class=\"left-box\">"+
												"				<div class=\"chat-btns\" style=\"display:inline-block\"> "+
												"					<div class=\"chat-btns-bottom\"> "+
												"						<div class=\"chat-user-time\">"+data.array4[i].InputDateTime+"</div> "+
												"					</div> "+
												"				</div> "+
												"			</div> "+
												"		</div> "+
												"	</div> "+
												" </li>";
						        	} else {
						        		chat = "<li class=\"message-item right-section\" data-cno = "+data.array4[i].ChatIdx+">"+
												"	<div class=\"chat-right\">"+
												"		<div class=\"chat-text-write\">"+
												"			<div class=\"right-box\">"+
												"				<div class=\"chat-text\">"+
												"					<div class=\"chat-value\">"+data.array4[i].Conversation+"</div>"+
												"				</div>"+
												"			</div>"+
												"			<div class=\"right-box\">"+
												"				<div class=\"chat-btns\" style=\"display:inline-block\">"+
												"					<div class=\"chat-btns-bottom\">"+
												"						<div class=\"chat-user-time\">"+data.array4[i].InputDateTime+"</div>"+
												"					</div> "+
												"				</div> "+
												"			</div> "+
												"		</div> "+
												"	</div> "+
												" </li>";
						        	}
						        	$('.chatting-room-message').append(chat);
							        if(data.array4[i].DateComparison == 'Y') {
							        	let date = "<div class=\"chat-date\">"
												"		<span>"+data.array4[i].InputDate+"</span>"
												"	</div>";
							        	$('.chatting-room-message').append(date);
							        } else {
							        	
							        }
						        }
					},
					error: function(r, s, e) {
			            console.log(r.status);
			            console.log(e);
			            alert("오류");
			        }
			    });
	  		} else {
	  			alert("3인 이상 선택하십시오.");
	  		}
	  	});
			  	$(document).click(function(event) {
			  	    if (!$(event.target).closest('.Chat-more-menu-area').length) {
			  	        $('.Chat-more-menu-layer').css('display', 'none');
			  	    }
			  	});
			  	$('.chat-room-more-btn').click(function(event) {
			  	    $('.Chat-more-menu-layer').css('display', 'block');
			  	});
			  	$('.Chat-more-menu-background').click(function() {
			  	    $('.Chat-more-menu-layer').css('display', 'none');
			  	});
			  	$('.Chat-Setting-background').click(function() {
			  	    $('.Chat-Setting-layer').css('display', 'none');
			  	});
			  	$('.Chat-room-Setting-btn').click(function(){
			  		$('.Chat-more-menu-layer').css('display','none');
			  		$('.Chat-Setting-layer').css('display','block');
			  	});
			  	//채팅방이름변경창 출력 
			  	$('.setting-chat-Name-change').click(function(){
			  		$('.chatting-back-area').css('display','block');
			  		$('.change-chat-title-box').css('display','block');
			  	});
			  	$('.change-chat-title-close').click(function(){
			  		$('.chatting-back-area').css('display','none');
			  		$('.change-chat-title-box').css('display','none');
			  		$('.change-chat-title-input').val(chatName);
			  	});
			  	$('.change-chat-title-cancle').click(function(){
			  		$('.chatting-back-area').css('display','none');
			  		$('.change-chat-title-box').css('display','none');
			  		$('.change-chat-title-input').val(chatName);
			  	});
			  	let webSocket;
			  	let reconnectInterval = 5000; // 재연결 시도 간격 (5초)

			  	function connectWebSocket() {
			  	    // WebSocket 연결
			  	   webSocket = new WebSocket("ws://114.207.245.107:9090//Project/Broadcasting");

			  	    // WebSocket 연결이 열린 경우
			  	    webSocket.onopen = function() {
			  	        console.log("WebSocket 연결이 열렸습니다.");
			  	    };

			  	    // WebSocket 메시지 수신 시 처리
			  	    webSocket.onmessage = function(e) {
			  	        let data = JSON.parse(e.data); 
			  	        console.log(data);

			  	        // 서버에서 보낸 메시지 처리 (내가 보낸 메시지는 제외)
			  	        if (data.chatIdx && data.Conversation) {
			  	            let chat;
			  	            // 내가 보낸 메시지인지 다른 사람이 보낸 메시지인지 memberIdx로 구분
			  	            if (data.memberIdx === <%= memberIdx %>) { // 현재 페이지에서 memberIdx를 가져와 비교
			  	                // 내가 보낸 메시지는 오른쪽에 표시
			  	                chat = "<li class=\"message-item right-section\" data-cno=" + data.chatIdx + ">" +
			  	                    "<div class=\"chat-right\">" +
			  	                    "<div class=\"chat-text-write\">" +
			  	                    "<div class=\"right-box\">" +
			  	                    "<div class=\"chat-text\">" +
			  	                    "<div class=\"chat-value\">" + data.Conversation + "</div>" +
			  	                    "</div>" +
			  	                    "</div>" +
			  	                    "<div class=\"right-box\">" +
			  	                    "<div class=\"chat-btns\" style=\"display:inline-block\">" +
			  	                    "<div class=\"chat-btns-bottom\">" +
			  	                    "<div class=\"chat-user-time\">" + data.InputDateTime + "</div>" +
			  	                    "</div> " +
			  	                    "</div> " +
			  	                    "</div> " +
			  	                    "</div>" +
			  	                    "</div>" +
			  	                    "</li>";
			  	            } else {
			  	                // 다른 사람이 보낸 메시지는 왼쪽에 표시
			  	                chat = "<li class=\"message-item left-section\" data-cno=" + data.chatIdx + ">" +
			  	                    "<div class=\"chat-left\">" +
			  	                    "<div class=\"chat-text-write\">" +
			  	                    "<div class=\"left-box\">" +
			  	                    "<div class=\"chat-text\">" +
			  	                    "<div class=\"chat-value\">" + data.Conversation + "</div>" +
			  	                    "</div>" +
			  	                    "</div>" +
			  	                    "<div class=\"left-box\">" +
			  	                    "<div class=\"chat-btns\" style=\"display:inline-block\">" +
			  	                    "<div class=\"chat-btns-bottom\">" +
			  	                    "<div class=\"chat-user-time\">" + data.InputDateTime + "</div>" +
			  	                    "</div> " +
			  	                    "</div> " +
			  	                    "</div> " +
			  	                    "</div>" +
			  	                    "</div>" +
			  	                    "</li>";
			  	            }

			  	            // 채팅 메시지 화면에 추가
			  	            $('.chatting-room-message').append(chat);

			  	            // 날짜가 필요한 경우 추가 (예시)
			  	            if (data.DateComparison == 'Y') {
			  	                let date = "<div class=\"chat-date\">" +
			  	                    "<span>" + data.InputDate + "</span>" +
			  	                    "</div>";
			  	                $('.chatting-room-message').append(date);
			  	            }
			  	        }
			  	    };

			  	    // WebSocket 연결이 종료된 경우 자동 재연결 시도
			  	    webSocket.onclose = function(event) {
			  	        console.log("WebSocket 연결이 종료되었습니다. 재연결 시도...");
			  	        setTimeout(connectWebSocket, reconnectInterval); // 재연결 시도 (5초 후)
			  	    };

			  	    // WebSocket 오류 처리
			  	    webSocket.onerror = function(error) {
			  	        console.log("WebSocket 오류 발생:", error);
			  	        webSocket.close(); // 오류 발생 시 연결 종료
			  	    };
			  	}

			  	// 페이지 로드 시 WebSocket 연결 시작
			  	window.onload = function() {
			  	    connectWebSocket();
			  	};

			  	$('.btn-chat-enter').click(function() {
			  	    let text = $('.create-chat-input-box').text().trim();
			  	    let chatRoomIdx = $(this).parents('.side-chatting-room').data("chno");

			  	    // WebSocket이 정의되어 있고 OPEN 상태일 때만 메시지 전송
			  	    if (text) {
			  	        if (webSocket && webSocket.readyState === WebSocket.OPEN) {
			  	            let messageData = {
			  	                chatText: text,
			  	                memberIdx: <%= memberIdx %>, // 서버에서 전달된 memberIdx
			  	                chatRoomIdx: chatRoomIdx,
			  	            };

			  	            // 서버로 메시지 전송
			  	            webSocket.send(JSON.stringify(messageData));
			  	          $('.create-chat-input-box').text('');
			  	            // 서버에서 받은 메시지를 기준으로 화면에 표시하도록 대기
			  	            // (서버가 응답한 후, 그 메시지를 화면에 바로 표시하게 될 것임)
			  	        } else {
			  	            alert("WebSocket이 연결되지 않았습니다. 잠시 후 다시 시도해주세요.");
			  	        }
			  	    } else {
			  	        alert("메시지를 입력해주세요.");
			  	    }
			  	});


			  	$('.create-chat-input-box').keypress(function(event) {
			  	    if (event.which === 13) {  
			  	        event.preventDefault();
			  	      $('.btn-chat-enter').click();
			  	    }
			  	});
			  	$('.change-chat-title-submit').click(function(){
			  		let chatRoomIdx = $('.side-chatting-room').data("chno");
			  		let text = $('.change-chat-title-input').val();
			  		if(text.length <= 0) {
			  			alert("제목을 입력하시오.");
			  		} else {
				  		$.ajax({
				  			type : "post",
				  			url : "ChatRoomNameChangeAjax",
				  			data : {
				  				chatRoomIdx : chatRoomIdx,
				  				text : text,
				  			},
				  			success: function(data) {
								 console.log(data);
								 $('.chatting-back-area').css('display','none');
							     $('.change-chat-title-box').css('display','none');
								 $('.change-chat-title-input').val(text);
								 $('.setting-chat-Name').text(text);
								 $('.Chat-name').text(text);
								 $('.chatting-item').each(function(){
									if($(this).data("chno") == chatRoomIdx) {
										$(this).find('.chat-title').text(text);
									} 
								 });
				  			},
				  			error: function(r, s, e) {
					            console.log(r.status);
					            console.log(e);
					            alert("오류");
					        }
				  		});
			  		}
			  	});
			  	$('.ChatInviteButton').click(function(){
			  		let name = $(this).text().trim();
			  		if(name == '초대하기') {
			  			
			  		} else {
			  			let pno = $('.side-chatting-room').data("pno");
			    		$.ajax ({
			    			type: 'post',
			    	        url: 'MoveprojectAjax',
			    	        data: {
			    	            pno : pno
			    	        },
			    	        success: function(data) {
			    	        	console.log(data);
			    	        	var url = "";
			    	        	if(data.hometab=="피드") {
			    	        		url = "Controller?command=FEED";
			    	        	}
								if(data.hometab=="업무") {
									url = "Controller?command=Task";    	    	        		
								}
								if(data.hometab=="캘린더") {
									
								}
								var form = $('<form>', {
				                    'action': url,
				                    'method': 'POST'
				                });

				                form.append($('<input>', {
				                    'type': 'hidden',
				                    'name': 'projectIdx',
				                    'value': pno
				                }));

				                $('body').append(form);
				                form.submit();
			    	        		
			    	        },
			    	        error: function(r, s, e) {
			    	        	console.log(r.status);
			    	        	console.log(e);
			    	        }
			    		});
			  		}
			  	});
			  	$('#ContactUl').on('click','.participant-chat-button',function(){
			  		let memberIdx = $(this).parents('.participant-item').data("mno");
			  		$.ajax({
			  			type : "post",
			  			url : "SoloChatAjax",
			  			data : {
			  				memberIdx1 : <%=memberIdx%>,
			  				memberIdx2 : memberIdx
			  			},
				  		success: function(data) {
				        	console.log(data);
				        	$('.chatting-item').remove();
				        	$('.chat-participants-item').remove();
					        $('.message-item').remove();
					        $('.side-chat').css('display', 'none');
					        $('.side-chatting-room').css('display', 'block');
					        $('.side-chatting-room').attr('data-chno', data.chatRoomIdx);
					        $('.Chat-name').text(data.chatRoomName);
					        $('.setting-chat-Name').text(data.chatRoomName);
					        $('.change-chat-title-input').val(data.chatRoomName);
					        chatName = data.chatRoomName;
					        $('.chat-room-member-count').text(data.count);
					        $('.ChatInviteButton').text('초대하기');
					        $('.chat-participant-count').text('('+data.count+')');
						        for(let i = 0; i<data.array1.length; i++) {
						        	let Profile = "<li class=\"chat-participants-item\" data-mno = "+data.array1[i].memberIdx+">"+
													 "		<div class=\"chat-post-author\">"+
													 "		<span class=\"chat-profile-radius\" style=\"background-image: url('"+data.array1[i].profileImg+"');\"></span>"+
													 "		<dl class=\"chat-post-profile-text\" style=\"width : 180px;\">"+
													 "			<dt>"+
													 "				<strong class=\"chat-author-name\">"+data.array1[i].name+"</strong>"+
													"				<em class=\"chat-author-position\">"+data.array1[i].position+"</em>"+
													 "			</dt>"+
													"			<dd>"+
													"				<strong class=\"chat-author-company\">"+data.array1[i].companyName+"</strong>"+
													"				<em class=\"chat-author-department\">"+data.array1[i].departmentName+"</em>"+
													"			</dd>"+
													"		</dl>"+
													"	</div>"+
													"	<div class=\"chat-participants-more-btn\">"+
													"		<button class=\"chat-btn-icon\"></button>"+
													"	</div>"+
													" </li>";
													$('.chat-participants-list').append(Profile);
						        }
						        for(let i = 0; i<data.array2.length; i++) {
						        	let chat = "<li class = \"chatting-item\" data-chno = "+data.array2[i].chatRoomIdx+">"+
												"	<div class = \"chatting-item-main\">"+
												"		<div class = \"chatting-room-img\">"+
												"			<div class = \"profile-img\" style = \"background-image: url('https://team-0aanf8.flow.team/flowImg/FLOW_202104235852152_d5111f66-1d9c-4806-bdff-bbcde78d0546.png?width=400&height=400'), url('https://team-0aanf8.flow.team/flowImg/FLOW_202104235852152_d5111f66-1d9c-4806-bdff-bbcde78d0546.png'), url('/flow-renewal/assets/images/profile-default.svg');\"></div>"+
												"		</div>"+
												"		<div class = \"chatting-room-author\">"+
												"			<p>"+
												"				<strong class = \"chat-title\">"+data.array2[i].chatRoomName+"</strong>"+
												"				<span class = \"chat-count\" style = \"display:none\"></span>"+
												"			</p>"+
												"			<p class = \"chat-author-gray\">"+
												"				<span class = \"last-chat\">"+data.array2[i].Conversation+"</span>"+
												"			</p>"+
												"		</div>"+
												"		<div class = \"Chatting-room-more-setting\">"+
															" </div> "+
														"	<div class = \"last-chat-date\">"+data.array2[i].amPm+" "+data.array2[i].time+"</div> "+
													"	</div> "+
												"	</div> "+
											"	</li> ";
											$('#ChatUl').append(chat);
						        }
						        for(let i = 0; i<data.array4.length; i++) {
						        	let chat;
						        	$('.chat-date span').text(data.array4[0].InputDate);
						        	if(data.array4[i].WriterIdx != <%=memberIdx%>) {
						        		chat = "<li class=\"message-item left-section\" data-cno = "+data.array4[i].ChatIdx+">"+
												"	<div class=\"chat-left\">"+
												"		<div class=\"chat-text-write\">"+
												"			<div class=\"left-box\">"+
												"				<div class=\"chat-text\">"+
												"					<div class=\"chat-value\">"+data.array4[i].Conversation+"</div>"+
												"				</div>"+
												"			</div>"+
												"			<div class=\"left-box\">"+
												"				<div class=\"chat-btns\" style=\"display:inline-block\"> "+
												"					<div class=\"chat-btns-bottom\"> "+
												"						<div class=\"chat-user-time\">"+data.array4[i].InputDateTime+"</div> "+
												"					</div> "+
												"				</div> "+
												"			</div> "+
												"		</div> "+
												"	</div> "+
												" </li>";
						        	} else {
						        		chat = "<li class=\"message-item right-section\" data-cno = "+data.array4[i].ChatIdx+">"+
												"	<div class=\"chat-right\">"+
												"		<div class=\"chat-text-write\">"+
												"			<div class=\"right-box\">"+
												"				<div class=\"chat-text\">"+
												"					<div class=\"chat-value\">"+data.array4[i].Conversation+"</div>"+
												"				</div>"+
												"			</div>"+
												"			<div class=\"right-box\">"+
												"				<div class=\"chat-btns\" style=\"display:inline-block\">"+
												"					<div class=\"chat-btns-bottom\">"+
												"						<div class=\"chat-user-time\">"+data.array4[i].InputDateTime+"</div>"+
												"					</div> "+
												"				</div> "+
												"			</div> "+
												"		</div> "+
												"	</div> "+
												" </li>";
						        	}
						        	$('.chatting-room-message').append(chat);
							        if(data.array4[i].DateComparison == 'Y') {
							        	let date = "<div class=\"chat-date\">"
												"		<span>"+data.array4[i].InputDate+"</span>"
												"	</div>";
							        	$('.chatting-room-message').append(date);
							        } else {
							        	
							        }
						        }
				  		},
		  				error: function(r, s, e) {
		    	        	console.log(r.status);
		    	        	console.log(e);
		    	        }
			  		});
			  	});
			  	$('.chat-participants-list').on('click','.chat-btn-icon',function(){
			  		let memberIdx = $(this).parents('.chat-participants-item').data("mno");
			  		$.ajax({
			  			type : "post",
			  			url : "SoloChatAjax",
			  			data : {
			  				memberIdx1 : <%=memberIdx%>,
			  				memberIdx2 : memberIdx
			  			},
				  		success: function(data) {
				        	console.log(data);
				        	$('.Chat-more-menu-layer').css('display','none');
				        	$('.chatting-item').remove();
				        	$('.chat-participants-item').remove();
					        $('.message-item').remove();
					        $('.side-chat').css('display', 'none');
					        $('.side-chatting-room').css('display', 'block');
					        $('.side-chatting-room').attr('data-chno', data.chatRoomIdx);
					        $('.Chat-name').text(data.chatRoomName);
					        $('.setting-chat-Name').text(data.chatRoomName);
					        $('.change-chat-title-input').val(data.chatRoomName);
					        chatName = data.chatRoomName;
					        $('.chat-room-member-count').text(data.count);
					        $('.ChatInviteButton').text('초대하기');
					        $('.chat-participant-count').text('('+data.count+')');
						        for(let i = 0; i<data.array1.length; i++) {
						        	let Profile = "<li class=\"chat-participants-item\" data-mno = "+data.array1[i].memberIdx+">"+
													 "		<div class=\"chat-post-author\">"+
													 "		<span class=\"chat-profile-radius\" style=\"background-image: url('"+data.array1[i].profileImg+"');\"></span>"+
													 "		<dl class=\"chat-post-profile-text\" style=\"width : 180px;\">"+
													 "			<dt>"+
													 "				<strong class=\"chat-author-name\">"+data.array1[i].name+"</strong>"+
													"				<em class=\"chat-author-position\">"+data.array1[i].position+"</em>"+
													 "			</dt>"+
													"			<dd>"+
													"				<strong class=\"chat-author-company\">"+data.array1[i].companyName+"</strong>"+
													"				<em class=\"chat-author-department\">"+data.array1[i].departmentName+"</em>"+
													"			</dd>"+
													"		</dl>"+
													"	</div>"+
													"	<div class=\"chat-participants-more-btn\">"+
													"		<button class=\"chat-btn-icon\"></button>"+
													"	</div>"+
													" </li>";
													$('.chat-participants-list').append(Profile);
						        }
						        for(let i = 0; i<data.array2.length; i++) {
						        	let chat = "<li class = \"chatting-item\" data-chno = "+data.array2[i].chatRoomIdx+">"+
												"	<div class = \"chatting-item-main\">"+
												"		<div class = \"chatting-room-img\">"+
												"			<div class = \"profile-img\" style = \"background-image: url('https://team-0aanf8.flow.team/flowImg/FLOW_202104235852152_d5111f66-1d9c-4806-bdff-bbcde78d0546.png?width=400&height=400'), url('https://team-0aanf8.flow.team/flowImg/FLOW_202104235852152_d5111f66-1d9c-4806-bdff-bbcde78d0546.png'), url('/flow-renewal/assets/images/profile-default.svg');\"></div>"+
												"		</div>"+
												"		<div class = \"chatting-room-author\">"+
												"			<p>"+
												"				<strong class = \"chat-title\">"+data.array2[i].chatRoomName+"</strong>"+
												"				<span class = \"chat-count\" style = \"display:none\"></span>"+
												"			</p>"+
												"			<p class = \"chat-author-gray\">"+
												"				<span class = \"last-chat\">"+data.array2[i].Conversation+"</span>"+
												"			</p>"+
												"		</div>"+
												"		<div class = \"Chatting-room-more-setting\">"+
															" </div> "+
														"	<div class = \"last-chat-date\">"+data.array2[i].amPm+" "+data.array2[i].time+"</div> "+
													"	</div> "+
												"	</div> "+
											"	</li> ";
											$('#ChatUl').append(chat);
						        }
						        for(let i = 0; i<data.array4.length; i++) {
						        	let chat;
						        	$('.chat-date span').text(data.array4[0].InputDate);
						        	if(data.array4[i].WriterIdx != <%=memberIdx%>) {
						        		chat = "<li class=\"message-item left-section\" data-cno = "+data.array4[i].ChatIdx+">"+
												"	<div class=\"chat-left\">"+
												"		<div class=\"chat-text-write\">"+
												"			<div class=\"left-box\">"+
												"				<div class=\"chat-text\">"+
												"					<div class=\"chat-value\">"+data.array4[i].Conversation+"</div>"+
												"				</div>"+
												"			</div>"+
												"			<div class=\"left-box\">"+
												"				<div class=\"chat-btns\" style=\"display:inline-block\"> "+
												"					<div class=\"chat-btns-bottom\"> "+
												"						<div class=\"chat-user-time\">"+data.array4[i].InputDateTime+"</div> "+
												"					</div> "+
												"				</div> "+
												"			</div> "+
												"		</div> "+
												"	</div> "+
												" </li>";
						        	} else {
						        		chat = "<li class=\"message-item right-section\" data-cno = "+data.array4[i].ChatIdx+">"+
												"	<div class=\"chat-right\">"+
												"		<div class=\"chat-text-write\">"+
												"			<div class=\"right-box\">"+
												"				<div class=\"chat-text\">"+
												"					<div class=\"chat-value\">"+data.array4[i].Conversation+"</div>"+
												"				</div>"+
												"			</div>"+
												"			<div class=\"right-box\">"+
												"				<div class=\"chat-btns\" style=\"display:inline-block\">"+
												"					<div class=\"chat-btns-bottom\">"+
												"						<div class=\"chat-user-time\">"+data.array4[i].InputDateTime+"</div>"+
												"					</div> "+
												"				</div> "+
												"			</div> "+
												"		</div> "+
												"	</div> "+
												" </li>";
						        	}
						        	$('.chatting-room-message').append(chat);
							        if(data.array4[i].DateComparison == 'Y') {
							        	let date = "<div class=\"chat-date\">"
												"		<span>"+data.array4[i].InputDate+"</span>"
												"	</div>";
							        	$('.chatting-room-message').append(date);
							        } else {
							        	
							        }
						        }
				  		},
		  				error: function(r, s, e) {
		    	        	console.log(r.status);
		    	        	console.log(e);
		    	        }
			  		});
			  	});
				$('.m-content').on('click','.m-chat',function(){
					let memberIdx = $(this).parents(".member-body").data("mno");
			  		$.ajax({
			  			type : "post",
			  			url : "SoloChatAjax",
			  			data : {
			  				memberIdx1 : <%=memberIdx%>,
			  				memberIdx2 : memberIdx
			  			},
				  		success: function(data) {
				        	console.log(data);
				        	$('.chatting-item').remove();
				        	$('.chat-participants-item').remove();
					        $('.message-item').remove();
					        $('.side-chat').css('display', 'none');
					        $('.side-chatting-room').css('display', 'block');
					        $('.side-chatting-room').attr('data-chno', data.chatRoomIdx);
					        $('.Chat-name').text(data.chatRoomName);
					        $('.setting-chat-Name').text(data.chatRoomName);
					        $('.change-chat-title-input').val(data.chatRoomName);
					        chatName = data.chatRoomName;
					        $('.chat-room-member-count').text(data.count);
					        $('.ChatInviteButton').text('초대하기');
					        $('.chat-participant-count').text('('+data.count+')');
						        for(let i = 0; i<data.array1.length; i++) {
						        	let Profile = "<li class=\"chat-participants-item\" data-mno = "+data.array1[i].memberIdx+">"+
													 "		<div class=\"chat-post-author\">"+
													 "		<span class=\"chat-profile-radius\" style=\"background-image: url('"+data.array1[i].profileImg+"');\"></span>"+
													 "		<dl class=\"chat-post-profile-text\" style=\"width : 180px;\">"+
													 "			<dt>"+
													 "				<strong class=\"chat-author-name\">"+data.array1[i].name+"</strong>"+
													"				<em class=\"chat-author-position\">"+data.array1[i].position+"</em>"+
													 "			</dt>"+
													"			<dd>"+
													"				<strong class=\"chat-author-company\">"+data.array1[i].companyName+"</strong>"+
													"				<em class=\"chat-author-department\">"+data.array1[i].departmentName+"</em>"+
													"			</dd>"+
													"		</dl>"+
													"	</div>"+
													"	<div class=\"chat-participants-more-btn\">"+
													"		<button class=\"chat-btn-icon\"></button>"+
													"	</div>"+
													" </li>";
													$('.chat-participants-list').append(Profile);
						        }
						        for(let i = 0; i<data.array2.length; i++) {
						        	let chat = "<li class = \"chatting-item\" data-chno = "+data.array2[i].chatRoomIdx+">"+
												"	<div class = \"chatting-item-main\">"+
												"		<div class = \"chatting-room-img\">"+
												"			<div class = \"profile-img\" style = \"background-image: url('https://team-0aanf8.flow.team/flowImg/FLOW_202104235852152_d5111f66-1d9c-4806-bdff-bbcde78d0546.png?width=400&height=400'), url('https://team-0aanf8.flow.team/flowImg/FLOW_202104235852152_d5111f66-1d9c-4806-bdff-bbcde78d0546.png'), url('/flow-renewal/assets/images/profile-default.svg');\"></div>"+
												"		</div>"+
												"		<div class = \"chatting-room-author\">"+
												"			<p>"+
												"				<strong class = \"chat-title\">"+data.array2[i].chatRoomName+"</strong>"+
												"				<span class = \"chat-count\" style = \"display:none\"></span>"+
												"			</p>"+
												"			<p class = \"chat-author-gray\">"+
												"				<span class = \"last-chat\">"+data.array2[i].Conversation+"</span>"+
												"			</p>"+
												"		</div>"+
												"		<div class = \"Chatting-room-more-setting\">"+
															" </div> "+
														"	<div class = \"last-chat-date\">"+data.array2[i].amPm+" "+data.array2[i].time+"</div> "+
													"	</div> "+
												"	</div> "+
											"	</li> ";
											$('#ChatUl').append(chat);
						        }
						        for(let i = 0; i<data.array4.length; i++) {
						        	let chat;
						        	$('.chat-date span').text(data.array4[0].InputDate);
						        	if(data.array4[i].WriterIdx != <%=memberIdx%>) {
						        		chat = "<li class=\"message-item left-section\" data-cno = "+data.array4[i].ChatIdx+">"+
												"	<div class=\"chat-left\">"+
												"		<div class=\"chat-text-write\">"+
												"			<div class=\"left-box\">"+
												"				<div class=\"chat-text\">"+
												"					<div class=\"chat-value\">"+data.array4[i].Conversation+"</div>"+
												"				</div>"+
												"			</div>"+
												"			<div class=\"left-box\">"+
												"				<div class=\"chat-btns\" style=\"display:inline-block\"> "+
												"					<div class=\"chat-btns-bottom\"> "+
												"						<div class=\"chat-user-time\">"+data.array4[i].InputDateTime+"</div> "+
												"					</div> "+
												"				</div> "+
												"			</div> "+
												"		</div> "+
												"	</div> "+
												" </li>";
						        	} else {
						        		chat = "<li class=\"message-item right-section\" data-cno = "+data.array4[i].ChatIdx+">"+
												"	<div class=\"chat-right\">"+
												"		<div class=\"chat-text-write\">"+
												"			<div class=\"right-box\">"+
												"				<div class=\"chat-text\">"+
												"					<div class=\"chat-value\">"+data.array4[i].Conversation+"</div>"+
												"				</div>"+
												"			</div>"+
												"			<div class=\"right-box\">"+
												"				<div class=\"chat-btns\" style=\"display:inline-block\">"+
												"					<div class=\"chat-btns-bottom\">"+
												"						<div class=\"chat-user-time\">"+data.array4[i].InputDateTime+"</div>"+
												"					</div> "+
												"				</div> "+
												"			</div> "+
												"		</div> "+
												"	</div> "+
												" </li>";
						        	}
						        	$('.chatting-room-message').append(chat);
							        if(data.array4[i].DateComparison == 'Y') {
							        	let date = "<div class=\"chat-date\">"
												"		<span>"+data.array4[i].InputDate+"</span>"
												"	</div>";
							        	$('.chatting-room-message').append(date);
							        } else {
							        	
							        }
						        }
				  		},
		  				error: function(r, s, e) {
		    	        	console.log(r.status);
		    	        	console.log(e);
		    	        }
			  		});
			  	});
				$('.projectchat').click(function(){
					let title = $('.projecttitle').text().trim();
					$.ajax({
						type : "post",
			  			url : "ProjectChatAjax",
			  			data : {
			  				projectIdx : <%=projectIdx%>,
			  				memberIdx : <%=memberIdx%>,
			  				title : title
			  			},
			  			success: function(data) {
				        	console.log(data);
				        	$('.chatting-item').remove();
				        	$('.chat-participants-item').remove();
					        $('.message-item').remove();
					        $('.side-chat').css('display', 'none');
					        $('.side-chatting-room').css('display', 'block');
					        $('.side-chatting-room').attr('data-chno', data.chatRoomIdx);
					        $('.side-chatting-room').attr('data-pno', <%=projectIdx%>);
					        $('.Chat-name').text(data.chatRoomName);
					        $('.setting-chat-Name').text(data.chatRoomName);
					        $('.change-chat-title-input').val(data.chatRoomName);
					        chatName = data.chatRoomName;
					        $('.chat-room-member-count').text(data.count);
					        $('.ChatInviteButton').text('프로젝트 바로가기');
					        $('.chat-participant-count').text('('+data.count+')');
						        for(let i = 0; i<data.array1.length; i++) {
						        	let Profile = "<li class=\"chat-participants-item\" data-mno = "+data.array1[i].memberIdx+">"+
													 "		<div class=\"chat-post-author\">"+
													 "		<span class=\"chat-profile-radius\" style=\"background-image: url('"+data.array1[i].profileImg+"');\"></span>"+
													 "		<dl class=\"chat-post-profile-text\" style=\"width : 180px;\">"+
													 "			<dt>"+
													 "				<strong class=\"chat-author-name\">"+data.array1[i].name+"</strong>"+
													"				<em class=\"chat-author-position\">"+data.array1[i].position+"</em>"+
													 "			</dt>"+
													"			<dd>"+
													"				<strong class=\"chat-author-company\">"+data.array1[i].companyName+"</strong>"+
													"				<em class=\"chat-author-department\">"+data.array1[i].departmentName+"</em>"+
													"			</dd>"+
													"		</dl>"+
													"	</div>"+
													"	<div class=\"chat-participants-more-btn\">"+
													"		<button class=\"chat-btn-icon\"></button>"+
													"	</div>"+
													" </li>";
													$('.chat-participants-list').append(Profile);
						        }
						        for(let i = 0; i<data.array2.length; i++) {
						        	let chat = "<li class = \"chatting-item\" data-chno = "+data.array2[i].chatRoomIdx+">"+
												"	<div class = \"chatting-item-main\">"+
												"		<div class = \"chatting-room-img\">"+
												"			<div class = \"profile-img\" style = \"background-image: url('https://team-0aanf8.flow.team/flowImg/FLOW_202104235852152_d5111f66-1d9c-4806-bdff-bbcde78d0546.png?width=400&height=400'), url('https://team-0aanf8.flow.team/flowImg/FLOW_202104235852152_d5111f66-1d9c-4806-bdff-bbcde78d0546.png'), url('/flow-renewal/assets/images/profile-default.svg');\"></div>"+
												"		</div>"+
												"		<div class = \"chatting-room-author\">"+
												"			<p>"+
												"				<strong class = \"chat-title\">"+data.array2[i].chatRoomName+"</strong>"+
												"				<span class = \"chat-count\" style = \"display:none\"></span>"+
												"			</p>"+
												"			<p class = \"chat-author-gray\">"+
												"				<span class = \"last-chat\">"+data.array2[i].Conversation+"</span>"+
												"			</p>"+
												"		</div>"+
												"		<div class = \"Chatting-room-more-setting\">"+
															" </div> "+
														"	<div class = \"last-chat-date\">"+data.array2[i].amPm+" "+data.array2[i].time+"</div> "+
													"	</div> "+
												"	</div> "+
											"	</li> ";
											$('#ChatUl').append(chat);
						        }
						        for(let i = 0; i<data.array4.length; i++) {
						        	let chat;
						        	$('.chat-date span').text(data.array4[0].InputDate);
						        	if(data.array4[i].WriterIdx != <%=memberIdx%>) {
						        		chat = "<li class=\"message-item left-section\" data-cno = "+data.array4[i].ChatIdx+">"+
												"	<div class=\"chat-left\">"+
												"		<div class=\"chat-text-write\">"+
												"			<div class=\"left-box\">"+
												"				<div class=\"chat-text\">"+
												"					<div class=\"chat-value\">"+data.array4[i].Conversation+"</div>"+
												"				</div>"+
												"			</div>"+
												"			<div class=\"left-box\">"+
												"				<div class=\"chat-btns\" style=\"display:inline-block\"> "+
												"					<div class=\"chat-btns-bottom\"> "+
												"						<div class=\"chat-user-time\">"+data.array4[i].InputDateTime+"</div> "+
												"					</div> "+
												"				</div> "+
												"			</div> "+
												"		</div> "+
												"	</div> "+
												" </li>";
						        	} else {
						        		chat = "<li class=\"message-item right-section\" data-cno = "+data.array4[i].ChatIdx+">"+
												"	<div class=\"chat-right\">"+
												"		<div class=\"chat-text-write\">"+
												"			<div class=\"right-box\">"+
												"				<div class=\"chat-text\">"+
												"					<div class=\"chat-value\">"+data.array4[i].Conversation+"</div>"+
												"				</div>"+
												"			</div>"+
												"			<div class=\"right-box\">"+
												"				<div class=\"chat-btns\" style=\"display:inline-block\">"+
												"					<div class=\"chat-btns-bottom\">"+
												"						<div class=\"chat-user-time\">"+data.array4[i].InputDateTime+"</div>"+
												"					</div> "+
												"				</div> "+
												"			</div> "+
												"		</div> "+
												"	</div> "+
												" </li>";
						        	}
						        	$('.chatting-room-message').append(chat);
							        if(data.array4[i].DateComparison == 'Y') {
							        	let date = "<div class=\"chat-date\">"
												"		<span>"+data.array4[i].InputDate+"</span>"
												"	</div>";
							        	$('.chatting-room-message').append(date);
							        } else {
							        	
							        }
						        }
				  		},
				  		error: function(r, s, e) {
		    	        	console.log(r.status);
		    	        	console.log(e);
		    	        }
			  			
					})
				});
				let folderIdx = 0;
			  	$('.title > .plus').click(function(){
			  		event.stopPropagation();
			  		$('.mainPop').css('display','block');
			  		$('.project-folder-title-box-area').css('display','block');
			  		$('.project-folder-title').text('프로젝트 폴더 생성');
			  	});
			  	$('.project-folder-title-close').click(function(){
			  		$('.mainPop').css('display','none');
			  		$('.project-folder-title-box-area').css('display','none');
			  		$('.project-folder-title-input').val('');
			  	});
			  	$('.project-folder-title-cancle').click(function(){
			  		$('.mainPop').css('display','none');
			  		$('.project-folder-title-box-area').css('display','none');
			  		$('.project-folder-title-input').val('');
			  	});
			  	$('.project-folder-title-submit').click(function(){
			  		let folderTitle = $('.project-folder-title-input').val();
			  		if(folderTitle.length == 0) {
			  			alert("폴더 이름을 입력하세요 ");
			  		} else {
			  			let title = $('.project-folder-title').text().trim();
			  			if(title == '프로젝트 폴더 생성') {
					  		$.ajax({
					  			type : "Post",
					  			url : "CreateProjectFolderAjax",
					  			data : {
					  				folderTitle : folderTitle,
					  				memberIdx : <%=memberIdx%>
					  			},
					  			success : function(data) {
					  				console.log(data);
					  				$('.project-folder-title-input').val('');
					  				$('.mainPop').css('display','none');
					  		  		$('.project-folder-title-box-area').css('display','none');
					  		  		let folder = "<div class=\"left_items\" data-fno="+data.folderIdx+"><span class = \"projectFolderName\">"+data.name+"</span>" +
					  		  		"<span class = \"projectFolderMenu\"></span>"+
					  		  		"<ul class=\"Project-folder-setting-layer\" style=\"display: none;\">"+
									"	<li class=\"Project-folder-set-item-edit\">"+
									"		<i class=\"post-edit-icon\"></i>"+
									"		수정"+
									"	</li>"+
									"	<li class=\"Project-folder-set-item-del\">"+
									"		<i class=\"post-del-icon\"></i>"+
									"		삭제"+
									"	</li>"+
								"	</ul></div>";
					  		  		$('.plus').parents('.left_lower').append(folder);
					  			},
					  			error: function(r, s, e) {
				    	        	console.log(r.status);
				    	        	console.log(e);
				    	        }
					  		});
				  			} else {
				  				$.ajax({
						  			type : "Post",
						  			url : "UpdateProjectFolderNameAjax",
						  			data : {
						  				folderTitle : folderTitle,
						  				folderIdx : folderIdx,
						  			},
						  			success : function(data) {
						  				console.log(data);
						  				$('.left_items').each(function() {
						  					let dataFno = $(this).data('fno');
						  				    if (folderIdx === dataFno) {
						  				    	$(this).find('.projectFolderName').text(folderTitle);
						  				    }
						  				});
						  				$('.mainPop').css('display','none');
						  		  		$('.project-folder-title-box-area').css('display','none');
						  			},
						  			error: function(r, s, e) {
					    	        	console.log(r.status);
					    	        	console.log(e);
					    	        }
				  			});
				  		}
			  		}
			  	});
			  	$('.left_items').hover(
			  	        function() {
			  	            $(this).find('.projectFolderMenu').css('display', 'block');
			  	        },
			  	        function() {
			  	            $(this).find('.projectFolderMenu').css('display', 'none');
			  	        }
			  	    );
			  	$('.projectFolderMenu').click(function(event){
			  		 event.stopPropagation();
			  		$(this).parents('.left_items').find('.Project-folder-setting-layer').css('display','block');
			  	});
			  	$('.Project-folder-set-item-edit').click(function(event){
			  		event.stopPropagation();
			  		$('.Project-folder-setting-layer').css('display','none');
			  		$('.mainPop').css('display','block');
			  		$('.project-folder-title-box-area').css('display','block');
			  		$('.project-folder-title').text('프로젝트 폴더 수정');
			  		let title = $(this).parents('.left_items').find('.projectFolderName').text().trim();
			  		$('.project-folder-title-input').val(title);
			  		folderIdx = $(this).parents('.left_items').data('fno');
				});
				$('.Project-folder-set-item-del').click(function(event){
					event.stopPropagation();
					$('.Project-folder-setting-layer').css('display','none');
					folderIdx = $(this).parents('.left_items').data('fno');
					$.ajax({
			  			type : "Post",
			  			url : "DeleteProjectFolderAjax",
			  			data : {
			  				folderIdx : folderIdx,
			  			},
			  			success : function(data) {
			  				console.log(data);
			  				$('.left_items').each(function() {
			  					let dataFno = $(this).data('fno');
			  				    if (folderIdx === dataFno) {
			  				    	$(this).remove();
			  				    }
			  				});
			  			},
			  			error: function(r, s, e) {
		    	        	console.log(r.status);
		    	        	console.log(e);
		    	        }
			  		});
				});
				$(".title").click(function() {
		            if($(this).hasClass("open")) {
		               $(this).removeClass("open");
		               $(this).siblings().css("display", "none");
		            }else {
		               $(this).addClass("open");
		               $(this).siblings().css("display", "block");
		            }
		         });
				//프로필
				/*실시간 알림 동적*/
				/*실시간 알림창 띄우기&닫기 */
				$("#show-live-alarm-btn").click(function() {
					let now = $(".live-alarm-box");
					let nowDisplay = now.css('display');
					if(nowDisplay == 'none'){
						$(".live-alarm-box").css('display', 'block');
					}else{
						$(".live-alarm-box").css('display', 'none');
					}
				});
				/*창 닫기*/
				$("#live-alarm-close-btn").click(function() {
					$(".live-alarm-box").css('display', 'none');
				});
				/*전체 보기 클릭*/
				$(".all-show-btn").click(function() {
					$(this).css('border-bottom', '3px solid #333');
					$(".not-check-btn").css('border-bottom', 'none');
					
					$(this).css('color', '#333');
					$(".not-check-btn").css('color', '#999');
					
					$(this).addClass('on');
					$(".not-check-btn").removeClass('on');
				});
				/*미확인만 보기 클릭*/
				$(".not-check-btn").click(function() {
					$(this).css('border-bottom', '3px solid #333');
					$(".all-show-btn").css('border-bottom', 'none');
					
					$(this).css('color', '#333');
					$(".all-show-btn").css('color', '#999');
					
					$(this).addClass('on');
					$(".all-show-btn").removeClass('on');
				});
				/*검색창 띄우기*/
				$("#search-btn").click(function() {
					$(this).parent().parent().css('display', 'none');
					$(".input-search-box").css('display', 'block');
				});
				/*필터 검색으로 돌아가기*/
				$("#search-cancel-btn").click(function() {
					$(this).parent().parent().css('display', 'none');
					$(".filter-search-box").css('display', 'flex');
					$("#search-btn").parent().parent().css('display', 'flex');
					$('#liveAlarmSearchInput').val('');
					if($('.all-show-btn').hasClass('on')) {
						alarmSearchfunc('Y');
					} else if ($('.not-check-btn').hasClass('on')) {
						alarmSearchfunc('N');
					}
				});
				
				/*전체버튼 클릭*/
				$(".all-show-btn").click(function() {
					alarmSearchfunc('Y');
				})
				/*미확인 버튼 클릭*/
				$(".not-check-btn").click(function() {
					alarmSearchfunc('N');
				})
				$(document).ready(function() {
					/*실시간알림 검색어입력하기*/
					$("#liveAlarmSearchInput").on('keydown', function(event) {
						if(event.key === 'Enter') {
							let yn = $(".all-show-btn").hasClass('on') ? 'Y':'N';
							alarmSearchfunc(yn);
						}
					})
					/*실시간 알림 item 클릭 시*/
					$(document).on("click", ".item-box",  function() {
						let count = $("#show-live-alarm-btn").find('.badge').text();
						let location = $(this).data("idx");
						alert(location);
						$(this).removeClass("no-check");
						let liveAlarmIdx = $(this).data("laidx");
						$.ajax({
							type: 'post',
							url: 'LiveAlarmItemReadFuncAjaxServlet',
							data: {
								"liveAlarmIdx":liveAlarmIdx
							},
							success: function(data) {
								console.log(data);
								count--;
								if(count == 0) {
									$("#show-live-alarm-btn").find('.badge').css('display','none');
								}
							},
							error: function(r, s, e) {
								console.log(r.status);
								console.log(r.responseText);
								console.log(e);
							}
						})
					})
				})
				/*실시간알림 검색창 취소버튼 클릭*/
				$("#search-cancel-btn").click(function() {
					$("#liveAlarmSearchInput").val("");
				})
				/*모두 읽음처리 기능*/
				$(".all-read-btn").click(function() {
					$.ajax({
						type: 'post',
						url: 'allLiveAlarmReadFuncAjaxServlet',
						data: {"memberIdx":${memberIdx}},
						success: function(data) {
							console.log(data);
							if(data.notReadAlarmCnt == 0) {
								$("#show-live-alarm-btn").children().css("display", "none");
								$("#show-live-alarm-btn").find('.badge').css('display','none');
								$("#show-live-alarm-btn").find('.badge').text('0');
							}else {
								$("#show-live-alarm-btn").children().text(data.notReadAlarmCnt);
							}
							let yn = $(".all-show-btn").hasClass('on') ? 'Y':'N';
							alarmSearchfunc(yn);
						},
						error: function(r, s, e) {
							console.log(r.status);
							console.log(r.responseText);
							console.log(e);
						}
					})
				})
				/*프로필메뉴창열기*/
				$("#myProfShowBtn").click(function() {
					$("#memberProfMenuBox").css("display", "block");
					$(".live-alarm-box").css("display", "none");
				})
				/*프로필메뉴창닫기*/
				$(document).on('click', function(e) {
					if(!$(e.target).closest("#myProfShowBtn").length) {
						$("#memberProfMenuBox").css("display", "none");
					}
				})
				/*내 프로필 클릭*/
				$("#myProfBtn").click(function() {
					$("#myProf-popup-bg").css("display", "flex");
				})
				/*환경설정 클릭*/
				$("#settingBtn").click(function() {
					$("#mySetting-popup-bg").css("display", "flex");
					
					$("#setting-mainContent1").scrollTop(0);
				})
				/*로그아웃 클릭*/
				$("#logoutBtn").click(function() {
					$.ajax({
						type: 'post',
						url: 'logoutSessionActionServlet',
						success: function() {
							alert("로그아웃 되었습니다.");
							location.href="base_login.jsp";
						},
						error: function(r, s, e) {
							console.log(r.status);
							console.log(r.responseText);
							console.log(e);
						}
					})
				})
				/*프로필팝업창 닫기*/
				$("#myProf-closeBtn").click(function() {
					$("#myProf-popup-bg").css("display", "none");
				})
				/*채팅클릭*/
				$("#myProf-chatingBtn").click(function() {
					alert("채팅");
				})
				/*정보수정클릭*/
				$("#myProf-settingBtn").click(function() {
					$("#myProf-popup-bg").css("display", "none");
					$("#mySetting-popup-bg").css("display", "flex");
				})
				
				/*환경설정 팝업 시작*/
				/*환경설정 팝업창 닫기*/
				$("#setting-popup-closeBtn").click(function() {
					$("#setting-mainContent1").scrollTop(0);
					$("#setting-mainContent2").scrollTop(0);
					$("#setting-mainContent3").scrollTop(0);
					
					$("#mySetting-popup-bg").css("display", "none");
					
					$("#setting-mainContent1").css("display", "block");
					$("#setting-mainContent2").css("display", "none");
					$("#setting-mainContent3").css("display", "none");
					$(".mySestting-mainMenuBtn").each(function(i) {
						if(i == 0){
							$(this).css("color", "#5b40f8");
						}else {
							$(this).css("color", "#000000");
						}
					})
					
					$(".setting-menuContent").css("display", "flex");
					$(".setting-showModifyDiv").css("display", "none");
				})
				/*왼쪽사이드 메뉴 클릭*/
				$(".mySestting-mainMenuBtn").click(function() {
					if($(this).text() == "계정") {
						$("#setting-mainContent1").css("display", "block");
						$("#setting-mainContent2").css("display", "none");
						$("#setting-mainContent3").css("display", "none");
						
						$(".mySestting-mainMenuBtn").each(function(i) {
							if(i == 0){
								$(this).css("color", "#5b40f8");
							}else {
								$(this).css("color", "#000000");
							}
						})
					}else if($(this).text() == "알림") {
						$("#setting-mainContent1").css("display", "none");
						$("#setting-mainContent2").css("display", "block");
						$("#setting-mainContent3").css("display", "none");
						
						$(".mySestting-mainMenuBtn").each(function(i) {
							if(i == 1){
								$(this).css("color", "#5b40f8");
							}else {
								$(this).css("color", "#000000");
							}
						})
					}else if($(this).text() == "디스플레이 설정") {
						$("#setting-mainContent1").css("display", "none");
						$("#setting-mainContent2").css("display", "none");
						$("#setting-mainContent3").css("display", "block");
						
						$(".mySestting-mainMenuBtn").each(function(i) {
							if(i == 2){
								$(this).css("color", "#5b40f8");
							}else {
								$(this).css("color", "#000000");
							}
						})
					}
				})
				$('.display-setting-btn').click(function(){
					$("#mySetting-popup-bg").css("display", "flex");
					$("#setting-mainContent3").scrollTop(0);
					$("#setting-mainContent1").css("display", "none");
					$("#setting-mainContent2").css("display", "none");
					$("#setting-mainContent3").css("display", "block");
					
					$(".mySestting-mainMenuBtn").each(function(i) {
						if(i == 2){
							$(this).css("color", "#5b40f8");
						}else {
							$(this).css("color", "#000000");
						}
					})
				});
				let modifyPrevName;
				/*이름 수정 버튼 클릭*/
				$("#settingModify-nameBtn").click(function() {
					modifyPrevName = $(this).prev().text();
					$(this).parent().css("display", "none");
					$(this).parent().next().css("display", "flex");
				})
				/*이름 수정 취소 버튼 클릭*/
				$("#nameModify-cancleBtn").click(function() {
					$(this).parent().parent().css("display", "none");
					$(this).parent().parent().prev().css("display", "flex");
					$(this).parent().prev().val(modifyPrevName);
				})
				/*이름 수정 확인버튼 클릭*/
				$("#nameModify-checkBtn").click(function() {
					let name = $(this).parent().prev().val();
					$.ajax({
						type: 'post',
						url: 'UserNameModifyAjaxServlet',
						data: {
							"memberIdx":${memberInfo.memberIdx},
							"nameStr":name
						},
						success: function() {
							$("#setting-nameModifyDiv").css("display", "none");
							$("#setting-nameShowDiv").css("display", "flex");
							$("#setting-nameShowSpan").text(name);
						},
						error: function(r, s, e) {
							console.log(r.status);
							console.log(r.responseText);
							console.log(e);
						}
					})
				})
				let modifyPrevPosition;
				/*직책 수정 버튼 클릭*/
				$("#settingModify-positionBtn").click(function() {
					modifyPrevPosition = $(this).prev().text();
					$(this).parent().css("display", "none");
					$(this).parent().next().css("display", "flex");
				})
				/*직책 수정 취소 버튼 클릭*/
				$("#positionModify-cancleBtn").click(function() {
					$(this).parent().parent().css("display", "none");
					$(this).parent().parent().prev().css("display", "flex");
					$(this).parent().prev().val(modifyPrevPosition);
				})
				/*직책 수정 확인버튼 클릭*/
				$("#positionModify-checkBtn").click(function() {
					let position = $(this).parent().prev().val();
					$.ajax({
						type: 'post',
						url: 'UserPositionModifyAjaxServlet',
						data: {
							"memberIdx":${memberInfo.memberIdx},
							"positionStr":position
						},
						success: function() {
							$("#setting-positionModifyDiv").css("display", "none");
							$("#setting-positionShowDiv").css("display", "flex");
							$("#setting-positionShowSpan").text(position);
						},
						error: function(r, s, e) {
							console.log(r.status);
							console.log(r.responseText);
							console.log(e);
						}
					})
				})
				let modifyPrevPhone;
				/*휴대폰 번호 수정 버튼 클릭*/
				$("#settingModify-phoneBtn").click(function() {
					modifyPrevPhone = $(this).prev().text();
					$(this).parent().css("display", "none");
					$(this).parent().next().css("display", "flex");
				})
				/*휴대폰 번호 수정 취소 버튼 클릭*/
				$("#phoneModify-cancleBtn").click(function() {
					$(this).parent().parent().css("display", "none");
					$(this).parent().parent().prev().css("display", "flex");
					$(this).parent().prev().val(modifyPrevPhone);
				})
				/*휴대폰 번호 수정 확인버튼 클릭*/
				$("#phoneModify-checkBtn").click(function() {
					let phone = $(this).parent().prev().val();
					$.ajax({
						type: 'post',
						url: 'UserPhoneModifyAjaxServlet',
						data: {
							"memberIdx":${memberInfo.memberIdx},
							"phoneStr":phone
						},
						success: function() {
							$("#setting-phoneModifyDiv").css("display", "none");
							$("#setting-phoneShowDiv").css("display", "flex");
							$("#setting-phoneShowSpan").text(phone);
						},
						error: function(r, s, e) {
							console.log(r.status);
							console.log(r.responseText);
							console.log(e);
						}
					})
				})
				let modifyPrevCompanyPhone;
				/*회사연락처 수정 버튼 클릭*/
				$("#settingModify-companyPhoneBtn").click(function() {
					modifyPrevCompanyPhone = $(this).prev().text();
					$(this).parent().css("display", "none");
					$(this).parent().next().css("display", "flex");
				})
				/*회사연락처 수정 취소 버튼 클릭*/
				$("#companyPhoneModify-cancleBtn").click(function() {
					$(this).parent().parent().css("display", "none");
					$(this).parent().parent().prev().css("display", "flex");
					$(this).parent().prev().val(modifyPrevCompanyPhone);
				})
				/*회사연락처 수정 확인버튼 클릭*/
				$("#companyPhoneModify-checkBtn").click(function() {
					let companyPhone = $(this).parent().prev().val();
					$.ajax({
						type: 'post',
						url: 'UserCompanyPhoneModifyAjaxServlet',
						data: {
							"memberIdx":${memberInfo.memberIdx},
							"companyPhoneStr":companyPhone
						},
						success: function() {
							$("#setting-companyPhoneModifyDiv").css("display", "none");
							$("#setting-companyPhoneShowDiv").css("display", "flex");
							$("#setting-companyPhoneShowSpan").text(companyPhone);
						},
						error: function(r, s, e) {
							console.log(r.status);
							console.log(r.responseText);
							console.log(e);
						}
					})
				})
				let modifyPrevStatusMassage;
				/*회사연락처 수정 버튼 클릭*/
				$("#settingModify-statusMassageBtn").click(function() {
					modifyPrevStatusMassage = $(this).prev().text();
					$(this).parent().css("display", "none");
					$(this).parent().next().css("display", "flex");
				})
				/*회사연락처 수정 취소 버튼 클릭*/
				$("#statusMassageModify-cancleBtn").click(function() {
					$(this).parent().parent().css("display", "none");
					$(this).parent().parent().prev().css("display", "flex");
					$(this).parent().prev().val(modifyPrevStatusMassage);
				})
				/*회사연락처 수정 확인버튼 클릭*/
				$("#statusMassageModify-checkBtn").click(function() {
					let statusMassage = $(this).parent().prev().val();
					$.ajax({
						type: 'post',
						url: 'UserStatusMassageModifyAjaxServlet',
						data: {
							"memberIdx":${memberInfo.memberIdx},
							"statusMassageStr":statusMassage
						},
						success: function() {
							$("#setting-statusMassageModifyDiv").css("display", "none");
							$("#setting-statusMassageShowDiv").css("display", "flex");
							$("#setting-statusMassageShowSpan").text(statusMassage);
						},
						error: function(r, s, e) {
							console.log(r.status);
							console.log(r.responseText);
							console.log(e);
						}
					})
				})
				
				/*환경설정 - 알림푸시 클릭*/
				$("#setting-pushOutToggleBtn").click(function() {
					$.ajax({
						type: 'post',
						url: 'UserAlarmPushModifyAjaxServlet',
						data: {
							"memberIdx":${memberInfo.memberIdx}
						},
						success: function(data) {
							console.log(data);
							if(data.yn == "Y") {
								$("#setting-pushOutToggleBtn").css("background-color", "#5b40f8");
								$("#setting-pushOutToggleBtn").css("justify-content", "flex-end");
								$("#setting-pushInToggleBtn").css("border", "2px solid #5b40f8");
							}else {
								$("#setting-pushOutToggleBtn").css("background-color", "#aaa");
								$("#setting-pushOutToggleBtn").css("justify-content", "flex-start");
								$("#setting-pushInToggleBtn").css("border", "2px solid #aaa");
							}
						},
						error: function(r, s, e) {
							console.log(r.status);
							console.log(r.responseText);
							console.log(e);
						}
					})
				})
				$(document).on("click", "#projectColorFix-onClick", function() {
				/*환경설정 - 프로젝트 색상 고정 변경*/
				$.ajax({
					type: 'post',
					url: 'UserProjectColorFixModifyAjaxServlet',
					data: { "memberIdx":${memberInfo.memberIdx} },
					success: function(data) {
						console.log(data);
						$("#projectColor-ImgDiv-random").children().last().remove();
						$("#projectColor-ImgDiv-white").children().last().remove();
						if(data.yn == "Y") {
							$("#projectColor-ImgDiv-random").append('<img id="projectColorFix-onClick" class="setting-checkImg-Off" src="https://flow.team/flow-renewal/assets/scss/iconSet/svg-form/SelectCircleM.svg?v=13ca10f3e672023b1be08cac004209b7b701145d"/>');
							$("#projectColor-ImgDiv-white").append('<img class="setting-checkImg-On" src="https://flow.team/flow-renewal/assets/scss/iconSet/svg-form/SelectCircleM-active.svg?v=a86b76c603e020cd278b571f45f35a63f85f5644"/>');
						}else {
							$("#projectColor-ImgDiv-random").append('<img class="setting-checkImg-On" src="https://flow.team/flow-renewal/assets/scss/iconSet/svg-form/SelectCircleM-active.svg?v=a86b76c603e020cd278b571f45f35a63f85f5644"/>');
							$("#projectColor-ImgDiv-white").append('<img id="projectColorFix-onClick" class="setting-checkImg-Off" src="https://flow.team/flow-renewal/assets/scss/iconSet/svg-form/SelectCircleM.svg?v=13ca10f3e672023b1be08cac004209b7b701145d"/>');
						}
					},
					error: function(r, s, e) {
						console.log(r.status);
						console.log(r.responseText);
						console.log(e);
					}
				})
			})
					
			$(document).on("click", "#mainHomeTabBtn", function() {
				/*환경설정 - 메인 홈 설정*/
				$.ajax({
					type: 'post',
					url: 'UserMainHomeSettingModifyAjaxServlet',
					data: { "memberIdx":${memberInfo.memberIdx} },
					success: function(data) {
						console.log(data);
						$("#mainHome-ImgDiv-myProject").children().last().remove();
						$("#mainHome-ImgDiv-dashBoard").children().last().remove();
						if(data.mainHomeStr == "내 프로젝트") {
							$("#mainHome-ImgDiv-myProject").append('<img class="setting-checkImg-On" src="https://flow.team/flow-renewal/assets/scss/iconSet/svg-form/SelectCircleM-active.svg?v=a86b76c603e020cd278b571f45f35a63f85f5644"/>');
							$("#mainHome-ImgDiv-dashBoard").append('<img id="mainHomeTabBtn" class="setting-checkImg-Off" src="https://flow.team/flow-renewal/assets/scss/iconSet/svg-form/SelectCircleM.svg?v=13ca10f3e672023b1be08cac004209b7b701145d"/>');
						}else {
							$("#mainHome-ImgDiv-myProject").append('<img id="mainHomeTabBtn" class="setting-checkImg-Off" src="https://flow.team/flow-renewal/assets/scss/iconSet/svg-form/SelectCircleM.svg?v=13ca10f3e672023b1be08cac004209b7b701145d"/>');
							$("#mainHome-ImgDiv-dashBoard").append('<img class="setting-checkImg-On" src="https://flow.team/flow-renewal/assets/scss/iconSet/svg-form/SelectCircleM-active.svg?v=a86b76c603e020cd278b571f45f35a63f85f5644"/>');
						}
					},
					error: function(r, s, e) {
						console.log(r.status);
						console.log(r.responseText);
						console.log(e);
					}
				})
			})
			//어드민 이동
			$('#admin').click(function(){
				window.open('Controller?command=admin_page1', '_blank');
			});
			//회사 공개 프로젝트 이동
			$('#publicProject').click(function(){
				location.href = "Controller?command=public_project";
			});
			//북마크 이동
			$('#bookmark').click(function(){
				location.href = "Controller?command=sidetab_bookmark";
			});
			//내게시물로 이동
			$('#myBoard').click(function(){
				location.href = "Controller?command=sidetab_myboard";
			});
			//홈으로 이동
			$(".home_btn").click(function(){
				$.ajax({
					type: 'post',
					url: 'HomeBtnAjaxServlet',
					data: { "memberIdx": "${memberInfo.memberIdx}" },
					success: function(data) {
						console.log(data);
						if(data.hometab == "대시보드") {
						location.href="Controller?command=Dashboard";
						 } else {
						location.href="Controller?command=Myprojects";
						 } 
					},
					error: function(r, s, e) {
						console.log(r.status);
						console.log(r.responseText);
						console.log(e);
					}
				});
			});
		});
</script>

<body>
<div id="myProf-popup-bg" style="display: none;">
		<div id="myProf-popup">
			<div id="myProf-header" style="background-image: url('${memberInfo.profileImg}');">
				<button id="myProf-closeBtn"></button>
				<span id="myProf-userName">${memberInfo.name }</span>
			</div>
			<div id="myProf-content">
				<table id="myProf-contentTable">
					<tr>
						<th><div class="myProfInfoIcon" style="background-image: url('https://flow.team/flow-renewal/assets/images/icons/profile-company.svg?v=5d989fe5c8fd61a608c7fb913fbb5bfa82eff847');"></div></th>
						<td>
							<c:choose>
								<c:when test="${companyInfo.companyName != null }">
									${companyInfo.companyName }
								</c:when>
								<c:otherwise>
									-
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
					<tr>
						<th><div class="myProfInfoIcon" style="background-image: url('https://flow.team/flow-renewal/assets/images/icons/profile-mail.svg?v=a2d223d03783a37fd381f8cdaefd7217cd4951e1');"></div></th>
						<td>
							<c:choose>
								<c:when test="${memberInfo.email != null }">
									${memberInfo.email }
								</c:when>
								<c:otherwise>
									-
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
					<tr>
						<th><div class="myProfInfoIcon" style="background-image: url('https://flow.team/flow-renewal/assets/images/icons/profile-phone.svg?v=f0c9231c373b0f84c7873fbe42ff351b37ac69f9');"></div></th>
						<td>
							<c:choose>
								<c:when test="${memberInfo.phone != null }">
									${memberInfo.phone }
								</c:when>
								<c:otherwise>
									-
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
					<tr>
						<th><div class="myProfInfoIcon" style="background-image: url('https://flow.team/flow-renewal/assets/images/icons/profile-call.svg?v=c97428e9b8320591dbe35d208526e8858d53ce4f');"></div></th>
						<td>
							<c:choose>
								<c:when test="${memberInfo.companyPhone != null }">
									${memberInfo.companyPhone }
								</c:when>
								<c:otherwise>
									-
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
					<tr>
						<th><div class="myProfInfoIcon" style="background-image: url('https://flow.team/flow-renewal/assets/images/icons/profile-txt.svg?v=d00f6bb2d32419faf7309e6f63dfd7b2a8c430c6');"></div></th>
						<td>
							<c:choose>
								<c:when test="${memberInfo.statusMassage != null }">
									${memberInfo.statusMassage }
								</c:when>
								<c:otherwise>
									-
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
				</table>
				<div id="myProf-btnWrap">
					<div class="myProf-bottomBtn" id="myProf-chatingBtn">
						<div>채팅</div>
						<div class="myProf-bottomBtnIcon" style="background-image: url('https://flow.team/flow-renewal/assets/images/icons/icon-chat.svg?v=8c4e8c4d26035f52c6b62d3736c1088111c5a4ec');"></div>
					</div>
					<div class="myProf-bottomBtn" id="myProf-settingBtn">
						<div>정보수정</div>
						<div class="myProf-bottomBtnIcon" style="background-image: url('https://flow.team/flow-renewal/assets/images/icons/btn-modi.svg?v=1abd035b1322c355055e8dc35858cdcccc67625a');"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="mySetting-popup-bg" style="display: none;">
		<div id="mySetting-popup">
			<div id="mySetting-popup-header">
				<div id="mySetting-popup-header-profImg" style="background-image: url('${memberInfo.profileImg }');">
					<!-- <div id="mySetting-popup-header-profImg-modifyBtn"><img src="images/settingProfModifyIcon.png"/></div> -->
				</div>
				<div id="mySetting-popup-header-contentWrap"><span id="mySetting-popup-header-content">환경설정</span><button id="setting-popup-closeBtn" style="background-image: url('images/settingPopupCloseBtn.png');"></button></div>
			</div>
			<div style="display: flex;">
				<div id="mySetting-mainBtnWrap">
					<div class="mySestting-mainMenuBtn" style="color: #5b40f8;">계정</div>
					<div class="mySestting-mainMenuBtn">알림</div>
					<div class="mySestting-mainMenuBtn">디스플레이 설정</div>
				</div>
				<div id="setting-mainContent1" style="/* display: none; */">
					<ul id="setting-mainContent-ul">
						<li class="setting-mainContent-li">
							<div class="setting-menuTitle">아이디</div>
							<div class="setting-menuContent">${memberInfo.email }</div>
						</li>
						<li class="setting-mainContent-li">
							<div class="setting-menuTitle">이름</div>
							<div class="setting-menuContent" id="setting-nameShowDiv"><span id="setting-nameShowSpan">${memberInfo.name }</span><div id="settingModify-nameBtn"></div></div>
							<div id="setting-nameModifyDiv" class="setting-showModifyDiv" style="display: none;">
								<input type="text" value="${memberInfo.name }" style="width: 75%;"/>
								<div class="modifyBtnWrap">
									<button class="modify-cancleBtn" id="nameModify-cancleBtn">취소</button>
									<button class="modify-checkBtn" id="nameModify-checkBtn">확인</button>
								</div>
							</div>
						</li>
						<li class="setting-mainContent-li">
							<div class="setting-menuTitle">회사명</div>
							<div class="setting-menuContent">${companyInfo.companyName }</div>
						</li>
						<li class="setting-mainContent-li">
							<div class="setting-menuTitle">부서</div>
							<div class="setting-menuContent">${departmentName }</div>
						</li>
						<li class="setting-mainContent-li">
							<div class="setting-menuTitle">직책</div>
							<div class="setting-menuContent" id="setting-positionShowDiv"><span id="setting-positionShowSpan">${memberInfo.position }</span><div id="settingModify-positionBtn"></div></div>
							<div id="setting-positionModifyDiv" class="setting-showModifyDiv" style="display: none;">
								<input type="text" value="${memberInfo.position }" style="width: 75%;"/>
								<div class="modifyBtnWrap">
									<button class="modify-cancleBtn" id="positionModify-cancleBtn">취소</button>
									<button class="modify-checkBtn" id="positionModify-checkBtn">확인</button>
								</div>
							</div>
						</li>
						<li class="setting-mainContent-li">
							<div class="setting-menuTitle">휴대폰 번호</div>
							<div class="setting-menuContent" id="setting-phoneShowDiv"><span id="setting-phoneShowSpan">${memberInfo.phone }</span><div id="settingModify-phoneBtn"></div></div>
							<div id="setting-phoneModifyDiv" class="setting-showModifyDiv" style="display: none;">
								<input type="text" value="${memberInfo.phone }" style="width: 75%;"/>
								<div class="modifyBtnWrap">
									<button class="modify-cancleBtn" id="phoneModify-cancleBtn">취소</button>
									<button class="modify-checkBtn" id="phoneModify-checkBtn">확인</button>
								</div>
							</div>
						</li>
						<li class="setting-mainContent-li">
							<div class="setting-menuTitle">회사 연락처</div>
							<div class="setting-menuContent" id="setting-companyPhoneShowDiv"><span id="setting-companyPhoneShowSpan">${memberInfo.companyPhone }</span><div id="settingModify-companyPhoneBtn"></div></div>
							<div id="setting-companyPhoneModifyDiv" class="setting-showModifyDiv" style="display: none;">
								<input type="text" value="${memberInfo.companyPhone }" style="width: 75%;"/>
								<div class="modifyBtnWrap">
									<button class="modify-cancleBtn" id="companyPhoneModify-cancleBtn">취소</button>
									<button class="modify-checkBtn" id="companyPhoneModify-checkBtn">확인</button>
								</div>
							</div>
						</li>
						<li class="setting-mainContent-li">
							<div class="setting-menuTitle">상태 메시지</div>
							<div class="setting-menuContent" id="setting-statusMassageShowDiv"><span id="setting-statusMassageShowSpan">${memberInfo.statusMassage }</span><div id="settingModify-statusMassageBtn"></div></div>
							<div id="setting-statusMassageModifyDiv" class="setting-showModifyDiv" style="display: none;">
								<input type="text" value="${memberInfo.statusMassage }" style="width: 75%;"/>
								<div class="modifyBtnWrap">
									<button class="modify-cancleBtn" id="statusMassageModify-cancleBtn">취소</button>
									<button class="modify-checkBtn" id="statusMassageModify-checkBtn">확인</button>
								</div>
							</div>
						</li>
					</ul>
				</div>
				<div id="setting-mainContent2" style="display: none;">
					<ul id="setting-mainContent-ul">
						<li class="setting-mainContent-li">
							<c:choose>
								<c:when test="${memberInfo.alarmPush == \"Y\" }">
									<div class="setting-menuTitle">푸시<div id="setting-pushOutToggleBtn" style="background-color: #5b40f8; justify-content: flex-end;"><div id="setting-pushInToggleBtn" style="border: 2px solid #5b40f8;"></div></div></div>
								</c:when>
								<c:otherwise>
									<div class="setting-menuTitle">푸시<div id="setting-pushOutToggleBtn" style="background-color: #aaa; justify-content: flex-start;"><div id="setting-pushInToggleBtn" style="border: 2px solid #aaa;"></div></div></div>
								</c:otherwise>
							</c:choose>
							<div class="setting-menuContent">새로운 글, 댓글, 채팅의 실시간 알림을 받습니다.</div>
						</li>
					</ul>
				</div>
				<div id="setting-mainContent3" style="display: none;">
					<ul id="setting-mainContent-ul">
						<li class="setting-mainContent-li">
							<div class="setting-menuTitle">메인 홈 설정</div>
							<div class="setting-menuContent">메인 홈 화면을 설정하실 수 있습니다.</div>
							<div class="setting-mainHomeSettingDiv" style="border-bottom: 1px solid #eee;">
								<span>내 프로젝트</span>
								<div class="mainHome-ImgDiv" id="mainHome-ImgDiv-myProject">
									<div class="setting-mainHomeImg" style="background: url('images/mainHomeTab1.png') no-repeat center center / cover;"></div>
									<c:choose>
										<c:when test="${memberInfo.homeTab == \"내 프로젝트\" }">
											<img class="setting-checkImg-On" src="https://flow.team/flow-renewal/assets/scss/iconSet/svg-form/SelectCircleM-active.svg?v=a86b76c603e020cd278b571f45f35a63f85f5644"/>
										</c:when>
										<c:otherwise>
											<img id="mainHomeTabBtn" class="setting-checkImg-Off" src="https://flow.team/flow-renewal/assets/scss/iconSet/svg-form/SelectCircleM.svg?v=13ca10f3e672023b1be08cac004209b7b701145d"/>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
							<div class="setting-mainHomeSettingDiv">
								<span>대시보드</span>
								<div class="mainHome-ImgDiv" id="mainHome-ImgDiv-dashBoard">
									<div class="setting-mainHomeImg" style="background: url('images/mainHomeTab2.png') no-repeat center center / cover;"></div>
									<c:choose>
										<c:when test="${memberInfo.homeTab == \"대시보드\" }">
											<img class="setting-checkImg-On" src="https://flow.team/flow-renewal/assets/scss/iconSet/svg-form/SelectCircleM-active.svg?v=a86b76c603e020cd278b571f45f35a63f85f5644"/>
										</c:when>
										<c:otherwise>
											<img id="mainHomeTabBtn" class="setting-checkImg-Off" src="https://flow.team/flow-renewal/assets/scss/iconSet/svg-form/SelectCircleM.svg?v=13ca10f3e672023b1be08cac004209b7b701145d"/>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
						</li>
						<li class="setting-mainContent-li">
							<div class="setting-menuTitle">프로젝트 색상</div>
							<div class="setting-menuContent">프로젝트 만들기 또는 초대 받았을때, 프로젝트의 색상을 지정합니다.</div>
							<div class="setting-projectColorSettingDiv" style="border-bottom: 1px solid #eee;">
								<span>랜덤으로 설정</span>
								<div class="projectColor-ImgDiv" id="projectColor-ImgDiv-random">
									<div class="setting-projectColorImg" style="background-image: url('images/projectColorRandom.png');"></div>
									<c:choose>
										<c:when test="${memberInfo.projectColorFix == \"N\" }">
											<img class="setting-checkImg-On" src="https://flow.team/flow-renewal/assets/scss/iconSet/svg-form/SelectCircleM-active.svg?v=a86b76c603e020cd278b571f45f35a63f85f5644"/>
										</c:when>
										<c:otherwise>
											<img id="projectColorFix-onClick" class="setting-checkImg-Off" src="https://flow.team/flow-renewal/assets/scss/iconSet/svg-form/SelectCircleM.svg?v=13ca10f3e672023b1be08cac004209b7b701145d"/>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
							<div class="setting-projectColorSettingDiv">
								<span>흰생으로 고정</span>
								<div class="projectColor-ImgDiv" id="projectColor-ImgDiv-white">
									<div class="setting-projectColorImg" style="background-image: url('images/projectColorWhite.png');"></div>
									<c:choose>
										<c:when test="${memberInfo.projectColorFix == \"Y\" }">
											<img class="setting-checkImg-On" src="https://flow.team/flow-renewal/assets/scss/iconSet/svg-form/SelectCircleM-active.svg?v=a86b76c603e020cd278b571f45f35a63f85f5644"/>
										</c:when>
										<c:otherwise>
											<img id="projectColorFix-onClick" class="setting-checkImg-Off" src="https://flow.team/flow-renewal/assets/scss/iconSet/svg-form/SelectCircleM.svg?v=13ca10f3e672023b1be08cac004209b7b701145d"/>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
						</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
<div class = "create_area">
		<header class = "header-btn">
			<button class = "close-btn">
				<i class = "close-btn-icon"></i>
			</button>
		</header>
		<div class = "create_project_area">
			<div class = "create_project_value_area">
				<h1 class = "create_project_title">프로젝트 만들기</h1>
				<ul class = "create_project_make_layer">
					<li>
						<input class = "project-title-input" type="text" placeholder = "제목을 입력하세요." maxlength="50">
						<button class = "project_explanation-input-btn" style = "display: block">설명 입력</button>
						<textarea class = "project_explanation-input" placeholder = "프로젝트에 관한 설명 입력 (옵션)" maxlength="10000" style="display:none"></textarea>
					</li>
					<li class = "makeHomeTabLayer" style="display: block">
						<p class ="make-home-tab-label">
							<i class = "make-home-tab-icon"></i>
							홈 탭 설정
						</p>
						<ul class = "select-hometab-value">
							<li class = "hometab-item active" id = "feed">피드</li>
							<li class = "hometab-item" id = "tasks">업무</li>
							<li class = "hometab-item" id = "calander">캘린더</li>
						</ul>
					</li>
					<li class = "project-create-option1">
						<dl class = "project-create-option2">
							<dd class = "company-public-option">
								<div class = "public-setting">
									<div>
										<i class = "company-public-icon"></i>
										<span>회사 공개로 설정</span>
										<i class = "question-icon"></i>
									</div>
									<button class = "company-public-toggle-btn" id = "public-setting">
										<i class ="handle"></i>
									</button>
								</div>
							</dd>
							<dd class = "public-setting-content" >
								<div class = "public-setting-select-area">
									<span class = "public-title">카테고리 설정</span>
									<div class = "select-box">
										<select class = "company-category">
											<option class = "CATG1" data-code = "1">업무관련</option>
											<option class = "CATG2" data-code = "2">동호회</option>
											<option class = "CATG3" data-code = "3">정보공유</option>
											<option class = "CATG4" data-code = "4">학습</option>
										</select>
									</div>
								</div>
							</dd>
							<dd class ="company-admin-option">
								<div class = "public-setting">
									<div>
										<i class = "admin-lock-icon"></i>
										<span>관리자 승인 후 참여 가능</span>
										<i class = "question-icon"></i>
									</div>
									<button class = "company-public-toggle-btn" id = "admin-lock-setting">
										<i class ="handle"></i>
									</button>
								</div>
							</dd>
							<dd class ="company-admin-option">
								<div class = "public-setting">
									<div>
										<i class = "admin-setting-icon"></i>
										<span>권한 설정</span>
									</div>
									<button class = "admin-setting-toggle-option">
										<span class = "admin-setting-toggle-open">선택</span>
										<span class = "admin-setting-toggle-close">닫기</span>
									</button>
								</div>
								<dl class = "project-admin-more-option-area" style="display:">
									<dt>게시물</dt>
									<dd>
										<ul>
											<li class = "board-write-auth-element">
												<span>작성 권한</span>
												<div class = "select-authority-area">
													<select class = "authority-select-box">
														<option data-code = "0">전체</option>
														<option data-code = "1">프로젝트 관리자만</option>
													</select>
												</div>
											</li>
											<li class= "edit-auth-element" style="display: flex;">
												<span>수정 권한</span>
												<div class = "select-authority-area">
													<select class = "authority-select-box">
														<option data-code = "0">전체</option>
														<option data-code = "1">프로젝트 관리자 + 작성자만</option>
														<option data-code = "2">작성자만</option>
													</select>
												</div>
											</li>
											<li class = "view-auth-element">
												<span>조회 권한</span>
												<div class = "select-authority-area">
													<select class = "authority-select-box">
														<option data-code = "0">전체</option>
														<option data-code = "1">프로젝트 관리자 + 작성자만</option>
													</select>
												</div>
											</li>
											<li class = "add-option-info">
												<p class="add-option-info-value">
                                                  * 게시글 조회 권한은 프로젝트 생성 후에는 변경할 수 없습니다.
                                                </p>
											</li>
										</ul>
									</dd>
									<dt>댓글</dt>
									<dd>
										<ul>
											<li class = "comment-auth-element">
												<span>작성 권한</span>
												<div class = "select-authority-area">
													<select class = "authority-select-box">
														<option data-code = "0">전체</option>
														<option data-code = "1">프로젝트 관리자 + 작성자만</option>
													</select>
												</div>
											</li>
										</ul>
									</dd>
								</dl>
							</dd>
						</dl>
					</li>
					<li class = "project-create-btn">
						<button class ="submit-project">프로젝트 생성</button>						
					</li>
				</ul>
			</div>
			<div class = "create_project_value_preview_area">
				<div class = "template-preview">
					<div class = "template-preview-title-layer">
						<p class = "template-preview-title-text"></p>
						<i class = "icon-template-earth" style="display:none"></i>
						<i class = "icon-template-lock" style="display:none"></i>
					</div>
					<div class = "template-sample-img feed" id ="template"></div>
				</div>
			</div>
		</div>
	</div>
<div class = mainPop>
		<div class = mainPop1>
			<div class = mainPop2>
				<div class = "project-folder-title-box-area" style = "display:none">
					<div class = "project-folder-title-box-header">
						<div class = "project-folder-title">프로젝트 폴더 생성</div>
						<button class = "project-folder-title-close"></button>
					</div>
					<div class = "project-folder-title-box-content">
						<div class = "project-folder-title-input-box">
							<input type = "text" class = "project-folder-title-input">
						</div>
						<div class = "project-folder-title-box-button">
							<button class = "project-folder-title-cancle">취소</button>
							<button class = "project-folder-title-submit">확인</button>
						</div>
					</div>
				</div>
				<div class = "invite-chat-section">
					<div class = "invite-flow-section-header">
						<span class = "flow-invite-header-text">새 채팅</span>
						<button class = "invite-chat-close"></button>
					</div>
					<div class = "invite-flow-chat-section-main">
						<ul class = "invite-flow-chat-nav">
							<li class = "invite-chat-employees on">임직원</li>
							<li class = "invite-chat-outsider">외부인</li>
						</ul>
						<div class = "flowchatInviteArea">
							<div class = "memberchatSearchArea">
								<input type = "text" class = "invitechatSearchBox" placeholder="이름 검색">
								<i class = "icons-search"></i>
							</div>
							<div class = "chat-invite-employees">
								<div class = "chat-invite-member-box">
									<ul class = "chat-invite-member-area">
										<%for(MemberDto dto : CMlist) { %>
										<li class = "invite-member-items" data-mno = <%=dto.getMemberIdx() %>>
											<div class = "chat-invite-check-select"></div>
											<div class = "post-author">
												<span class = "profile-radius" style="background-image: url('<%= dto.getProfileImg() %>');"></span>
												<dl class = "post-profile-text">
													<dt>
														<strong class = "author-name"><%=dto.getName() %></strong>
														<em class = "author-position">
														
														<% if(dto.getPosition().equals("null")) { %>
															
														<%} else { %>
														<%=dto.getPosition() %>
														<% } %>
														</em>
													</dt>
													<dd>
														<strong class = "author-company"><%=dto.getCompanyName() %></strong>
														<em class = "author-department">
															<% if(dto.getDepartmentName().equals("null")) { %>
															
															<%} else { %>
															<%=dto.getDepartmentName() %>
															<% } %>
														</em>
													</dd>
												</dl>
											</div>
										</li>
										<% } %>
									</ul>
								</div>
							</div>
							<div class = "chat-invite-outsider" style="display:none">
								<div class = "chat-invite-member-box">
									<ul class = "chat-invite-member-area">
										<%for(MemberDto dto : Olist) { %>
										<li class = "invite-member-items" data-mno = <%=dto.getMemberIdx() %>>
											<div class = "chat-invite-check-select"></div>
											<div class = "post-author">
												<span class = "profile-radius" style="background-image: url('<%= dto.getProfileImg() %>');"></span>
												<dl class = "post-profile-text">
													<dt>
														<strong class = "author-name"><%=dto.getName() %></strong>
														<em class = "author-position"><% if(dto.getPosition().equals("null")) { %>
															
														<%} else { %>
														<%=dto.getPosition() %>
														<% } %></em>
													</dt>
													<dd>
														<strong class = "author-company"><%=dto.getCompanyName() %></strong>
														<em class = "author-department"><% if(dto.getDepartmentName().equals("null")) { %>
															
															<%} else { %>
															<%=dto.getDepartmentName() %>
															<% } %></em>
													</dd>
												</dl>
											</div>
										</li>
										<%} %>
									</ul>
								</div>
							</div>
						</div>
						<div class = "chatInviteMemberList">
							<p class = "chatinviteMemberListNull">대상을 선택해주세요</p>
							<div class = "chat-invite-selected-num" style = "display:none">
								<span class = "project-select-member-count"></span>
								<button class = "chat-select-member-all-delete">전체 삭제</button>
							</div>
							<ul class = "inviteTargetList"></ul>
						</div>
					</div>
					<div class = "invite-chat-section-bottom">
						<button class = "chatreturnMainbtn">취소</button>
						<button class = "chatinviteSubmitbtn">초대</button>
					</div>
				</div>
				<div class= "color-select-box">
					<div class = "mainPop-header">
						프로젝트 색상
						<div class = "close-event"></div>
					</div>
					<div class = "mainPop-content">
						<div class = "mainPop-category">
							<ul class = "select-color-list">
								<li class = "color-item mint" data-code = '1'>
									<input type = "radio" name = "color">
								</li>
								<li class = "color-item green" data-code = '2'>
									<input type = "radio" name = "color">
								</li>
								<li class = "color-item yellow" data-code = '3'>
									<input type = "radio" name = "color">
								</li>
								<li class = "color-item orange" data-code = '4'>
									<input type = "radio" name = "color">
								</li>
								<li class = "color-item red" data-code = '5'>
									<input type = "radio" name = "color">
								</li>
								<li class = "color-item pink" data-code = '6'>
									<input type = "radio" name = "color">
								</li>
								<li class = "color-item skyblue" data-code = '7'>
									<input type = "radio" name = "color">
								</li>
								<li class = "color-item blue" data-code = '8'>
									<input type = "radio" name = "color">
								</li>
								<li class = "color-item purple" data-code = '9'>
									<input type = "radio" name = "color">
								</li>
								<li class = "color-item gray" data-code = '10'>
									<input type = "radio" name = "color">
								</li>
								<li class = "color-item black" data-code = '11'>
									<input type = "radio" name = "color">
								</li>
								<li class = "color-item white" data-code = '12'>
									<input type = "radio" name = "color">
								</li>
							</ul>
						</div>
						<div class = "mainPop-btn">
							<button class = "cancle-mainPop">취소</button>
							<button class = "submit-mainPop">확인</button>
						</div>
					</div>
				</div>
				<div class = "label-select">
					<div class = "mainPop-header">
						프로젝트 폴더 설정
						<div class = "close-event"></div>
					</div>
					<ul class = "labelMain">
						<%ArrayList<MemberProjectFolderDto> mpfdlist = pdao.folderview(memberIdx); %>
						<%for(MemberProjectFolderDto dto : mpfdlist) { %>
						<li class = "label-item" data-code = <%=dto.getFloderIdx()%>>
							<%ArrayList<MemberProjectFolderDto> mpfdlist1 = pdao.folderviewChecks(memberIdx, projectIdx, dto.getFloderIdx()); %>
							<%if(mpfdlist1.size()==0) { %>
								<div class = label-set-item>
									<span class = "label-item-text">
										<%=dto.getForderName()%>
									</span>
									<div class = "label-check-btn"></div>
								</div>
							<% } else { %>
								<div class = "label-set-item active">
									<span class = "label-item-text">
										<%=dto.getForderName()%>
									</span>
									<div class = "label-check-btn"></div>
								</div>
							<% } %>
						</li>
						<% } %>
					</ul>
					<div class = "mainPop-btn">
						<button class = "cancle-mainPop">취소</button>
						<button class = "submit-mainPop">확인</button>
					</div>
				</div>
				<div class = "project-delete-area">
					<div class = "project-delete-box">
						<div class = "project-page-text" style="display:none">
							<p class = "project-page-text-value" style="display:none">
								프로젝트 나가기 시, 프로젝트 목록에서 삭제되며 
								 작성하신 게시물 확인이 불가합니다.
							</p>
						</div>
						<div class = "project-page-exit-text" style = "display:none">
							<p class = "project-page-text-values-1"  style = "display:none">
								게시글이 있는 프로젝트입니다.
								<br>
								 정말 삭제하시겠습니까? 
								<br>
								<br>
							</p>
							<p class = "project-page-text-values"  style = "display:none">
								회사 관리자에게 문의하여 복구하거나 완전히 삭제할 수 있습니다.
							</p>
						</div>
						<div class = "prjoect-page-btn">
							<button class = "project-page-cancle">취소</button>
							<button class = "project-page-submit">확인</button>
						</div>
					</div>
				</div>
				<div class = "project-invite-area">
					<div class = "projec-invite-header">
						<span class = "invite-title">
							<i class = "project-color color-code-4"></i>
							협업툴 만들기 프로젝트
						</span>
						<button class = "invite-close"></button>
					</div>
					<ul class = "project-invite-main">
						<li class = "flowInvite">
							<div class = "invite-icon-area">
								<span class = "icon-flow"></span>
							</div>
							<div class = "invite-text-areas">
								<span>참여자 초대</span>
								<em>직원 및 프로젝트를 함께했던 사람들을 초대할 수 있습니다.</em>
							</div>
						</li>
						<li class = "copyInviteUrl">
							<div class = "invite-icon-area">
								<span class = "icon-copy"></span>
							</div>
							<div class = "invite-text-areas">
								<span>초대 링크 복사</span>
								<em>복사한 링크로 초대할 수 있습니다.</em>
								 <input type="hidden" id="data-area" class="data-area" value="링크">
							</div>
						</li>
					</ul>
				</div>
				<div class = "invite-flow-section">
					<div class = "invite-flow-section-header">
						<em class = "return-btn-invite-main"></em>
						<span class = "flow-invite-header-text">참여자 초대</span>
						<button class = "invite-close"></button>
					</div>
					<div class = "invite-flow-section-main">
						<ul class = "invite-flow-nav">
							<li class = "invite-employees on">임직원</li>
							<li class = "invite-outsider">외부인</li>
						</ul>
						<div class = "flowInviteArea">
							<div class = "memberSearchArea">
								<input type = "text" class = "inviteSearchBox" placeholder="이름 검색">
								<i class = "icons-search"></i>
							</div>
							<div class = "project-invite-employees">
								<div class = "project-invite-member-box">
									<ul class = "project-invite-member-area">
										<%for(MemberDto dto : CMlist) { %>
										<li class = "invite-member-item" data-mno = <%=dto.getMemberIdx() %>>
											<div class = "invite-check-select"></div>
											<div class = "post-author">
												<span class = "profile-radius" style="background-image: url('<%= dto.getProfileImg() %>');"></span>
												<dl class = "post-profile-text">
													<dt>
														<strong class = "author-name"><%=dto.getName() %></strong>
														<em class = "author-position"><%=dto.getPosition() %></em>
													</dt>
													<dd>
														<strong class = "author-company"><%=dto.getCompanyName() %></strong>
														<em class = "author-department"><%=dto.getDepartmentName() %></em>
													</dd>
												</dl>
											</div>
										</li>
										<% } %>
									</ul>
								</div>
							</div>
							<div class = "project-invite-outsider" style="display:none">
								<div class = "project-invite-member-box">
									<ul class = "project-invite-member-area">
										<%for(MemberDto dto : Olist) { %>
										<li class = "invite-member-item" data-mno = <%=dto.getMemberIdx() %>>
											<div class = "invite-check-select"></div>
											<div class = "post-author">
												<span class = "profile-radius" style="background-image: url('<%= dto.getProfileImg() %>');"></span>
												<dl class = "post-profile-text">
													<dt>
														<strong class = "author-name"><%=dto.getName() %></strong>
														<em class = "author-position"><%=dto.getPosition() %></em>
													</dt>
													<dd>
														<strong class = "author-company"><%=dto.getCompanyName() %></strong>
														<em class = "author-department"><%=dto.getDepartmentName() %></em>
													</dd>
												</dl>
											</div>
										</li>
										<% } %>
									</ul>
								</div>
							</div>
						</div>
						<div class = "flowInviteMemberList">
							<p class = "inviteMemberListNull">대상을 선택해주세요</p>
							<div class = "project-invite-selected-num" style = "display:none">
								<span class = "project-select-member-count"></span>
								<button class = "project-select-member-all-delete">전체 삭제</button>
							</div>
							<ul class = "inviteTargetList"></ul>
						</div>
					</div>
					<div class = "invite-flow-section-bottom">
						<button class = "returnMainbtn">취소</button>
						<button class = "inviteSubmitbtn">초대</button>
					</div>
				</div>
				<div class = "project_member-layer-box">
					<div class = "project_member-layer-header">
						<span>참여자 관리</span>
						<button class = "project_member-close-btn"></button>
					</div>
					<div class = "project_member-layer-search">
						<i class = "icons-search"></i>
						<input type = "text" class = "project-member-search" placeholder = "이름으로 검색">
					</div>
					<div class = "project_member-layer-main">
						<ul class = "project_member-layer-area">
						<%for(ProjectMemberViewDto PAdto : PAlist) { %>
							<li class = "project-member-item" data-mno = <%=PAdto.getMemberIdx() %>>
								<div class = "post-author">
									<span class = "profile-radius" style="background:url('<%=PAdto.getProfileImg() %>'); no-repeat center center; background-size: cover;"></span>
									<dl class = "post-profile-text">
										<dt>
											<strong class = "author-name"><%=PAdto.getName() %></strong>
											<em class = "author-position"><% if(PAdto.getPosition()==null) { %>
															
														<%} else { %>
														<%=PAdto.getPosition() %>
														<% } %></em>
										</dt>
										<dd>
											<strong class = "author-company"><%=PAdto.getCompanyName() %></strong>
											<em class = "author-department"><% if(PAdto.getDepartmentName()==null) { %>
															
															<%} else { %>
															<%=PAdto.getDepartmentName() %>
															<% } %></em>
										</dd>
									</dl>
								</div>
								<%if(PMdto2.getAdminYN()=='Y') { %>
									<%if(PAdto.getMemberIdx()==memberIdx) {  %>
										<%if(PAdto.getAdminYN()=='Y') { %>
										<div class = "project-admin active">관리자</div>
										<button class = "project-other-option-btn">
											<span></span>
											<span></span>
											<span></span>
										</button>
										<div class = "project-other-option-layer">
											<div>
												<button class = "project-other-option-exit">나가기</button>
											</div>
											<div>
												<button class = "project-other-option-admin">관리자 해제</button>
											</div>
										</div>
										<% } else { %>
										<div class = "project-admin">관리자</div>
										<button class = "project-other-option-btn">
											<span></span>
											<span></span>
											<span></span>
										</button>
										<div class = "project-other-option-layer">
											<div>
												<button class = "project-other-option-exit">나가기</button>
											</div>
											<div>
												<button class = "project-other-option-admin">관리자 지정</button>
											</div>
										</div>
										<% } %>
									<% } else {%>
										<%if(PAdto.getAdminYN()=='Y') { %>
										<div class = "project-admin active">관리자</div>
										<button class = "project-other-option-btn">
											<span></span>
											<span></span>
											<span></span>
										</button>
										<div class = "project-other-option-layer">
											<div>
												<button class = "project-other-option-exit">내보내기</button>
											</div>
											<div>
												<button class = "project-other-option-admin">관리자 해제</button>
											</div>
										</div>
										<% } else { %>
										<div class = "project-admin">관리자</div>
										<button class = "project-other-option-btn">
											<span></span>
											<span></span>
											<span></span>
										</button>
										<div class = "project-other-option-layer">
											<div>
												<button class = "project-other-option-exit">내보내기</button>
											</div>
											<div>
												<button class = "project-other-option-admin">관리자 지정</button>
											</div>
										</div>
										<% } %>
									<% } %>
								<% } else { %>
									<%if(PAdto.getMemberIdx()==memberIdx) {  %>
										<%if(PAdto.getAdminYN()=='Y') { %>
										<div class = "project-admin active">관리자</div>
										<button class = "project-other-option-btn">
											<span></span>
											<span></span>
											<span></span>
										</button>
										<div class = "project-other-option-layer">
											<div>
												<button class = "project-other-option-exit">나가기</button>
											</div>
											<div>
												<button class = "project-other-option-admin" style="display:none">관리자 해제</button>
											</div>
										</div>
										<% } else { %>
										<div class = "project-admin">관리자</div>
										<button class = "project-other-option-btn">
											<span></span>
											<span></span>
											<span></span>
										</button>
										<div class = "project-other-option-layer">
											<div>
												<button class = "project-other-option-exit">나가기</button>
											</div>
											<div>
												<button class = "project-other-option-admin"style="display:none">관리자 지정</button>
											</div>
										</div>
										<% } %>
									<% } else {%>
										<%if(PAdto.getAdminYN()=='Y') { %>
										<div class = "project-admin active">관리자</div>
										<button class = "project-other-option-btn" style="display:none">
											<span></span>
											<span></span>
											<span></span>
										</button>
										<div class = "project-other-option-layer">
											<div>
												<button class = "project-other-option-exit">내보내기</button>
											</div>
											<div>
												<button class = "project-other-option-admin">관리자 해제</button>
											</div>
										</div>
										<% } else { %>
										<div class = "project-admin">관리자</div>
										<button class = "project-other-option-btn" style="display:none">
											<span></span>
											<span></span>
											<span></span>
										</button>
										<div class = "project-other-option-layer">
											<div>
												<button class = "project-other-option-exit">내보내기</button>
											</div>
											<div>
												<button class = "project-other-option-admin">관리자 지정</button>
											</div>
										</div>
										<% } %>
									<% } %>
								<% } %>
							</li>
						<% } %>
						</ul>
					</div>
				</div>
				<div class = "read-check" style = "display:none">
					<div class = "read-header">
						<span>읽음확인</span>
						<button class="read-close-btn"></button>
					</div>
					<div class = "read-tab">
						<div class = "read-tab-item on" data-code="read">읽음 ()</div>
						<div class = "read-tab-item" data-code="unread">미확인 ()</div>
					</div>
					<div class="read-layer-search">
						<i class="icons-search" style = "top: -15px;left: 9px;"></i>
						<input type="text" class="read-search" placeholder="이름으로 검색">
					</div>
					<ul class = "reader-list" data-category = "read">
						
					</ul>
					<ul class = "reader-list" data-category = "not-read" style = "display:none">
					
					</ul>
				</div>
				<div class = "emotion-all-check" style = "display:none">
					<div class = "emotion-header">
						<span>좋아요 확인</span>
						<button class = "emotion-close-btn"></button>
					</div>
					<div class = "emotion-total-value">
						<span class = "total-emotion-item" data-code="1">
							<i class = "emotion1"></i>
							<strong class = "emotion-count-value"></strong>
						</span>
						<span class = "total-emotion-item" data-code="2">
							<i class = "emotion2"></i>
							<strong class = "emotion-count-value"></strong>
						</span>
						<span class = "total-emotion-item" data-code="3">
							<i class = "emotion3"></i>
							<strong class = "emotion-count-value"></strong>
						</span>
						<span class = "total-emotion-item" data-code="4">
							<i class = "emotion4"></i>
							<strong class = "emotion-count-value"></strong>
						</span>
						<span class = "total-emotion-item" data-code="5">
							<i class = "emotion5"></i>
							<strong class = "emotion-count-value"></strong>
						</span>
						<div class = "total-emotion-count">
							<em>총</em>
							<strong class = "emotion-total-count-value">0</strong>
						</div>
					</div>
					<ul class = "emotion-participants-list">
						
					</ul>
				</div>
				<div class = "manager-add-section">
					<div class = "manager-add-section-header">
						<span class = "manager-add-header-text">담당자 변경</span>
						<button class = "manager-add-close"></button>
					</div>
					<div class = "manager-add-section-main">
						<div class = "managerAddArea">
							<div class = "menagerSearchArea">
								<input type = "text" class = "managerSearchBox" placeholder="이름으로 검색">
								<i class = "icons-search"></i>
							</div>
							<div class = "board-manager-employees">
								<div class = "board-manager-box">
									<ul class = "board-manager-area">
										
									</ul>
								</div>
							</div>
						</div>
						<div class = "managerAddList">
							<p class = "managerListNull">대상을 선택해주세요</p>
							<div class = "board-manager-selected-num" style = "display:none">
								<span class = "board-manager-selected-count"></span>
								<button class = "board-manager-selected-all-delete">전체 삭제</button>
							</div>
							<ul class = "inviteManagerList"></ul>
						</div>
					</div>
					<div class = "manager-add-section-bottom">
						<button class = "managerReturnMainbtn">취소</button>
						<button class = "managerSubmitbtn">확인</button>
					</div>
				</div>
			</div>
		</div>
	</div>
<div id="header">
		<div>
			<div id = "chat" class="fl">
			</div>
			 <div class="fl" id="show-live-alarm-btn">
			 <c:choose>  
			    <c:when test="${notReadAlarmCnt == 0}"> 
			        <span class="badge" style="display:none;">
			            ${notReadAlarmCnt}
			        </span>
			    </c:when> 
			    <c:otherwise> 
			        <span class="badge">
			            ${notReadAlarmCnt}
			        </span>
			    </c:otherwise> 
			</c:choose> 
			</div>
	         <div class="fl" id="myProfShowBtn" style="background-image: url('${memberInfo.profileImg }');"></div>
	         <div style="clear:both;"></div>
       </div>
       <div class="live-alarm-box" style="display: none;">
			<div class="live-alarm-header">
				<Strong>알림</Strong>
				<button type="button" id="live-alarm-close-btn"></button>
			</div>
			<div class="live-alarm-check-tab">
				<div style="display: flex;">
					<div class="not-check-btn">미확인</div>
					<div class="all-show-btn">전체</div>
				</div>
				<div class="all-read-btn">모두읽음</div>
			</div>
			<div class="filter-search-box">
				<div>
					<button type="button" id="search-btn"></button>
				</div>
			</div>
			<div class="input-search-box" style="display: none;">
				<div class="live-alarm-search-wrap">
					<img id="live-alarm-search-icon" src="images/live-alarm-search-icon.png"/>
					<input type="text" id="liveAlarmSearchInput" placeholder="검색"/>
					<button type="button" id="search-cancel-btn">취소</button>
				</div>
			</div>
			<div class="live-alarm-content">
				<c:choose>
					<c:when test="${alarmList.size() == 0 }">
						<div class="alarm-nothing-bg" style="display: none;">
							<img class="nothing-bg" src="https://team-0aaj7b.flow.team/flow-renewal/assets/images/none_data.png?v=86cf52f3c4c1c1c458fd4dedff02bb47ea35e280"/>
							<span>모든 알림을 확인했습니다.</span>
						</div>
					</c:when>
				</c:choose>
				<c:forEach var="dto" items="${alarmList }">
					<div class="item-box no-check" data-idx="${dto.coordinate }" data-laidx="${dto.liveAlarmIdx }" data-mention="${dto.mentionMeYn }" data-myboard="${myBoardYn }" data-work="${workYn }">
						<div class="live-alarm-prof" style="background-image: url('${dto.writerProf}');"></div>
						<div class="live-alarm-text-wrap">
							<div class="live-alarm-row-1">
								<div class="live-alarm-content-title">${dto.title }</div>
								<div class="content-write-date">${dto.alarmInfoDate }</div>
							</div>
							<div class="content-mini-title">${dto.simpleContent }</div>
							<div class="live-alarm-main-content">${dto.fullContent }</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
		<div id="memberProfMenuBox">
			<div id="profInfoWrap"><span id="memberProfInfoImg" style="background-image: url('${memberInfo.profileImg}');"></span><span id="memberProfInfoName">${memberInfo.name }</span></div>
			<div class="memberProfMenuBtn" id="myProfBtn"><div class="memberProfMenuBtnIcon" style="background-image: url('images/memberProfMyProf.png');"></div><span id="memberProfMyProf">내프로필</span></div>
			<div class="memberProfMenuBtn" id="settingBtn"><div class="memberProfMenuBtnIcon" style="background-image: url('images/MemberProfSetting.png');"></div><span id="memberProfSetting">환경설정</span></div>
			<div class="memberProfMenuBtn" id="logoutBtn"><div class="memberProfMenuBtnIcon" style="background-image: url('images/MemberProfLogout.png');"></div><span id="memberProfLogout">로그아웃</span></div>
		</div>
	</div>
	<div class ="create-flow-background-1" style="display: none">
		<div class = "project-make-1">
			<div class ="project-make-2">
				<div class = "create-post">
					<div class = "create-post-header">
						<div class = "header-left">
							<h4 class ="create-post-title">게시물 작성</h4>
							<div class = "select-project-btn" style="display:flex">
								<i class = "postArrowicon" style="display:block"></i>
								<div class = "post-project-color color-code-<%=pdao.ProjectMemberColorView(memberIdx,projectIdx)%>"></div>
								<p class = "post-project-title"><%=PVPdto.getProjectName() %></p>
							</div>
							<div class = "search-post-project" style = "display:none">
								<div>
									<i class ="icon-search"></i>
									<input class = "select-project-search" type ="text" placeholder="프로젝트명으로 검색하세요.">
								</div>
								<ul class = "select-project-list">
									<%ArrayList<MyProjectViewDto> MPlist =  pdao.MyProjectView(memberIdx,0,0); %>
									<%for(MyProjectViewDto MPVdto : MPlist) { %>
									<li class ="project-item" data-pno = <%=MPVdto.getProjectIdx() %>>
										<div class = "squre color-code-<%=MPVdto.getProjectColor()%>"></div>
										<p class ="project-title-value"><%=MPVdto.getProjectName() %></p>
									</li>
									<% } %>
								</ul>
							</div>
						</div>
						<button class = "btn-minimize">
							<i class = "btn-minimize-icon"></i>
						</button>
						<button class = "btn-close">
							<i class ="btn-close-icon"></i>
						</button>
					</div>
					<ul class = "create-post-nav">
						<li class = "post-type-item">
							<button class = "create-tab-write" id = "crt-post">
								<i class ="write-icon"></i>
								<span>글</span>
							</button>
						</li>
						<li class = "post-type-item">
							<button class = "create-tab-write" id = "crt-task">
								<i class ="task2-icon"></i>
								<span>업무</span>
							</button>
						</li>
						<li class = "post-type-item">
							<button class = "create-tab-write" id = "crt-schedule">
								<i class ="schedule-icon"></i>
								<span>일정</span>
							</button>
						</li>
					</ul>
					<div class = "create-post-main">
						<div>
							<fieldset>
								<div>
									<input class = "postTitle" type = "text" placeholder = "제목을 입력하세요." maxlength="200">
								</div>
								<div class = "post-content-box-post" style = "display:none">
									<div class = "create-content-area">
										<div class = "create-content-value" placeholder = "내용을 입력하세요." contenteditable="true"></div>
									</div>
								</div>
								<div class = "task-area"style = "display:none">
									<div class = "task-options">
										<ul class ="create-task-content-group">
											<li class = "task-state-area">
												<div class = "task-content-cell task-icon">
													<i class = "task-state-img"></i>
												</div>
												<div class = "task-content-cell">
													<div class = "task-state-btn-group">
														<button class = "task-state-btn request on">요청</button>
														<button class = "task-state-btn progress">진행</button>
														<button class = "task-state-btn feedback">피드백</button>
														<button class = "task-state-btn complete">완료</button>
														<button class = "task-state-btn hold">보류</button>
													</div>
												</div>
											</li>
											<li class = "task-manager-area" style= "display:flex">
												<div class = "task-content-cell task-icon">
													<i class = "task-manager-image"></i>
												</div>
												<div class = "task-content-cell">
													<div class = "user-box">
														<span class = "manager-group">
														</span>
														<input type = "text" class = "manager-search-input" placeholder="담당자 추가" style="display: inline-block">
														<div class = "search-manager-box" style = "display:none">
															<div class = "sub-manager-group">
																<div class = "sub-manager-list">
																	<ul class ="sub-manager-list-box">
																	<%ArrayList<ProjectMemberViewDto> PMVlist = pdao.participantselect(projectIdx); %>
																	<%for(ProjectMemberViewDto PMVdto : PMVlist) { %>
																		<li class = "select-list" data-mno=<%=PMVdto.getMemberIdx() %>>
																			<div class = "registration-list">
																				<div class = "profile-img-box"
																				style="background-image: url('<%=PMVdto.getProfileImg()%>')"></div>
																				<div class = "profile-content-box">
																					<div class = "profile-content1">
																						<div class = "registration-name"><%=PMVdto.getName() %></div>
																						<span class = "registration-position"><%=PMVdto.getPosition() %></span>
																					</div>
																					<div class = "profile-content2">
																						<div class = "registration-company"><%=PMVdto.getCompanyName() %></div>
																						<div class = "registration-team"><%=PMVdto.getDepartmentName() %></div>
																					</div>
																				</div>
																			</div>
																		</li>
																	<% } %>
																		<div class = "select-nulls" style = "display:none">
																			<div class = "select-null">
																				<span>검색 결과가 없습니다.</span>
																			</div>
																		</div>
																	</ul>
																</div>
															</div>
														</div>
													</div>
												</div>
											</li>
											<li class = "task-startdate-area" style= "display:none">
												<div class = "task-content-cell task-icon">
													<i class = "icon-date"></i>
												</div>
												<div class = "task-content-cell">
													<div class = "data-content">
														<span class = "input-data-text"></span>
														<label type="button" class="input-date" style="display:flex">
															<input type = "text" class="input-start-datas datepicker" id="datepicker1" style="display: inline-block;" placeholder="시작일추가" id="dp1737514628589">
														</label>
													</div>
														<button class="board-remove-btn"style = "display: none;" ></button>
												</div>
											</li>
											<li class = "task-enddate-area" style= "display:flex">
												<div class = "task-content-cell task-icon">
													<i class = "icon-date"></i>
												</div>
												<div class = "task-content-cell">
													<div class = "data-content">
														<span class = "input-data-text"></span>
														<label type="button" class="input-date" style="display:flex">
															<input type = "text" class="input-end-datas datepicker" id="datepicker2" style="display: inline-block;" placeholder="마감일추가" id="dp1737514628589">
														</label>
													</div>
														<button class="board-remove-btn" style = "display: none;"></button>
												</div>
											</li>
											<li class = "task-priority-area" style= "display:none">
												<div class = "task-content-cell task-icon">
													<i class  = "icon-priority"></i>
												</div>
												<div class = "task-content-cell">
													<div class = "data-content">
														<button class = "input-data-priority" style="display:">우선순위 추가</button>
														<div class = "priority-span" style="display: inline-block">
															<i class = "icons"></i>
															<span class = "priority-text"></span>
														</div>
															<button class = "board-remove-btn" style="display:none"></button>
														<div class = "priority-layer" style = "display:none">
															<button class = "priority-btn" id = "low">
																<span>
																	<i class = "low"></i>
																</span>
																낮음
															</button>
															<button class = "priority-btn" id = "middle">
																<span>
																	<i class = "middle"></i>
																</span>
																중간
															</button>
															<button class = "priority-btn" id = "high">
																<span>
																	<i class = "high"></i>
																</span>
																높음
															</button>
															<button class = "priority-btn" id = "emergency">
																<span>
																	<i class = "emergency"></i>
																</span>
																긴급
															</button>
														</div>
													</div>
												</div>
											</li>
											<li class = "task-group-area" style= "display:none">
												<div class = "task-content-cell task-icon">
													<i class = "task-group-img"></i>
												</div>
												<div class = "task-content-cell">
													<div class = "data-content">
														<button class = "input-data-group" style="display:">그룹 추가</button>
														<div class = "task-group-value" style="display: inline-block">
															<span class = "task-group-values"></span>
														</div>													
															<button class = "board-remove-btn" style="float:right; display:none"></button>
														<div class = "task-group-list-layer" style="display:none">
															<div class = "task-group-list-box">
																<ul>
																	<%ArrayList<TaskGroupViewDto> TGVlist = tdao.TaskGroupView(projectIdx); %>
																	<%for(TaskGroupViewDto TGVdto : TGVlist) { %>
																	<li>
																		<div class = "task-group-items" data-code =<%=TGVdto.getTaskGroupIdx() %>>
																			<div class = "task-group-name-boxs"><%=TGVdto.getTaskGroupName() %></div>
																		</div>
																	</li>
																	<% } %>
																	<li>
																		<div class = "task-group-items"  data-code ="0" id = "none-group">
																			<div class = "task-group-name-boxs">그룹 미지정</div>
																		</div>
																	</li>
																</ul>
															</div>
														</div>
													</div>
												</div>
											</li>
											<li class = "task-progress-area" style= "display:none">
												<div class = "task-content-cell task-icon">
													<i class = "task-progress-img"></i>
												</div>
												<div class = "task-content-cell">
													<div class = "progress-bar" style="width:0%"></div>
													<div class = "progress-graph">
														<span class = "progress-btn"><em>0%</em></span>
														<span class = "progress-btn"><em>10%</em></span>
														<span class = "progress-btn"><em>20%</em></span>
														<span class = "progress-btn"><em>30%</em></span>
														<span class = "progress-btn"><em>40%</em></span>
														<span class = "progress-btn"><em>50%</em></span>
														<span class = "progress-btn"><em>60%</em></span>
														<span class = "progress-btn"><em>70%</em></span>
														<span class = "progress-btn"><em>80%</em></span>
														<span class = "progress-btn"><em>90%</em></span>
														<span class = "progress-btn"><em>100%</em></span>
													</div>
													<span class = "progress-text">0%</span>
												</div>
											</li>
										</ul>
										<button class = "task-more-add-btn" style="display:block">
											<i class = "plus-icon"></i>
											항목추가입력
										</button>
									</div>
									<div class = "create-content-area">
										<div class = "create-content-value" placeholder = "내용을 입력하세요." contenteditable="true"></div>
									</div>
								</div>
								<div class="schedule-add-content-box" style = "display:none">
									<div class="content-date-select">
										<img id="date-select-icon" src="images/date-select-icon.png"/>
										<input type="text" id="startDateInput" class="date-select-input datetimepicker" value=""/>
										<div></div>
										<input type="text" id="endDateInput" class="date-select-input datetimepicker" value=""/>
										<label for="all-day-check"><input type="checkbox" id="all-day-check"/>종일</label>
									</div>
									<div class="content-member-select">
										<img id="member-select-icon" src="images/member-select-icon.png"/>
										<div id="memberItemsWrap" style="display: flex;">
											<span class="member-item-box" data-idx="<%=memberIdx %>">
												<img class="user-prof" src="<%=profile%>"/>
												<span><%=name %></span>
												<button type="button" class="participantRemoveBtn"></button>
											</span>
										</div>
										<div id="participantSelectBox">
											<input type="text" id="member-add-input" placeholder="참석자 추가"/>
											<table id="participantSelectTable" style="display: none;">
												<tr>
													<%for(ProjectMemberListDto pmdto : pmList) { %>
														<td class="selectMemberItem" data-idx="<%=pmdto.getMemberIdx()%>">
															<img src="<%=pmdto.getProf()%>" class="participantProfileImg"/>
															<div class="participantInfoWrap">
																<div class="participantNameAndPositiondiv"><span class="participantName"><%=pmdto.getMemberName()%></span><span class="participantPosition"><%=pmdto.getPosition()%><span></div>
																<div class="participantSelectCompanyName"><%=pmdto.getCompanyName()%></div>
															</div>
														</td>
													<%} %>
												</tr>
											</table>
										</div>
									</div>
									<div class="content-location-select">
										<img id="location-select-icon" src="images/location-select-icon.png"/>
										<div>
											<input type="text" id="loaction-input" placeholder="장소를 입력하세요"/>
										</div>
									</div>
									<div class="content-alarm-select">
										<img id="alarm-select-icon" src="images/alarm-select-icon.png"/>
										<select class="alarm-select">
											<option>없음</option>
											<option>10분 전 미리 알림</option>
											<option>30분 전 미리 알림</option>
											<option>1 시간 전 미리 알림</option>
											<option>2 시간 전 미리 알림</option>
											<option>3 시간 전 미리 알림</option>
											<option>1일 전 미리 알림</option>
											<option>2일 전 미리 알림</option>
											<option>7일 전 미리 알림</option>
										</select>
									</div>
									<div class="add-content-box">
										<div class="create-content-value" placeholder="내용을 입력하세요." contenteditable="true"></div>
									</div>
								</div>
							</fieldset>
						</div>
					</div>
					<div class = "create-post-bottom">
						<ul class = "create-btn-group">
							<li class = "create-bottom-item" style= "display: inline-block">
								<button class = "create-file-btn">
									<i class = "create-file-icon"></i>
								</button>
								<div class = "upload-menu">
									<button class ="file-option pc-upload">
										<i class = "icon-pc"></i>
										내 컴퓨터
									</button>
									<button class ="file-option flow-file-upload">
										<i class = "icon-flowbox"></i>
										파일함
									</button>
								</div>
							</li>
							<li class = "create-bottom-item" style= "display: inline-block">
								<button class = "create-place-btn">
									<i class = "create-place-icon"></i>
								</button>
							</li>
						</ul>
						<div class = "create-right-menu">
							<div class = "create-private-btn off full" style = "display: inline-block">전체 공개</div>
							<ul class = "create-post-option" style ="display:none">
								<li>
									<div class = "private-option-full">
										<i class = "private-option-full-icon"></i>
										전체 공개
									</div>
								</li>
								<li>
									<div class = "private-option-admin">
										<i class = "private-option-admin-icon"></i>
										프로젝트 관리자만
									</div>
								</li>
							</ul>
							<a class = "temporary-storage">
								<span class = "temporary-btn">임시저장</span>
								<span class = "temporary-count">0</span>
							</a>
							<button class ="create-post-submit-btn" style = "display: inline-block">등록</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="leftside" class="fl">
		<c:choose>
			<c:when test="${companyLogo != null }">
				<div class = "home_btn"><span><img src="upload/${companyLogo}" style = "margin: 0 auto;"/></span></div>	<!-- 로고div -->
			</c:when>
			<c:otherwise>
				<div class = "home_btn"><span><img src="https://flow.team/flow-renewal/assets/images/logo/logo-flow.svg"/></span></div>	<!-- 로고div -->
			</c:otherwise>
		</c:choose>
		<div>	<!-- 새 프로젝트 -->
			<div class="black_box">
				<svg width="21" height="21" viewBox="0 0 21 21" fill="none" xmlns="http://www.w3.org/2000/svg"><circle cx="18.1445" cy="5.3125" r="1.5" fill="#FF3434"/><path fill-rule="evenodd" clip-rule="evenodd" d="M12.8956 3.66602H3.66797C2.5634 3.66602 1.66797 4.56145 1.66797 5.66602V15.666C1.66797 16.7706 2.5634 17.666 3.66797 17.666H17.168C18.2725 17.666 19.168 16.7706 19.168 15.666V9.944H18.168V15.666C18.168 16.2183 17.7203 16.666 17.168 16.666H3.66797C3.11568 16.666 2.66797 16.2183 2.66797 15.666V5.66602C2.66797 5.11373 3.11568 4.66602 3.66797 4.66602H12.8956V3.66602Z" fill="white"/><line x1="11.0234" y1="4.16699" x2="13.0898" y2="4.16699" stroke="white" stroke-linecap="round"/><line x1="18.668" y1="11.8604" x2="18.668" y2="9.79395" stroke="white" stroke-linecap="round"/></svg>
				<span>새 프로젝트</span>
			</div>
		</div>
		<div class="left_upper">	<!-- 대시보드, 내 프로젝트, 회사공개프로젝트, 더보기 -->
			<div class="left_items" id = "dashboard"><span>대시보드</span></div>
			<div class="left_items" id = "myproject"><span>내 프로젝트</span></div>
			<div class="left_items" id = "publicProject"><span>회사 공개 프로젝트</span></div>
		</div>
		<div id="left_lowers">
			<div class="left_lower">  <!-- 'closed' -->	<!-- [모아보기] -->
				<div class="title open">모아보기</div>
				<div class="left_items" id = "bookmark"><span>북마크</span></div>
				<div class="left_items" id = "myBoard"><span>내게시물</span></div>
				<!-- <div class="left_items"><span>What if ...?</span></div>
				<div class="left_items"><span>What if ...?</span></div>
				<div class="left_items"><span>What if ...?</span></div>
				<div class="left_items"><span>What if ...?</span></div>
				<div class="left_items"><span>What if ...?</span></div>
				<div class="left_items"><span>What if ...?</span></div>
				<div class="left_items"><span>What if ...?</span></div>
				<div class="left_items"><span>What if ...?</span></div>
				<div class="left_items"><span>What if ...?</span></div>
				<div class="left_items"><span>What if ...?</span></div> -->
			</div>
			<div class="left_lower"> <!-- 'closed' -->	<!-- [최근 업데이트] -->
				<div class="title open">최근 업데이트</div>
				<%for(MyProjectViewDto dto : MPlist2) { %>
					<div class="left_items_color" data-pno = <%=dto.getProjectIdx() %>><span class = "color-code-<%=dto.getProjectColor()%>"></span><span><%=dto.getProjectName() %></span></div>
				<%} %>
			</div>
			<div class="left_lower"> <!-- 'closed' -->	<!-- [프로젝트 폴더] -->
				<div class="title open">프로젝트 폴더
				<span class= "plus"></span>
				</div>
				<%for(ProjectUserFolder dto : PUFlist) { %>
				<div class="left_items" data-fno = <%=dto.getFolderIdx() %>><span class = projectFolderName><%=dto.getName() %></span><span class = "projectFolderMenu"></span>
					<ul class="Project-folder-setting-layer" style="display: none;">
						<li class="Project-folder-set-item-edit">
							<i class="post-edit-icon"></i>
							수정
						</li>
						<li class="Project-folder-set-item-del">
							<i class="post-del-icon"></i>
							삭제
						</li>
					</ul>
				</div>
				<% } %>
			</div>
		</div>
		<div class="left_bottom"> <!-- 직원 초대 -->
			<div class="left_items" id = "inviteURL"><span>직원 초대</span>
				<input type="hidden" id="data-invite-area" class="data-invite-area" value="초대링크">
			</div>
			<c:choose>
				<c:when test="${adminYN == 'Y'}">
					<div class="left_items" id = "admin"><span>어드민</span></div>
				</c:when>
				<c:otherwise>
					<div class="left_items" id = "admin" style = "display:none"><span>어드민</span></div>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	<div id="rightside" class="fr">
		<div class = "side-chatting-room" style = "display:none">
			<div class = "chatting-back-area" style = "display:none">
				<div class ="chatting-back-area1">
					<div class = "chatting-back-area2">
						<div class = "change-chat-title-box" style = "display:none">
							<div class = "change-chat-title-background"></div>
							<div class = "change-chat-title-box-area">
								<div class = "change-chat-title-box-header">
									<div class = "change-chat-title">채팅방 이름 설정</div>
									<button class = "change-chat-title-close"></button>
								</div>
								<div class = "change-chat-title-box-content">
									<div class = "change-chat-title-input-box">
										<input type = "text" class = "change-chat-title-input">
									</div>
									<div class = "change-chat-title-box-button">
										<button class = "change-chat-title-cancle">취소</button>
										<button class = "change-chat-title-submit">확인</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class = "chatting-room-header">
				<div class = "chatting-title">
					<div class = "chatting-profile-img"></div>
					<strong>
						<span class = "Chat-name">123</span>
						<div class ="chat-info">
							<em class = "chat-member-count">
								<i class = "chat-icon"></i>
								<span class = "chat-room-member-count">1</span>
							</em>
						</div>
					</strong>
					<button class = "chat-room-more-btn"></button>
				</div>
			</div>
			<ul class = "chatting-room-message">
				<div class = "chat-date">
					<span></span>
				</div>
			</ul>
			<div class = "chatting-input-area">
				<div class = "chatting-room-bottom">
					<div class = "chat-write-area">
						<div class = "create-chat-container">
							<fieldset>
								<div class = "messengerInput">
									<div class="create-chat-input-box" contenteditable="true" placeholder="메시지를 입력하세요. ( 줄바꿈 Shift + Enter)"></div>
									<button class="btn-chat-enter">전송</button>
								</div>
							</fieldset>
						</div>
					</div>
				</div>
			</div>
			<div class = "Chat-more-menu-layer" style = "display:none">
				<div class = "Chat-more-menu-background"></div>
				<div class = "Chat-more-menu-area">
					<div class = "Chat-more-menu-box">
						<div class = "Chat-more-menu-middle">
							<button class = "projectMoveButton chat-btn-01" style = "display:none">프로젝트 바로가기</button>
							<button class = "ChatInviteButton chat-btn-01"></button>
							<div class = "chat-menu-title">
								<b class = "chat-participant-text">참여자</b>
								<span class = "chat-participant-count"></span>
							</div>
							<ul class = "chat-participants-list">
								
							</ul>
						</div>
						<div class = "Chat-more-menu-bottom">
							<div class = "Chat-room-setting-btn-area">
								<button class = "Chat-room-out"></button>
								<div class = "Chat-room-setting-btn-area-right">
									<button class = "Chat-room-Setting-btn">
										<i class = "chat-Setting-icon"></i>
									</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class = "Chat-Setting-layer"  style = "display:none">
				<div class = "Chat-Setting-background"></div>
				<div class = "chat-room-Setting-area">
					<div class ="chat-room-Setting-top">
						<strong>채팅 설정</strong>
						<button class = "chat-close-btn"></button>
					</div>
					<div class ="chat-room-Setting-main">
						<strong class = "setting-tit">채팅 이름 설정</strong>
						<div class = "setting-box">
							<div class = "setting-chat-Name"></div>
							<button class = "setting-chat-Name-change"></button>
						</div>
					</div>
					<div class ="chat-room-Setting-bottom">
						<button class = "chat-room-exit-btn">채팅 나가기</button>
					</div>
				</div>
			</div>
		</div>
		<div class = "side-chat" style = "display:none">
			<div class ="chat-menu-header">
				<strong>채팅</strong>
				<button class = "side-chat-menu-close"></button>
			</div>
			<div class = "chat-menu-main">
				<ul class = "chat-menu-mainmenu">
					<li class = "chatBtn">
						<span class = "chatTab on">채팅</span>
					</li>
					<li class = "contactBtn">
						<span class = "contactTab">연락처</span>
					</li>
				</ul>
				<div class = "chat-menu-mainmenu-right">
					<button class = "new-chat-create-btn">
						<i class = "icon-chat"></i>
						<span>새 채팅</span>
					</button>
				</div>
				<div class = "chat-search-area">
					<i class = "icons-search" style = "top: -14px;"></i>
					<input class = "chat-search" id ="chat-search-value" placeholder = "이름, 채팅방명 검색">
					<input class = "chat-search" id = "contact-search-value" placeholder = "이름, 소속, 전화번호 검색" style = "display:none;">
				</div>
				<ul id = "ChatUl" class = "participants-list" style = "display:block">
					<%for(ChatRoomListDto dto : Clist) { %>
					<li class = "chatting-item" data-chno = <%=dto.getChatRoomIdx() %>>
						<div class = "chatting-item-main">
							<div class = "chatting-room-img">
								<div class = "profile-img" style = "background-image: url('https://team-0aanf8.flow.team/flowImg/FLOW_202104235852152_d5111f66-1d9c-4806-bdff-bbcde78d0546.png?width=400&height=400'), url('https://team-0aanf8.flow.team/flowImg/FLOW_202104235852152_d5111f66-1d9c-4806-bdff-bbcde78d0546.png'), url('/flow-renewal/assets/images/profile-default.svg');"></div>
							</div>
							<div class = "chatting-room-author">
								<p>
									<strong class = "chat-title"><%=dto.getChatRoomName() %></strong>
									<span class = "chat-count" style = "display:none"></span>
								</p>
								<p class = "chat-author-gray">
									<span class = "last-chat"><%=dto.getConversation() %></span>
								</p>
							</div>
							<div class = "Chatting-room-more-setting">
								<div class = "last-chat-date"><%=dto.getAmPm() %> <%=dto.getTime() %></div>
							</div>
						</div>
					</li>
					<% } %>
				</ul>
				<ul id = "ContactUl" class = "participants-list" style = "display:none">
					<%for(MemberDto dto : Mlist) { %>
					<li class = "participant-item" data-mno = <%=dto.getMemberIdx() %>>
						<div class = "posts-author">
							<span class="profile-img" style="background-image: url('<%= dto.getProfileImg() %>');"></span>
							<dl class="post-author-info">
				                <dt>
				                    <strong class="post-name"><%=dto.getName() %></strong>
				                    <em class="position"><%=dto.getPosition() %></em>
				                </dt>
				                <dd>
				                    <strong class="company-name"><%=dto.getCompanyName() %></strong>
				                    <span class="department-name"><%=dto.getDepartmentName() %></span>
				                </dd>
				            </dl>
						</div>
						<button class = "participant-chat-button">
							<i class = "chat-img"></i>
						</button>
					</li>
					<% } %>
				</ul>
			</div>
		</div>
		<div class="mainarea">
			<div class="mainheader">
				<div class = "titleheader">
					<div class = "headerdetail">
						<div class = "headerarea" style = "display : block">
							<div class = "color-area" id = "mainheaders">
								<i class = "color-boxs color-code-<%=projectColor%>">
								</i>
							</div>
							<div class = "text-area" id = "mainheaders">
								<div class = "titlearea">
									<div class = "projectbtn" id = "headertitle">
										<%if(pdao.ProjectFavoritesYN(projectIdx, memberIdx) == 'Y') { %>
										<div class = "star-btn">
											<button class = "star-button active"></button>
										</div>
										<%} else { %>
										<div class = "star-btn">
											<button class = "star-button"></button>
										</div>
										<% } %>
										<button class = "set-btn">
											<span class = "firstspan"></span>
											<span></span>
											<span></span>
										</button>
										<div class = "project-option-layer">
											<div class = "project-option-header">
												<span>프로젝트 번호</span>
												<em id = "project-idx"><%=projectIdx%></em>
											</div>
											<ul class = "project-option-area">
												<li id = "color-set">
													<i class = "icon-set-color"></i>
													<span>색상 설정</span>
												</li>
												<li id = "project-set">
													<i class = "icon-set-project-folder"></i>
													<span>프로젝트 폴더 설정</span>
												</li>
												<li id = "project-exit-set">
													<i class = "icon-set-project-exit"></i>
													<span>프로젝트 나가기</span>
												</li>
												<%if(adminMy == 'Y') { %>
												<li id = "project-edit-set">
													<i class = "icon-set-project-edit"></i>
													<span>프로젝트 수정</span>
												</li>
												<li id = "project-delete-set">
													<i class = "icon-set-project-delete"></i>
													<span>프로젝트 삭제</span>
												</li>
												<% } %>
											</ul>
										</div>
									</div>
									<div class = "projecttitle" id = "headertitle"><%=pdto.getProjectName() %></div>
									<div class = "project-status-group">
										<%if(pvdto.getApprovalYN() == 'Y') { %>
											<div class = "admin_project">
												<i class = "admin-icon"></i>
											</div>
										<% } else { %>
											<div class = "admin_project" style = "display:none">
												<i class = "admin-icon"></i>
											</div>
										<% } %>
										<%if(pvdto.getCompanyProjectYN() == 'Y') { %>
											<div class = "company_project">
												<i class = "company-icon"></i>
											</div>
										<% } else { %>
											<div class = "company_project" style = "display:none">
												<i class = "company-icon"></i>
											</div>
										<% }%>
										<%if(pvdto.getCategoryIdx() > 0) { %>
											<div class = "public_project">
												<i class = "public-icon"></i>
											</div>
										<% } else { %>
											<div class = "public_project" style = "display:none">
												<i class = "public-icon"></i>
											</div>
										<% } %>
										<%if(projectOutsidermember>0) { %>
											<div class = "outsider_project">
												<span class="outsider-text" mouseover-text="프로젝트에 외부 사용자가 있습니다">외부</span>
											</div>
										<% } else { %>
											<div class = "outsider_project">
												<span class="outsider-text" mouseover-text="프로젝트에 외부 사용자가 있습니다" style = "display:none">외부</span>
											</div>
										<% } %>
									</div>
								</div>
								<div class = "project-description">
									<p class = "project-description-content">
									<%if(pvdto.getProjectExplanation()!=null) {%>
										<%= pvdto.getProjectExplanation() %>
									<% } %>
									</p>
								</div>
							</div>
						</div>
					</div>
				</div>
				<button class = "private">
					<div class = "privateicon"></div>
					<div class = "privatename">초대하기</div>
				</button>
			</div>
			<div class = "mainbody">
				<div class = mainbody-box>
					<div class = "mainbody-header">
						<div class = "mainbody-headeroption">
							<div class = "headeroption" id = "feedoption">
								<div class = "feedcontent">
									<%if(pvdto.getHomeTab().equals("피드")) { %>
										<div class = "hometab" style = "display: block;"></div>
									<% } else { %>
										<div class = "hometab" style = "display: none;"></div>
									<% } %>
									<div class = "feedtext">피드</div>
								</div>
							</div>
							<div class = "headeroption" id = "taskoption">
								<div class = "taskcontent">
									<%if(pvdto.getHomeTab().equals("업무")) { %>
										<div class = "hometab" style = "display: block;"></div>
									<% } else { %>
										<div class = "hometab" style = "display: none;"></div>
									<% } %>
									<div class = "tasktext">업무</div>
								</div>
							</div>
							<div class = "headeroption" id = "calenderoption">
								<div class = "calendercontent">
									<%if(pvdto.getHomeTab().equals("캘린더")) { %>
										<div class = "hometab" style = "display: block;"></div>
									<% } else { %>
										<div class = "hometab" style = "display: none;"></div>
									<% } %>
									<div class = "calendertext">캘린더</div>
								</div>
							</div>
							<div class = "headeroption" id = "alarmoption">
								<div class = "alarmcontent">
									<div class = "alarmtext">알림</div>
								</div>
							</div>
						</div>
					</div>
					<div class = "maincontent" style = "display:block">
						<div class = "main-content">
							<div class = "main-value">
								<div class = "board-create">
									<div class = "create-box">
										<div class = "create-type">
											<div class = "create-txt" id = "writing">
												<div class = "write-img"></div>
												<div class = "write-txt">글</div>
											</div>
											<div class = "create-txt" id = "task">
												<div class = "task-img"></div>
												<div class = "task-txt">업무</div>
											</div>
											<div class = "create-txt" id = "schedule">
												<div class = "schedule-img"></div>
												<div class = "schedule-txt">일정</div>
											</div>
										</div>
										<div class = "create-content">
											<div class = "create-text" id = "create-text">내용을 입력하세요.</div>
											<div class = "create-text" id = "create-textimg">
												<div class = "create-img" id = "create-fileimg"></div>
												<div class = "create-img" id = "create-pictureimg"></div>
												<div class = "create-img" id = "create-typingimg"></div>
											</div>
										</div>
									</div>
								</div>
								<%if(bdao.TopFixedCount(projectIdx)!=0) { %>
								<div class = "top-fixed">
									<div class = "fixed-header">
										<div class = "fixed-headname">
											<div class = "fixed-headtxt" id = "fixed-headtext">상단고정</div>
											<div class = "fixed-headtxt" id = "fixed-headcnt"><%=bdao.TopFixedCount(projectIdx) %></div>
										</div>
									</div>
									<ul class = "fixed-body" style = "height:auto">
									<% ArrayList<BoardTopFixedDto> BTFList = bdao.BoardTopFixCategory(projectIdx); %>
									<%for(BoardTopFixedDto Btdto : BTFList) { %>
									<% BoardTopFixedDto Btdto2 = bdao.BoardTopFixView(Btdto.getBoardIdx(), Btdto.getCategory()); %>
									<%if(Btdto.getCategory().equals("글")) { %>
										<li class = "item-fixed" id = "post-fixed" data-bno = <%=Btdto.getBoardIdx()%>>
											<span class = "pin-drag"></span>
											<a href="#board<%=Btdto.getBoardIdx()%>">
												<div class = "fixed-box">
													<div class = "fixed" id = "fixed-img">
														<div class = "fixed-image-post"></div>
													</div>
													<div class = "fixed" id = "fixed-txt" >
														<div class = "fixed-content">
															<div class = "fix-image"></div>
															<div class = "fixed-title"><%=Btdto2.getTitle()%></div>
														</div>
													</div>
												</div>
											</a>
										</li>
									<% } %>
									<%if(Btdto.getCategory().equals("업무")) { %>
										<li class = "item-fixed" id = "task-fixed" data-bno = <%=Btdto.getBoardIdx()%>>
											<span class = "pin-drag"></span>
											<a href="#board<%=Btdto.getBoardIdx()%>">
												<div class = "fixed-box">
													<div class = "fixed" id = "fixed-img">
														<div class = "fixed-image-task"></div>
													</div>
													<div class = "fixed" id = "fixed-txt">
														<div class = "fixed-content">
															<div class = "fix-image"></div>
															<div class = "fixed-title"><%=Btdto2.getTitle()%></div>
														</div>
													</div>
													<div class = "fixed" id = "fixed-value">
														<%if(Btdto2.getState() == 1)  {%>
														<div class = "fixed-state request">요청</div>
														<% } %>
														<%if(Btdto2.getState() == 2)  {%>
														<div class = "fixed-state progress">진행</div>
														<% } %>
														<%if(Btdto2.getState() == 3)  {%>
														<div class = "fixed-state feedback">피드백</div>
														<% } %>
														<%if(Btdto2.getState() == 4)  {%>
														<div class = "fixed-state complete">완료</div>
														<% } %>
														<%if(Btdto2.getState() == 5)  {%>
														<div class = "fixed-state hold">보류</div>
														<% } %>
													</div>
												</div>
											</a>
										</li>
									<% } %>
									<%if(Btdto.getCategory().equals("일정")) { %>
										<li class = "item-fixed" id = "schedule-fixed" data-bno = <%=Btdto.getBoardIdx()%>>
											<span class = "pin-drag"></span>
											<a href="#board<%=Btdto.getBoardIdx()%>">
												<div class = "fixed-box">
													<div class = "fixed" id = "fixed-img">
														<div class = "fixed-image-calander"></div>
													</div>
													<div class = "fixed" id = "fixed-txt" >
														<div class = "fixed-content">
															<div class = "fix-image"></div>
															<div class = "fixed-title"><%=Btdto2.getTitle()%></div>
														</div>
														<div class = "fixed-writedate">
															<div class = "fixed-date">
																<%
																    String fixStartDate = Btdto2.getStartDate();
																    if (fixStartDate != null) {
																        if (fixStartDate.endsWith("00:00:00")) {%>
																            <%=fixStartDate.substring(0, 10) %>
																<%      } else { %>
																            <%=fixStartDate.substring(0, 16)%>
																     <% }
																    }
																%>
																
																- 
																
																<%
																    String fixendDate = Btdto2.getEndDate();
																    if (fixendDate != null) {
																        if (fixendDate.endsWith("00:00:00")) {%>
																            <%=fixendDate.substring(0, 10) %>
																<%      } else { %>
																            <%=fixendDate.substring(0, 16)%>
																     <% }
																    }
																%>
															</div>
														</div>
													</div>
													<div class = "fixed" id = "fixed-value"></div>
												</div>
											</a>
										</li>
									<% } %>
									<% } %>
									</ul>
								</div>
								<% } %>
								<div class = "feed-area">
									<div class = "feed-entire">
										<div class ="entire-txt">
											<div class = "entire-txt-title">전체</div>
										</div>
										<div class ="entire-btn">
											<button class = "entire-button" id = "entire-filter-btn">
												<div class = "entire-button-content" id = "entire-filter-img"></div>
												<div class = "entire-button-content" id = "entire-filter-title">필터</div>
											</button>
											<ul class = "feed-filter-layer">
												<li>
													<div class="check-menu-item active">전체</div>
												</li>
												<li>
													<div class="check-menu-item">글</div>
												</li>
												<li>
													<div class="check-menu-item">업무</div>
												</li>
												<li>
													<div class="check-menu-item">일정</div>
												</li>
											</ul>
										</div>
									</div>
									<div class = "feed-contentarea">
										<div class = "feed-post">
										<%if(bdao.boardCount(projectIdx)==0) {%>
											<div class = "noDetailData">
												<img src="https://flow.team/flow-renewal/assets/images/none_member.png">
												<p class ="none-text">
												현재 글이 없습니다 
												<br>
												새로운 글을 생성해 주세요.
												</p>
											</div>
										<% } else { %>
											<div class = "noDetailData" style = "display:none">
												<img src="https://flow.team/flow-renewal/assets/images/none_member.png">
												<p class ="none-text">
												현재 글이 없습니다 
												<br>
												새로운 글을 생성해 주세요.
												</p>
											</div>
										<% } %>
										<%ArrayList<BoardTopFixedDto> Slist = bdao.SearchIdxOrCategory(projectIdx); %>
										<%for(BoardTopFixedDto bdto2 : Slist)  {%>
											<%if(bdto2.getCategory().equals("글")) { %>
											<%BoardPostViewDto bdto3 = bdao.PostViewBoard(bdto2.getBoardIdx());%>
												<div class = "feed-board" id = "board<%=bdto2.getBoardIdx()%>" data-category="글" data-bno=<%=bdto2.getBoardIdx()%>>
												<div class = "feed-board-1">
													<div class = "feed-board-2">
														<div class = "feed-board-header-top">
															<div class = "feed-board-writer">
																<span class = "feed-board-writer1-img" style = "background:url('<%=bdto3.getProfileImg() %>'); no-repeat center center; background-size: cover;"></span>
																<div class = "feed-board-writer-date">
																	<div class = "feed-board-writer-date-box">
																		<div class = "feed-board-writer-name"><%=bdto3.getName() %></div>
																		<div class = "feed-board-date"><%=bdto3.getWriteDate() %></div>
																		<%if(bdto3.getReleaseYN()=='N') { %>
																			<div class = "feed-lock-icon">
																				<div class = "feed-lock-icon-img"></div>
																			</div>
																		<% } else { %>
																			<div class = "feed-people-icon">
																				<div class = "feed-people-icon-img"></div>
																			</div>
																		<% } %>
																	</div>
																</div>
																<div class="feed-post-option">
																	<button class="feed-board-fixbtn" style="display:block">
																	<%if(bdto3.getTopFixed()=='N') { %>
																		<div class="feed-board-fixbtn-img"></div>
																	<% } else { %>
																		<div class="feed-board-fixbtn-img on"></div>
																	<% }  %>
																	</button>
																	<button class="feed-board-optionbtn">
																		<span></span>
																		<span></span>
																		<span></span>
																	</button>
																	<ul class = "board-setting-layer" style = "display:none">
																		<li class = "board-set-item-edit">
																			<i class = "post-edit-icon"></i>
																			수정
																		</li>
																		<li class = "board-set-item-del">
																			<i class = "post-del-icon"></i>
																			삭제
																		</li>
																	</ul>
																</div>
															</div>
														</div>
														<div class="feed-board-header-bottom">
															<div class = "board-title-area">
																<h4 class = "board-title"><%=bdto3.getTitle() %></h4>
															</div>
														</div>
														<div class = "feed-board-main">
															<div class = "board-main-content">
																<p><%=bdto3.getContent() %></p>
															</div>
															<div class = "board-main-option">
																<div class="board-main-option-left">
																	<div class="board-emotion" style="display:block">
																			<div class="board-emotion-group">
																				<%ArrayList<BoardEmotionDto> BElist = bdao.BoardEmotionTypeCount(bdto2.getBoardIdx()); %>
																				<%for(BoardEmotionDto dto : BElist) { %>
																					<%if(dto.getEmotionType()==1 && dto.getCountemotion() >0 ) { %>
																						<div class="emotion1"></div>
																					<% } %>
																					<%if(dto.getEmotionType()==2 && dto.getCountemotion() >0 ) { %>
																						<div class="emotion2"></div>
																					<% } %>
																					<%if(dto.getEmotionType()==3 && dto.getCountemotion() >0 ) { %>
																						<div class="emotion3"></div>
																					<% } %>
																					<%if(dto.getEmotionType()==4 && dto.getCountemotion() >0 ) { %>
																						<div class="emotion4"></div>
																					<% } %>
																					<%if(dto.getEmotionType()==5 && dto.getCountemotion() >0 ) { %>
																						<div class="emotion5"></div>
																					<% } %>
																				<% } %>
																			</div>
																			<%if(bdao.BoardEmotionTotalCount(bdto2.getBoardIdx())>0) { %>
																			<span class="board-emotion-writer">
																				<%ArrayList<BoardEmotionDto> BElist2 =  bdao.BoardEmotionView(bdto2.getBoardIdx(),1); %>
																				<%for(BoardEmotionDto dto : BElist2) { %>
																				<span class="emotion-writer-name"><%=dto.getName() %></span>
																				<% } %>
																				<%if(bdao.BoardEmotionTotalCount(bdto2.getBoardIdx())>1) { %>
																					<span class="emotion-writer-cnt">+<%=bdao.BoardEmotionTotalCount(bdto2.getBoardIdx())-1 %></span>
																				<% } else { %>
																					<span class="emotion-writer-cnt"></span>
																				<% } %>
																			</span> 
																			<% } else { %>
																			<span class="board-emotion-writer">
																				<span class="emotion-writer-name"></span>
																				<span class="emotion-writer-cnt"></span>
																			</span> 
																			<% } %>	
																		</div>
																	<div class="main-option-btn">
																		<%if(bdao.BoardEmotionMine(bdto2.getBoardIdx(),memberIdx)!=0) { %>
																			<button class="emotion-btn on">
																				<div class="emotion-icon on"></div>
																				<%BoardEmotionDto BEdto =  bdao.MyAddEmotionCheck(bdto2.getBoardIdx(),memberIdx); %>
																				<%if(BEdto.getEmotionType()==1) { %>
																					<span class = "emotion-text">좋아요</span>
																				<% } %>
																				<%if(BEdto.getEmotionType()==2) { %>
																					<span class = "emotion-text">부탁해요</span>
																				<% } %>
																				<%if(BEdto.getEmotionType()==3) { %>
																					<span class = "emotion-text">힘들어요</span>
																				<% } %>
																				<%if(BEdto.getEmotionType()==4) { %>
																					<span class = "emotion-text">훌륭해요</span>
																				<% } %>
																				<%if(BEdto.getEmotionType()==5) { %>
																					<span class = "emotion-text">감사해요</span>
																				<% } %>
																			</button>
																		<% } else { %>
																			<button class="emotion-btn">
																				<div class="emotion-icon"></div>
																				<span class = "emotion-text">좋아요</span>
																			</button>
																		<% } %>
																		<button class="bookmark-btn">
																			<%if(bdao.bookmarkView(bdto2.getBoardIdx(),memberIdx)==1) { %>
																				<div class="bookmark-icon on"></div>
																			<% } else { %>
																				<div class="bookmark-icon"></div>
																			<% } %>
																			<span>북마크</span>
																		</button>
																		<div class = "emotion-layer">
																			<ul>
																				<li class = "emotion-item" data-code = "1">
																					<i class = "emotion-1-img"></i>
																					<p>좋아요</p>
																				</li>
																				<li class = "emotion-item" data-code = "2">
																					<i class = "emotion-2-img"></i>
																					<p>부탁해요</p>
																				</li>
																				<li class = "emotion-item" data-code = "3">
																					<i class = "emotion-3-img"></i>
																					<p>힘들어요</p>
																				</li>
																				<li class = "emotion-item" data-code = "4">
																					<i class = "emotion-4-img"></i>
																					<p>훌륭해요</p>
																				</li>
																				<li class = "emotion-item" data-code = "5">
																					<i class = "emotion-5-img"></i>
																					<p>감사해요</p>
																				</li>
																			</ul>
																		</div>
																	</div>
															</div>
															<div class="board-main-option-right">
																<div class="main-option-cnt">
																	<span>읽음</span>
																	<span class="read-cnt-member"><%=bdao.ReadCount(bdto2.getBoardIdx()) %></span>
																</div>
															</div>
															</div>
														</div>
														<%if(bdao.CommentCount(bdto2.getBoardIdx(),0,0)!=0) { %>
														<div class = "feed-board-comment">
															<div class = "comment-content" id ="all">
																<%ArrayList<BoardCommentViewDto> BCVlist = bdao.BoardCommentViewer(bdto2.getBoardIdx(),0); %>
																<%for(BoardCommentViewDto dto : BCVlist) { %>
																<div class = "comment-content-box" data-Idx = <%=dto.getCommentIdx() %>>
																	<div class = "comment-writer-icon">
																		<span class = "comment-writer2-icon-image" style = "background:url('<%=dto.getProfileImg() %>'); no-repeat center center; background-size: cover;"></span>
																	</div>
																	<div class = "comment-content-mainbox">
																		<div class = "mainbox-user">
																			<div class = "mainbox-userbox">
																				<span class = "userbox-username"><%=dto.getName() %></span>
																				<span class = "userbox-record-date"><%=dto.getWriteTime() %></span>
																			</div>
																			<div class = "mainbox-user-option">
																				<button class = "comment-modify">수정</button>
																				<button class = "comment-delete">삭제</button>
																			</div>
																		</div>
																		<div class = "mainbox-content">
																			<div>
																				<div class = "mainbox-content-area">
																					<div>
																						<%=dto.getCommentContent() %>
																					</div>
																				</div>
																			</div>
																		</div>
																	</div>
																	<form class="input-comment" style="display:none">
																		<fieldset>
																			<div class="input-comment-box" contenteditable="true" placeholder="줄바꿈 Shift + Enter / 입력 Enter 입니다."></div>
																		</fieldset>
																	</form>
																</div>
																<% } %>
															</div>
														</div>
														<%} %>
														<div class = "feed-board-comment-input">
															<div class = "comment_writer1_img" style = "background:url('<%=profile %>'); no-repeat center center; background-size: cover;"></div>
															<form class = "input-comment">
																<fieldset>
																	<div class = "input-comment-box" contenteditable="true"
																		placeholder = "줄바꿈 Shift + Enter / 입력 Enter 입니다."
																	></div>
																</fieldset>
															</form>
														</div>
													</div>
												</div>
											</div>
											<%} if(bdto2.getCategory().equals("업무")) { %>
											<%BoardPostViewDto bdto3 = bdao.PostViewBoard(bdto2.getBoardIdx());%>
											<%MyboardViewTaskDto bdto4 = bdao.ViewTask(bdto2.getBoardIdx());%>
											<div class = "feed-board" id = 	"board<%=bdto2.getBoardIdx()%>" data-category="업무" data-bno=<%=bdto2.getBoardIdx()%>>
													<div class = "feed-board-1">
														<div class = "feed-board-2">
															<div class = "feed-board-header-top">
																<div class = "feed-board-writer">
																	<span class = "feed-board-writer2-img" style = "background:url('<%=bdto3.getProfileImg() %>'); no-repeat center center; background-size: cover;"></span>
																	<div class = "feed-board-writer-date">
																		<div class = "feed-board-writer-date-box">
																			<div class = "feed-board-writer-name"><%=bdto3.getName() %></div>
																			<div class = "feed-board-date"><%=bdto3.getWriteDate() %></div>
																			<%if(bdto3.getReleaseYN()=='N') { %>
																				<div class = "feed-lock-icon">
																					<div class = "feed-lock-icon-img"></div>
																				</div>
																			<% } else { %>
																				<div class = "feed-people-icon">
																					<div class = "feed-people-icon-img"></div>
																				</div>
																			<% } %>
																		</div>
																	</div>
																	<div class = "feed-post-option">
																		<button class = "feed-board-fixbtn" style = "display:block">
																			<%if(bdto3.getTopFixed()=='N') { %>
																				<div class="feed-board-fixbtn-img"></div>
																			<% } else { %>
																				<div class="feed-board-fixbtn-img on"></div>
																			<% }  %>
																		</button>
																		<button class = "feed-board-optionbtn">
																			<span></span>
																			<span></span>
																			<span></span>
																		</button>
																		<ul class = "board-setting-layer" style = "display:none">
																			<li class = "board-set-item-edit">
																				<i class = "post-edit-icon"></i>
																				수정
																			</li>
																			<li class = "board-set-item-del">
																				<i class = "post-del-icon"></i>
																				삭제
																			</li>
																		</ul>
																	</div>
																</div>
															</div>
															<div class = "feed-board-header-bottom">
																<div class = "board-title-area">
																	<h4 class = "board-title"><%=bdto3.getTitle()%></h4>
																</div>
																<div class = "task-num">
																	<span class = "task-num-cnt">
																		업무번호
																		<em><%=bdto4.getTaskIdx()%></em>
																	</span>
																</div>
															</div>
															<div class = "feed-board-main">
																<div class = "board-main-content">
																	<div class = "task-option">
																		<div class = "task-option-area">
																			<div class = "task-state" style = "display:flex">
																				<div class = "task-icon">
																					<div class = "task-state-img"></div>
																				</div>
																				<div class = "task-state-content">
																					<div class = "task-state-btns">
																					<%if(bdto4.getState()==1) { %>
																						<button class = "task-btn request active">요청</button>
																						<button class = "task-btn progress">진행</button>
																						<button class = "task-btn feedback">피드백</button>
																						<button class = "task-btn complete">완료</button>
																						<button class = "task-btn hold">보류</button>
																					<% } else if(bdto4.getState()==2) { %>
																						<button class = "task-btn request">요청</button>
																						<button class = "task-btn progress active">진행</button>
																						<button class = "task-btn feedback">피드백</button>
																						<button class = "task-btn complete">완료</button>
																						<button class = "task-btn hold">보류</button>
																					<% } else if(bdto4.getState()==3) { %>
																						<button class = "task-btn request">요청</button>
																						<button class = "task-btn progress">진행</button>
																						<button class = "task-btn feedback active">피드백</button>
																						<button class = "task-btn complete">완료</button>
																						<button class = "task-btn hold">보류</button>
																					<% } else if(bdto4.getState()==4) { %>
																						<button class = "task-btn request">요청</button>
																						<button class = "task-btn progress">진행</button>
																						<button class = "task-btn feedback">피드백</button>
																						<button class = "task-btn complete active">완료</button>
																						<button class = "task-btn hold">보류</button>
																					<% } else if(bdto4.getState()==5) { %>
																						<button class = "task-btn request">요청</button>
																						<button class = "task-btn progress">진행</button>
																						<button class = "task-btn feedback">피드백</button>
																						<button class = "task-btn complete">완료</button>
																						<button class = "task-btn hold active">보류</button>
																					<% } %>
																					</div>
																				</div>
																			</div>
																			<div class = "task-manager" style = "display:flex">
																				<div class = "task-icon">
																					<div class = "task-manager-img"></div>
																				</div>
																				<div class = "task-manager-content">
																					<div class = "task-manager-user">
																						<span class = "task-manager-area">
																							<%ArrayList<TaskManagerDto> TMlist = bdao.ViewTaskManager(bdto4.getTaskIdx()); %>
																							<%for(TaskManagerDto TMdto : TMlist) { %>
																							<span class = "task-manager-name">
																								<span class = "task-manager-img" style = "background:url('<%=TMdto.getProfileImg() %>') no-repeat center center; background-size: cover;" id = "task-manager-img2"></span>
																								<span class = "task-manager-value" data-mno=<%=TMdto.getMemberIdx()%>><%=TMdto.getName()%></span>
																								<button class = "manager-remove-btn"></button>
																							</span>
																							<% } %>
																						</span>
																					</div>
																					<%if(tdao.taskManagerCount(bdto4.getTaskIdx()) != 0) { %>
																					<button class = "change-task-manager">담당자 변경</button>
																					<% } else { %>
																					<button class = "change-task-manager">담당자 추가</button>
																					<% } %>
																				</div>
																			</div>
																			<div class = "task-start-date" style = "display:flex">
																				<div class = "task-icon">
																					<div class = "task-date-img"></div>
																				</div>
																				<%
																				 	SimpleDateFormat sdf = new SimpleDateFormat("EEEE", java.util.Locale.KOREA); 
																				    SimpleDateFormat sdfInput = new SimpleDateFormat("yyyy-MM-dd");
																				%>
																			    <%! 
																					    public String getDayOfWeeksShort(String dayOfWeek) {
																					        if (dayOfWeek.equals("월요일")) return "월";
																					        if (dayOfWeek.equals("화요일")) return "화";
																					        if (dayOfWeek.equals("수요일")) return "수";
																					        if (dayOfWeek.equals("목요일")) return "목";
																					        if (dayOfWeek.equals("금요일")) return "금";
																					        if (dayOfWeek.equals("토요일")) return "토";
																					        if (dayOfWeek.equals("일요일")) return "일";
																					        return dayOfWeek; // Default case, although should not happen
																					    }
																					%>
																				<div class = "task-start-date-content" style = "display:flex">
																					<div class = "task-date-box">
																				<%if(bdto4.getStartDate()==null) { %>
																						<label type = "button" class ="input-date" style="display:flex">
																							<input class="input-start-data datepicker" style="display: inline-block;" placeholder = "시작일추가">
																						</label>
																						<div class = "task-start-date-value" style = "display:none">
																							<span class = "task-date-value">
																								<span class = "task-date-name" id="start-date">
																								<%
																								    // Start Date 관련 처리
																								    String startOfWeek = null;
																								    if (bdto4.getStartDate() != null) {
																								        String startDateString = bdto4.getStartDate();
																								        Date startDate = sdfInput.parse(startDateString);
																								        startOfWeek = sdf.format(startDate);
																								
																								        startOfWeek = getDayOfWeeksShort(startOfWeek);
																								    }
																								
																								%>
																						
																								<%
																						            String startDate = bdto4.getStartDate();
																						            if (startDate != null) {
																						                if (startDate.endsWith("00:00:00")) { 
																						        %>
																						                    <%= startDate.substring(0, 10) %> (<%= startOfWeek != null ? startOfWeek : "요일 정보 없음" %>) 
																						        <%
																						                } else { 
																						        %>
																						                    <%= startDate %> (<%= startOfWeek != null ? startOfWeek : "요일 정보 없음" %>)
																						        <%
																						                }
																						            }
																						        %>
																								</span>
																							</span>
																							<button class = "remove-btn" style = "display:none"></button>
																							<% } else { %>
																								<label type = "button" class ="input-date" style="display:none">
																									<input class="input-start-data datepicker" style="display: inline-block;" placeholder = "시작일추가">
																								</label>
																								<div class = "task-start-date-value" style = "display:flex">
																									<span class = "task-date-value">
																										<span class = "task-date-name" id="start-date">
																								<%
																								    // Start Date 관련 처리
																								    String startOfWeek = null;
																								    if (bdto4.getStartDate() != null) {
																								        String startDateString = bdto4.getStartDate();
																								        Date startDate = sdfInput.parse(startDateString);
																								        startOfWeek = sdf.format(startDate);
																								
																								        startOfWeek = getDayOfWeeksShort(startOfWeek);
																								    }
																								
																								%>
																						
																								<%
																						            String startDate = bdto4.getStartDate();
																						            if (startDate != null) {
																						                if (startDate.endsWith("00:00:00")) { 
																						        %>
																						                    <%= startDate.substring(0, 10) %> (<%= startOfWeek != null ? startOfWeek : "요일 정보 없음" %>) 
																						        <%
																						                } else { 
																						        %>
																						                    <%= startDate %> (<%= startOfWeek != null ? startOfWeek : "요일 정보 없음" %>)
																						        <%
																						                }
																						            }
																						        %>
																								</span>
																							</span>
																							<button class = "remove-btn"></button>
																							<% } %>
																						</div>
																					</div>
																				</div>
																			</div>
																			<div class = "task-end-date" style = "display:flex">
																				<div class = "task-icon">
																					<div class = "task-date-img"></div>
																				</div>
																				<div class = "task-date-content" style = "display:flex">
																					<div class = "task-date-box">
																					<%if(bdto4.getEndDate()==null) { %>
																						<label type = "button" class ="input-date" style="display:flex">
																							<input class="input-end-data datepicker" style="display: inline-block;" placeholder = "마감일추가">
																						</label>
																						<div class = "task-end-date-value" style = "display:none">
																							<span class = "task-date-value">
																								<span class="task-date-name" id="end-date"></span>
																							</span>	
																							<button class = "remove-btn" style = "display:none"></button>
																						<% } else {%>
																						<label type = "button" class ="input-date" style="display:none">
																							<input class="input-end-data datepicker" style="display: inline-block;" placeholder = "마감일추가">
																						</label>
																						<div class = "task-end-date-value" style = "display:flex">
																							<span class = "task-date-value">
																								<%
																								    // 현재 날짜를 가져옴
																								    Date currentDate = new Date(); // 현재 날짜
																								    String endOfWeek = null;
																								    Date endDate = null;  // endDate를 if문 밖에서 선언
																								
																								    // bdto4.getEndDate() 값이 null 이거나 "null" 문자열인 경우를 체크
																								    String endDateString = bdto4.getEndDate();
																								    
																								    if (endDateString != null && !"null".equals(endDateString)) {
																								        // endDateString을 Date 객체로 변환
																								        SimpleDateFormat sdfInput2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
																								        endDate = sdfInput2.parse(endDateString);  // endDate에 값 할당
																								
																								        // 요일 정보 추출
																								        endOfWeek = sdf.format(endDate); // 요일 정보 얻기
																								        endOfWeek = getDayOfWeeksShort(endOfWeek); // 요일 축약형
																								    }
																								%>
																								
																								<!-- 항상 <span id="end-date"> 태그를 렌더링 -->
																								<span class="task-date-name" id="end-date"
																								    <%
																								        if (endDate != null && endDate.before(currentDate)) {  // 과거 날짜일 경우
																								    %>
																								        style="color:red;"
																								    <%
																								        }
																								    %>
																								>
																								    <%
																								        if (endDate != null) {
																								    %>
																								            <%= endDateString.substring(0, 10) %> (<%= endOfWeek != null ? endOfWeek : "" %>)
																								    <%    } else { // endDate가 null인 경우
																								            // 아무 내용도 입력되지 않음
																								    %>
																								        <!-- 빈 내용 -->
																								    <% } %>
																								</span>
																							</span>	
																							<button class = "remove-btn"></button>																						
																						<% } %>
																						</div>
																					</div>
																				</div>
																			</div>
																			<div class = "task-priority" style = "display:flex">
																				<div class = "task-icon">
																					<div class = "task-priority-img"></div>
																				</div>
																				<div class = "task-priority-content">
																					<%if (bdto4.getPriority()==5) { %>
																					<button class = "input-task-btn" style = "display:inline-block">우선순위 추가</button>
																					<div class = "task-priority-write" style = "display:none">
																						<div class = "task-priority-icon" style = "float:left">
																							<div class = "priority"></div>
																						</div>
																						<span class = "task-priority-value" style = "display:none"></span>
																					</div>
																					<button class ="remove-btn" style="display:none"></button>
																					<% } else if(bdto4.getPriority()==4) {%>
																					<button class = "input-task-btn" style = "display:none">우선순위 추가</button>
																					<div class = "task-priority-write" style = "display:inline-block">
																						<div class = "task-priority-icon" style = "float:left">
																							<div class = "priority low"></div>
																						</div>
																						<span class = "task-priority-value">낮음</span>
																					</div>
																					<button class ="remove-btn" style="display:inline-block"></button>
																					<% } else if(bdto4.getPriority()==3) {%>
																					<button class = "input-task-btn" style = "display:none">우선순위 추가</button>
																					<div class = "task-priority-write" style = "display:inline-block">
																						<div class = "task-priority-icon" style = "float:left">
																							<div class = "priority middle"></div>
																						</div>
																						<span class = "task-priority-value">중간</span>
																					</div>
																					<button class ="remove-btn" style="display:inline-block"></button>
																					<% } else if(bdto4.getPriority()==2) {%>
																					<button class = "input-task-btn" style = "display:none">우선순위 추가</button>
																					<div class = "task-priority-write" style = "display:inline-block">
																						<div class = "task-priority-icon" style = "float:left">
																							<div class = "priority high"></div>
																						</div>
																						<span class = "task-priority-value">높음</span>
																					</div>
																					<button class ="remove-btn" style="display:inline-block"></button>
																					<% } else if(bdto4.getPriority()==1) {%>
																					<button class = "input-task-btn" style = "display:none">우선순위 추가</button>
																					<div class = "task-priority-write" style = "display:inline-block">
																						<div class = "task-priority-icon" style = "float:left">
																							<div class = "priority emergency"></div>
																						</div>
																						<span class = "task-priority-value">긴급</span>
																					</div>
																					<button class ="remove-btn" style="display:inline-block"></button>
																					<% } %>
																					<div class="task-priority-layer">
																						<button class="priority-layer-btn" id="priority-layer-emergency-btn" data-code = "1">
																							<span>
																								<i class="emergency-icon"></i>
																								긴급
																							</span>
																						</button>
																						<button class="priority-layer-btn" id="priority-layer-high-btn" data-code = "2">
																							<span>
																								<i class="high-icon"></i>
																								높음
																							</span>
																						</button>
																						<button class="priority-layer-btn" id="priority-layer-middle-btn" data-code = "3">
																							<span>
																								<i class="middle-icon"></i>
																								중간
																							</span>
																						</button>
																						<button class="priority-layer-btn" id="priority-layer-low-btn" data-code = "4">
																							<span>
																								<i class="low-icon"></i>
																								낮음
																							</span>
																						</button>
																					</div>
																				</div>
																			</div>
																			<div class = "task-group" style = "display:flex">
																				<div class = "task-icon">
																					<div class = "task-group-img"></div>
																				</div>
																				<%if(bdto4.getTaskGroupIdx()!=0) { %>
																					<button class = "input-task-btn" style = "display:none">그룹 추가</button>
																					<div class = "task-group-content" style = "display:inline-block">
																						<span class = "task-group-name"><%=bdto4.getTaskGroupName() %></span>
																					</div>
																					<button class = "remove-btn" style="display:inline-block"></button>
																				<% } else { %>
																					<button class = "input-task-btn" style = "display:inline-block">그룹 추가</button>
																					<div class = "task-group-content" style = "display:none">
																						<span class = "task-group-name" ></span>
																					</div>
																					<button class = "remove-btn" style="display:none"></button>
																				<% }  %>
																				<div class="task-group-list-layers" style="display:none">
																					<div class="task-group-list-box">
																						<ul>
																							<%ArrayList<TaskGroupViewDto> TGVlist2 = tdao.TaskGroupView(projectIdx); %>
																							<%for(TaskGroupViewDto TGVdto : TGVlist2) { %>
																							<li>
																								<div class = "task-group-item" data-code =<%=TGVdto.getTaskGroupIdx() %>>
																									<div class = "task-group-name-box"><%=TGVdto.getTaskGroupName() %></div>
																								</div>
																							</li>
																							<% } %>
																							<li>
																								<div class="task-group-item" data-code = "0" id="none-group">
																									<div class="task-group-name-box">그룹 미지정</div>
																								</div>
																							</li>
																						</ul>
																					</div>
																				</div>
																			</div>
																			<div class = "task-progress"style = "display:flex">
																				<div class = "task-icon">
																					<div class = "task-progress-img"></div>
																				</div>
																				<div class = "progress-content">
																					<%if(bdto4.getProgress()==100) { %> 
																						<div class = "progress-bars" style = "width:<%=bdto4.getProgress()%>%; background:blue;"></div>
																					<% } else { %>
																						<div class = "progress-bars" style = "width:<%=bdto4.getProgress()%>%"></div>
																					<% } %>
																					<div class = "progress-graphs">
																						<span class = "progress-btns" data-progress-value = "0"><em>0%</em></span>
																						<span class = "progress-btns" data-progress-value = "10"><em>10%</em></span>
																						<span class = "progress-btns" data-progress-value = "20"><em>20%</em></span>
																						<span class = "progress-btns" data-progress-value = "30"><em>30%</em></span>
																						<span class = "progress-btns" data-progress-value = "40"><em>40%</em></span>
																						<span class = "progress-btns" data-progress-value = "50"><em>50%</em></span>
																						<span class = "progress-btns" data-progress-value = "60"><em>60%</em></span>
																						<span class = "progress-btns" data-progress-value = "70"><em>70%</em></span>
																						<span class = "progress-btns" data-progress-value = "80"><em>80%</em></span>
																						<span class = "progress-btns" data-progress-value = "90"><em>90%</em></span>
																						<span class = "progress-btns" data-progress-value = "100"><em>100%</em></span>
																					</div>
																					<span class = "progress-values"><%=bdto4.getProgress()%>%</span>
																				</div>
																				
																			</div>
																		</div>
																	</div>
																	<div><%=bdto3.getContent() %></div>
																</div>
																<div class = "board-main-option">
																	<div class = "board-main-option-left">
																		<div class="board-emotion" style="display:block">
																			<div class="board-emotion-group">
																				<%ArrayList<BoardEmotionDto> BElist = bdao.BoardEmotionTypeCount(bdto2.getBoardIdx()); %>
																				<%for(BoardEmotionDto dto : BElist) { %>
																					<%if(dto.getEmotionType()==1 && dto.getCountemotion() >0 ) { %>
																						<div class="emotion1"></div>
																					<% } %>
																					<%if(dto.getEmotionType()==2 && dto.getCountemotion() >0 ) { %>
																						<div class="emotion2"></div>
																					<% } %>
																					<%if(dto.getEmotionType()==3 && dto.getCountemotion() >0 ) { %>
																						<div class="emotion3"></div>
																					<% } %>
																					<%if(dto.getEmotionType()==4 && dto.getCountemotion() >0 ) { %>
																						<div class="emotion4"></div>
																					<% } %>
																					<%if(dto.getEmotionType()==5 && dto.getCountemotion() >0 ) { %>
																						<div class="emotion5"></div>
																					<% } %>
																				<% } %>
																			</div>
																			<%if(bdao.BoardEmotionTotalCount(bdto2.getBoardIdx())>0) { %>
																			<span class="board-emotion-writer">
																				<%ArrayList<BoardEmotionDto> BElist2 =  bdao.BoardEmotionView(bdto2.getBoardIdx(),1); %>
																				<%for(BoardEmotionDto dto : BElist2) { %>
																				<span class="emotion-writer-name"><%=dto.getName() %></span>
																				<% } %>
																				<%if(bdao.BoardEmotionTotalCount(bdto2.getBoardIdx())>1) { %>
																					<span class="emotion-writer-cnt">+<%=bdao.BoardEmotionTotalCount(bdto2.getBoardIdx())-1 %></span>
																				<% } else { %>
																					<span class="emotion-writer-cnt"></span>
																				<% } %>
																			</span> 
																			<% } else { %>
																			<span class="board-emotion-writer">
																				<span class="emotion-writer-name"></span>
																				<span class="emotion-writer-cnt"></span>
																			</span> 
																			<% } %>	
																		</div>
																		<div class = "main-option-btn">
																			<%if(bdao.BoardEmotionMine(bdto2.getBoardIdx(),memberIdx)!=0) { %>
																				<button class="emotion-btn on">
																					<div class="emotion-icon on"></div>
																					<%BoardEmotionDto BEdto =  bdao.MyAddEmotionCheck(bdto2.getBoardIdx(),memberIdx); %>
																					<%if(BEdto.getEmotionType()==1) { %>
																						<span class = "emotion-text">좋아요</span>
																					<% } %>
																					<%if(BEdto.getEmotionType()==2) { %>
																						<span class = "emotion-text">부탁해요</span>
																					<% } %>
																					<%if(BEdto.getEmotionType()==3) { %>
																						<span class = "emotion-text">힘들어요</span>
																					<% } %>
																					<%if(BEdto.getEmotionType()==4) { %>
																						<span class = "emotion-text">훌륭해요</span>
																					<% } %>
																					<%if(BEdto.getEmotionType()==5) { %>
																						<span class = "emotion-text">감사해요</span>
																					<% } %>
																				</button>
																			<% } else { %>
																				<button class="emotion-btn">
																					<div class="emotion-icon"></div>
																					<span class = "emotion-text">좋아요</span>
																				</button>
																			<% } %>
																			<button class = "bookmark-btn">
																				<%if(bdao.bookmarkView(bdto2.getBoardIdx(),memberIdx)==1) { %>
																					<div class="bookmark-icon on"></div>
																				<% } else { %>
																					<div class="bookmark-icon"></div>
																				<% } %>
																				<span>북마크</span>
																			</button>
																			<div class = "emotion-layer">
																					<ul>
																						<li class = "emotion-item" data-code = "1">
																							<i class = "emotion-1-img"></i>
																							<p>좋아요</p>
																						</li>
																						<li class = "emotion-item" data-code = "2">
																							<i class = "emotion-2-img"></i>
																							<p>부탁해요</p>
																						</li>
																						<li class = "emotion-item" data-code = "3">
																							<i class = "emotion-3-img"></i>
																							<p>힘들어요</p>
																						</li>
																						<li class = "emotion-item" data-code = "4">
																							<i class = "emotion-4-img"></i>
																							<p>훌륭해요</p>
																						</li>
																						<li class = "emotion-item" data-code = "5">
																							<i class = "emotion-5-img"></i>
																							<p>감사해요</p>
																						</li>
																					</ul>
																				</div>
																		</div>
																	</div>
																<div class = "board-main-option-right">
																	<div class = "main-option-cnt" >
																		<span>읽음</span>
																		<span class = "read-cnt-member"><%=bdao.ReadCount(bdto2.getBoardIdx()) %></span>
																	</div>
																</div>
															</div>
														</div>
														<%if(bdao.CommentCount(bdto2.getBoardIdx(),0,0)!=0) { %>
														<div class = "feed-board-comment">
															<div class = "comment-content" id ="all">
																<%ArrayList<BoardCommentViewDto> BCVlist = bdao.BoardCommentViewer(bdto2.getBoardIdx(),0); %>
																<%for(BoardCommentViewDto dto : BCVlist) { %>
																<div class = "comment-content-box" data-Idx = <%=dto.getCommentIdx() %>>
																	<div class = "comment-writer-icon">
																		<span class = "comment-writer2-icon-image" style = "background:url('<%=bdto3.getProfileImg() %>'); no-repeat center center; background-size: cover;"></span>
																	</div>
																	<div class = "comment-content-mainbox">
																		<div class = "mainbox-user">
																			<div class = "mainbox-userbox">
																				<span class = "userbox-username"><%=dto.getName() %></span>
																				<span class = "userbox-record-date"><%=dto.getWriteTime() %></span>
																			</div>
																			<div class = "mainbox-user-option">
																				<button class = "comment-modify">수정</button>
																				<button class = "comment-delete">삭제</button>
																			</div>
																		</div>
																		<div class = "mainbox-content">
																			<div>
																				<div class = "mainbox-content-area">
																					<div>
																						<%=dto.getCommentContent() %>
																					</div>
																				</div>
																			</div>
																		</div>
																	</div>
																	<form class="input-comment"style="display:none">
																		<fieldset>
																			<div class="input-comment-box" contenteditable="true" placeholder="줄바꿈 Shift + Enter / 입력 Enter 입니다."></div>
																		</fieldset>
																	</form>
																</div>
																<% } %>
															</div>
														</div>
														<%} %>
														<div class = "feed-board-comment-input">
															<div class = "comment_writer1_img" style = "background:url('<%=profile %>'); no-repeat center center; background-size: cover;"></div>
															<form class = "input-comment">
																<fieldset>
																	<div class = "input-comment-box" contenteditable="true"
																		placeholder = "줄바꿈 Shift + Enter / 입력 Enter 입니다."
																	></div>
																</fieldset>
															</form>
														</div>
													</div>
													</div>
												</div>
											<% } if(bdto2.getCategory().equals("일정")) { %>
											<%BoardPostViewDto bdto3 = bdao.PostViewBoard(bdto2.getBoardIdx());%>
											<%BoardScheduleDto bdto4 = bdao.viewSchedule(bdto2.getBoardIdx());%>
												<div class = "feed-board" id = 	"board<%=bdto2.getBoardIdx()%>"data-category="일정" data-bno=<%=bdto2.getBoardIdx()%> data-cno=<%=bdto4.getScheduleIdx() %>>
													<div class = "feed-board-1">
														<div class = "feed-board-2">
															<div class = "feed-board-header-top">
																<div class = "feed-board-writer">
																	<span class = "feed-board-writer2-img" style = "background:url('<%=bdto3.getProfileImg() %>'); no-repeat center center; background-size: cover;"></span>
																	<div class = "feed-board-writer-date">
																		<div class = "feed-board-writer-date-box">
																			<div class = "feed-board-writer-name"><%=bdto3.getName() %></div>
																			<div class = "feed-board-date"><%=bdto3.getWriteDate() %></div>
																			<%if(bdto3.getReleaseYN()=='N') { %>
																				<div class = "feed-lock-icon">
																					<div class = "feed-lock-icon-img"></div>
																				</div>
																			<% } else { %>
																				<div class = "feed-people-icon">
																					<div class = "feed-people-icon-img"></div>
																				</div>
																			<% } %>
																		</div>
																	</div>
																	<div class = "feed-post-option">
																		<button class = "feed-board-fixbtn" style = "display:block">
																			<%if(bdto3.getTopFixed()=='N') { %>
																				<div class="feed-board-fixbtn-img"></div>
																			<% } else { %>
																				<div class="feed-board-fixbtn-img on"></div>
																			<% }  %>
																		</button>
																		<button class = "feed-board-optionbtn">
																			<span></span>
																			<span></span>
																			<span></span>
																		</button>
																		<ul class = "board-setting-layer" style = "display:none">
																			<li class = "board-set-item-edit">
																				<i class = "post-edit-icon"></i>
																				수정
																			</li>
																			<li class = "board-set-item-del">
																				<i class = "post-del-icon"></i>
																				삭제
																			</li>
																		</ul>
																	</div>
																</div>
															</div>
														<div class = "feed-board-main">
															<div class="feed-board-header-bottom">
																<div class="schedule-date">
																	<div class="date-year-month"><%=bdto4.getYearMonth() %></div>
																	<div class="date-day"><%=bdto4.getDay() %></div>
																</div>
																<div class="board-title-schedule-area">
																	<div class="board-title"><%=bdto3.getTitle() %></div>
																	<div class="board-schedule-title-area">
																	<%
																	 		SimpleDateFormat sdf = new SimpleDateFormat("EEEE", java.util.Locale.KOREA); 
																		    SimpleDateFormat sdfInput = new SimpleDateFormat("yyyy-MM-dd");
																		
																		    // Start Date 관련 처리
																		    String startOfWeek = null;
																		    if (bdto4.getStartDate() != null) {
																		        String startDateString = bdto4.getStartDate();
																		        Date startDate = sdfInput.parse(startDateString);
																		        startOfWeek = sdf.format(startDate);
																		
																		        startOfWeek = getDayOfWeekShort(startOfWeek);
																		    }
																		
																		    String endOfWeek = null;
																		    if (bdto4.getEndDate() != null) {
																		        String endDateString = bdto4.getEndDate();
																		        Date endDate = sdfInput.parse(endDateString);
																		        endOfWeek = sdf.format(endDate);
																		
																		        endOfWeek = getDayOfWeekShort(endOfWeek);
																		    }
																		%>
																		
																		    <%! 
																				    // 요일 축약형 처리 메서드
																				    public String getDayOfWeekShort(String dayOfWeek) {
																				        if (dayOfWeek.equals("월요일")) return "월";
																				        if (dayOfWeek.equals("화요일")) return "화";
																				        if (dayOfWeek.equals("수요일")) return "수";
																				        if (dayOfWeek.equals("목요일")) return "목";
																				        if (dayOfWeek.equals("금요일")) return "금";
																				        if (dayOfWeek.equals("토요일")) return "토";
																				        if (dayOfWeek.equals("일요일")) return "일";
																				        return dayOfWeek; // Default case, although should not happen
																				    }
																				%>
																		
																		<% if (bdto4.getAllDayYN() == 'Y') { %>
																		    <span class="schedule-period">
																		        <%
																		            String startDate = bdto4.getStartDate();
																		            if (startDate != null) {
																		                if (startDate.endsWith("00:00:00")) { 
																		        %>
																		                    <%= startDate.substring(0, 10) %> (<%= startOfWeek != null ? startOfWeek : "요일 정보 없음" %>) 
																		        <%
																		                } else { 
																		        %>
																		                    <%= startDate %> (<%= startOfWeek != null ? startOfWeek : "요일 정보 없음" %>)
																		        <%
																		                }
																		            }
																		        %>
																		    </span>
																		    <span class="schedule-period" style="display:inline-block">
																		        <span class="schedule-period-bar"></span>
																		        <%
																		            String endDate = bdto4.getEndDate();
																		            if (endDate != null) {
																		                if (endDate.endsWith("00:00:00")) { 
																		        %>
																		                    <%= endDate.substring(0, 10) %> (<%= endOfWeek != null ? endOfWeek : "요일 정보 없음" %>) 
																		        <%
																		                } else { 
																		        %>
																		                    <%= endDate %> (<%= endOfWeek != null ? endOfWeek : "요일 정보 없음" %>)
																		        <%
																		                }
																		            }
																		        %>
																		    </span>
																		<% } else { %>
																		    <span class="schedule-period">
																		        <%
																		            String startDate = bdto4.getStartDate();
																		            if (startDate != null) { %>
																		                <%= startDate.substring(0, 16) %> (<%= startOfWeek != null ? startOfWeek : "요일 정보 없음" %>)
																		        <% }
																		        %> 
																		    </span>
																		    <span class="schedule-period" style="display:inline-block">
																		        <span class="schedule-period-bar"></span>
																		        <%
																		            String endDate = bdto4.getEndDate();
																		            if (endDate != null) { %>
																		                <%= endDate.substring(0, 16) %> (<%= endOfWeek != null ? endOfWeek : "요일 정보 없음" %>)
																		        <% }
																		        %> 
																		    </span>
																		<% } %>
																	</div>
																</div>
																<div class="board-post-state"></div>
															</div>
															<div class="board-main-content">
																	<div class="board-main-content-box">
																		<div class="board-main-content-boxIn">
																			<div class="board-main-participant" style="display:flex">
																				<div class="participant-people-icon">
																					<div class="participant-people-iconimg"></div>
																				</div>
																				<div class="participant-people-group">
																					<div class="participant-img">
																						<div class="participant-img-box">
																						<%ArrayList<BoardScheduleDto> BSlist = bdao.viewMemberSchdule(bdto4.getScheduleIdx(), 0, 0); %>
																						<%for(BoardScheduleDto dto : BSlist) { %>
																							<%if(dto.getAttendWhether()!=null) { %>
																								<%if(dto.getAttendWhether().equals("참석")) { %>
																								<span class="participant1-img Attendance" style = "background:url('<%=dto.getProfileImg() %> ')  no-repeat center center; background-size: cover;" data-mno = <%=dto.getMemberIdx() %>></span>
																								<% } else if(dto.getAttendWhether().equals("불참")) { %>
																								<span class="participant1-img nonappearance" style = "background:url('<%=dto.getProfileImg() %>')  no-repeat center center; background-size: cover;" data-mno = <%=dto.getMemberIdx() %>></span>
																								<% } else { %>
																								<span class="participant1-img Undecided" style = "background:url('<%=dto.getProfileImg() %>')  no-repeat center center; background-size: cover;" data-mno = <%=dto.getMemberIdx() %>></span>
																								<% } %>
																							<% } else { %>
																								<span class="participant1-img" style = "background:url('<%=dto.getProfileImg() %>')  no-repeat center center; background-size: cover;" data-mno = <%=dto.getMemberIdx() %>></span>
																							<% }%>
																						<% } %>
																						</div>
																					</div>
																					<button class="participant-change">참석자 변경</button>
																					<div class="participant-appearance" style="display:block">
																					<%ScheduleCountDto bdto5 = bdao.scheduleCount(bdto4.getScheduleIdx()); %>
																						<span class="participant-state-appearance">
																							<span>참석</span>
																							<em class="participan-cnt"><%=bdto5.getCount1() %></em>
																						</span>
																						<span class="participant-state-nonappearance">
																							<span>불참</span>
																							<em class="participan-cnt"><%=bdto5.getCount2() %></em>
																						</span>
																						<span class="participant-state-Undecided">
																							<span>미정</span>
																							<em class="participan-cnt"><%=bdto5.getCount3() %></em>
																						</span>
																					</div>
																				</div>
																			</div>
																			<div class="board-main-location" style="display:flex">
																				<div class="location-img-box">
																					<div class="location-img"></div>
																				</div>
																				<div class="location-map-content">
																					<div class="location-map-name">
																						<div class="location-map-name-content">
																							<div class="location-map-name-data"><% 
																							if(bdto4.getLocation() != null && !bdto4.getLocation().equals("null")) { 
																							%>
																							    <%= bdto4.getLocation() %>
																							<% 
																							} else { 
																							%>
																							<% 
																							} 
																							%>
																							</div>
																						</div>
																					</div>
																				</div>
																			</div>
																			<div class="board-main-detail" style="display:flex">
																				<div class="board-main-memo">
																					<div class="board-main-memocontent">
																						<div><%=bdto3.getContent() %></div>
																					</div>
																				</div>
																			</div>
																		</div>
																		<div></div>
																	</div>
																</div>
																<div class="board-main-bottom-schedule">
																<%
																    ArrayList<BoardScheduleDto> BSlist2 = bdao.viewMemberSchdule(bdto4.getScheduleIdx(), memberIdx, 1);
																
																    if (BSlist2 != null && !BSlist2.isEmpty()) {
																        for (BoardScheduleDto dto : BSlist2) {
																            String attendWhether = dto.getAttendWhether();
																            if ("참석".equals(attendWhether)) {
																                %>
																                <button class="Attendance-btn on">참석</button>
																                <button class="NonAttendance-btn">불참</button>
																                <button class="Undecided-btn">미정</button>
																                <%
																            } else if ("불참".equals(attendWhether)) {
																                %>
																                <button class="Attendance-btn">참석</button>
																                <button class="NonAttendance-btn on">불참</button>
																                <button class="Undecided-btn">미정</button>
																                <%
																            } else if ("미정".equals(attendWhether)) {
																                %>
																                <button class="Attendance-btn">참석</button>
																                <button class="NonAttendance-btn">불참</button>
																                <button class="Undecided-btn on">미정</button>
																                <%
																            } else {
																                %>
																                <button class="Attendance-btn">참석</button>
																                <button class="NonAttendance-btn">불참</button>
																                <button class="Undecided-btn">미정</button>
																                <%
																            }
																        }
																    } else {
																        out.println("일정 정보가 없습니다.");
																    }
																%>
																</div>
																<div class="board-main-option">
																	<div class="board-main-option-left">
																		<div class="board-emotion" style="display:block">
																			<div class="board-emotion-group">
																				<%ArrayList<BoardEmotionDto> BElist = bdao.BoardEmotionTypeCount(bdto2.getBoardIdx()); %>
																				<%for(BoardEmotionDto dto : BElist) { %>
																					<%if(dto.getEmotionType()==1 && dto.getCountemotion() >0 ) { %>
																						<div class="emotion1"></div>
																					<% } %>
																					<%if(dto.getEmotionType()==2 && dto.getCountemotion() >0 ) { %>
																						<div class="emotion2"></div>
																					<% } %>
																					<%if(dto.getEmotionType()==3 && dto.getCountemotion() >0 ) { %>
																						<div class="emotion3"></div>
																					<% } %>
																					<%if(dto.getEmotionType()==4 && dto.getCountemotion() >0 ) { %>
																						<div class="emotion4"></div>
																					<% } %>
																					<%if(dto.getEmotionType()==5 && dto.getCountemotion() >0 ) { %>
																						<div class="emotion5"></div>
																					<% } %>
																				<% } %>
																			</div>
																			<%if(bdao.BoardEmotionTotalCount(bdto2.getBoardIdx())>0) { %>
																			<span class="board-emotion-writer">
																				<%ArrayList<BoardEmotionDto> BElist2 =  bdao.BoardEmotionView(bdto2.getBoardIdx(),1); %>
																				<%for(BoardEmotionDto dto : BElist2) { %>
																				<span class="emotion-writer-name"><%=dto.getName() %></span>
																				<% } %>
																				<%if(bdao.BoardEmotionTotalCount(bdto2.getBoardIdx())>1) { %>
																					<span class="emotion-writer-cnt">+<%=bdao.BoardEmotionTotalCount(bdto2.getBoardIdx())-1 %></span>
																				<% } else { %>
																					<span class="emotion-writer-cnt"></span>
																				<% } %>
																			</span> 
																			<% } else { %>
																			<span class="board-emotion-writer">
																				<span class="emotion-writer-name"></span>
																				<span class="emotion-writer-cnt"></span>
																			</span> 
																			<% } %>	
																		</div>
																		<div class="main-option-btn">
																			<%if(bdao.BoardEmotionMine(bdto2.getBoardIdx(),memberIdx)!=0) { %>
																				<button class="emotion-btn on">
																					<div class="emotion-icon on"></div>
																					<%BoardEmotionDto BEdto =  bdao.MyAddEmotionCheck(bdto2.getBoardIdx(),memberIdx); %>
																					<%if(BEdto.getEmotionType()==1) { %>
																						<span class = "emotion-text">좋아요</span>
																					<% } %>
																					<%if(BEdto.getEmotionType()==2) { %>
																						<span class = "emotion-text">부탁해요</span>
																					<% } %>
																					<%if(BEdto.getEmotionType()==3) { %>
																						<span class = "emotion-text">힘들어요</span>
																					<% } %>
																					<%if(BEdto.getEmotionType()==4) { %>
																						<span class = "emotion-text">훌륭해요</span>
																					<% } %>
																					<%if(BEdto.getEmotionType()==5) { %>
																						<span class = "emotion-text">감사해요</span>
																					<% } %>
																				</button>
																			<% } else { %>
																				<button class="emotion-btn">
																					<div class="emotion-icon"></div>
																					<span class = "emotion-text">좋아요</span>
																				</button>
																			<% } %>
																			<button class="bookmark-btn">
																				<%if(bdao.bookmarkView(bdto2.getBoardIdx(),memberIdx)==1) { %>
																					<div class="bookmark-icon on"></div>
																				<% } else { %>
																					<div class="bookmark-icon"></div>
																				<% } %>
																				<span>북마크</span>
																			</button>
																			<div class = "emotion-layer">
																				<ul>
																					<li class = "emotion-item" data-code = "1">
																						<i class = "emotion-1-img"></i>
																						<p>좋아요</p>
																					</li>
																					<li class = "emotion-item" data-code = "2">
																						<i class = "emotion-2-img"></i>
																						<p>부탁해요</p>
																					</li>
																					<li class = "emotion-item" data-code = "3">
																						<i class = "emotion-3-img"></i>
																						<p>힘들어요</p>
																					</li>
																					<li class = "emotion-item" data-code = "4">
																						<i class = "emotion-4-img"></i>
																						<p>훌륭해요</p>
																					</li>
																					<li class = "emotion-item" data-code = "5">
																						<i class = "emotion-5-img"></i>
																						<p>감사해요</p>
																					</li>
																				</ul>
																			</div>
																		</div>
																</div>
																<div class="board-main-option-right">
																	<div class="main-option-cnt">
																		<span>읽음</span>
																		<span class="read-cnt-member"><%=bdao.ReadCount(bdto2.getBoardIdx()) %></span>
																	</div>
																</div>
															</div></div>
															<%if(bdao.CommentCount(bdto2.getBoardIdx(),0,0)!=0) { %>
														<div class = "feed-board-comment">
															<div class = "comment-content" id ="all">
																<%ArrayList<BoardCommentViewDto> BCVlist = bdao.BoardCommentViewer(bdto2.getBoardIdx(),0); %>
																<%for(BoardCommentViewDto dto : BCVlist) { %>
																<div class = "comment-content-box" data-Idx = <%=dto.getCommentIdx() %>>
																	<div class = "comment-writer-icon">
																		<span class = "comment-writer2-icon-image" style = "background:url('<%=bdto3.getProfileImg() %>'); no-repeat center center; background-size: cover;"></span>
																	</div>
																	<div class = "comment-content-mainbox">
																		<div class = "mainbox-user">
																			<div class = "mainbox-userbox">
																				<span class = "userbox-username"><%=dto.getName() %></span>
																				<span class = "userbox-record-date"><%=dto.getWriteTime() %></span>
																			</div>
																			<div class = "mainbox-user-option">
																				<button class = "comment-modify">수정</button>
																				<button class = "comment-delete">삭제</button>
																			</div>
																		</div>
																		<div class = "mainbox-content">
																			<div>
																				<div class = "mainbox-content-area">
																					<div>
																						<%=dto.getCommentContent() %>
																					</div>
																				</div>
																			</div>
																		</div>
																	</div>
																	<form class="input-comment"style="display:none">
																		<fieldset>
																			<div class="input-comment-box" contenteditable="true" placeholder="줄바꿈 Shift + Enter / 입력 Enter 입니다."></div>
																		</fieldset>
																	</form>
																</div>
																<% } %>
															</div>
														</div>
														<%} %>
															<div class = "feed-board-comment-input">
																<div class = "comment_writer1_img" style = "background:url('<%=profile %>'); no-repeat center center; background-size: cover;"></div>
																<form class = "input-comment">
																	<fieldset>
																		<div class = "input-comment-box" contenteditable="true"
																			placeholder = "줄바꿈 Shift + Enter / 입력 Enter 입니다."
																		></div>
																	</fieldset>
																</form>
															</div>
														</div>
													</div>
												</div>
											<% } %>
										<% } %>
									</div>
								</div>
							</div>
						</div>
					<div class="project-member">
						<div class="member-box">
							<div class="member-title">
								<div class="member-cnt">
									<div class="m-title" id="m-cnt">참여자</div>
									<div class="m-count" id="m-cnt"><%=projectmember%></div>
								</div>
								<div class="allview" style="margin-left: auto">
									<button class="allview-btn" type="button" style="display : block">전체 보기</button>
								</div>
							</div>
							<div class="member-content">
								<div class="mem-content">
									<div class="m-content">
										<div class="member-header admin">
											<div class="m-headertitle">프로젝트 관리자</div>
											<div class="m-headercnt"><%=projectadminmember %></div>
										</div>
										<div class = "admin-member-list">
											<%for(MemberDto Mdto : Mlist1) { %>
											<div class="member-body" data-mno = <%=Mdto.getMemberIdx() %>>
												<div class="m-profile">
													<div class="profile1-img" style = "float: left; background:url('<%=Mdto.getProfileImg() %>'); no-repeat center center; background-size: cover;"></div>
													<dl class = "post-profile-text" style = "float: left;margin: 0px;margin-left: 10px;">
														<dt>
															<strong class = "author-name"><%=Mdto.getName()%></strong>
															<em class = "author-position"><% if(Mdto.getPosition()==null) { %>
															
														<%} else { %>
														<%=Mdto.getPosition() %>
														<% } %></em>
														</dt>
														<dd>
															<strong class = "author-company"><%=Mdto.getCompanyName()%></strong>
															<em class = "author-department"><% if(Mdto.getDepartmentName()==null) { %>
															
															<%} else { %>
															<%=Mdto.getDepartmentName() %>
															<% } %></em>
														</dd>
													</dl>
												</div>
												<button class="m-chat" type="button">
													<div class="chat-img"></div>
												</button>
											</div>
											<% } %>
										</div>
										<%if(projectNoNadminmember!=0) { %>
										<div class="member-header nonadmin">
											<div class="m-headertitle">임직원</div>
											<div class="m-headercnt"><%=projectNoNadminmember %></div>
										</div>
										<div class = "nonadmin-member-list">
											<%for(MemberDto Mdto : Mlist2) { %>
											<div class="member-body" data-mno = <%=Mdto.getMemberIdx() %>>
												<div class="m-profile">
													<div class="profile1-img" style = "float: left; background:url('<%=Mdto.getProfileImg() %>'); no-repeat center center; background-size: cover;"></div>
													<dl class = "post-profile-text" style = "float: left;margin: 0px;margin-left: 10px;">
														<dt>
															<strong class = "author-name"><%=Mdto.getName()%></strong>
															<em class = "author-position"><% if(Mdto.getPosition()==null) { %>
															
														<%} else { %>
														<%=Mdto.getPosition() %>
														<% } %></em>
														</dt>
														<dd>
															<strong class = "author-company"><%=Mdto.getCompanyName()%></strong>
															<em class = "author-department"><% if(Mdto.getDepartmentName()==null) { %>
															
															<%} else { %>
															<%=Mdto.getDepartmentName() %>
															<% } %></em>
														</dd>
													</dl>
												</div>
												<button class="m-chat" type="button">
													<div class="chat-img"></div>
												</button>
											</div>
											<%} %>
										</div>
										<% } else { %>
										<div class="member-header nonadmin" style="display:none">
											<div class="m-headertitle">임직원</div>
											<div class="m-headercnt"></div>
										</div>
										<div class = "nonadmin-member-list" style="display:none">
											
										</div>
										<% } %>
										<%if(projectOutsidermember!=0) { %>
										<div class="member-header outsider">
											<div class="m-headertitle">외부인</div>
											<div class="m-headercnt"><%=projectOutsidermember%></div>
										</div>
										<div class = "outsider-member-list">
											<%for(MemberDto Mdto : Mlist3) { %>
											<div class="member-body" data-mno = <%=Mdto.getMemberIdx() %>>
												<div class="m-profile">
													<div class="profile1-img" style = "float: left; background:url('<%=Mdto.getProfileImg() %>'); no-repeat center center; background-size: cover;"></div>
													<dl class = "post-profile-text" style = "float: left;margin: 0px;margin-left: 10px;">
														<dt>
															<strong class = "author-name"><%=Mdto.getName()%></strong>
															<em class = "author-position"><% if(Mdto.getPosition() == null) { %>
															
														<%} else { %>
														<%=Mdto.getPosition() %>
														<% } %></em>
														</dt>
														<dd>
															<strong class = "author-company"><%=Mdto.getCompanyName()%></strong>
															<em class = "author-department"><% if(Mdto.getDepartmentName() == null) { %>
															
															<%} else { %>
															<%=Mdto.getDepartmentName() %>
															<% } %></em>
														</dd>
													</dl>
												</div>
												<button class="m-chat" type="button">
													<div class="chat-img"></div>
												</button>
											</div>
											<% } %>
										</div>
										<%} else { %>
										<div class="member-header outsider" style="display:none">
											<div class="m-headertitle">외부인</div>
											<div class="m-headercnt"><%=projectOutsidermember%></div>
										</div>
										<div class = "outsider-member-list"style="display:none">
											<%for(MemberDto Mdto : Mlist3) { %>
											<div class="member-body" data-mno = <%=Mdto.getMemberIdx() %>>
												<div class="m-profile">
													<div class="profile1-img" style = "float: left; background:url('<%=Mdto.getProfileImg() %>'); no-repeat center center; background-size: cover;"></div>
													<dl class = "post-profile-text" style = "float: left;margin: 0px;margin-left: 10px;">
														<dt>
															<strong class = "author-name"><%=Mdto.getName()%></strong>
															<em class = "author-position"><% if(Mdto.getPosition() == null) { %>
															
														<%} else { %>
														<%=Mdto.getPosition() %>
														<% } %></em>
														</dt>
														<dd>
															<strong class = "author-company"><%=Mdto.getCompanyName()%></strong>
															<em class = "author-department"><% if(Mdto.getDepartmentName() == null) { %>
															<%} else { %>
																<%=Mdto.getDepartmentName() %>
															<% } %></em>
														</dd>
													</dl>
												</div>
												<button class="m-chat" type="button">
													<div class="chat-img"></div>
												</button>
											</div>
											<% } %>
										</div>
										<% } %>
									</div>
								</div>
								<div class="member-menu">
									<button class="projectchat">
										<div class="project-chat">
											<div class="project-chatimg"></div>
											<div class="project-chatname">채팅</div>
										</div>
									</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	</div>
</div>
</body>
</html>