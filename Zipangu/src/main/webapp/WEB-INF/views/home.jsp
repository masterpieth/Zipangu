<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>home</title>
</head>
<body>
<h1>
	Hello world!  
</h1>
<P>  The time on the server is ${serverTime}. </P>
<h2><a href="<c:url value='/personality/personalityInsight'/>">성향분석페이지로 이동</a></h2>
<h2><a href="<c:url value='/personality/keywordTimeline'/>">성향분석에서 선택한 키워드에 관한 에피소드를 작성하고 타임라인 형식으로 조회할 수 있는 페이지</a></h2>
<a href="<c:url value='/member/signupForm' />">회원 가입</a>
</body>
</html>