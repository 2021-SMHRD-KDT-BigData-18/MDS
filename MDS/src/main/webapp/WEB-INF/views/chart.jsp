<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cpath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="resources/css/chart.css" rel="stylesheet" type="text/css">
<title>chart</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/modernizr/2.8.3/modernizr.min.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/snap.svg/0.3.0/snap.svg-min.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js" type="text/javascript"></script>
</head>
<body>

<svg id="svg" viewBox="0 0 1000 1000"></svg>
<button id="draw">Draw</button>



<script type="text/javascript" src="resources/JS/chart.js"></script>
</body>
</html>

