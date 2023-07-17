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
		  <c:when test="${result eq null}">
			  <a href="signIn.com" >로그인</a>
			  <a href="signUp.com">회원가입</a>
		  </c:when>
		  <c:otherwise>
		  	<h1>${result.u_id}님, 환영합니다!</h1>
		  </c:otherwise>
	  </c:choose>
  </div>
  
  
  
  
  <script type="text/javascript" src="resources/JS/account.js"></script>
  
  <script>
  (function(){var w=window;if(w.ChannelIO){return w.console.error("ChannelIO script included twice.");}var ch=function(){ch.c(arguments);};ch.q=[];ch.c=function(args){ch.q.push(args);};w.ChannelIO=ch;function l(){if(w.ChannelIOInitialized){return;}w.ChannelIOInitialized=true;var s=document.createElement("script");s.type="text/javascript";s.async=true;s.src="https://cdn.channel.io/plugin/ch-plugin-web.js";var x=document.getElementsByTagName("script")[0];if(x.parentNode){x.parentNode.insertBefore(s,x);}}if(document.readyState==="complete"){l();}else{w.addEventListener("DOMContentLoaded",l);w.addEventListener("load",l);}})();

  ChannelIO('boot', {
    "pluginKey": "11553b79-b366-44e9-a7ee-7fc16496a30a"
  });
</script>
  
</body>
</html>
