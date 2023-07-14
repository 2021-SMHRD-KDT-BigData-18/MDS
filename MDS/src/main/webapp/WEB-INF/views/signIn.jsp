<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="resources/css/singln.css" rel="stylesheet" type="text/css">
<title>Insert title here</title>
</head>
<body>
	<div class="wrapper">

		<div class="wrap">
			<form action="${cpath}/" method="post">
				<div class="logo_wrap">
					<span>M D S </span>
				</div>
				<div class="login_wrap">
					<div class="id_wrap">
						<div class="id_input_box">
							<input class="id_input" type="text">
						</div>
					</div>
					<div class="pw_wrap">
						<div class="pw_input_box">
							<input class="pw_iput" type="password">
						</div>
					</div>
					<div class="login_button_wrap">
						<input type="submit" class="login_button" value="로그인">
					</div>
				</div>
			</form>

		</div>

	</div>
</body>
</html>