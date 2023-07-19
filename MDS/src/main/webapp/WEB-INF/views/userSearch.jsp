<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cpath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="resources/css/userSearch.css" rel="stylesheet"
	type="text/css">
<title>Insert title here</title>
</head>
<body>
	<div class="wrapper">
		<form action="userSearch" method="post">
			<div class="wrap">
				<div>
					<span>ID/PW찾기</span>
				</div>

				<div class="mail_wrap">
					<div class="mail_name">이메일</div>
					<div class="mail_input_box">
						<input type="text" name="u_email" id="u_email" placeholder="이메일">
						<div class="mail_check_wrap">
							<div class="mail_check_button">
								<button type="button" class="btn btn-primary"
									id="mail-Check-Btn">본인인증</button>
							</div>
							<div class="mail_check_input_box">
								<input name="u_email_num" class="form-control mail-check-input"
									placeholder="인증번호 6자리를 입력해주세요!" disabled="disabled"
									maxlength="6">
							</div>
							<span id="mail-check-warn"></span> 
							<input type="submit" class="modify_button" value="확인">
						</div>
					</div>
				</div>
			</div>
	</form>
	</div>
	<script src="resources/JS/jquery-3.6.4.min.js"></script>
	<script
		src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script type="text/javascript" src="resources/JS/account.js"></script>

</body>
</html>