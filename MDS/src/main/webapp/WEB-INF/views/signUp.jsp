<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cpath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="resources/css/signUp.css" rel="stylesheet" type="text/css">
<title>Insert title here</title>
</head>
<body>
	<div class="wrapper">
		<div class="ocean">
			<div class="wave"></div>
			<div class="wave"></div>
		</div>
		<div class="con">
			<div class="logo_wrap">
				<span> 회 원 가 입 </span>
			</div>
			<form action="signUp.com" method="post">
				<div class="wrap">
					<div class="id_wrap">
						<div class="id_name">아이디</div>
						<div class="id_input_box">
							<input class="id_input" type="text" name="u_id" id="u_id">
						</div>
							<div id="id_check"></div>
					</div>
					<div class="pw_wrap">
						<div class="pw_name">비밀번호</div>
						<div class="pw_input_box">
							<input class="pw_input" type="password" name="u_pw" id="u_pw">
						</div>
						<div class="pwck_name">비밀번호 확인</div>
						<div class="pwck_input_box">
							<input class="pwck_input" type="password" name="u_pw_confirm"
								id="u_pw_confirm">
						</div>
						<span id="confirmMsg"></span>
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
							</div>
						</div>
					</div>

					<div class="address_wrap">
						<div class="address_name">농장주소</div>
						<input type="text" id="sample6_postcode" placeholder="우편번호"
							name="farm_zip_code"> <input type="button"
							onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
						<input type="text" id="sample6_address" placeholder="주소"
							name="farm_addr"><br> <input type="text"
							id="sample6_detailAddress" placeholder="상세주소"
							name="farm_detailed_addr"> <input type="text"
							id="sample6_extraAddress" placeholder="참고항목" name="farm_add_addr">

					</div>
					<div class="join_button_wrap">
						<input type="submit" class="join_button" value="회원가입">
					</div>
				</div>
			</form>
		</div>
	</div>

	<script src="resources/JS/jquery-3.6.4.min.js"></script>
	<script
		src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script type="text/javascript" src="resources/JS/account.js"></script>

</body>
</html>