<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cpath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width">
<script src="https://code.jquery.com/jquery-3.1.0.js"></script>
<link href="resources/images/cam.png" rel="shortcut icon"
	type="image/png">
<link href="resources/css/main.css" rel="stylesheet" type="text/css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jsmpeg/0.1/jsmpg.js"></script>
<title>메인페이지</title>
</head>
<body>
		<!-- 다크모드 버튼 -->
		<input type="checkbox" id="darkmode-toggle" /> <label
			for="darkmode-toggle" id="darkmode-label"> <svg class="moon"
				viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
	            <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
	            <g id="SVGRepo_tracerCarrier" stroke-linecap="round"
					stroke-linejoin="round"></g>
	            <g id="SVGRepo_iconCarrier"> 
	                <path
					d="M19.9001 2.30719C19.7392 1.8976 19.1616 1.8976 19.0007 2.30719L18.5703 3.40247C18.5212 3.52752 18.4226 3.62651 18.298 3.67583L17.2067 4.1078C16.7986 4.26934 16.7986 4.849 17.2067 5.01054L18.298 5.44252C18.4226 5.49184 18.5212 5.59082 18.5703 5.71587L19.0007 6.81115C19.1616 7.22074 19.7392 7.22074 19.9001 6.81116L20.3305 5.71587C20.3796 5.59082 20.4782 5.49184 20.6028 5.44252L21.6941 5.01054C22.1022 4.849 22.1022 4.26934 21.6941 4.1078L20.6028 3.67583C20.4782 3.62651 20.3796 3.52752 20.3305 3.40247L19.9001 2.30719Z"
					fill="#1C274C"></path> <path
					d="M16.0328 8.12967C15.8718 7.72009 15.2943 7.72009 15.1333 8.12967L14.9764 8.52902C14.9273 8.65407 14.8287 8.75305 14.7041 8.80237L14.3062 8.95987C13.8981 9.12141 13.8981 9.70107 14.3062 9.86261L14.7041 10.0201C14.8287 10.0694 14.9273 10.1684 14.9764 10.2935L15.1333 10.6928C15.2943 11.1024 15.8718 11.1024 16.0328 10.6928L16.1897 10.2935C16.2388 10.1684 16.3374 10.0694 16.462 10.0201L16.8599 9.86261C17.268 9.70107 17.268 9.12141 16.8599 8.95987L16.462 8.80237C16.3374 8.75305 16.2388 8.65407 16.1897 8.52902L16.0328 8.12967Z"
					fill="#1C274C"></path> <path opacity="0.5"
					d="M12 22C17.5228 22 22 17.5228 22 12C22 11.5373 21.3065 11.4608 21.0672 11.8568C19.9289 13.7406 17.8615 15 15.5 15C11.9101 15 9 12.0899 9 8.5C9 6.13845 10.2594 4.07105 12.1432 2.93276C12.5392 2.69347 12.4627 2 12 2C6.47715 2 2 6.47715 2 12C2 17.5228 6.47715 22 12 22Z"
					fill="#1C274C"></path> 
	            </g>
	        </svg>
		</label>
		
	<!-- 다크모드 칠하는 div -->
	<div class="background"></div>

	<div class="container">
		<div class="head_con">
			<div class="logo_img">
				<a class="logo" href="javascript:listView('${result.u_id}')"> <img
					alt="MDS로고" src="resources/images/MDS_logo.png" width="250px"
					height="100px">
				</a>
			</div>
			<div class="header">
				<c:choose>
					<c:when test="${result ne null}">
						<h1>${result.u_id}님,환영합니다!</h1>
						<a href="#">개인정보수정</a>
						<a href="logout.com">로그아웃</a>
					</c:when>
				</c:choose>
			</div>

		</div>

		<div class="menu_container">
			<div class="tabs">
				<input type="radio" id="radio-1" name="tabs" checked />
				<label class="tab" for="radio-1">영상조회</label>
				<input type="radio" id="radio-2" name="tabs" />
				<label class="tab" for="radio-2">데이터조회</label>
				<input type="radio" id="radio-3" name="tabs" />
				<label class="tab" for="radio-3" id="entryLog">출입기록</label>
				<input type="radio" id="radio-4" name="tabs" />
				<label class="tab" for="radio-4" id="webAlarm">
				<img src="resources/images/bell.svg" alt="알림" name="bell">
				<span class="notification">2</span>
				</label> <span class="glider"></span>
			</div>
		</div>

		<div class="videoPlayer" id="page1-content" value="메인페이지">
			<c:choose>
				<c:when test="${result.u_id eq list.u_id && result ne null}">
					<video autoplay="true" id="videoElement"></video>
					<canvas class="canvas" id="mirrored"></canvas>
				</c:when>
			</c:choose>
		</div>
		
		<div class="calendar_page" id="page2-content" style="display: none;" value="데이터조회">

			<div id="calendar">
				<div id="calendar_header">
					<i class="icon-chevron-left"></i>
					<h1></h1>
					<i class="icon-chevron-right"></i>
				</div>
				<div id="calendar_weekdays"></div>
				<div id="calendar_content"></div>
			</div>

		</div>

		<div id="date_content" style="display: none;">
			<h1>데이터조회</h1>
			
		
		</div>
		
		</div>

		

		<div class="" id="page3-content" style="display: none;" value="데이터분석">
		
		<h1>데이터분석</h1>
		
		
		
		</div>

		<div class="" id="page4-content" style="display: none;" value="마이페이지">
		
		<h1>마이페이지</h1>
		
		
		
		</div>


	</div>
	
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
	
	
</body>
</html>
