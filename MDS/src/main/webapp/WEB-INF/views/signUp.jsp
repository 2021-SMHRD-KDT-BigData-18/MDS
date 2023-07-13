<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.1.0.js"></script>
<title>Insert title here</title>
</head>
<body>
	<form action="signIn.com" method="post">
		ID<input type="text" name="user_id" id="user_id"> </br>
		<!-- ID 중복체크 -->
		<p id="idCheck"></p>
		이름<input type="text" name="user_name"> </br>
		농장주소<input type="text" name="user_farm_address"> </br>
		PW<input type="password" name="user_pw"> </br>
		email<input type="text" name="user_email"> </br>
		<input type="submit" value="회원가입">
	</form>
	
	<script type="text/javascript" src="resources/JS/account.js"></script>
</body>
</html>