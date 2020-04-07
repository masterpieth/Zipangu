<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
	<title>메인화면</title>
</head>
<body>
<h1>
	Hello world!  
</h1>
<a href="<c:url value="analysis/company"/>">인재상 분석</a>
<a href="<c:url value='/member/signupForm' />">회원 가입</a>
<a href="<c:url value='/header' />">헤더확인</a>
<a href="<c:url value='/footer' />">푸터확인</a>
<a href="<c:url value='/maintemp' />">메인화면(작업중)</a>
<a href="<c:url value='analysis/companyTemp' />">기업 분석 화면 작업중</a>
<a href="<c:url value='analysis/entrysheet' />">자소서 작업중</a>
</body>
</html>