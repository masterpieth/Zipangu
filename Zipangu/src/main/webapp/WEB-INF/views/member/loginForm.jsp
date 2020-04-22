<jsp:include page="/WEB-INF/views/include/header.jsp" />
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link rel="stylesheet" href="<c:url value='/resources/template_css/bootstrap.min.css' />">
</head>
<body>
<div class="container" style="height:100px;"></div>
<div class="container col-3">
	<form action="<c:url value='/member/login' />" method="post">
		<table class="table table-bordered">
			<tr><th style="text-align:center;"><h4>로그인</h4></th></tr>
			<tr><td>
				<h6>아이디</h6>
				<input type="text" class="form-control" name="userID" placeholder="아이디" required>
				<br>
				<h6>비밀번호</h6>
				<input type="password" class="form-control" name="userPwd" placeholder="비밀번호" required>
				<br>
				<button type="submit" class="btn btn-primary btn-block">로그인</button>
				<br>
				<a href="<c:url value='/member/signupForm' />">
					<button type="button" class="btn btn-info btn-block">회원 가입</button>
				</a>
			</td></tr>
		</table>
	</form>
</div>
<div class="container" style="height:100px;"></div>
</body>
</html>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />