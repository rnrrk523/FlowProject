<%@page import="dto.dto.ProjectUserFolder"%>
<%@page import="dto.GoToDto"%>
<%@page import="dao.ChattingDao"%>
<%@page import="dto.ChatRoomListDto"%>
<%@page import="dto.TaskGroupViewDto"%>
<%@page import="dto.ProjectViewProjecIdxDto"%>
<%@page import="dao.TaskALLDao"%>
<%@page import="dto.RequestTaskDto"%>
<%@page import="dao.DashDao"%>
<%@page import="dto.DashboardDto"%>
<%@page import="dto.MyProjectViewDto"%>
<%@page import="dao.ProjectALLDao"%>
<%@page import="java.util.Calendar"%>
<%@ page import="java.util.Date , java.text.SimpleDateFormat" %>
<%@page import="java.util.ArrayList"%>
<%@page import="dto.MemberDto"%>
<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true" %>
<% 
	MemberDao dao = new MemberDao();
	DashDao Ddao = new DashDao();
	ChattingDao cdao = new ChattingDao();
	TaskALLDao tdao = new TaskALLDao();
    ProjectALLDao pdao = new ProjectALLDao();
    int companyIdx = (Integer)request.getAttribute("companyIdx");
    int memberIdx = (Integer)request.getAttribute("memberIdx");
    int readCount = (Integer)request.getAttribute("readCount");
    int requestCount1 = (Integer)request.getAttribute("requestCount1");
    int requestCount2 = (Integer)request.getAttribute("requestCount2");
    int colornum = (Integer)request.getAttribute("colornum");
    String email = (String)request.getAttribute("loginemail");
    String name = (String)request.getAttribute("name");
	String StateMessage = (String)request.getAttribute("StateMessage");
	String hour = (String)request.getAttribute("hour");
	String today = (String)request.getAttribute("today");
	String hometab = (String)request.getAttribute("hometab");
	String timeOfDay = (String)request.getAttribute("timeOfDay");
	String dayOfWeek = (String)request.getAttribute("dayOfWeek");
	String profile = (String)request.getAttribute("profile");
	ArrayList<MemberDto> list = (ArrayList<MemberDto>)request.getAttribute("list");
	ArrayList<MyProjectViewDto> Mlist = (ArrayList<MyProjectViewDto>)request.getAttribute("Mlist");
	ArrayList<DashboardDto> Dlist = (ArrayList<DashboardDto>)request.getAttribute("Dlist");
	ArrayList<ChatRoomListDto> Clist = (ArrayList<ChatRoomListDto>)request.getAttribute("Clist");
	ArrayList<RequestTaskDto> Rlist1 = (ArrayList<RequestTaskDto>)request.getAttribute("Rlist1");
	ArrayList<RequestTaskDto> Rlist2 = (ArrayList<RequestTaskDto>)request.getAttribute("Rlist2");
	ArrayList<MemberDto> Olist = (ArrayList<MemberDto>)request.getAttribute("Olist");
	ArrayList<MemberDto> CMlist = (ArrayList<MemberDto>)request.getAttribute("CMlist");
	ArrayList<GoToDto> GoToList = (ArrayList<GoToDto>)request.getAttribute("GoToList");
	ArrayList<MyProjectViewDto> MPlist = (ArrayList<MyProjectViewDto>)request.getAttribute("MPlist");
	ArrayList<ProjectUserFolder> PUFlist = (ArrayList<ProjectUserFolder>)request.getAttribute("PUFlist");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
	<link href='http://fonts.googleapis.com/css?family=Roboto:400,300,100,500,700' rel='stylesheet' type='text/css'>
	<link rel="stylesheet" href="css/2_Flow_TopAndLeft_20241126.css"/>
	<link rel="stylesheet" href="css/2_Flow_Dashboard.css"/>
	<link rel="stylesheet" href="css/2_Flow_CreateProject.css"/>
	<link rel="stylesheet" href="css/2_Flow_Createboard.css"/>
	<link rel="stylesheet" href="css/2_Flow_Task_2024-12-05.css"/>
	<link rel="stylesheet" href="css/Flow_live_alarm.css"/>
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
		$(function(){
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
			$('#myproject').click(function(){
				 window.location.href = 'Controller?command=Myprojects';
			});
			$('#dashboard').click(function(){
				window.location.href = 'Controller?command=Dashboard';
			});
			$('.widget-default-prj').click(function(){
				$('.create_area').css('display', 'flex');
			});
			$('.black_box').click(function() {
		    	$('.create_area').css('display', 'flex');
		    });
		    $('.project_explanation-input-btn').click(function() {
		    	$('.project_explanation-input-btn').css('display', 'none');
		    	$('.project_explanation-input').css('display', 'block');
		    });
		    $('.hometab-item').click(function() {
		    	$('.hometab-item').removeClass('active');
		    	$(this).addClass('active');
		    	if($('.hometab-item.active').attr('id') == 'feed') {
		    		$('.template-sample-img').removeClass('calander');
		    		$('.template-sample-img').removeClass('task');
		    		$('.template-sample-img').removeClass('file');
		    		$('.template-sample-img').addClass('feed');
		    	}
		    	if($('.hometab-item.active').attr('id') == 'task') {
		    		$('.template-sample-img').removeClass('feed');
		    		$('.template-sample-img').removeClass('calander');
		    		$('.template-sample-img').removeClass('file');
		    		$('.template-sample-img').addClass('task');
		    		
		    	}
		    	if($('.hometab-item.active').attr('id') == 'calander') {
		    		$('.template-sample-img').removeClass('file');
		    		$('.template-sample-img').removeClass('feed');
		    		$('.template-sample-img').removeClass('task');
		    		$('.template-sample-img').addClass('calander');
		    		
		    	}
		    	if($('.hometab-item.active').attr('id') == 'file') {
		    		$('.template-sample-img').removeClass('feed');
		    		$('.template-sample-img').removeClass('task');
		    		$('.template-sample-img').removeClass('calander');
		    		$('.template-sample-img').addClass('file');
		    		
		    	}
		      });
		    $('.company-public-toggle-btn').click(function() {
		        $(this).toggleClass('on');

		        if ($('#public-setting').hasClass('on')) {
		            $('.icon-template-earth').css('display', 'block');
		            $('.public-setting-content').css('display', 'block');
		        } else {
		            $('.icon-template-earth').css('display', 'none');
		            $('.public-setting-content').css('display', 'none');
		        }

		        if ($('#admin-lock-setting').hasClass('on')) {
		            $('.icon-template-lock').css('display', 'block');
		        } else {
		            $('.icon-template-lock').css('display', 'none');
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
		    	let publicIdx = 0;
		    	let adminvalue = '';
		    	if(admin==true) {
		    		adminvalue = 'Y';
		    	} else {
		    		adminvalue = 'N';
		    	}
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
			            	adminvalue : adminvalue,
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
		    	        		url = "Controller?command=FEED";
		    	        	}
							if(data.hometab=="업무") {
								url = "Controller?command=Task";    	    	        		
							}
							if(data.hometab=="캘린더") {
								
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
	            $(".view-auth-element").find('.authority-select-box').prop('disabled', false);
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
	        });
		    $(document).on('click','.widget-option-button',function (event) {
		        var $layer = $(this).siblings('.widget-option-layer');
		        $('.widget-option-layer').not($layer).hide();
		        if ($layer.css('display') === 'none') {
		            $layer.show();
		        } else {
		            $layer.hide();
		        }
		    });
		    $('.widget-2').click(function(){
		    	$('.widget-2').addClass('active');
		    	$('.widget-1').removeClass('active');
		    	$('#widget-1').css('display','none');
		    	$('#widget-2').css('display','block');
		    });
		    $('.widget-1').click(function(){
		    	$('.widget-1').addClass('active');
		    	$('.widget-2').removeClass('active');
		    	$('#widget-2').css('display','none');
		    	$('#widget-1').css('display','block');
		    });
		    $('.dropdown-btn').click(function(){
		    	if($(this).parent().find('.shortcut-menu-layer').css('display')=='none'){
			    	$(this).parent().find('.shortcut-menu-layer').css('display','block');
		    	} else {
			    	$(this).parent().find('.shortcut-menu-layer').css('display','none');
		    	}
		    });
		    $('.project-item').click(function(){
		    	let projectIdx = $(this).data("pno");
		    	$.ajax ({
	    			type: 'post',
	    	        url: 'MoveprojectAjax',
	    	        data: {
	    	            pno : projectIdx
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
		                    'value': projectIdx
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
		    $('.widget-size-change').on('click', function() {
		    	if($(this).text()=='큰 위젯으로 변경') {
			        var parentLi = $(this).closest('li');
			        parentLi.attr('wide', 'widget-wide-item');
			        $(this).text('작은 위젯으로 변경');
			        let dashIdx = parentLi.data("dno");
			        $.ajax({
			        	type : "POST",
			        	url : "WidgetChangeAjax",
			        	data: {
			                dashIdx: dashIdx,
			                size: 1
			            },
			        	success : function(data) {
			        		console.log(data);
			        	},
			        	error: function(r, s, e) {
			                console.log(e);
			                alert("오류");
			            }
			        });
		    	} else {
		    		var parentLi = $(this).closest('li');
			        parentLi.attr('wide', '');
			        $(this).text('큰 위젯으로 변경');
			        let dashIdx = parentLi.data("dno");
			        $.ajax({
			        	type : "POST",
			        	url : "WidgetChangeAjax",
			        	data: {
			                dashIdx: dashIdx,
			                size: 0
			            },
			        	success : function(data) {
			        		console.log(data);
			        	},
			        	error: function(r, s, e) {
			                console.log(e);
			                alert("오류");
			            }
			        });
		    	}
		    	$('.widget-option-layer').css('display','none');
		    });
		    $(document).on('keyup','.user-state-message', function() {
		    	let stateMessage = $(this).val();
		    	$.ajax({
		            type: 'POST',
		            url: 'MemberStateMessageAjax', 
		            data: {
		            	stateMessage: stateMessage,
		            	memberIdx : <%=memberIdx%>
		            },
		            success : function(data) {
		        		console.log(data);
		        	},
		        	error: function(r, s, e) {
		                console.log(e);
		                alert("오류");
		            }
		        });
		    });
		    let inviteCount = 0;
			let sideManagerValue = [];
		    $('.side-btn-close').click(function() {
				$('.side-board-area').css('display','none');
				sideManagerValue = []
			});
		    $(document).on('click','.task-item',function(){
		    	let taskIdx = $(this).data("bno");
		    	if($('.side-board-area').css('display') == 'none'){
					$('.side-board-area').css('display','block');
			    	$.ajax({
			    		type : "POST",
						url : "SideBoardDashAjax",
						data : {
							memberIdx : <%=memberIdx%>,
							taskIdx : taskIdx
						},
						success : function(data) {
							console.log(data);
							$('.side-board-area.side').each(function(){
								$(this).find('.feed-board-writer2-img').css('background-image','url('+data.ProfileImg+')');
								$(this).attr('data-bno',data.boardIdx);	
								$(this).find('.project-color').addClass("color-code-"+data.projectColor+"");
								$(this).find('.project-title-btn').text(data.projectName);
								$(this).find('.feed-board-writer-name').text(data.WriterName);
								$(this).find('.feed-board-date').text(data.BoardWriteTime);
								$(this).find('.side-text-content').text(data.content);
								$(this).find('.read-cnt-member').text(data.read);
								$(this).find('.board-title').text(data.title);
								$(this).find('.task-num-cnt em').text(data.taskIdx);
								$(this).find('.progress-bar').css('width',data.progress+'%');
								$(this).find('.progress-value').text(data.progress+'%');
								if(data.progress == 100) {
									$(this).find('.progress-bar').css('background','blue');
								} else {
									$(this).find('.progress-bar').css('background','green');
									
								}
								if(data.fix=='Y') {
									$(this).find('.feed-board-fixbtn-img').addClass('on');
								} else {
									$(this).find('.feed-board-fixbtn-img').removeClass('on');
								}
								$(this).find('.task-btn').removeClass('on');
								if(data.state == 1) {
									$(this).find('.task-btn.request').addClass('on');
								} else if (data.state == 2) {
									$(this).find('.task-btn.progress').addClass('on');
								} else if (data.state == 3) {
									$(this).find('.task-btn.feedback').addClass('on');
								} else if (data.state == 4) {
									$(this).find('.task-btn.complete').addClass('on');
								} else if (data.state == 5) {
									$(this).find('.task-btn.hold').addClass('on');
								}
								$(this).find('.input-data-text').each(function() {
								    if ($(this).parents('.task-start-date').length > 0) {
								        if (data.startDate == null) {
								            $(this).text(''); 
								            $(this).parents('.task-start-date').find('.input-data-text').css('display', 'none'); 
								            $(this).parents('.task-start-date').find('.remove-btn').css('display', 'none'); 
								            $(this).parents('.task-start-date').find('.side-input-start-datas').css('display', 'inline-block');  
								        } else {
								            $(this).text(data.startDate); 
								            $(this).parents('.task-start-date').find('.input-data-text').css('display', 'inline-block'); 
								            $(this).parents('.task-start-date').find('.remove-btn').css('display', 'inline-block'); 
								            $(this).parents('.task-start-date').find('.side-input-start-datas').css('display', 'none'); 
								        }
								    } else if ($(this).parents('.task-end-date').length > 0) {
								    	if (data.endDate == null) {
								            $(this).text(''); 
								            $(this).parents('.task-end-date').find('.input-data-text').css('display', 'none'); 
								            $(this).parents('.task-end-date').find('.remove-btn').css('display', 'none'); 
								            $(this).parents('.task-end-date').find('.side-input-end-datas').css('display', 'inline-block');  
								        } else {
								        	
								        	if (data.endValue == 'Y') {
								        	    $(this).parent().css('color', 'red !important');
								        	} else {
								        		$(this).parent().css('color', 'black !important');
								        	}

								        	$(this).text(data.endDate); 
								        	$(this).parents('.task-end-date').find('.input-data-text').css('display', 'inline-block'); 
								        	$(this).parents('.task-end-date').find('.remove-btn').css('display', 'inline-block'); 
								        	$(this).parents('.task-end-date').find('.side-input-end-datas').css('display', 'none');
								        }
								    }
								});
								$(this).find('.priority').removeClass('low');
								$(this).find('.priority').removeClass('middle');
								$(this).find('.priority').removeClass('high');
								$(this).find('.priority').removeClass('emergency');
								if(data.priority == 1) {
									$(this).find('.task-priority').find('.input-task-btn').css('display','none');
									$(this).find('.task-priority-write').css('display','inline-block');
									$(this).find('.priority').addClass('emergency');
									$(this).find('.task-priority-value').text('긴급');
									$(this).find('.task-priority').find('.remove-btn').css('display','inline-block');
								} else if(data.priority == 2) {
									$(this).find('.task-priority').find('.input-task-btn').css('display','none');
									$(this).find('.task-priority-write').css('display','inline-block');
									$(this).find('.priority').addClass('high');
									$(this).find('.task-priority-value').text('높음');
									$(this).find('.task-priority').find('.remove-btn').css('display','inline-block');
								} else if(data.priority == 3) {
									$(this).find('.task-priority').find('.input-task-btn').css('display','none');
									$(this).find('.task-priority-write').css('display','inline-block');
									$(this).find('.priority').addClass('middle');
									$(this).find('.task-priority-value').text('중간');
									$(this).find('.task-priority').find('.remove-btn').css('display','inline-block');
								} else if(data.priority == 4) {
									$(this).find('.task-priority').find('.input-task-btn').css('display','none');
									$(this).find('.task-priority-write').css('display','inline-block');
									$(this).find('.priority').addClass('low');
									$(this).find('.task-priority-value').text('낮음');
									$(this).find('.task-priority').find('.remove-btn').css('display','inline-block');
								} else if(data.priority == 5) {
									$(this).find('.task-priority').find('.input-task-btn').css('display','none');
									$(this).find('.input-task-btn').css('display','inline-block');
									$(this).find('.task-priority-write').css('display','none');
									$(this).find('.task-priority-value').text('');
									$(this).find('.task-priority').find('.remove-btn').css('display','none');
								}
								if(data.TaskGroupIdx == 0) {
									$(this).find('.task-group').find('.input-task-btn').css('display','inline-block');
									$(this).find('.task-group-content').css('display','none');
									$(this).find('.task-group-name').text('');
									$(this).find('.task-group').find('.remove-btn').css('display','none');
								} else {
									$(this).find('.task-group').find('.input-task-btn').css('display','none');
									$(this).find('.task-group-content').css('display','inline-block');
									$(this).find('.task-group-name').text(data.TaskGroupName);
									$(this).find('.task-group').find('.remove-btn').css('display','inline-block');
								}
								$(this).find('.task-manager-name').remove();
								for(let i = 0; i<data.manager.length; i++) {
									let managerValue = "<span class=\"task-manager-name\" data-mno=\"" + data.manager[i].taskManagerId + "\">" +
									    " <span class=\"task-manager-img\" id=\"task-manager-img2\" style=\"background-image: url(" + data.manager[i].taskManagerProfileImg + ")\"></span>" +
									    " <span class=\"task-manager-value\">" + data.manager[i].taskManagerName + "</span>" +
									    " <button class=\"side-manager-remove-btn\"></button>" +
									"</span>";
									$(this).find('.task-manager-area').append(managerValue);
									sideManagerValue.push(data.manager[i].taskManagerId);
								}
								$(this).find('.emotion1').remove();
								$(this).find('.emotion2').remove();
								$(this).find('.emotion3').remove();
								$(this).find('.emotion4').remove();
								$(this).find('.emotion5').remove();
								$(this).find('.task-group-list-box').find('li').remove();
								for(let i = 0; i<data.taskGroup.length; i++) {
									let taskGroup = "<li> "+
													"		<div class = \"task-group-item\" data-code ="+data.taskGroup[i].taskGroupIdx+"> "+
													"		<div class = \"task-group-name-box\">"+data.taskGroup[i].taskGroupName+"</div> "+
													"	</div> "+
												"	</li>";
									$(this).find('.task-group-list-box').find('ul').append(taskGroup);
								}
								let taskdefault = "<li>"+
													"		<div class = \"task-group-item\" id = \"none-group\" data-code=\"0\">"+
													"		<div class = \"task-group-name-box\">그룹 미지정</div>"+
													"	</div>"+
													" </li>";
								$(this).find('.task-group-list-box').find('ul').append(taskdefault);
								for(let i = 0; i<data.emotion.length; i++) {
									let emotion = ""
									
									if(data.emotion[i].emotionType == 1) {
										emotion = "<div class=\"emotion1\"></div>";
									} else if (data.emotion[i].emotionType == 2) {
										emotion = "<div class=\"emotion2\"></div>";
									} else if (data.emotion[i].emotionType == 3) {
										emotion = "<div class=\"emotion3\"></div>";
									} else if (data.emotion[i].emotionType == 4) {
										emotion = "<div class=\"emotion4\"></div>";
									} else if (data.emotion[i].emotionType == 5) {
										emotion = "<div class=\"emotion5\"></div>";
									}
									$(this).find('.side-board-emotion').append(emotion);
								}
								if(data.emotionTotal <= 0) {
									$(this).find('.emotion-writer-cnt').text('');
									$(this).find('.emotion-writer-name').text('');
								} else if(data.emotionTotal >= 1) {
									$(this).find('.emotion-writer-name').text(data.emotionName);
								} 
								if(data.emotionTotal > 1) {
									$(this).find('.emotion-writer-cnt').text("+"+(data.emotionTotal-1));
								}
								if(data.bookmark == 0) {
									$(this).find('.bookmark-icon').removeClass('on');
								} else {
									$(this).find('.bookmark-icon').addClass('on');
								}
								$(this).find('.emotion-icon').removeClass('on');
								$(this).find('.emotion-btn span').text('좋아요');
								for(let i = 0; i<data.emotionMember.length; i++) {
									if(data.emotionMember[i].memberIdx == <%=memberIdx%>) {
										$(this).find('.emotion-icon').addClass('on');
										if(data.emotionMember[i].emotionType == 1) {
											$(this).find('.emotion-btn span').text('좋아요');
										} else if(data.emotionMember[i].emotionType == 2) {
											$(this).find('.emotion-btn span').text('부탁해요');
										} else if(data.emotionMember[i].emotionType == 3) {
											$(this).find('.emotion-btn span').text('힘들어요');
										} else if(data.emotionMember[i].emotionType == 4) {
											$(this).find('.emotion-btn span').text('훌륭해요');
										} else if(data.emotionMember[i].emotionType == 5) {
											$(this).find('.emotion-btn span').text('감사해요');
										}
									} 
								}
								$(this).find('.comment-content-box').remove();
								for(let i = 0; i<data.comment.length; i++) {
								let comment = " <div class=\"comment-content-box\" data-cno="+data.comment[i].commentIdx+"> "+
										"	<div class=\"comment-writer-icon\">"+
										" <span class=\"comment-writer2-icon-image\" style=\"background-image: url('" + data.comment[i].commentProfileImg + "');\"></span>" +
										"	</div>"+
										"	<div class=\"comment-content-mainbox\">"+
										"		<div class=\"mainbox-user\"> "+
										"			<div class=\"mainbox-userbox\"> "+
										"				<span class=\"userbox-username\">"+data.comment[i].commentwriter+"</span>"+
										"				<span class=\"userbox-user-position\"></span>"+
										"				<span class=\"userbox-record-date\">"+data.comment[i].commentTime+"</span>"+
										"			</div>"+
										"		</div>"+
										"		<div class=\"mainbox-content\">"+
										"			<div>"+
										"				<div class=\"mainbox-content-area\">"+
										"					<div>"+
										"						"+data.comment[i].commentContent+""+
										"					</div>"+
										"				</div>"+
										"			</div>"+
										"		</div>"+
										"	</div>"+
										" </div>";
								
								$(this).find('.comment-content').append(comment);
								}
								
							});
						},
						error: function(r, s, e) {
			                console.log(e);
			                alert("오류");
			            }
			    	});
				} else {
					$('.side-board-area').css('display','none');
					sideManagerValue = []
				}
			});
		    $('.feed-board-fixbtn').click(function(){
				let boardIdx = $(this).parents('.side-board-area').data("bno");
				if($(this).find('.feed-board-fixbtn-img').hasClass("on")==true) {
					$(this).find('.feed-board-fixbtn-img').removeClass("on");
					$.ajax({
						type: 'POST',
				        url: 'BoardFixDelAjax',
				        data: {
				            boardIdx : boardIdx 
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
					$(this).find('.feed-board-fixbtn-img').addClass("on");
					$.ajax({
						type: 'POST',
				        url: 'BoardFixAjax',
				        data: {
				        	boardIdx : boardIdx 
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
		    $(document).on('click','.task-group-item',function() {
				$('.task-group-list-layers').css('display', 'none');
			    if ($(this).attr('id') === 'none-group') {
			        return;
			    } else {
			    	let taskIdx = $(this).parents('.side-board-area').find('.task-num-cnt em').text();
			    	let code = $(this).data("code");
			        var text = $(this).text().trim(); 
			        $(this).parents('.task-group').find('.input-task-btn').css('display', 'none');
			        $(this).parents('.task-group').find('.task-group-name').text(text);
			        $(this).parents('.task-group').find('.remove-btn').css('display', 'inline-block');
			        $(this).parents('.task-group').find('.task-group-content').css('display', 'inline-block');
			        $.ajax({
						type: "POST",
	                    url: "TaskGroupSetAjax",
	                    data: { 
	                        taskIdx: taskIdx,
	                        taskGroupIdx : code
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
					});
			    }
			});
		    $('.priority-btn').click(function() {
		    	let taskIdx = $(this).parents('.side-board-area').find('.task-num-cnt em').text();
				$(this).parents('.task-priority').find('.input-task-btn').css('display','none');
				$(this).parents('.task-priority').find('.task-priority-write').css('display','inline-block');
				$(this).parents('.task-priority').find('.task-priority-value').css('display','inline-block');
				$(this).parents('.task-priority').find('.task-priority-icons').css('display','inline-block');
				var priorityselect = $(this).parents('.task-priority');
					$(priorityselect).find('.priority').removeClass('high');
					$(priorityselect).find('.priority').removeClass('middle');
					$(priorityselect).find('.priority').removeClass('emergency');
					$(priorityselect).find('.priority').removeClass('low');
				if($(this).attr('id')=='low') {
					$(priorityselect).find('.priority').addClass('low');
					$(priorityselect).find('.task-priority-value').text("낮음");
					$(priorityselect).find('.remove-btn').css('display','inline-block');
					Taskpriority = 4;
				}
				if($(this).attr('id')=='middle') {
					$(priorityselect).find('.priority').addClass('middle');
					$(priorityselect).find('.task-priority-value').text("중간");
					$(priorityselect).find('.remove-btn').css('display','inline-block');
					Taskpriority = 3;
				}
				if($(this).attr('id')=='high') {
					$(priorityselect).find('.priority').addClass('high');
					$(priorityselect).find('.task-priority-value').text("높음");
					$(priorityselect).find('.remove-btn').css('display','inline-block');
					Taskpriority = 2;
				}
				if($(this).attr('id')=='emergency') {
					$(priorityselect).find('.priority').addClass('emergency');
					$(priorityselect).find('.task-priority-value').text("긴급");
					$(priorityselect).find('.remove-btn').css('display','inline-block');
					Taskpriority = 1;
				}
				$('.prioritys-layer').css('display','none');
				$.ajax({
					type: "POST",
                    url: "TaskPrioritySetAjax",
                    data: { 
                        taskIdx: taskIdx,
                        code : Taskpriority
                    },
                    success: function(data) {
                        console.log(data);
                        Taskpriority = 5;
                    },
                    error: function(r, s, e) {
                        console.log(r.status);
                        console.log(e);
                        alert("오류");
                    }
				});
		    });
		  //댓글 작성
			$('.input-comment-box').on('keydown', function(e) {
				let boardIdx = $(this).parents('.side-board-area').data("bno");
		        if (e.keyCode === 13 && !e.shiftKey) {
		            e.preventDefault();  
		            if (comment !== '') {
		            var comment = $(this).html().trim();  
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
		        }
		    });
			//담당자 변경 클릭시
			$('.change-task-manager').click(function(){
					let taskIdx = $(this).parents('.feed-board-2').find('.task-num-cnt').find('em').text();
					$('.manager-add-section').attr('data-tno', taskIdx);
					$('.manager-add-section').css('display','block');
					$('.mainPop').css('display','block');
					
					$.ajax({
						type : "POST",
						url : "/Project/TaskManagerViewAjax",
						data : {
							taskIdx : taskIdx,
							projectIdx : 0
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
						        " <span class = \"task-manager-img\" id = \"task-manager-img2\" style=\"background-image: url('"+data[i].profileImg+"');\"></span>" +
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
										sideManagerValue.push($(this).data('mno'));
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
			$('.remove-btn').click(function() {
		    	let taskIdx = $(this).parents('.feed-board-2').find('.task-num-cnt em').text();
			
			    if($(this).parents('.task-start-date').length > 0) {
			        $('#datepicker-side1').val(''); 
			        $('#datepicker-side1').css('display','inline-block');
			        $(this).parents('.task-start-date').find('.input-data-text').text(''); 
			        $(this).css('display', 'none'); 
			        $.ajax({
			            type: "POST",
			            url: "TaskStartDateDELAjax",
			            data: { taskIdx: taskIdx },
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
			    if ($(this).parents('.task-end-date').length > 0) {
			    	$('#datepicker-side2').val(''); 
			        $('#datepicker-side2').css('display','inline-block');
			        $(this).parents('.task-end-date').find('.input-data-text').text(''); 
			        $(this).css('display', 'none'); 
			        $.ajax({
			            type: "POST",
			            url: "TaskEndDateDELAjax",
			            data: { taskIdx: taskIdx },
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
			    if ($(this).parents('.task-priority').length > 0) {
			    	$(this).parents('.task-priority').find('.task-priority-write').css('display','none');
			    	$(this).parents('.task-priority').find('.task-priority-value').text('');
			    	$(this).parents('.task-priority').find('.priority').removeClass('high');
			    	$(this).parents('.task-priority').find('.priority').removeClass('middle');
			    	$(this).parents('.task-priority').find('.priority').removeClass('low');
			    	$(this).parents('.task-priority').find('.priority').removeClass('emergency');
			    	$(this).parents('.task-priority').find('.input-task-btn').css('display','inline-block');
			    	$(this).css('display', 'none');
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
			    if ($(this).parents('.task-group').length > 0) {
			    	$(this).css('display', 'none');
			    	$(this).parents('.task-group').find('.task-group-content').css('display','none');
			    	$(this).parents('.task-group').find('.task-group-name').text('');
			    	$(this).parents('.task-group').find('.input-task-btn').css('display','inline-block');
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
			$('#datepicker-side1').datepicker({
		        dateFormat: 'yy-mm-dd',
		        changeMonth: true,       
		        changeYear: true,        
		        showButtonPanel: true,  
		        showAnim: 'fadeIn'    
		    });
		  $('#datepicker-side2').datepicker({
		        dateFormat: 'yy-mm-dd',  
		        changeMonth: true,       
		        changeYear: true,        
		        showButtonPanel: true,   
		        showAnim: 'fadeIn'       
		    });
		  let weekdays = ["일", "월", "화", "수", "목", "금", "토"];
			let startDate = "";
			let endDate = "";
		    $('#datepicker-side1').on('change', function() {
		    	let taskIdx = $(this).parents('.feed-board-2').find('.task-num-cnt em').text();
		        var selectedDate = $(this).val(); 
		        var date = new Date(selectedDate);
		        var dayOfWeek = weekdays[date.getDay()]; 
		        $(this).css('display','none');
		        $(this).parents('.data-content').find('.input-data-text').css('display','inline-block');
		        $(this).parents('.data-content').find('.input-data-text').text(selectedDate + ' ('+dayOfWeek+') 부터'); 
		        $(this).parents('.data-content').next().css('display', 'inline-block');
		        $.ajax({
                	type: "POST",
		            url: "TaskStartDateUpdateAjax",
		            data: { 
		            	taskIdx: taskIdx,
		            	date : selectedDate
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
		    $('#datepicker-side2').on('change', function() {
		    	let taskIdx = $(this).parents('.feed-board-2').find('.task-num-cnt em').text();
		        var selectedDate = $(this).val(); 
		        var date = new Date(selectedDate);
		        var dayOfWeek = weekdays[date.getDay()];
		        $(this).hide();
		        $(this).parents('.data-content').find('.input-data-text').text(selectedDate + ' ('+dayOfWeek+') 까지'); 
		        $(this).parents('.data-content').find('.input-data-text').css('display','inline-block');
		        $(this).parents('.data-content').next().css('display', 'inline-block');
		        $.ajax({
                    type: "POST",
                    url: "TaskEndDateUpdateAjax",
                    data: { 
                        taskIdx: taskIdx,
                        date: selectedDate
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
	        	sideManagerValue = []; 
			});
			$(document).ready(function() {
			    $(document).on('keyup','.managerSearchBox', function() {
			    	let taskIdx = $(this).parents('.manager-add-section').data('tno');
			    	let text = $(this).val();
			    	sideManagerValue = []; 
				    $('.task-manager-name').each(function() {
				        var mno = $(this).data('mno');
				        sideManagerValue.push(mno);
				    });
				    $.ajax({
				    	type : "POST",
						url : "/Project/TaskManagerSearchAjax",
						data : {
							taskIdx : taskIdx,
							projectIdx : 0,
				    		search : text
						},
						success: function(data) {
							$('.board-manager-item').remove();
				            console.log(data);
				            for(let i = 0; i<data.length; i++) {
					            var taskManager =  "";
					            if (sideManagerValue.includes(data[i].memberIdx)) {
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
			    	
			    });
			});
			$('.bookmark-btn').click(function(){
				let boardIdx = $(this).parents('.side-board-area').data("bno");
				if($(this).find('.bookmark-icon').hasClass('on')) {
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
				} else {
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
			        sideManagerValue.push(mno);
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
			        var index = sideManagerValue.indexOf(mno); 
			        if (index !== -1) {
			        	sideManagerValue.splice(index, 1);
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
			//담당자 등록버튼 클릭 
			 
			$('.managerSubmitbtn').click(function(){
				let taskIdx = $(this).parents('.manager-add-section').data('tno');
			    
			    $.ajax({
			    	type : "POST",
					url : "/Project/TaskManagerChangeAjax",
					data : {
						taskIdx : taskIdx,
						mnoValues : JSON.stringify(sideManagerValue)
					},
					success: function(data) {
						 console.log(data);
						 	$('.task-manager-name').remove();
							$('.manager-add-section').css('display','none');
							$('.mainPop').css('display','none');
						    $('.board-manager-item').removeClass('active');
						    managerCount = 0;
						    sideManagerValue = [];
						    $('.managerListNull').css('display','block');
				        	$('.board-manager-selected-num').css('display','none');
				        	$('.inviteManagerList').css('display','none');
				        	$('.managerSearchBox').val('');
				        	$('.feed-board-2').each(function() {
				                 let currentTaskIdx = $(this).find('.task-num-cnt em').text(); 

				                 if (currentTaskIdx == taskIdx) {
				                     for (let i = 0; i < data.length; i++) {
				                         let createmanager = " <span class='task-manager-name'>" +
				                         "<span class='task-manager-img' id='task-manager-img2' style = \"background:url('"+data[i].profileImg+"'); no-repeat center center; background-size: cover;\"></span>" +
				                             "<span class='task-manager-value' data-mno=" + data[i].memberIdx + ">" + data[i].name + "</span>" +
				                             "<button class='side-manager-remove-btn'></button>" +
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
				 var index = sideManagerValue.indexOf(memberIdx); 
			        if (index !== -1) {
			        	sideManagerValue.splice(index, 1);
			        }
				 $('.board-manager-selected-count').text(managerCount+"건 선택");
				 if(managerCount == 0) {
			        	$('.managerListNull').css('display','block');
			        	$('.board-manager-selected-num').css('display','none');
			        	$('.inviteManagerList').css('display','none');
			     }
			});
			$(document).on('click', '.side-manager-remove-btn', function(){
				let memberIdx = $(this).parent().data("mno");
				let taskIdx = $(this).parents('.feed-board-2').find('.task-num-cnt').find('em').text();
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
			            $(this).parents('.task-manager-name').remove();
			        },
			        error: function(r, s, e) {
			            console.log(r.status);
			            console.log(e);
			            alert("오류");
			        }
				});
			});
			//업무 매니저 전체삭제
			$('.board-manager-selected-all-delete').click(function(){
		        $('.task-manager-name').remove();
		        $('.board-manager-item').removeClass('active');
		        sideManagerValue = [];
		        managerCount = 0;
		        $('.managerListNull').css('display','block');
	        	$('.board-manager-selected-num').css('display','none');
	        	$('.inviteManagerList').css('display','none');
			});
			$('.invite-close').click(function(){
				$('.project-invite-area').css('display','none');
				$('.mainPop').css('display','none');
				$('.invite-flow-section').css('display','none');
				$('.invite-email').css('display','none');
				$('.all-select').text('전체 선택');
			    $('.invite-member-item').removeClass('active');
			    inviteCount = 0;
			    $('.class="manager-add-section"').css('diplay','none');
			    $('.inviteMemberListNull').css('display','block');
		       	$('.project-invite-selected-num').css('display','none');
		       	$('.inviteTargetList').css('display','none');
		       	$('.invite-email-value').val(""); 
		        $('.invite-email-list').empty(); 
		       
		        $.each(initialDivs, function(i, div) {
		            $('.invite-email-list').append(div);
		        });
		        $('.invite-email-value-input').text("");
			})
			
			$('.invite-member-item').click(function() {
			    if (!$(this).hasClass('active')) {
			        $(this).addClass('active');
			        $('.all-select').text('전체 해제');
			        inviteCount++;
			        managerCount++;
			       	$('.project-select-memeber-count').text(inviteCount+"건 선택");
			        if(inviteCount > 0) {
			        	$('.inviteMemberListNull').css('display','none');
			        	$('.project-invite-selected-num').css('display','block');
			        	$('.inviteTargetList').css('display','block');
			        }
			    } else {
			        $(this).removeClass('active');
			        if (inviteCount >= 1) {
			            $('.all-select').text('전체 선택'); // inviteCount가 0이면 전체 선택으로 변경
			        }
			        inviteCount--;  // 카운트 감소
			        managerCount--;
			        $('.project-select-memeber-count').text(inviteCount+"건 선택");
			        if(inviteCount == 0) {
			        	$('.inviteMemberListNull').css('display','block');
			        	$('.project-invite-selected-num').css('display','none');
			        	$('.inviteTargetList').css('display','none');
			        }
			    }
			});

			$('.all-select').click(function() {
			    if ($(this).text().trim() == "전체 선택") {
			        // 전체 선택
			        $(this).text('전체 해제');
			        $('.invite-member-item').addClass('active');
			        inviteCount = $('.project-invite-member-area .invite-member-item.active').length-1;
			        managerCount = $('.project-invite-member-area .invite-member-item.active').length-1;
			        $('.project-select-memeber-count').text(inviteCount+"건 선택");
			        $('.inviteMemberListNull').css('display','none');
		        	$('.project-invite-selected-num').css('display','block');
		        	$('.inviteTargetList').css('display','block');
			    } else {
			        // 전체 해제
			        $(this).text('전체 선택');
			        $('.invite-member-item').removeClass('active');
			        inviteCount = 0;
			        managerCount = 0;
			        $('.inviteMemberListNull').css('display','block');
		        	$('.project-invite-selected-num').css('display','none');
		        	$('.inviteTargetList').css('display','none');
			    }
			});
			//해당사이드글 진행상태 변경
			$('.task-btn').click(function(){
				let taskIdx = $(this).parents('.feed-board-2').find('.task-num-cnt').find('em').text();
				let state = 1;
				$('.task-btn').removeClass('on');
				$(this).addClass('on');
				if($('.task-btn.request').hasClass('on')) {
					state = 1;
				}
				if($('.task-btn.progress').hasClass('on')) {
					state = 2;
				}
				if($('.task-btn.feedback').hasClass('on')) {
					state = 3;
				}
				if($('.task-btn.complete').hasClass('on')) {
					$(this).parents('.task-option-area').find('.progress-bar').css('width', '100%');
					$(this).parents('.task-option-area').find('.progress-bar').css('background', 'blue');
					$(this).parents('.task-option-area').find('.progress-value').text('100%');
					state = 4;
				}
				if($('.task-btn.hold').hasClass('on')) {
					state = 5;
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
			});
			
			//우선순위 버튼 출력
			$('.input-task-btn').click(function(){
				if ($(this).parent().find('.prioritys-layer').css('display')=='none') {
					$(this).parent().find('.prioritys-layer').css('display','block');
				} else {
					$(this).parent().find('.prioritys-layer').css('display','none');
				}
			});
			
			//업무 그룹 추가 버튼
			$('.input-task-btn').click(function(){
				if ($(this).parent().find('.task-group-list-layers').css('display')=='none') {
					$(this).parent().find('.task-group-list-layers').css('display','block');
				} else {
					$(this).parent().find('.task-group-list-layers').css('display','none');
				}
			});
			//해당 remove버튼
			$('.remove-btn').click(function(){
				$(this).css('display','none');
				if($(this).parents('.task-start-date-content')) {
					var start = $(this).parents('.task-start-date-content');
					$(start).find('.input-date').css('display','inline-block');
					$(start).find('.task-date-name').text("");
					$(start).find('.task-start-date-value').css('display','none');
				}
				if($(this).parents('.task-date-content')) {
					var end = $(this).parents('.task-date-content');
					$(end).find('.input-date').css('display','inline-block');
					$(end).find('.task-date-name').text("");
					$(end).find('.task-start-date-value').css('display','none');
				}
				if($(this).parents('.task-priority-content')) {
					var priority = $(this).parents('.task-priority-content');
					$(priority).find('.input-task-btn').css('display','inline-block');
					$(priority).find('.task-priority-value').text("");
					$(priority).find('.priority').removeClass('high');
					$(priority).find('.priority').removeClass('low');
					$(priority).find('.priority').removeClass('middle');
					$(priority).find('.priority').removeClass('emergency');
					$(priority).find('.task-priority-value').css('display','none');
					$(priority).find('.task-priority-icons').css('display','none');
				}
				if($(this).parents('.task-group')) {
					var group = $(this).parents('.task-group');
					$(group).find('.input-task-btn').css('display','inline-block');
					$(group).find('.task-group-name').text("");
					$(group).find('.task-group-content').css('display','none');
				}
			});
			//더보기 클릭
			$('.add-task-option').click(function(){
				$('.task-group').css('display','flex');
				$('.task-progress').css('display','flex');
				$('.task-priority').css('display','flex');
				$('.task-end-date').css('display','flex');
				$('.task-start-date').css('display','flex');
				$('.add-task-option').css('display','none');
			});
			//진행도 클릭시
			$('.progress-btn').click(function(){
				var progress = $(this).find('em').text().trim();
				$(this).parents('.task-progress').find('.progress-value').text(progress);
				let taskIdx = $(this).parents('.side-board-area').find('.task-num-cnt em').text();
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
				$.ajax({
					type: "POST",
                    url: "TaskProgressSetAjax",
                    data: { 
                        taskIdx: taskIdx,
                        progress : Taskprogress
                    },
                    success: function(data) {
                        console.log(data);
                        alert("변경되었습니다.");
                        Taskprogress = 0;
                    },
                    error: function(r, s, e) {
                        console.log(r.status);
                        console.log(e);
                        alert("오류");
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
			$('#widget-my-chat').on('click','.chat-item',function(){
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
		    	$('.flow-invite-header-text').text('새 채팅');
		    	$('.flow-invite-header-text').removeData('chno');
		    	$('.invite-member-item').removeClass('active');
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
		    	$('.invite-member-item').removeClass('active');
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
		    	$('.invite-member-item').removeClass('active');
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
			$(document).on('click', '.invite-member-item', function() {
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
		  		$('.invite-member-item').removeClass('active');
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
						    		search : text,
								},
								success: function(data) {
									$('.invite-member-item').remove();
						            console.log(data);
						            for(let i = 0; i<data.length; i++) {
							            var taskManager =  "";
							            if (chatmnoValues.includes(data[i].memberIdx)) {
							                taskManager += " <li class = \"invite-member-item active\" data-mno=" + data[i].memberIdx + ">";
							            } else {
							                taskManager += " <li class = \"invite-member-item\" data-mno=" + data[i].memberIdx + ">";
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
						    		search : text,
								},
								success: function(data) {
									$('.invite-member-item').remove();
						            console.log(data);
						            for(let i = 0; i<data.length; i++) {
							            var taskManager =  "";
							            if (chatmnoValues.includes(data[i].memberIdx)) {
							                taskManager += " <li class = \"invite-member-item active\" data-mno=" + data[i].memberIdx + ">";
							            } else {
							                taskManager += " <li class = \"invite-member-item\" data-mno=" + data[i].memberIdx + ">";
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
		  			let chatRoomIdx = $('.side-chatting-room').data("chno");
		  			$('.invite-chat-section').attr('data-chno', chatRoomIdx);
		  			$('.flow-invite-header-text').text('채팅 초대');
		  			$('.mainPop').css('display','block');
			    	$('.invite-chat-section').css('display','block');
			    	$('.invite-member-item').removeClass('active');
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
			        $.ajax({
			        	type: 'post',
		    	        url: 'ChatRoomMemberSearchAjax',
		    	        data: {
		    	        	chatRoomIdx : chatRoomIdx
		    	        },
		    	        success: function(data) {
		    	        	console.log(data);
		    	        	let existingMemberIdxList = data.array1.map(function(member) {
		    	    			return member.memberIdx;
		    	    		});

		    	    		$('.invite-member-item').each(function() {
		    	    			let mno = Number($(this).data('mno'));
		    	    			if (existingMemberIdxList.includes(mno)) {
		    	    				$(this).hide();
		    	    			} else {
		    	    				$(this).show();
		    	    			}
		    	    		});
		    	        },
		    	        error: function(r, s, e) {
		    	        	console.log(r.status);
		    	        	console.log(e);
		    	        }
			        });
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
		  	//바로가기 이동 
		  	$('.shortcut-list').on('click','.shortcut-item',function(){
		  		let url = $(this).data("url");
		  		window.location.href = url;
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
							$('.user-state-message').val(statusMassage);
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
			$('#inviteURL').click(function(){
				const copyText = "http://114.207.245.107:9090//Project/Controller?command=AccountMemberShip&companyIdx="+<%=companyIdx%>; 
			    const temp = document.createElement("textarea");
			    temp.value = copyText;
			    document.body.appendChild(temp);
			    temp.select();
			    document.execCommand("copy");
			    document.body.removeChild(temp);
			    alert("초대 링크가 복사되었습니다.");
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
	<div class = "mainPop" style = "display: none;">
		<div class = "mainPop1">
			<div class = "mainPop2">
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
										<li class = "invite-member-item" data-mno = <%=dto.getMemberIdx() %>>
											<div class = "chat-invite-check-select"></div>
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
							<div class = "chat-invite-outsider" style="display:none">
								<div class = "chat-invite-member-box">
									<ul class = "chat-invite-member-area">
										<%for(MemberDto dto : Olist) { %>
										<li class = "invite-member-item" data-mno = <%=dto.getMemberIdx() %>>
											<div class = "chat-invite-check-select"></div>
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
							<li class = "hometab-item" id = "task">업무</li>
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
											<option class = "CATG1">업무관련</option>
											<option class = "CATG2">동호회</option>
											<option class = "CATG3">정보공유</option>
											<option class = "CATG4">학습</option>
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
											<li>
												<span>작성 권한</span>
												<div class = "select-authority-area">
													<select class = "authority-select-box">
														<option value = "0">전체</option>
														<option value = "1">프로젝트 관리자만</option>
													</select>
												</div>
											</li>
											<li class= "edit-auth-element" style="display: flex;">
												<span>수정 권한</span>
												<div class = "select-authority-area">
													<select class = "authority-select-box">
														<option value = "0">전체</option>
														<option value = "1">프로젝트 관리자 + 작성자만</option>
														<option value = "2">작성자만</option>
													</select>
												</div>
											</li>
											<li>
												<span>조회 권한</span>
												<div class = "select-authority-area">
													<select class = "authority-select-box">
														<option value = "0">전체</option>
														<option value = "1">프로젝트 관리자 + 작성자만</option>
													</select>
												</div>
											</li>
										</ul>
									</dd>
									<dt>댓글</dt>
									<dd>
										<ul>
											<li>
												<span>작성 권한</span>
												<div class = "select-authority-area">
													<select class = "authority-select-box">
														<option value = "0">전체</option>
														<option value = "1">프로젝트 관리자 + 작성자만</option>
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
				<%for(MyProjectViewDto dto : MPlist) { %>
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
					<%for(MemberDto dto : list) { %>
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
			<div class = "side-board-area side">
				<div class = "side-post-header">
					<h3 class = "side-post-title">
						<i class = "project-color"></i>
						<span class = "project-title-btn"></span>
					</h3>
					<button class = "side-btn-close">
						<i class = "close-btn-icon"></i>
					</button>
				</div>
				<div class = "auto-scroll-side-board">
					<div class = "feed-board-2">
							<div class = "feed-board-header-top">
								<div class = "feed-board-writer">
									<span class = "feed-board-writer2-img"></span>
									<div class = "feed-board-writer-date">
										<div class = "feed-board-writer-date-box">
											<div class = "feed-board-writer-name"></div>
											<div class = "feed-board-date"></div>
											<div class = "feed-people-icon">
												<div class = "feed-people-icon-img"></div>
											</div>
										</div>
									</div>
									<div class = "feed-post-option">
										<button id = "movepost" class = "btn-go-board">게시글 바로가기</button>
										<button class = "feed-board-fixbtn" style = "display:block">
											<div class = "feed-board-fixbtn-img"></div>
										</button>
									</div>
								</div>
							</div>
							<div class = "feed-board-header-bottom">
								<div class = "board-title-area">
									<h4 class = "board-title"></h4>
								</div>
								<div class = "task-num">
									<span class = "task-num-cnt">
										업무번호
										<em></em>
									</span>
								</div>
							</div>
							<div class = "feed-board-main">
								<div class = "board-main-content">
									<div class = "task-option">
										<div class = "task-option-area">
											<div class = "task-states" style = "display:flex">
												<div class = "task-icons">
													<div class = "task-state-img"></div>
												</div>
												<div class = "task-state-content">
													<div class = "task-state-btns">
														<button class = "task-btn request" >요청</button>
														<button class = "task-btn progress" >진행</button>
														<button class = "task-btn feedback" >피드백</button>
														<button class = "task-btn complete" >완료</button>
														<button class = "task-btn hold" >보류</button>
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
														</span>
													</div>
													<button class = "change-task-manager">담당자 변경</button>
												</div>
											</div>
											<div class = "task-start-date" style = "display:flex">
												<div class = "task-icon">
													<div class = "task-date-img"></div>
												</div>
												<div class = "task-start-date-content" style = "display:flex">
													<div class = "data-content">
														<span class = "input-data-text"></span>
														<label type="button" class="input-date" style="display:flex">
															<input type = "text" class="side-input-start-datas datepicker" id="datepicker-side1" style="display: inline-block;" placeholder="시작일추가" id="dp1737514628589">
														</label>
													</div>
													<button class = "remove-btn" style = "display:none"></button>
												</div>
											</div>
											<div class = "task-end-date" style = "display:flex">
												<div class = "task-icon">
													<div class = "task-date-img"></div>
												</div>
												<div class = "task-date-content" style = "display:flex">
													<div class = "data-content">
														<span class = "input-data-text"></span>
														<label type="button" class="input-date" style="display:flex">
															<input type = "text" class="side-input-end-datas datepicker" id="datepicker-side2" style="display: inline-block;" placeholder="마감일추가" id="dp1737514628589">
														</label>
													</div>
													<button class = "remove-btn" style = "display:none"></button>
												</div>
											</div>
											<div class = "task-priority" style = "display:flex">
												<div class = "task-icon">
													<div class = "task-priority-img"></div>
												</div>
												<div class = "task-priority-content">
													<button class = "input-task-btn" style = "display:none">우선순위 추가</button>
													<div class = "task-priority-write" style = "display:inline-block">
														<div class = "task-priority-icons" style = "float:left">
															<div class = "priority"></div>
														</div>
														<span class = "task-priority-value"></span>
														<button class ="remove-btn" style="display:inline-block"></button>
													</div>
													<div class="prioritys-layer" style="display: none;">
														<button class="priority-btn" id="low">
															<span>
																<i class="low"></i>
															</span>
															낮음
														</button>
														<button class="priority-btn" id="middle">
															<span>
																<i class="middle"></i>
															</span>
															중간
														</button>
														<button class="priority-btn" id="high">
															<span>
																<i class="high"></i>
															</span>
															높음
														</button>
														<button class="priority-btn" id="emergency">
															<span>
																<i class="emergency"></i>
															</span>
															긴급
														</button>
													</div>
												</div>
											</div>
											<div class = "task-group" style = "display:flex">
												<div class = "task-icon">
													<div class = "task-group-img"></div>
												</div>
												<button class = "input-task-btn" style = "display:none">그룹 추가</button>
												<div class = "task-group-content" style = "display:inline-block">
													<span class = "task-group-name"></span>
													<button class = "remove-btn" style="display:inline-block"></button>
												</div>
												<div class = "task-group-list-layers" style="display:none">
													<div class = "task-group-list-box">
														<ul>
															<li>
																<div class = "task-group-item" id = "none-group" data-code="0">
																	<div class = "task-group-name-box">그룹 미지정</div>
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
													<div class = "progress-bar" style = "display :flex; width:0%"></div>
													<div class = "progress-graph">
														<span class = "progress-btn" data-progress-value = "0"><em>0%</em></span>
														<span class = "progress-btn" data-progress-value = "10"><em>10%</em></span>
														<span class = "progress-btn" data-progress-value = "20"><em>20%</em></span>
														<span class = "progress-btn" data-progress-value = "30"><em>30%</em></span>
														<span class = "progress-btn" data-progress-value = "40"><em>40%</em></span>
														<span class = "progress-btn" data-progress-value = "50"><em>50%</em></span>
														<span class = "progress-btn" data-progress-value = "60"><em>60%</em></span>
														<span class = "progress-btn" data-progress-value = "70"><em>70%</em></span>
														<span class = "progress-btn" data-progress-value = "80"><em>80%</em></span>
														<span class = "progress-btn" data-progress-value = "90"><em>90%</em></span>
														<span class = "progress-btn" data-progress-value = "100"><em>100%</em></span>
													</div>
													<span class = "progress-value">%</span>
												</div>
											</div>
										</div>
									</div>
									<div class = "side-text-content"></div>
								</div>
								<div class = "board-main-option">
									<div class = "board-main-option-left">
										<div class = "board-emotion" style = "display:block">
											<div class = "board-emotion-group">
												<div class = "side-board-emotion"></div>
											</div>
											<span class = "board-emotion-writer">
												<span class = "emotion-writer-name"></span>
												<span class = "emotion-writer-cnt"></span>
											</span> 	
										</div>
										<div class = "main-option-btn">
											<button class = "bookmark-btn">
												<div class = "bookmark-icon"></div>
												<span>북마크</span>
											</button>
										</div>
									</div>
								<div class = "board-main-option-right">
									<div class = "main-option-cnt" >
										<span>읽음</span>
										<span class = "read-cnt-member"></span>
									</div>
								</div>
							</div>
						</div>
						<div class = "feed-board-comment">
							<div class = "comment-content">
							</div>
							<div class = "comment-bottomline"></div>
						</div>
					</div>
				</div>
				<div class = "feed-board-comment-input">
					<div class="comment_writer1_img" style="background: url('<%= profile %>'); no-repeat center center; background-size: cover;"></div>
					<form class = "input-comment">
						<fieldset>
							<div class = "input-comment-box" contenteditable="true"
								placeholder = "줄바꿈 Shift + Enter / 입력 Enter 입니다."
							></div>
						</fieldset>
						<div class = "input-comment-file-box"></div>
						<div class = "input-comment-img-box"></div>
					</form>
				</div>
			</div>
			<div class = "dash-board-area" style="display: flex">
				<div class = "dash-header">
					<div class = "dash-header-left">
						<ul>
							<li class = "dash-profile-name"><%=name%>님 즐거운 <%=timeOfDay%>입니다.😊</li>
							<li class = "name-input">
								<input class ="user-state-message" name ="status-message" placeholder="프로필 상태 메시지를 입력해보세요." maxlength="50" value = "<%=StateMessage%>">
							</li>
						</ul>
					</div>
					<div class = "dash-header-right">
						<div class = "dash-header-time">
							<span id ="widget-date"><%=today %><%=dayOfWeek%></span>
						</div>
						<div class = "dash-header-right-btn">
							<button class = "display-setting-btn"></button>
						</div>
					</div>
				</div>
				<div class = "dash-shortcut">
					<div class = "shortcut-layer">
						<div class = "shortcut-list">
							<%for(GoToDto dto : GoToList) { %>
							<div class = "shortcut-item" data-url = <%=dto.getUrl() %>>
								<em class = "item-square" style="background-image: url(<%=dto.getIcon()%>)"></em>
								<span class = "item-name"><%=dto.getName() %></span>
							</div>
							<% } %>
						</div>
					</div>
				</div>
				<div class = "main-widget-area">
					<ul class = "dash-board-widget-list">
					<%for(DashboardDto Ddto : Dlist) { %>
						<%if (Ddto.getWidgetCategory()==2) { %>
						<%if (Ddto.getBoardSize()==0) { %>
						<li id = "widget-my-prj" data-dno = <%=Ddto.getDashBoardIdx() %>>
						<% } else { %>
						<li id = "widget-my-prj" wide="widget-wide-item" data-dno = <%=Ddto.getDashBoardIdx() %>>
						<% } %>
							<div class = "widget-header">
								<div class = "widget-title-box">
									<span class = "title">내 프로젝트</span>
								</div>
								<div class = "widget-option-btn">
									<button class = "widget-option-button">
										<span></span>
										<span></span>
										<span></span>
									</button>
									<div class = "widget-option-layer" style="display:none">
										<%if (Ddto.getBoardSize()==0) { %>
										<button class = "widget-size-change">큰 위젯으로 변경</button>
										<% } else { %>
										<button class = "widget-size-change">작은 위젯으로 변경</button>
										<% } %>
									</div>
								</div>
							</div>
							<ul class = "scroll-widget-value">
								<li class = "widget-default-prj">
									<span class = "prj-icon"></span>
									<span class = "prj-title">새 프로젝트</span>
								</li>
								<% for(MyProjectViewDto dto : Mlist) { %>
									<li class = "project-item" data-pno = <%=dto.getProjectIdx() %>>
										<span class = "prj-box color-code-<%=dto.getProjectColor() %>"></span>
										<span class = "prj-title"><%= dto.getProjectName() %></span>
									</li>
								<% } %>
							</ul>
						</li>
						<%} %>
						<%if (Ddto.getWidgetCategory()==3) { %>
						<li id = "widget-my-manager-task" wide="widget-wide-item" data-dno = <%=Ddto.getDashBoardIdx() %>>
							<div class = "widget-header">
								<div class = "widget-title-box">
									<span class = "title">내가 담당중인 업무</span>
								</div>
							</div>
							<ul class = "widget-tab-title">
								<li class = "widget-1 active">
									예정된 업무
									<span><%=requestCount1%></span>
								</li>
								<li class = "widget-2">
									지연된 업무
									<span><%=requestCount2%></span>
								</li>
							</ul>
							<ul class = "widget-content-list" id = "widget-1">
								<%if(requestCount1 == 0) { %>
								<li class = "widget-content-null">
									<p>예정된 업무가 없습니다.</p>
								</li>
								<% } else { %>
								<%for(RequestTaskDto Rdto : Rlist1) { %>
									<li class = "task-item" data-bno = <%=Rdto.getTaskIdx() %>>
										<%if(Rdto.getState() == 1) { %>
										<span class = "status request">요청</span>
										<% } %>
										<%if(Rdto.getState() == 2) { %>
										<span class = "status progress">진행</span>
										<% } %>
										<%if(Rdto.getState() == 3) { %>
										<span class = "status feedback">피드백</span>
										<% } %>
										<%if(Rdto.getState() == 4) { %>
										<span class = "status complete">완료</span>
										<% } %>
										<%if(Rdto.getState() == 5) { %>
										<span class = "status hold">보류</span>
										<% } %>
										<p><%=Rdto.getTitle() %></p>
										<span class = "priority">
											<%if(Rdto.getPriority()==5) {%>
											<i class=""></i>
											<% } %>
											<%if(Rdto.getPriority()==4) {%>
											<i class="icons-low"></i>
											<% } %>
											<%if(Rdto.getPriority()==3) {%>
											<i class="icons-middle"></i>
											<% } %>
											<%if(Rdto.getPriority()==2) {%>
											<i class="icons-high"></i>
											<% } %>
											<%if(Rdto.getPriority()==1) {%>
											<i class="icons-emergency"></i>
											<% } %>
										</span>
										<span class = "due-date"><%=Rdto.getEndDate().substring(0, 10) %></span>
									</li>
								<%} %>
								<% } %>
							</ul>
							<ul class = "widget-content-list" id = "widget-2" style = "display:none">
								<%if(requestCount2 == 0) { %>
								<li class = "widget-content-null">
									<p>예정된 업무가 없습니다.</p>
								</li>
								<% } else { %>
								<%for(RequestTaskDto Rdto : Rlist2) { %>
									<li class = "task-item" data-bno = <%=Rdto.getTaskIdx() %>>
										<%if(Rdto.getState() == 1) { %>
										<span class = "status request">요청</span>
										<% } %>
										<%if(Rdto.getState() == 2) { %>
										<span class = "status progress">진행</span>
										<% } %>
										<%if(Rdto.getState() == 3) { %>
										<span class = "status feedback">피드백</span>
										<% } %>
										<%if(Rdto.getState() == 4) { %>
										<span class = "status complete">완료</span>
										<% } %>
										<%if(Rdto.getState() == 5) { %>
										<span class = "status hold">보류</span>
										<% } %>
										<p><%=Rdto.getTitle() %></p>
										<span class = "priority">
											<%if(Rdto.getPriority()==5) {%>
											<i class=""></i>
											<% } %>
											<%if(Rdto.getPriority()==4) {%>
											<i class="icons-low"></i>
											<% } %>
											<%if(Rdto.getPriority()==3) {%>
											<i class="icons-middle"></i>
											<% } %>
											<%if(Rdto.getPriority()==2) {%>
											<i class="icons-high"></i>
											<% } %>
											<%if(Rdto.getPriority()==1) {%>
											<i class="icons-emergency"></i>
											<% } %>
										</span>
										<span class = "due-date"><%=Rdto.getEndDate().substring(0, 10) %></span>
									</li>
								<%} %>
								<% } %>
							</ul>
						</li>
						<% } %>
						<%if (Ddto.getWidgetCategory()==13) { %>
						<%if (Ddto.getBoardSize()==0) { %>
						<li id = "widget-my-chat" data-dno = <%=Ddto.getDashBoardIdx() %>>
						<% } else { %>
						<li id = "widget-my-chat" wide="widget-wide-item" data-dno = <%=Ddto.getDashBoardIdx() %>>
						<% } %>
							<div class = "widget-header">
								<div class = "widget-title-box">
									<span class = "title">채팅 방</span>
								</div>
								<div class = "widget-option-btn">
									<button class = "widget-option-button">
										<span></span>
										<span></span>
										<span></span>
									</button>
									<div class = "widget-option-layer" style="display:none">
										<%if (Ddto.getBoardSize()==0) { %>
										<button class = "widget-size-change">큰 위젯으로 변경</button>
										<% } else { %>
										<button class = "widget-size-change">작은 위젯으로 변경</button>
										<% } %>
									</div>
								</div>
							</div>
							<ul class = "scroll-widget-value">
								<%for(ChatRoomListDto dto : Clist) { %>
								<li class ="chat-item" data-chno = <%=dto.getChatRoomIdx() %>>
									<div class = "chat-suv-area">
										<div class = "chat-member-profile type1">
											<div class = "chat-member-profile-img"
											style="background-image: url('https://flow.team/flowImg/FLOW_202104235852152_d5111f66-1d9c-4806-bdff-bbcde78d0546.png?width=400&height=400'), url('https://flow.team/flowImg/FLOW_202104235852152_d5111f66-1d9c-4806-bdff-bbcde78d0546.png'), url('/flow-renewal/assets/images/profile-default.svg')"></div>
										</div>
										<div class = "widget-chat-content">
											<p><strong class = "widget-chat-title"><%=dto.getChatRoomName() %></strong></p>
											<p class = "text-gray">
												<i class = "img-icon" style="display:none"></i>
												<i class = "file-icon" style="display:none"></i>
												<span>
													<a class = "widget-chat-value"><%=dto.getConversation() %></a>
												</span>
											</p>
										</div>
										<div class = "chat-more-option">
											<div class = "chat-last-time"><%=dto.getAmPm() %> <%=dto.getTime() %></div>
										</div>
									</div>
								</li>
								<% } %>
							</ul>
						</li>
						<%} %>
						<% } %>
					</ul>
					<div class = "add-widget-box"></div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>