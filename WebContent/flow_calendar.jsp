<%@page import="dto.MemberProjectFolderDto"%>
<%@page import="dto.ProjectViewProjecIdxDto"%>
<%@page import="dto.ProjectMemberViewDto"%>
<%@page import="dto.MyProjectViewDto"%>
<%@page import="dto.ChatRoomListDto"%>
<%@page import="dto.MemberDto"%>
<%@page import="dto.dto.ProjectUserFolder"%>
<%@page import="dao.ChattingDao"%>
<%@page import="dao.ProjectALLDao"%>
<%@page import="dto.ProjectMemberListDto"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="dao.ProjectCalendarDao"%>
<%@page import="dto.TaskCalendarDto"%>
<%@page import="dao.ScheduleDao"%>
<%@page import="dto.ScheduleCalendarDto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dto.ProjectColorDto"%>
<%@page import="dao.ProjectDao"%>
<%@page import="dto.OnlyMemberDto"%>
<%@page import="dao.MemberDao"%>
<%
	MemberDao dao = new MemberDao();
	ProjectALLDao pdao = new ProjectALLDao();
	ChattingDao cdao = new ChattingDao();
	int memberIdx = (Integer)request.getAttribute("memberIdx");
	int companyIdx = (Integer)request.getAttribute("companyIdx");
	int readCount = (Integer)request.getAttribute("readCount");
	int colornum = (Integer)request.getAttribute("colornum");
	int projectIdx = (Integer)request.getAttribute("projectIdx");
	int projectColors = (Integer)request.getAttribute("projectColors");
	int projectOutsidermember = (Integer)request.getAttribute("projectOutsidermember");
	int projectNoNadminmember = (Integer)request.getAttribute("projectNoNadminmember");
	int projectadminmember = (Integer)request.getAttribute("projectadminmember");
	String hometab = (String)request.getAttribute("hometab");
	ProjectMemberViewDto PMdto2 = (ProjectMemberViewDto)request.getAttribute("PMdto2");
	ArrayList<ProjectUserFolder> PUFlist = (ArrayList<ProjectUserFolder>)request.getAttribute("PUFlist");
	ArrayList<MemberDto> list = (ArrayList<MemberDto>)request.getAttribute("list");
	ArrayList<ChatRoomListDto> Clist = (ArrayList<ChatRoomListDto>)request.getAttribute("Clist");
	ArrayList<MemberDto> Olist = (ArrayList<MemberDto>)request.getAttribute("Olist");
	ArrayList<MemberDto> CMlist = (ArrayList<MemberDto>)request.getAttribute("CMlist");
	ArrayList<MyProjectViewDto> MPlist = (ArrayList<MyProjectViewDto>)request.getAttribute("MPlist");
	ArrayList<MyProjectViewDto> MPlist2 = (ArrayList<MyProjectViewDto>)request.getAttribute("MPlist");
	ArrayList<MemberDto> Mlist = (ArrayList<MemberDto>)request.getAttribute("Mlist");
	ProjectViewProjecIdxDto pvdto = (ProjectViewProjecIdxDto)request.getAttribute("pvdto");
	ProjectViewProjecIdxDto pdto = (ProjectViewProjecIdxDto)request.getAttribute("pdto");
	char adminMy = ((String)request.getAttribute("adminMy")).charAt(0);
%>
<%-- <%
	int companyIdx = 1;
	int memberIdx = 2;
	int projectIdx = 1;
	
	// 왼쪽 사이드바 필터 상태 받기
	ArrayList<ScheduleCalendarDto> scheduleList = (ArrayList<ScheduleCalendarDto>)request.getAttribute("scheduleList");
	ArrayList<TaskCalendarDto> taskList = (ArrayList<TaskCalendarDto>)request.getAttribute("taskList");
	String scheduleStandard = (String)request.getAttribute("scheduleStandard") == null ? "전체" : (String)request.getAttribute("scheduleStandard");
	String taskStandard = (String)request.getAttribute("taskStandard") == null ? "선택안함" : (String)request.getAttribute("taskStandard");
	String str = (String)request.getAttribute("str") == null ? "" : (String)request.getAttribute("str");
	
	// 받은게 없을 시
	if(scheduleList == null) {
		ScheduleDao sDao = new ScheduleDao();
		scheduleList = sDao.getProjectCalendar(projectIdx, memberIdx, "전체", "");
	}
	if(taskList == null) {
		ProjectCalendarDao tDao = new ProjectCalendarDao();
		taskList = tDao.getTaskCalendarList(projectIdx, memberIdx, "선택안함", "");
	}
	
	// 현재 유저 정보 가져오기
	MemberDao mDao = new MemberDao();
	OnlyMemberDto memberInfo = null;
	try {
		memberInfo = mDao.getMemberInfoAll(memberIdx);
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	
	// 프로젝트 컬러와 이름 가져오기
	ProjectDao pDao = new ProjectDao();
	ArrayList<ProjectColorDto> projectList = new ArrayList<ProjectColorDto>();
	projectList = pDao.getProjectColor(companyIdx, memberIdx);
	
	int writeProjectIdx = projectIdx;
	String projectName = "";
	String projectColor = "";
	for(ProjectColorDto dto : projectList){
		if(projectIdx == dto.getProjectIdx()) {
			projectName = dto.getProjectName();
			projectColor = dto.getColorCode();
		}
	}
	
	ArrayList<ProjectMemberListDto> pmList = new ArrayList<ProjectMemberListDto>();
	pmList = pDao.getProjectMemberList(projectIdx);
%> --%>
<%
	ArrayList<ScheduleCalendarDto> scheduleList = null;
	try {
		scheduleList = (ArrayList<ScheduleCalendarDto>)request.getAttribute("scheduleList");
	} catch(Exception e) {}
	
	ArrayList<TaskCalendarDto> taskList = null;
	try {
		taskList = (ArrayList<TaskCalendarDto>)request.getAttribute("taskList");
	} catch(Exception e) {}
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>플로우 프로젝트 캘린더</title>
	<link rel="stylesheet" href="css/2_Flow_CreateProject.css">
	<link href='http://fonts.googleapis.com/css?family=Roboto:400,300,100,500,700' rel='stylesheet' type='text/css'>
	<link rel="stylesheet" href="css/2_Flow_TopAndLeft_20241126.css"/>
	<link rel="stylesheet" href="css/Flow_calender.css">
	<link rel="stylesheet" href="css/2_Flow_Feed_2024-11-28.css">
	<link rel="stylesheet" href="css/Flow_live_alarm.css">
	<script src="js/jquery-3.7.1.min.js"></script>
	<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js'></script>
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
		// Full Calendar, color.
		/* let COLOR_BG_TEAM_EVENT = 'rgb(11, 199, 118)';
		let COLOR_BD_TEAM_EVENT = 'rgba(11, 199, 118, 0.5)';
		let COLOR_BG_PERSONAL_EVENT = 'rgb(33, 128, 199)';
		let COLOR_BD_PERSONAL_EVENT = 'rgba(33, 128, 199, 0.5)'; */

		/*모든 일정 참석여부 버튼들을 off로 바꾸는 메서드*/
		function allBtnOff(_this){
			_this.parent().find("button").removeClass("on");
			_this.parent().find("button").addClass("off");
			
			_this.parent().find(".off").each(function(idx, item){
				let color = $(item).css('border-color');
				
				$(item).css('background-color', '#ffffff');
				$(item).css('color', color);
			});
		};
		
		/*종일여부 용 전역변수*/
		let _prevStartDate;
		let _prevEndDate;
		
		/*선택된 참석자 수*/
		let managerCount;
		
		
		$(function() {
			/*일정 참석여부 버튼 클릭*/
			$("#attend-btn").click(function() {
				if($(this).hasClass("off")){
					allBtnOff($(this));
					
					$(this).removeClass("off");
					$(this).addClass("on");
					$(this).css('background-color', '#00b19c');
					$(this).css('color', '#ffffff');
				}
			})
			$("#non-attend-btn").click(function() {
				if($(this).hasClass("off")){
					allBtnOff($(this));
					
					$(this).removeClass("off");
					$(this).addClass("on");
					$(this).css('background-color', '#ff6b6b');
					$(this).css('color', '#ffffff');
				}
			})
			$("#TBD-btn").click(function() {
				if($(this).hasClass("off")){
					allBtnOff($(this));
					
					$(this).removeClass("off");
					$(this).addClass("on");
					$(this).css('background-color', '#777777');
					$(this).css('color', '#ffffff');
				}
			})
			
			/*일정추가 클릭*/
			$(".add-btn").click(function() {
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
			});
			/*일정작성창 닫기*/
			$("#close-btn").click(function() {
				$("#release-select").addClass('r1');
				$("#release-select").css('display', 'block');
				$('#release-select-box').css('display','none');
				
				$("#project-select-active-box").css('display', 'none');
				
				$(".schedule-add-background").css('display', 'none');
			});
			/*공개 설정 클릭*/
			$("#release-select").click(function() {
				$("#release-select-box").css('display', 'block');
			});
			/*전체 공개 선택*/
			$("#release-1").click(function() {
				let change = $(this).html();
				$("#release-select").html(change);
				$("#release-select").addClass('r1');
				$("#release-select").removeClass('r2');
				$(this).parent().css('display', 'none');
				$("#release-select").css('display', 'block');
			});
			/*프로젝트 관리자만 선택*/
			$("#release-2").click(function() {
				let change = $(this).html();
				$("#release-select").html(change);
				$("#release-select").addClass('r2');
				$("#release-select").removeClass('r1');
				$(this).parent().css('display', 'none');
				$("#release-select").css('display', 'block');
			});
			/*왼쪽 사이드필터메뉴 창올리기&내리기*/
			$(".side-menu-title").click(function() {
				let now = $(this).parent().find('label');
				let nowDisplay = now.css('display');
				if(nowDisplay == 'inline'){
					$(this).parent().find('label').css('display', 'none');
					$(this).parent().find('br').css('display', 'none');
					$(this).find("#arrow-top").attr('src', 'images/arrow-down.png');
				}else{
					$(this).parent().find('label').css('display', 'inline');
					$(this).parent().find('br').css('display', 'inline');
					$(this).find("#arrow-top").attr('src', 'images/arrow-top.png');
				}
			});
			
			/*캘린더 사이드바에서 전환하기*/
			$(".side-hide-btn-box").click(function() {
				$(".left-side-calender").css('display', 'none');
				$("#leftside").css('display', 'block');
			});
			
			/*메인 사이드바에서 전환하기*/
			$(".show-calender-side-btn").click(function() {
				$(".left-side-calender").css('display', 'block');
				$("#leftside").css('display', 'none');
			});
			
			/*왼쪽 일정 사이드바에서 필터 검색하기*/
			$("input[type=radio][name=schedule-filter]").on('change', function() {
				$('#calendarFilterForm').submit();
			})
			$("input[type=radio][name=task-filter]").on('change', function() {
				$('#calendarFilterForm').submit();
			})
			/*일정 검색창 찍은후 엔터눌렀을 때!*/
			$(document).ready(function() {
				$('input[type="text"][name="schedule_name"]').on('keydown', function(event) {
					if (event.key == 'Enter') {
						$('#calendarFilterForm').submit();
					}
				})
			})
			/*일정작성 창에서 파일 선택창 띄우기&닫기*/
			$("#file-clip-icon").click(function() {
				let nowDisplay = $(".file-select-box").css('display');
				if(nowDisplay == 'none'){
					$(".file-select-box").css('display', 'block');
				}else{
					$(".file-select-box").css('display', 'none');
				}
			});
			
			/*작성할 일정의 프로젝트를 선택하는 창 띄우기*/
			$(".project-select-box").click(function() {
				$("#project-select-active-box").css('display', 'block');
			});
			/*작성할 일정의 프로젝트 선택하기*/
			$(".item-project").click(function() {
				let selectProjectIdx = $(this).data("idx");
				let bgColor = $(this).find("div").css('background-color');
				let projectName = $(this).find("p").text();
				
				$(".project-select-box").find("div").css('background', bgColor);
				$(".project-select-box").find("p").text(projectName);
				$(".project-select-box").find("p").data("idx", selectProjectIdx);
				$(this).parent().css('display', 'none');
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
			/*일정작성창 등록버튼 클릭 (일정작성 메서드)*/
			$("#add-schedule-submit").click(function() {
				let title = $("#title-input").val();
				if(title == ""){
					alert("제목을 입력하세요.");
					return;
				}
				let projectIdx = $("#writeProjectName").data("idx");
				let startDate = $("#startDateInput").val();
				let endDate = $("#endDateInput").val();
				let allDayYN = $("#all-day-check").prop('checked') == true ? 'Y' : 'N';
				let content = $(".textarea").text();
				let locationStr = $("#loaction-input").val();
				let alarmType = $(".alarm-select").val();
				let releaseYn = $("#release-select").text() == '전체 공개' ? 'Y' : 'N';
				let memberIdxArray = [];
				$(".member-item-box").each(function(idx, element) {
					memberIdxArray[idx] = $(this).data("idx");
				})
				$.ajax({
					type: 'post',
					url: 'scheduleWriteRecordAjaxServlet',
					data: {
						"projectIdx":projectIdx,
						"writerIdx":${memberIdx},
						"title":title,
						"startDate":startDate,
						"endDate":endDate,
						"allDayYN":allDayYN,
						"memberIdxArray":memberIdxArray.join(),
						"content":content,
						"location":locationStr,
						"alarmType":alarmType,
						"releaseYn":releaseYn
					},
					success: function() {
						alert("등록되었습니다.");
						webSocketAlarm.send("NewAlarm");
						location.reload();
					},
					error: function() {
						console.log(r.status);
						console.log(r.responseText);
						console.log(e);
					}
				})
			})
			
			/*일정창 닫기*/
			$("#select-schedule-show-close-btn, #header, #leftside, .left-side-calender, .mainheader, .mainbody, .content-wrap").click(function() {
				$("#select-schedule-show-box").css('display', 'none');
			})
			$(document).ready(function() {
				/*참석자 지우기*/
				$(document).on("click", ".participantRemoveBtn", function() {
					$(this).parent().remove();
				})
				/*종일여부 체크 시 시간 사라지게 하기*/
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
				})
				/*커서 탈출 시 참석자 지정창 닫히기*/
				$(document).on('click', function() {
					if(!$(event.target).closest('#participantSelectTable').length && !$(event.target).closest("#member-add-input").length) {
						$("#participantSelectTable").css('display', 'none');
					}
				})
			})
			/*참석자 추가 입력창 클릭*/
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
					let newTr = '<div class="member-item-box" data-idx="'+memberIdx+'">' +
									'<img class="user-prof" src="'+profImgUrl+'"/>' +
									'<span>'+memberName+'</span>' +
									'<button type="button" class="participantRemoveBtn"></button>' +
								'</div>';
					
					$("#memberItemsWrap").append(newTr);
				}
				$("#participantSelectTable").css('display', 'none');
			})
			/*날짜의 요일구하기*/
			function getDayOfWeek(dateString) {
			    // 문자열을 Date 객체로 변환
			    let date = new Date(dateString);
			
			    // 요일 이름 배열
			    let dayNames = ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'];
			
			    // 요일 인덱스 가져오기
			    let dayIndex = date.getDay();
			
			    // 요일 이름 반환
			    return dayNames[dayIndex];
			}
			// 참석버튼 초기화 메서드
			function btnReset() {
				$("#attend-btn").addClass('off');
				$("#attend-btn").removeClass('on');
				$("#attend-btn").css('color', '#00b19c');
				$("#attend-btn").css('background-color', '#FFF');
				
				$("#non-attend-btn").addClass('off');
				$("#non-attend-btn").removeClass('on');
				$("#non-attend-btn").css('color', '#ff6b6b');
				$("#non-attend-btn").css('background-color', '#FFF');
				
				$("#TBD-btn").addClass('off');
				$("#TBD-btn").removeClass('on');
				$("#TBD-btn").css('color', '#777');
				$("#TBD-btn").css('background-color', '#FFF');
			}
			/*일정 item클릭 시 오른쪽사이드에 일정 정보 띄우기*/
			function scheduleShowInfo(_thisIdx) {
				$.ajax({
					type: 'post',
					url: 'scheduleShowInfoAjaxServlet',
					data: {
						"boardIdx":_thisIdx,
						"memberIdx":${memberIdx}
					},
					success: function(data) {
						console.log(data);
						if(data.boardInfo.attend == "") { $("#vote-box").css('display', 'none'); }
						$("#select-schedule-show-box").data("idx", data.boardInfo.scheduleIdx);
						$("#select-schedule-show-box").data("scheduleIdx", _thisIdx);
						$("#select-schedule-prj-name").text("${projectName}");
						$("#writerNameSpan").text(data.boardInfo.writerName);
						$("#writeDateSpan").text(data.boardInfo.writeDate.substring(0, 16));
						if(data.boardInfo.releaseYN == 'Y') {
							$("#all-relese-icon").attr('src', 'images/all-release-icon.png');
						}else {
							$("#all-relese-icon").attr('src', 'images/admin-release-icon.png');
						}
						$("#schedule-date-icon").find('div:nth-child(1)').text(data.boardInfo.startDate.substring(0, 7));
						$("#schedule-date-icon").find('div:nth-child(2)').text(data.boardInfo.startDate.substring(8, 10));
						$("#schedule-title").text(data.boardInfo.title);
						let startDateWeek = getDayOfWeek(data.boardInfo.startDate);
						let startTime = data.boardInfo.startDate.substring(11, 16);
						let endTime = data.boardInfo.endDate.substring(11, 16);
						if(data.boardInfo.allDayYN == 'Y') {
							$("#schedule-date").html(data.boardInfo.startDate.substring(0, 10)+" ("+startDateWeek.charAt(0)+"), 종일");
						}else {
							$("#schedule-date").html(data.boardInfo.startDate.substring(0, 10)+" ("+startDateWeek.charAt(0)+"), <span>"+startTime+"</span> - <span>"+endTime+"</span>");
						}
						$(".participant-prof").remove();
						btnReset();
						let attend_cnt = 0;
						let non_attend_cnt = 0;
						let TBC_cnt = 0;
						for(let i=0; i<=data.attenders.length-1; i++) {
							let color = data.attenders[i].attendWhether == '참석' ? '#00b695' : (data.attenders[i].attendWhether == '불참' ? '#fb2a2a' : '#999999');
							data.attenders[i].attendWhether == '참석' ? attend_cnt++ : (data.attenders[i].attendWhether == '불참' ? non_attend_cnt++ : (data.attenders[i].attendWhether == '미정' ? TBC_cnt++ : TBC_cnt));
							// 참석자가 현재 접속자일때 화면 표시
							if(data.attenders[i].memberIdx == ${memberIdx}) {
								if(data.attenders[i].attendWhether == null) {
									let newTr = '<div class="participant-prof" data-idx="'+data.attenders[i].memberIdx+'" style="background : url('+data.attenders[i].profImg+') no-repeat center center; background-size: cover;"><div style="display: none;"></div></div>';
									$("#participantBox").append(newTr);
									
									$("#vote-box").find("button").each(function() {
										$(this).removeClass("on");
										$(this).addClass("off");
									});
									
									$("#attend-btn").css('background-color', '#FFF');
									$("#attend-btn").css('color', '#00b695');
									
									$("#non-attend-btn").css('background-color', '#FFF');
									$("#non-attend-btn").css('color', '#fb2a2a');
									
									$("#TBD-btn").css('background-color', '#FFF');
									$("#TBD-btn").css('color', '#999999');
									continue;
								}
								let fontColor;
								if(data.attenders[i].attendWhether == '참석') {
									$("#attend-btn").removeClass("off");
									$("#attend-btn").addClass("on");
									
									fontColor = $("#attend-btn").css('border-color');
									$("#attend-btn").css('background-color', fontColor);
									$("#attend-btn").css('color', '#FFF');
								}else if(data.attenders[i].attendWhether == '불참') {
									$("#non-attend-btn").removeClass("off");
									$("#non-attend-btn").addClass("on");
									
									fontColor = $("#non-attend-btn").css('border-color');
									$("#non-attend-btn").css('background-color', fontColor);
									$("#non-attend-btn").css('color', '#FFF');
								}else if(data.attenders[i].attendWhether == '미정') {
									$("#TBD-btn").removeClass("off");
									$("#TBD-btn").addClass("on");
									
									fontColor = $("#TBD-btn").css('border-color');
									$("#TBD-btn").css('background-color', fontColor);
									$("#TBD-btn").css('color', '#FFF');
								}
							}
							if(data.attenders[i].attendWhether == null) {
								let newTr = '<div class="participant-prof" data-idx="'+data.attenders[i].memberIdx+'" style="background : url('+data.attenders[i].profImg+') no-repeat center center; background-size: cover;"></div>';
								$("#participantBox").append(newTr);
							}else {
								let newTr = '<div class="participant-prof" data-idx="'+data.attenders[i].memberIdx+'" style="background : url('+data.attenders[i].profImg+') no-repeat center center; background-size: cover;"><div style="background-color: '+color+';"></div></div>';
								$("#participantBox").append(newTr);
							}
						}
						$("#attend-cnt").text(attend_cnt);
						$("#non-attend-cnt").text(non_attend_cnt);
						$("#TBC-cnt").text(TBC_cnt);
						$("#schedult-content-text").text(data.boardInfo.content);
						
						$("#select-schedule-show-box").css('display', 'block');
					},
					error: function(r, s, e) {
						console.log(r.status);
						console.log(r.responseText);
						console.log(e);
					}
				})
			}
			/*참석여부 버튼 클릭 시*/
			$(".off").click(function() {
				let str = $(this).text();
				let scheduleIdx = $("#select-schedule-show-box").data("idx");
				$.ajax({
					type: 'post',
					url: 'SchesuleAttendSelectAjaxServlet',
					data: {
						"memberIdx":${memberIdx},
						"str":str,
						"scheduleIdx":scheduleIdx
					},
					success: function(data) {
						console.log(data);
						let attendCnt = 0;
						let nonAttendCnt = 0;
						let TBCCnt = 0;
						$("#attend-cnt").text(attendCnt);
						$("#non-attend-cnt").text(nonAttendCnt);
						$("#TBC-cnt").text(TBCCnt);
						$(".participant-prof").each(function() {
							if($(this).data("idx") == ${memberIdx}) {
								$(this).find('div').css('display', 'block');
							}
							for(let i=0; i<=data.length-1; i++) {
								if($(this).data("idx") == data[i].memberIdx) {
									if(data[i].attendWhether == '참석') {
										$(this).find('div').css('background-color', '#00b695');
										attendCnt++;
									}else if(data[i].attendWhether == '불참') {
										$(this).find('div').css('background-color', '#ff6b6b');
										nonAttendCnt++;
									}else if(data[i].attendWhether == '미정') {
										$(this).find('div').css('background-color', '#999999');
										TBCCnt++;
									}
								}
							}
						})
						$("#attend-cnt").text(attendCnt);
						$("#non-attend-cnt").text(nonAttendCnt);
						$("#TBC-cnt").text(TBCCnt);
					},
					error: function(r, s, e) {
						console.log(r.status);
						console.log(r.responseText);
						console.log(e);
					}
				})
			})
			
			/*오른쪽 사이드 일정창에서 참석자 변경 클릭*/
			$("#change-participant-btn").click(function() {
				let scheduleIdx = $("#select-schedule-show-box").data("idx");
				$(".task-manager-name").remove();
				$.ajax({
					type: 'post',
					url: 'GetScheduleAttendeesAjaxServlet',
					data: {
						"scheduleIdx":scheduleIdx,
						"projectIdx":${projectIdx}
					},
					success: function(data) {
						console.log(data);
						$(".board-manager-item").remove();
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
						}
						managerCount = $('.board-manager-item.active').length;
						$('.board-manager-item').each(function(){
							if($(this).hasClass('active')) {
								$('.board-manager-selected-count').text(managerCount+"건 선택");
								
						        if(managerCount > 0) {
						        	$('.managerListNull').css('display','none');
						        	$('.board-manager-selected-num').css('display','block');
						        	$('.inviteManagerList').css('display','block');
						        }
								let memberIdx = $(this).data("mno");
								let name = $(this).find('.author-name').text();
								let ManagerList = " <li class = \"task-manager-name\" data-mno="+memberIdx+">" +
											        " <span class = \"task-manager-img\" id = \"task-manager-img2\"></span>" +
											        " <span class = \"task-manager-value\">"+name+"</span>" +
											        " <button class = \"manager-remove-btn\"></button> " +
												" </li> ";
						        $('.inviteManagerList').prepend(ManagerList);
							}
						});
					},
					error: function(r, s, e) {
						console.log(r.status);
						console.log(r.responseText);
						console.log(e);
					}
				})
				
				$(".mainPop").css('display', 'block');
				$(".manager-add-section").css('display', 'block');
			})
			/*참석자 선택하기*/
			$(document).on('click', '.board-manager-item', function() {
				let memberIdx = $(this).data("mno");
				let name = $(this).find('.author-name').text();
			    if (!$(this).hasClass('active')) {
			        $(this).addClass('active');
			        managerCount++;
			       	$('.board-manager-selected-count').text(managerCount+"건 선택");
			        if(managerCount > 0) {
			        	$('.managerListNull').css('display','none');
			        	$('.board-manager-selected-num').css('display','block');
			        	$('.inviteManagerList').css('display','block');
			        }
			        let ManagerList = " <li class = \"task-manager-name\" data-mno="+memberIdx+">" +
			        " <span class = \"task-manager-img\" id = \"task-manager-img2\"></span>" +
			        " <span class = \"task-manager-value\">"+name+"</span>" +
			        " <button class = \"manager-remove-btn\"></button> " +
					" </li> ";
			        $('.inviteManagerList').prepend(ManagerList);
			    } else {
			        $(this).removeClass('active');
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
			//참석자 지정 해제
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
				 
				 $('.board-manager-selected-count').text(managerCount+"건 선택");
				 if(managerCount == 0) {
			        	$('.managerListNull').css('display','block');
			        	$('.board-manager-selected-num').css('display','none');
			        	$('.inviteManagerList').css('display','none');
			     }
			});
			//참석자 전체 해제
			$('.board-manager-selected-all-delete').click(function(){
		        $('.task-manager-name').remove();
		        $('.board-manager-item').removeClass('active');
		        managerCount = 0;
		        $('.managerListNull').css('display','block');
	        	$('.board-manager-selected-num').css('display','none');
	        	$('.inviteManagerList').css('display','none');
			});
			/*오른쪽 사이드 일정창에서 취소/닫기 버튼 클릭*/
			$(".managerReturnMainbtn").click(function() {
				$(".managerSearchBox").val("");
				$(".mainPop").css('display', 'none');
				$(".manager-add-section").css('display', 'none');
			})
			$(".manager-add-close").click(function() {
				$(".managerSearchBox").val("");
				$(".mainPop").css('display', 'none');
				$(".manager-add-section").css('display', 'none');
			})
			/*일정 게시물의 참석자 변경창에서 확인 버튼 클릭*/
			$(".managerSubmitbtn").click(function() {
				let scheduleIdx = $("#select-schedule-show-box").data("idx");
				let attender = [];
				let attendWhether = [];
				
				let attend_cnt = 0;
				let non_attend_cnt = 0;
				let TBC_cnt = 0;
				
				// 우선 모든 참석자 해제
				$.ajax({
					type: 'post',
					url: 'DelScheduleAttenderAjaxServlet',
					data: { "scheduleIdx":scheduleIdx },
					success: function(data) {
						console.log(data);
						$(".participant-prof").remove();
						for(let i=0; i<=data.length-1; i++) {
							attender.push(data[i].memberIdx);
							attendWhether.push(data[i].attendWhether);
						}
						// 그 다음 등록된 참석자 추가
						$(".board-manager-area").find(".active").each(function() {
							let mno;
							let mAttendWhether;
							let yn;
							for(let i=0; i<=attender.length-1; i++) {
								if($(this).data("mno") == attender[i]) {
									yn = true;
									mAttendWhether = attendWhether[i];
									break;
								}else {
									yn = false;
								}
							}
							if(yn) {
								mno = $(this).data("mno");
							}else {
								mno = $(this).data("mno");
								mAttendWhether = null;
							}
							$.ajax({
								type: 'post',
								url: 'addScheduleAttenderAjaxServlet',
								data: {
									"memberIdx":mno,
									"attendWhether":mAttendWhether,
									"scheduleIdx":scheduleIdx
								},
								success: function(data) {
									let color = data.whether == '참석' ? '#00b695' : (data.whether == '불참' ? '#fb2a2a' : (data.whether == '미정' ? '#999999' : null));
									if(data.whether == '참석') {
										attend_cnt++;
									}else if(data.whether == '불참') {
										non_attend_cnt++;
									}else if(data.whether == '미정') {
										TBC_cnt++;
									}
									if(data.memberIdx == ${memberIdx}) {
										let fontColor;
										if(data.whether == '참석') {
											$("#attend-btn").removeClass("off");
											$("#attend-btn").addClass("on");
											
											fontColor = $("#attend-btn").css('border-color');
											$("#attend-btn").css('background-color', fontColor);
											$("#attend-btn").css('color', '#FFF');
										}else if(data.whether == '불참') {
											$("#non-attend-btn").removeClass("off");
											$("#non-attend-btn").addClass("on");
											
											fontColor = $("#non-attend-btn").css('border-color');
											$("#non-attend-btn").css('background-color', fontColor);
											$("#non-attend-btn").css('color', '#FFF');
										}else if(data.whether == '미정') {
											$("#TBD-btn").removeClass("off");
											$("#TBD-btn").addClass("on");
											
											fontColor = $("#TBD-btn").css('border-color');
											$("#TBD-btn").css('background-color', fontColor);
											$("#TBD-btn").css('color', '#FFF');
										}
									}
									if(color == null) {
										let newTr = '<div class="participant-prof" data-idx="'+data.memberIdx+'" style="background : url('+data.prof+') no-repeat center center; background-size: cover;"></div>';
										$("#participantBox").append(newTr);
									}else {
										let newTr = '<div class="participant-prof" data-idx="'+data.memberIdx+'" style="background : url('+data.prof+') no-repeat center center; background-size: cover;"><div style="background-color: '+color+';"></div></div>';
										$("#participantBox").append(newTr);
									}
									$("#attend-cnt").text(attend_cnt);
									$("#non-attend-cnt").text(non_attend_cnt);
									$("#TBC-cnt").text(TBC_cnt);
								},
								error: function(r, s, e) {
									console.log(r.status);
									console.log(r.responseText);
									console.log(e);
								}
							})
						})
					},
					error: function(r, s, e) {
						console.log(r.status);
						console.log(r.responseText);
						console.log(e);
					}
				})
				alert("참석자가 변경되었습니다.");
				
				$(".mainPop").css('display', 'none');
				$(".manager-add-section").css('display', 'none');
			})
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
			let calElement = document.getElementById("content-wrap");
			let calendar = new FullCalendar.Calendar(calElement, {
				initialView: 'dayGridMonth',
				headerToolbar: {
					start: 'today prev,next',
					center: 'title',
					end: 'dayGridDay,dayGridWeek,dayGridMonth'
				},
				datesSet: function(info) {
					console.log(info);
					let d = info.startStr.substring(0,10);
					//alert(d);
				},
				editable: true,
				displayEventTime: false,
				events: [
					<%
					for(ScheduleCalendarDto dto : scheduleList) {
						String startDate = "";
						String endDate = "";
						String title = dto.getTitle();
						if(dto.getAllDayYN() == 'Y') {
							startDate = dto.getStartDate().substring(0, 10);
							endDate = dto.getEndDate().substring(0, 10);
						}else {
							startDate = dto.getStartDate().substring(0, 10) + "T" + dto.getStartDate().substring(11, dto.getStartDate().length());
							endDate = dto.getEndDate().substring(0, 10) + "T" + dto.getEndDate().substring(11, dto.getEndDate().length());
							if(Integer.parseInt(startDate.substring(11, 13)) >= 12) {
								title = "오전 " + startDate.substring(11, 16) + " " + dto.getTitle();
							}else {
								title = "오후 " + startDate.substring(11, 16) + " " + dto.getTitle();
							}
						}
					%>
						{
							id: '<%=dto.getBoardIdx() %>',
							title: '<%=title %>',
							start: '<%=startDate %>',
							end: '<%=endDate %>'
						},
					<%}%>
					<%
					for(TaskCalendarDto dto : taskList) {
						if(dto.getStartDate() == null && dto.getEndDate() == null) break;
						String startDate = "";
						String endDate = "";
						if(dto.getStartDate() == null) {
							startDate = dto.getEndDate().replace(" ", "T");
							endDate = dto.getEndDate().replace(" ", "T");
						}
						if(dto.getEndDate() == null) {
							startDate = dto.getStartDate().replace(" ", "T");
							endDate = dto.getStartDate().replace(" ", "T");
						}
						if(dto.getStartDate() != null && dto.getEndDate() != null) {
							startDate = dto.getStartDate().replace(" ", "T");
							endDate = dto.getEndDate().replace(" ", "T");
						}
						if(startDate.endsWith("00:00:00")) startDate = startDate.substring(0, 10);
						if(endDate.endsWith("00:00:00")) endDate = endDate.substring(0, 10);
					%>
						{
							id: '<%=dto.getTaskIdx() %>',
							title: '[<%=dto.getState() + "] " + dto.getTitle() %>',
							start: '<%=startDate %>',
							end: '<%=endDate %>'
						},
					<%}%>
				],
				eventClick: function(info) {
					scheduleShowInfo(info.event.id);
				}
			});
			calendar.render();
		});
	</script>
	<script>
		$(function() {
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
			let url = "";
			let inviteCount = 0;
			let label = [];
			let labeldel= [];
			$('.feedcontent').click(function(){
				 url = 'Controller?command=FEED';
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
	    		$('.template-sample-img').removeClass('calander');
	    		$('.template-sample-img').removeClass('task');
	    		$('.template-sample-img').removeClass('file');
	    		$('.template-sample-img').addClass('feed');
            });
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
		})
	</script>
	<style>
		#feedoption:after {
		display: none!important;
	    content: "";
	    position: absolute;
	    left: 0;
	    right: 0;
	    bottom: -1px;
		width : 100%;
		height : 4px;
		border : 1px solid;
		border-radius:10px;
		background : #333; 
		
	}
	#calenderoption:after {
		display: block!important;
	    content: "";
	    position: absolute;
	    left: 0;
	    right: 0;
	    bottom: 2px;
		width : 100%;
		height : 4px;
		border : 1px solid;
		border-radius:10px;
		background : #333; 
		
	}
	.calendercontent {
		color: #333333!important;
	}
	.feedcontent {
	    color: #999999!important;
	}
	</style>
</head>
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
			<div class = "manager-add-section">
				<div class = "manager-add-section-header">
					<span class = "manager-add-header-text">참석자 변경</span>
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
<!-- calrendarFilterServlet -->
<form action="Controller" method="post" id="calendarFilterForm">
	<input type="hidden" name="command" value="project_calendar"/>
	<input type="hidden" name="projectIdx" value="${projectIdx }"/>
	<input type="hidden" name="memberIdx" value="${memberIdx }"/>
	<input type="hidden" name="companyIdx" value="${companyIdx }"/>
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
	<div class="schedule-add-background" style="display: none;">
		<div class="schedule-add-write">
			<div class="post-header">
				<div>
					<h4>일정 작성</h4>
					<div class="project-select-box">
						<img id="down-arrow" src="https://team-0aaj7b.flow.team/flow-renewal/assets/images/icons/icon-arrow-dwn-55.svg?v=76eb009fb1fd68505f742c334179f6dc752f8f29"/>
						<div class="project-icon" style="background-color: ${projectColor} !important"></div>
						<p id="writeProjectName" data-idx="${writeProjectIdx }">${projectName }</p>
					</div>
					<div id="project-select-active-box" style="display: none;">
						<div class="project-search-input">
							<img src="https://team-0aaj7b.flow.team/flow-renewal/assets/images/icon-search.svg?v=304211365c59dd79e7b701ae194c7b293eab732c"/>
							<input type="text" placeholder="프로젝트명으로 검색하세요."/>
						</div>
						<c:forEach var="dto" items="${projectList }">
							<div class="item-project" data-idx="${dto.projectIdx }">
								<div style="background-color: '${dto.colorCode}'+' !important' %>;"></div>
								<p>${dto.projectName }</p>
							</div>
						</c:forEach>
					</div>
				</div>
				<div>
					<button type="button" id="hide-btn"></button>
					<button type="button" id="close-btn"></button>
				</div>
			</div>
			<div>
				<input type="text" id="title-input" placeholder="제목을 입력하세요."/>
			</div>
			<div class="schedule-add-content-box">
				<div class="content-date-select">
					<img id="date-select-icon" src="images/date-select-icon.png"/>
					<input type="text" id="startDateInput" class="date-select-input datetimepicker" value=""/>
					<div></div>
					<input type="text" id="endDateInput" class="date-select-input datetimepicker" value=""/>
					<label for="all-day-check"><input type="checkbox" id="all-day-check"/>종일</label>
				</div>
				<div class="content-member-select">
					<img id="member-select-icon" src="images/member-select-icon.png"/>
					<div id="memberItemsWrap">
						<div class="member-item-box" data-idx="${memberIdx }">
							<img class="user-prof" src="${memberInfo.profileImg }"/>
							<span>${memberInfo.name }</span>
							<button type="button" class="participantRemoveBtn"></button>
						</div>
					</div>
					<div id="participantSelectBox">
						<input type="text" id="member-add-input" placeholder="참석자 추가"/>
						<table id="participantSelectTable" style="display: none;">
							<tr>
							<c:forEach var="dto" items="${pmList }">
								<td class="selectMemberItem" data-idx="${dto.memberIdx }">
									<img src="${dto.prof }" class="participantProfileImg"/>
									<div class="participantInfoWrap">
										<div class="participantNameAndPositiondiv"><span class="participantName">${dto.memberName }</span><span class="participantPosition">${dto.position }<span></div>
										<div class="participantSelectCompanyName">${dto.companyName }</div>
									</div>
								</td>
							</c:forEach>
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
					<div class="textarea" placeholder="내용을 입력하세요." contenteditable="true"></div>
				</div>
			</div>
			<div class="post-footer">
				<div>
					<img id="file-clip-icon" src="images/file-clip-icon.png"/>
				</div>
				<div class="file-select-box" style="display: none;">
					<div id="file-menu1">내 컴퓨터</div>
					<div id="file-menu2">파일함</div>
				</div>
				<div style="position: relative;">
					<div id="release-select" class="r1">전체 공개</div>
					<div id="release-select-box" style="display: none;">
						<div id="release-1" class="r1">전체 공개</div>
						<div id="release-2" class="r2">프로젝트 관리자만</div>
					</div>
					<button type="button" id="temporary-record">임시저장</button>
					<button type="button" id="add-schedule-submit">등록</button>
				</div>
			</div>
		</div>
	</div>
	<div id="leftside" class="fl" style="display: none;">
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
		<div class="show-calender-side-btn">
			<div><img src="images/show-calender-side1.png"/></div>
			<div><img src="images/show-calender-side2.png"/></div>
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
	<div class="left-side-calender">
		<div class="logo-box">
			<c:choose>
				<c:when test="${companyLogo != null }">
					<div class = "home_btn"><span><img src="upload/${companyLogo}" style = "margin: 0 auto;"/></span></div>	<!-- 로고div -->
				</c:when>
				<c:otherwise>
					<div class = "home_btn"><span><img src="https://flow.team/flow-renewal/assets/images/logo/logo-flow.svg"/></span></div>	<!-- 로고div -->
				</c:otherwise>
			</c:choose>
		</div>
		<div class="side-hide-btn-box">
			<div><img src="https://flow.team/flow-renewal/assets/images/icons/sb-push-w.svg?v=3810c550de5300472fc6e1dd1abdbfc8620f2725"/></div>
			<div><img src="https://flow.team/flow-renewal/assets/images/icons/sb-close-w.svg?v=02a56797e954cdb575267acdf95e453a5e1697d7"/></div>
		</div>
		<div class="side-content-box">
			<div class="side-menu-box">
				<c:choose>
					<c:when test="${scheduleStandard == '전체' }">
						<div class="side-menu-title"><div>일정</div><div><img id="arrow-top" src="images/arrow-top.png"/></div></div>
						<label><input type="radio" name="schedule-filter" value="전체" checked/><span>전체</span></label><br/>
						<label><input type="radio" name="schedule-filter" value="내 일정"/><span>내 일정</span></label><br/>
						<label><input type="radio" name="schedule-filter" value="등록한 일정"/><span>등록한 일정</span></label><br/>
						<label><input type="radio" name="schedule-filter" value="선택안함"/><span>선택안함</span></label>
					</c:when>
					<c:when test="${scheduleStandard == '내 일정' }">
						<div class="side-menu-title"><div>일정</div><div><img id="arrow-top" src="images/arrow-top.png"/></div></div>
						<label><input type="radio" name="schedule-filter" value="전체"/><span>전체</span></label><br/>
						<label><input type="radio" name="schedule-filter" value="내 일정" checked/><span>내 일정</span></label><br/>
						<label><input type="radio" name="schedule-filter" value="등록한 일정"/><span>등록한 일정</span></label><br/>
						<label><input type="radio" name="schedule-filter" value="선택안함"/><span>선택안함</span></label>
					</c:when>
					<c:when test="${scheduleStandard == '등록한 일정' }">
						<div class="side-menu-title"><div>일정</div><div><img id="arrow-top" src="images/arrow-top.png"/></div></div>
						<label><input type="radio" name="schedule-filter" value="전체"/><span>전체</span></label><br/>
						<label><input type="radio" name="schedule-filter" value="내 일정"/><span>내 일정</span></label><br/>
						<label><input type="radio" name="schedule-filter" value="등록한 일정" checked/><span>등록한 일정</span></label><br/>
						<label><input type="radio" name="schedule-filter" value="선택안함"/><span>선택안함</span></label>
					</c:when>
					<c:when test="${scheduleStandard == '선택안함' }">
						<div class="side-menu-title"><div>일정</div><div><img id="arrow-top" src="images/arrow-top.png"/></div></div>
						<label><input type="radio" name="schedule-filter" value="전체"/><span>전체</span></label><br/>
						<label><input type="radio" name="schedule-filter" value="내 일정"/><span>내 일정</span></label><br/>
						<label><input type="radio" name="schedule-filter" value="등록한 일정"/><span>등록한 일정</span></label><br/>
						<label><input type="radio" name="schedule-filter" value="선택안함" checked/><span>선택안함</span></label>
					</c:when>
				</c:choose>
			</div>
			<div class="side-menu-box">
				<c:choose>
					<c:when test="${taskStandard == '전체' }">
						<div class="side-menu-title"><div>업무</div><div><img id="arrow-top" src="images/arrow-top.png"/></div></div>
						<label><input type="radio" name="task-filter" value="전체" checked/><span>전체</span></label><br/>
						<label><input type="radio" name="task-filter" value="내 업무"/><span>내 업무</span></label><br/>
						<label><input type="radio" name="task-filter" value="요청한 업무"/><span>요청한 업무</span></label><br/>
						<label><input type="radio" name="task-filter" value="선택안함"/><span>선택안함</span></label>
					</c:when>
					<c:when test="${taskStandard == '내 업무' }">
						<div class="side-menu-title"><div>업무</div><div><img id="arrow-top" src="images/arrow-top.png"/></div></div>
						<label><input type="radio" name="task-filter" value="전체" checked/><span>전체</span></label><br/>
						<label><input type="radio" name="task-filter" value="내 업무"/><span>내 업무</span></label><br/>
						<label><input type="radio" name="task-filter" value="요청한 업무"/><span>요청한 업무</span></label><br/>
						<label><input type="radio" name="task-filter" value="선택안함"/><span>선택안함</span></label>
					</c:when>
					<c:when test="${taskStandard == '요청한 업무' }">
						<div class="side-menu-title"><div>업무</div><div><img id="arrow-top" src="images/arrow-top.png"/></div></div>
						<label><input type="radio" name="task-filter" value="전체"/><span>전체</span></label><br/>
						<label><input type="radio" name="task-filter" value="내 업무"/><span>내 업무</span></label><br/>
						<label><input type="radio" name="task-filter" value="요청한 업무" checked/><span>요청한 업무</span></label><br/>
						<label><input type="radio" name="task-filter" value="선택안함"/><span>선택안함</span></label>
					</c:when>
					<c:when test="${taskStandard == '선택안함' }">
						<div class="side-menu-title"><div>업무</div><div><img id="arrow-top" src="images/arrow-top.png"/></div></div>
						<label><input type="radio" name="task-filter" value="전체"/><span>전체</span></label><br/>
						<label><input type="radio" name="task-filter" value="내 업무"/><span>내 업무</span></label><br/>
						<label><input type="radio" name="task-filter" value="요청한 업무"/><span>요청한 업무</span></label><br/>
						<label><input type="radio" name="task-filter" value="선택안함" checked/><span>선택안함</span></label>
					</c:when>
				</c:choose>
			</div>
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
								<i class = "color-boxs color-code-<%=projectColors%>">
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
										<button type="button" class = "set-btn">
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
				<button type="button" class = "private">
					<div class = "privateicon"></div>
					<div class = "privatename">초대하기</div>
				</button>
			</div>
			<div class ="mainbody">
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
				</div>
			</div>
			<div class="content-wrap">
				<div class="search-calender-box">
					<div class="search-left-box">
						<img src="images/search-btn.png" class="search-img"/>
						<input type="text" name="schedule_name" value="${str }" class="input-schedule" placeholder="일정명을 입력 해주세요."/>
					</div>
					<div class="add-btn">+ 일정 추가</div>
				</div>
				<div id="content-wrap"></div>
				<!--
				<table id="calendarTable">
					<tr>
						<th class="sun-th">일</th>
						<th>월</th>
						<th>화</th>
						<th>수</th>
						<th>목</th>
						<th>금</th>
						<th class="sat-th">토</th>
					</tr>
					<tr>
						<td class="sun-td"><div>1</div><div></div></td>
						<td><div>2</div><div></div></td>
						<td><div>3</div><div>[일정] 플로우 기능 영상 시청하기 👀</div></td>
						<td><div>4</div><div></div></td>
						<td><div>5</div><div></div></td>
						<td><div>6</div><div></div></td>
						<td class="sat-td"><div>7</div><div></div></td>
					</tr>
					<tr>
						<td class="sun-td"><div>8</div><div></div></td>
						<td><div>9</div><div></div></td>
						<td><div>10</div><div></div></td>
						<td><div>11</div><div></div></td>
						<td><div>12</div><div></div></td>
						<td><div>13</div><div></div></td>
						<td class="sat-td"><div>14</div><div></div></td>
					</tr>
					<tr>
						<td class="sun-td"><div>15</div><div></div></td>
						<td><div>16</div><div></div></td>
						<td><div>17</div><div></div></td>
						<td><div>18</div><div></div></td>
						<td><div>19</div><div></div></td>
						<td><div>20</div><div></div></td>
						<td class="sat-td"><div>21</div><div></div></td>
					</tr>
					<tr>
						<td class="sun-td"><div>22</div><div></div></td>
						<td><div>23</div><div></div></td>
						<td><div>24</div><div></div></td>
						<td><div>25</div><div></div></td>
						<td><div>26</div><div></div></td>
						<td><div>27</div><div></div></td>
						<td class="sat-td"><div>28</div><div></div></td>
					</tr>
					<tr>
						<td class="sun-td"><div>29</div><div></div></td>
						<td><div>30</div><div></div></td>
						<td><div>31</div><div></div></td>
						<td><div>1</div><div></div></td>
						<td><div>2</div><div></div></td>
						<td><div>3</div><div></div></td>
						<td class="sat-td"><div>4</div><div></div></td>
					</tr>
					<tr>
						<td class="sun-td"><div>5</div><div></div></td>
						<td><div>6</div><div></div></td>
						<td><div>7</div><div></div></td>
						<td><div>8</div><div></div></td>
						<td><div>9</div><div></div></td>
						<td><div>10</div><div></div></td>
						<td class="sat-td"><div>11</div><div></div></td>
					</tr>
				</table>
				-->
			</div>
			<!-- 일정창 내용 시작 -->
			<div id="select-schedule-show-box" data-idx="0" style="display: none;">
				<div id="select-schedule-show-top">
					<div id="select-schedule-show-header">
						<div id="select-schedule-prj-icon"></div>
						<div id="select-schedule-prj-name">긴급 프로젝트</div>
						<div id="select-schedule-show-close-btn"></div>
					</div>
				</div>
				<div id="select-schedule-title-box">
					<div>
						<div id="writer-prof"></div>
						<div id="writeer-name">
							<span id="writerNameSpan">정성훈</span>
							<span id="writeDateSpan" style="margin-left: 6px;">2024-12-14 21:33</span>
							<img id="all-relese-icon" src="images/all-release-icon.png"/>
						</div>
						<div id="board-option">
							<div id="board-goto">게시글 바로가기</div>
							<div id="top-fixed"></div>
							<div id="board-set-btn"></div>
						</div>
					</div>
				</div>
				<div id="schedule-top">
					<div id="schedule-date-icon">
						<div>2024-12</div>
						<div>03</div>
					</div>
					<div id="schedule-title-box">
						<div id="schedule-title">일정 제목</div>
						<div id="schedule-date">2024-12-03 (화), <span>21:40</span> - <span>22:40</span></div>
					</div>
				</div>
				<div class="hr"></div>
				<div id="schedule-content-container">
					<div id="schedule-content-box">
						<div id="schedule-participant">
							<div id="participant-icon"></div>
							<div id="participant-content">
								<div>
									<div id="participantBox">
										<div class="participant-prof"><div></div></div>
									</div>
									<div id="change-participant-btn">참석자 변경</div>
								</div>
								<div>
									<div id="participant-cnt">
										<p>참석 <span id="attend-cnt">0</span></p>
										<p>불참 <span id="non-attend-cnt">0</span></p>
										<p>미정 <span id="TBC-cnt">0</span></p>
									</div>
								</div>
							</div>
						</div>
						<p id="schedult-content-text">
							일정 내용...
						</p>
						<div id="vote-box">
							<button type="button" class="off" id="attend-btn">참석</button>
							<button type="button" class="off" id="non-attend-btn">불참</button>
							<button type="button" class="off" id="TBD-btn">미정</button>
						</div>
					</div>
					<div id="board-footer">
						<div>
							<div class="board-foot-btn" id="good-btn">
								<img src="images/board-good-off-icon.png"/>
								<span> 좋아요</span>
							</div>
							<div class="board-foot-btn" id="bookMark-btn">
								<img src="images/board-bookmark-off-icon.png"/>
								<span> 북마크</span>
							</div>
							<div class="board-foot-btn" id="reAlarm-btn">
								<img src="images/board-reAlarm-off-icon.png"/>
								<span> 다시알림</span>
							</div>
						</div>
						<div id="read-cnt-box">읽음 <span id="read-cnt">1</span></div>
					</div>
				</div>
				<!-- 댓글 시작 -->
				<div id="comment-menu-tab">
					<div id="comment-menu-item-box">
						<div class="comment-menu-item">댓글 <span id="comment-count">3</span></div>
					</div>
				</div>
				<div class="comment-items">
					<div class="comment-item-prof"></div>
					<div class="comment-item-content">
						<div class="comment-item-row1">
							<div>
								<span class="comment-user-name">정성훈</span>
								<span class="comment-write-date">2024-12-16 22:53</span>
							</div>
							<div>
								<button type="button" class="comment-item-alter-btn">수정</button>
								<button type="button" class="comment-item-del-btn">삭제</button>
							</div>
						</div>
						<div class="comment-item-row2">
							<div>일정 댓글...</div>
						</div>
						<div class="comment-item-row3">
							<div class="comment-item-good-btn">
								<div></div>
								<span>좋아요</span>
							</div>
							<div class="comment-item-recom-btn">
								<div></div>
								<span>답글</span>
							</div>
						</div>
					</div>
				</div>
				<div id="comment-input-box">
					<div id="my-prof"></div>
					<div id="comment-input-area">
						<div>
							<input id="comment-input-text" type="text" placeholder="줄바꿈 Shift + Enter / 입력 Enter 입니다."/>
							<button type="button" id="comment-file-upload"></button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div style="clear:both;"></div>
</form>
</body>
</html>