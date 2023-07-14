<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cpath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width">
  <script src="https://code.jquery.com/jquery-3.1.0.js"></script>
  <link href="resources/css/main.css" rel="stylesheet" type="text/css">
  <title>메인페이지</title>
</head>
<body>
  
  <div id="home">
	  <c:choose>
		  <c:when test="${result.user_id() eq null}">
			  <a href="signIn.com" >로그인</a>
			  <a href="signUp.com">회원가입</a>
		  </c:when>
		  <c:otherwise>
		  	<h1>${result.user_name()}님, 환영합니다!</h1>
		  </c:otherwise>
	  </c:choose>
  </div>
  
  
  
  
  <script type="text/javascript" src="resources/JS/account.js"></script>
  
  
</body>
</html>
