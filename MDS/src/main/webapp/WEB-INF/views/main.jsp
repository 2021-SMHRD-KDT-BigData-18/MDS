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
<link href="resources/css/main.css" rel="stylesheet" type="text/css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jsmpeg/0.1/jsmpg.js"></script>
<title>메인페이지</title>
<style type="text/css">
#videoElement, #mirrored {
	width: 500px;
	height: 375px;
	background-color: #666;
	display: inline-block;
}
</style>
</head>
<body>

	<c:choose>
		<c:when test="${result.u_id eq list.u_id && result ne null}">
			<div class="header">
				<h1>${result.u_id}님,환영합니다!</h1>
				<a href="logout.com">로그아웃</a>
			</div>

			<div class="category"></div>

			<div class="videoPlayer">
				<video autoplay="true" id="videoElement"></video>
				<canvas class="canvas" id="mirrored"></canvas>
			</div>
		</c:when>
	</c:choose>


	<script type="text/javascript" src="resources/JS/account.js"></script>
	<script type="text/javascript" src="resources/JS/chat.js"></script>
	<script type="text/javascript" src="resources/JS/webCam.js"></script>
	<script src="resources/JS/cctv.js"></script>



</body>
</html>
