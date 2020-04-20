<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<head>
<title>경고</title>
</head>
<body>
	<div class="container">
		<div class="jumbotron">
			<h1>허용되지 않은 접근입니다.</h1>
			<p><a href="<c:url value='/member/loginForm' />">로그인</a> 후 이용해 주시기 바랍니다.</p>
		</div>
		<div class="alert alert-info">
			<strong>계정이 없으신가요?</strong>
			<br>
			<br>
			가입하시려면  <a href="<c:url value='/member/signupForm' />" class="alert-link">회원 가입</a>
		</div>
	</div>
</body>