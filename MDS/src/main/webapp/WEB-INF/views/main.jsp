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
<link href="resources/images/cam.png" rel="shortcut icon" type="image/png">
<link href="resources/css/main.css" rel="stylesheet" type="text/css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jsmpeg/0.1/jsmpg.js"></script>
<title>메인페이지</title>
</head>
<body>

	<div class="container">
		<div class="head_con">
			<div class="logo_img">
				<a class="logo" href="main.com"> <img alt="MDS로고"
					src="resources/images/MDS_logo.png" width="150px" height="75px">
				</a>
			</div>
			<div class="header">
				<c:choose>
					<c:when test="${result ne null}">
						<h1>${result.u_id}님,환영합니다!</h1>
						<a href="logout.com">로그아웃</a>
					</c:when>
				</c:choose>
			</div>
			
		</div>

		<div class="menu_container">
			<div class="tabs">
				<input type="radio" id="radio-1" name="tabs" checked /> <label
					class="tab" for="radio-1">영상조회</label> <input type="radio"
					id="radio-2" name="tabs" /> <label class="tab" for="radio-2">데이터조회</label>
				<input type="radio" id="radio-3" name="tabs" /> <label class="tab"
					for="radio-3">정보수정/차량등록</label> <input type="radio" id="radio-4"
					name="tabs" /> <label class="tab" for="radio-4">출입기록</label> <input
					type="radio" id="radio-5" name="tabs" checked /> <label
					class="tab" for="radio-5"><img src="resources/images/bell.svg" alt="알림"
					name="bell"><span class="notification">2</span></label> <span
					class="glider"></span>
			</div>
		</div>

		<div class="videoPlayer">
			<c:choose>
				<c:when test="${result.u_id eq list.u_id && result ne null}">
					<video autoplay="true" id="videoElement"></video>
					<canvas class="canvas" id="mirrored"></canvas>
				</c:when>
			</c:choose>
		</div>


	</div>

	<script type="text/javascript" src="resources/JS/account.js"></script>
	<script type="text/javascript" src="resources/JS/chat.js"></script>
	<script type="text/javascript" src="resources/JS/webCam.js"></script>
	<script src="resources/JS/cctv.js"></script>
</body>
</html>
