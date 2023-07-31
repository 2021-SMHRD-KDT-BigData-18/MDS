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
				<img src="resources/images/bell.svg" alt="알림" name="bell"> <span
					class="glider">25</span> <span class="notification"></span>
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

					<div id="calendar" style="width: 80%;"></div>

				</div>


				<div class="" id="page3-content" style="display: none;"
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

				<div class="" id="page4-content" style="display: none;" value="마이페이지">
					
				
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
				<p>이곳에 알림 내용이 들어갑니다.</p>
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
	<script src="fullcalendar/fullcalendar.css"></script>
	<script>
		var calendarEl = $('#calendar')[0];
		var calendar = new FullCalendar.Calendar(calendarEl, {
			// contentHeight: 600,
			height : '700px', // calendar 높이 설정
			width : '1200px',
			// 너비가 높이의 두 배
			expandRows : true, // 화면에 맞게 높이 재설정
			slotMinTime : '08:00', // Day 캘린더에서 시작 시간
			slotMaxTime : '20:00', // Day 캘린더에서 종료 시간
			// 해더에 표시할 툴바
			headerToolbar : {
				left : 'prev,next today',
				center : 'title',
				right : 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
			},
			initialView : 'dayGridMonth', // 초기 로드 될때 보이는 캘린더 화면(기본 설정: 달)
			//       initialDate: '2023-05-11', // 초기 날짜 설정 (설정하지 않으면 오늘 날짜가 보인다.)
			navLinks : true, // 날짜를 선택하면 Day 캘린더나 Week 캘린더로 링크
			editable : true, // 수정 가능?
			selectable : true, // 달력 일자 드래그 설정가능
			nowIndicator : true, // 현재 시간 마크
			dayMaxEvents : true, // 이벤트가 오버되면 높이 제한 (+ 몇 개식으로 표현)
			locale : 'ko', // 한국어 설정
			eventAdd : function(obj) { // 이벤트가 추가되면 발생하는 이벤트
				console.log(obj);
			},
			eventChange : function(obj) { // 이벤트가 수정되면 발생하는 이벤트
				var customProperty = obj.event.extendedProps;
				$.ajax({
					url : 'updateRvInfo.do',
					type : 'post',
					data : {
						"seq" : customProperty.seq,
						"date" : getDateFormat(obj.event.start, true),
						"staffSeq" : customProperty.staffSeq,
						"petYn" : customProperty.petYn
					},
					// 521
					success : function(res) {
						console.log("saved");
					},
					error : function(e) {
						alert("요청 실패");
					},
				});
			},
			eventRemove : function(obj) { // 이벤트가 삭제되면 발생하는 이벤트
				console.log(obj);
			},
			datesSet : function(info) {
				calendar.removeAllEvents();

				var currentDate = this.getDate(); // 현재 달력의 날짜 가져오기
				var currentYear = currentDate.getFullYear(); // 현재 연도
				var currentMonth = (currentDate.getMonth() + 1) + ""; // 현재 월 (0부터 시작하므로 1을 더해줌)
				currentMonth = currentMonth.length == 1 ? "0" + currentMonth
						: currentMonth;

				selectRvList(currentYear + '-' + currentMonth)
			},
			select : function(arg) { // 캘린더에서 드래그로 이벤트를 생성할 수 있다.
				var title = prompt('Event Title:');
				if (title) {
					calendar.addEvent({
						title : title,
						start : arg.start,
						end : arg.end,
						allDay : arg.allDay
					})
				}
				calendar.unselect()
			},
			eventClick : function(info) {
				var event = info.event; // 클릭된 이벤트 객체
				console.log(event)
				var customProperty = event.extendedProps;
				// 클릭된 이벤트 정보를 활용하여 원하는 작업을 수행
				// 예: 이벤트 상세 정보 표시, 특정 동작 수행 등
				alert("ID :" + event.id + "\n청소카테고리 :  " + event.title
						+ "\n예약일자 : " + customProperty.rdt + "\n요청사항 : "
						+ customProperty.note + "\n담당매니저이름 : "
						+ customProperty.staffName)
				// 기타 정보는
				/*
				customProperty.addr
				customProperty.note
				customProperty.petYn
				customProperty.seq
				customProperty.staffSeq
				 */

				console.log('이벤트가 클릭되었습니다.');
				console.log(customProperty)

				// 추가 작업 수행 가능
			},
			// 이벤트
			events : []
		});

		function selectRvList(YM) {
			$.ajax({
				url : 'rvInfo.do',
				type : 'post',
				data : {
					"YM" : YM
				// ym 대신 rv. ~~ 로 하기를 권장 
				},
				success : function(res) {
					var result = JSON.parse(res);
					console.log(result);
					console.log(calendar)

					for (var i = 0; i < result.length; i++) {
						console.log(result[i])
						var rv = result[i];

						// 132, 137 (캘린더 시간대 나오게 하는 코드)
						// 2시간 간격 (아래 두줄 추가)
						var date = new Date(rv.REV_DT)
						date.setHours(date.getHours() + 2)

						var newEvent = {
							// end 추가함, start: dateFormat에서 dateTimeFormat함수로 교체 
							title : rv.JOB_T,
							start : dateTimeFormat(rv.REV_DT),
							end : dateTimeFormat(date),
							rdt : dateTimeFormat(rv.REV_DT),
							note : rv.REV_NOTE,
							addr : rv.M_ADDR,
							id : rv.M_ID,
							seq : rv.REV_SEQ,
							petYn : rv.PET_YN,
							staffSeq : rv.STAFF_SEQ,
							staffName : rv.STAFF_NAME
						}
						calendar.addEvent(newEvent);
					}
				},
				error : function(e) {
					alert("요청 실패");
				},
			});
		}

		function getDate() {
			var today = new Date();
			var year = today.getFullYear(); // 년도
			var month = String(today.getMonth() + 1).padStart(2, '0'); // 월 (0부터 시작하므로 1을 더해줌)
			return year + '-' + month;
		}

		function dateTimeFormat(date) {
			return getDateFormat(date, true);
		}

		function dateFormat(date) {
			return getDateFormat(date, false);
		}

		function getDateFormat(date, timeFlag) {
			var dateObj = new Date(date);

			var year = dateObj.getFullYear(); // 연도
			var month = String(dateObj.getMonth() + 1).padStart(2, '0'); // 월 (0부터 시작하므로 1을 더해줌)
			var day = String(dateObj.getDate()).padStart(2, '0'); // 일
			var hours = String(dateObj.getHours()).padStart(2, '0'); // 시간
			var minutes = String(dateObj.getMinutes()).padStart(2, '0'); // 분
			var seconds = String(dateObj.getSeconds()).padStart(2, '0'); // 초

			var formattedDate = year + '-' + month + '-' + day;
			return timeFlag ? formattedDate + ' ' + hours + ':' + minutes + ':'
					+ seconds : formattedDate
		}

		calendar.render();
		// selectRvList(getDate());
	</script>

</body>
</html>
