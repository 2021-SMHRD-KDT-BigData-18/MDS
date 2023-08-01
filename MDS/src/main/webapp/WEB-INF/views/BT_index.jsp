<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cpath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>Dashboard - SB Admin</title>
<link
	href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css"
	rel="stylesheet" />
<link href="resources/BT_css/styles.css" rel="stylesheet" />
<script src="https://code.jquery.com/jquery-3.1.0.js"></script>
<link href="resources/images/cam.png" rel="shortcut icon"
	type="image/png">
<!-- fullcalendar CDN -->
<link
	href='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.css'
	rel='stylesheet' />
<script
	src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.js'></script>
<!-- fullcalendar 언어 CDN -->
<script
	src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/locales-all.min.js'></script>
</head>
<body class="sb-nav-fixed">
	<nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
		<div class="logo_img">
			<a class="logo" href="javascript:listView('${result.u_id}')"> <img
				alt="MDS로고" src="resources/images/MDS_logo.png" width="180px"
				height="60px">
			</a>
		</div>
		<div class="header">
			<button type="button" class="icon-button" id="icon-button">
				<img src="resources/images/bell.svg" alt="알림" name="bell"> 
				<span class="glider" id="countAlarm"></span> 
				<span class="notification"></span>
			</button>
			<a href="logout.com">로그아웃</a>
		</div>
	</nav>
	<div id="layoutSidenav">
		<div id="layoutSidenav_nav">
			<nav class="sb-sidenav accordion sb-sidenav-dark"
				id="sidenavAccordion">
				<div class="sb-sidenav-menu">
					<div class="nav">
						<div class="sb-sidenav-menu-heading">CCTV</div>
						<div class="nav-link" id="radio-1">
							<div class="sb-nav-link-icon">
								<i class="fas fa-tachometer-alt"></i>
							</div>
							실시간 영상
						</div>
						<div class="sb-sidenav-menu-heading">데이터</div>
						<div id="radio-2" class="nav-link collapsed"
							data-bs-toggle="collapse" data-bs-target="#collapseLayouts"
							aria-expanded="false" aria-controls="collapseLayouts">
							<div class="sb-nav-link-icon">
								<i class="fas fa-columns"></i>
							</div>
							데이터 조회
							<div class="sb-sidenav-collapse-arrow">
								<i class="fas fa-angle-down"></i>
							</div>
						</div>
						<div id="radio-3" class="nav-link collapsed"
							data-bs-toggle="collapse" data-bs-target="#collapsePages"
							aria-expanded="false" aria-controls="collapsePages">
							<div class="sb-nav-link-icon">
								<i class="fas fa-book-open"></i>
							</div>
							데이터 분석
							<div class="sb-sidenav-collapse-arrow">
								<i class="fas fa-angle-down"></i>
							</div>
						</div>
						<div class="sb-sidenav-menu-heading">정보수정</div>
						<div id="radio-4" class="nav-link" href="tables.html">
							<div class="sb-nav-link-icon">
								<i class="fas fa-table"></i>
							</div>
							마이페이지
						</div>
					</div>
				</div>
				<div class="sb-sidenav-footer">
					<div class="small">
						<c:choose>
							<c:when test="${result ne null}">
									${result.u_id}님,환영합니다!
								</c:when>
						</c:choose>
					</div>

				</div>
			</nav>
		</div>


		<div id="layoutSidenav_content">
			<main>
				<div id="HeaderMain_image">
					<img alt="" src="#"> 이미지 들어갈 공간
				</div>

				<div class="videoPlayer" id="page1-content">
					<c:choose>
						<c:when test="${result.u_id eq list.u_id && result ne null}">
							<video autoplay="true" id="videoElement"></video>
							<canvas class="canvas" id="mirrored"></canvas>
						</c:when>
					</c:choose>
				</div>

				<div class="calendar_page" id="page2-content" style="display: none;"
					value="데이터조회">

					<div id="calendar" class="calendar_size"></div>
					<p class="date" id="nows"></p>

				</div>


				<div class="analyze" id="page3-content" style="display: none;"
					value="데이터분석">

					<div class="row">
						<div class="col-xl-6">
							<div class="card mb-4">
								<div class="card-header">
									<i class="fas fa-chart-area me-1"></i> Area Chart Example
								</div>
								<div class="card-body">
									<canvas id="myAreaChart" width="100%" height="40"></canvas>
								</div>
							</div>
						</div>
						<div class="col-xl-6">
							<div class="card mb-4">
								<div class="card-header">
									<i class="fas fa-chart-bar me-1"></i> Bar Chart Example
								</div>
								<div class="card-body">
									<canvas id="myBarChart" width="100%" height="40"></canvas>
								</div>
							</div>
						</div>
					</div>



				</div>

				<div class="myinfo" id="page4-content" style="display: none;" value="마이페이지">
					
					<div class="containerbody">
				<div class=middle>
					<form method=post action="updateinfoSuccess.com">
						<br>
						<h2>내 정보 수정</h2>
						<table>
							<tr>
								<th>ID</th>
								<td><span id=id><c:choose>
							<c:when test="${result ne null}">
						${result.u_id}
					</c:when>
						</c:choose></span></td>
							</tr>
							<tr>
								<th>PW</th>
								<td><input type=password name=pw id=pw disabled
									placeholder="필수 입력 사항입니다." value="2">
									<input type=button id=pw_button value="변경"
									onclick="change_pw();"></td>
								<input type=hidden name="user_pw" id=pw2
									value="3">
							</tr>
							<tr>
								<th>E-mail</th>
								<td><input type=text name=name id=name disabled
									placeholder="필수 입력 사항입니다." value="4">
									<input type=button id=name_button value="변경"
									onclick="change_name();"></td>
								<input type=hidden name="user_name" id=name2
									value="5">
							</tr>
							<tr>
								<th>농장주소</th>
								<td><input type="text" name=phone id=phone disabled
									value="6"> <input type=button
									id=phone_button value="변경" onclick="change_phone();"></td>
								<input type=hidden name="user_phone" id=phone2
									value="7">
							</tr>
							<tr>
								<th>자동차 등록</th>
								<td><input type="text" name=intro id=intro disabled
									value="8"> <input
									type=button id=intro_button value="변경"
									onclick="change_intro();"></td>
								<input type=hidden name="user_v_account" id=intro2
									value="9">
							</tr>
						</table>
						<input disabled id=submit type="submit" value="변경사항 확정하기">
					</form>
				</div>
			</div>
					
				</div>


			</main>
		</div>

		<div class="foot">
			<footer>
				<div class="footerContainer">
					<div class="socialIcons">
						<a href=""><i class="fa-brands fa-facebook"></i></a> <a href=""><i
							class="fa-brands fa-instagram"></i></a> <a href=""><i
							class="fa-brands fa-twitter"></i></a> <a href=""><i
							class="fa-brands fa-youtube"></i></a>
					</div>
					<div class="footerNav">
						<ul>
							<li><a href="">Home</a></li>
							<li><a href="">News</a></li>
							<li><a href="">About</a></li>
							<li><a href="">Contact Us</a></li>
							<li><a href="">Our Team</a></li>
						</ul>
					</div>
				</div>
			</footer>
		</div>
	</div>


	<!-- 모달 -->
	<div class="modal-bg" id="modal-bg">
		<div class="modal" id="modal">
			<div class="modal-content">
				<!-- 모달 내용 추가 -->
				<h2>알림</h2>
				<div id="modr" style="display: block;">침입 내역이 없습니다.</div>
				<div id="webAlarm_content"></div>
				<button type="button" class="modal-close-btn" id="modal-close-btn">&times;</button>
			</div>
		</div>
	</div>



	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>
	<script src="resources/BT_js/scripts.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"
		crossorigin="anonymous"></script>
	<script src="resources/BT_assets/demo/chart-area-demo.js"></script>
	<script src="resources/BT_assets/demo/chart-bar-demo.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"
		crossorigin="anonymous"></script>
	<script src="resources/BT_js/datatables-simple-demo.js"></script>

	<script type="text/javascript">
		var data = '${result.u_id}';
	</script>
	<script type="text/javascript" src="resources/JS/main.js"></script>
	<script type="text/javascript" src="resources/JS/account.js"></script>
	<script type="text/javascript" src="resources/JS/chat.js"></script>
	<script type="text/javascript" src="resources/JS/webCam.js"></script>
	<script src="resources/JS/cctv.js"></script>
	<script src="resources/JS/entryLog.js"></script>
	<script type="text/javascript" src="resources/JS/entryLog.js"></script>
	<script type="text/javascript" src="resources/JS/webAlarm.js"></script>
	<script>
	document.addEventListener('DOMContentLoaded', function () {
		$(function () {
	        var request = $.ajax({
	            url: "/full-calendar/calendar-admin", // 변경하기
	            type: "post",
	            dataType: "json"
	    });
		request.done(function (data) {
			var calendarEl = $('#calendar')[0];
		    var calendar = new FullCalendar.Calendar(calendarEl, {
		    	// contentHeight: 600,
		        height: '500px', // calendar 높이 설정
		    	// 너비가 높이의 두 배
		        expandRows: true, // 화면에 맞게 높이 재설정
		        slotMinTime: '08:00', // Day 캘린더에서 시작 시간
		        slotMaxTime: '20:00', // Day 캘린더에서 종료 시간
		        // 해더에 표시할 툴바
		        headerToolbar: {
		            //left: 'prev,next today',
		            left: '',
		            center: 'title',
		            right:'prev,next today'
		            //right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
		        },
		        initialView: 'dayGridMonth', // 초기 로드 될때 보이는 캘린더 화면(기본 설정: 달)
		 //       initialDate: '2023-05-11', // 초기 날짜 설정 (설정하지 않으면 오늘 날짜가 보인다.)
		        navLinks: false, // 날짜를 선택하면 Day 캘린더나 Week 캘린더로 링크
		        editable: true, // 수정 가능?
		        selectable: true, // 달력 일자 드래그 설정가능
		        nowIndicator: true, // 현재 시간 마크
		        dayMaxEvents: true, // 이벤트가 오버되면 높이 제한 (+ 몇 개식으로 표현)
		        locale: 'ko', // 한국어 설정
		        eventAdd: function(obj) { // 이벤트가 추가되면 발생하는 이벤트
		            console.log(obj);
		        },
		        
		        // 날짜 클릭 시 리스트 출력
				dateClick: function (info) {
				   $('#nows').html(info.dateStr);
				   $('#nows').html = "";
				}
		        
		    });
		    
		    calendar.render();
			});
		});
	 
    });
	</script>

</body>
</html>
