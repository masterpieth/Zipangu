<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<head>
<title>로그인</title>
</head>
<body>
<div class="container col-4">
	<form action="<c:url value='/member/login' />" method="post">
		<input type="text" class="form-control" name="userID" placeholder="ID">
		<br>
		<input type="password" class="form-control" name="userPwd" placeholder="Password">
		<br>
		<button type="submit" class="btn btn-primary float-right">로그인</button>
		<p class="float-right">&nbsp;&nbsp;</p>
		<a href="<c:url value='/member/signupForm' />">
			<button type="button" class="btn btn-info float-right">회원가입</button>
		</a>
	</form>
</div>
</body>