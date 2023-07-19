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
#videoElement{
	width: 500px;
	height: 375px;
	background-color: #666;
	display: inline-block;
}
</style>
</head>
<body>

	<div class="header">
		<c:choose>
			<c:when test="${result eq null}">
				<a href="signIn.com">로그인</a>
				<a href="signUp.com">회원가입</a>
				<a href="checkUser.com">정보수정</a>
			</c:when>
			<c:otherwise>
				<h1>${result.u_id}님,환영합니다!</h1>
				<a href="logout.com">로그아웃</a>
			</c:otherwise>
		</c:choose>
	</div>

	<div class="category"></div>


	<div class="videoPlayer">
		<c:choose>
			<c:when test="${result.u_id eq list.u_id && result ne null}">
				<video autoplay="true" id="videoElement">
			</c:when>
			<c:otherwise>
				<div>로그인이 필요한 서비스 or CCTV rtsp 주소를 등록해주라는 요청 페이지 필요</div>
			</c:otherwise>
		</c:choose>
	</div>



	<script type="text/javascript" src="resources/JS/account.js"></script>
	<script type="text/javascript" src="resources/JS/chat.js"></script>
	<script type="text/javascript" src="resources/JS/webCam.js"></script>
	<script src="resources/JS/cctv.js"></script>

	

</body>
</html>
