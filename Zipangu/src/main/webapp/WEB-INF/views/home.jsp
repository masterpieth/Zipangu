<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Zipangu</title>
<link rel="stylesheet" href="<c:url value='/resources/css/bootstrap.min.css' />">
<script src="<c:url value='/resources/js/jquery-3.4.1.min.js' />"></script>
<script src="<c:url value='/resources/js/popper.min.js' />"></script>
<script src="<c:url value='/resources/js/bootstrap.min.js' />"></script>
</head>
<body>
<a href="<c:url value='/member/signupForm' />">회원 가입</a>
<<<<<<< Updated upstream
<a href="<c:url value='/header' />">헤더확인</a>
<a href="<c:url value='/footer' />">푸터확인</a>
<a href="<c:url value='/maintemp' />">메인화면(작업중)</a>
=======
<a href="<c:url value='/resume/resumeForm' />">이력서 작성</a>
<a href="<c:url value='/resume/resumeList' />">이력서 조회</a>
>>>>>>> Stashed changes
<hr>
<div class="container">
<c:choose>
	<c:when test="${empty userID}">
		<form action="<c:url value='/member/login' />" method="post">
			<input type="text" class="form-control" name="userID">
			<input type="password" class="form-control" name="userPwd">
			<button type="submit" class="btn btn-primary">로그인</button>
		</form>
	</c:when>
	<c:otherwise>
		<h1>${userID}로 로그인 중</h1>
	</c:otherwise>
</c:choose>
</div>
</body>
</html>