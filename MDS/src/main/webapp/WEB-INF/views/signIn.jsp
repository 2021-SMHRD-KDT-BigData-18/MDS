<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<c:set var="cpath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="resources/css/singln.css" rel="stylesheet" type="text/css">
</head>
<body>
	<form action="${cpath}/" method="post">
		ID<input type="text"> </br>
		PW<input type="password"> </br>
		<input type="submit" value="로그인"> </br>
	</form>
</body>
</html>