<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>home</title>
</head>
<body>
<a href="<c:url value='/member/signupForm' />">회원 가입</a>

<!-- 면접 -->
<a href="<c:url value='/interview/getinterview' />">모의 면접 시작</a>
<a href="<c:url value='/interview/getinterviewResult' />">모의 면접 결과 조회(미작업)</a>
</body>
</html>