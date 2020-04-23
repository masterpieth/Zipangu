<jsp:include page="/WEB-INF/views/include/header.jsp" />
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>
<div class="container" style="height:100px;"></div>
<div class="container col-3">
	<form action="<c:url value='/member/login' />" method="post">
		<table class="table table-bordered">
			<tr><th style="text-align:center;"><h4>로그인</h4></th></tr>
			<tr><td>
				<p>아이디</p>
				<input type="text" class="form-control" name="userID" placeholder="아이디" required>
				<br>
				<p>비밀번호</p>
				<input type="password" class="form-control" name="userPwd" placeholder="비밀번호" required>
				<br>
				<button type="submit" class="genric-btn info btn-block" style="font-size: 15px;">로그인</button>
				<br>
				<br>
				<a href="<c:url value='/member/signupForm' />">
					<button type="button" class="genric-btn success btn-block" style="font-size: 15px;">회원 가입</button>
				</a>
			</td></tr>
		</table>
	</form>
</div>
<div class="container" style="height:100px;"></div>
<c:if test="${requestScope.result == false}">
    <script>alert("ID 또는 암호가 일치하지 않습니다");</script>
</c:if>
</body>
</html>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />