<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Zipangu</title>
</head>
<body>

<c:choose>
	<c:when test="${sessionScope.userID != null}">
		<h2>${sessionScope.userID} 님 반갑습니다!</h2>
		<a href="<c:url value='/member/logout' />">로그아웃</a>
	</c:when>
	<c:otherwise>
		<a href="<c:url value='/member/signupForm' />">회원 가입</a>
		<a href="<c:url value='/member/loginForm' />">로그인</a>
	</c:otherwise>
</c:choose>

<!-- 면접 -->
<a href="<c:url value='/interview/getinterview' />">모의 면접 시작</a>
<a href="<c:url value='/interview/getinterviewResult' />">모의 면접 결과 조회</a>
<a href="<c:url value='/header' />">헤더확인</a>
<a href="<c:url value='/footer' />">푸터확인</a>
<a href="<c:url value='/maintemp' />">메인화면(작업중)</a>
</body>
</html>