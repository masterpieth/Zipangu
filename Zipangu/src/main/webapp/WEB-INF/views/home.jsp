<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>Zipangu</title>
</head>
<body>
<h1>
	Hello world!  
</h1>
<P>  The time on the server is ${serverTime}. </P>
${sessionScope.authority }
<h3><a href="<c:url value='/member/loginTemp' />">임시 로그인 페이지</a></h3>
<h3><a href="<c:url value='/member/logoutTemp' />">로그아웃</a></h3>
<h3>${sessionScope.userID} : 지금 접속해 있는 사람</h3>
<h3><a href="<c:url value='/personality/personalityInsight'/>">성향분석페이지로 이동</a></h3>
<h3><a href="<c:url value='/personality/keywordTimeline'/>">성향분석에서 선택한 키워드에 관한 에피소드를 작성하고 타임라인 형식으로 조회할 수 있는 페이지</a></h3>

<c:if test="${sessionScope.authority=='2'}">
<h3><a href="<c:url value='/msg/msg_main'/>">멘티로 로그인 했을 때만 보임: 멘토리스트 + 선택하면 대화창으로(msg_read)</a></h3>
</c:if>
<a href="<c:url value='/member/signupForm' />">회원 가입</a>

<a href="<c:url value='/header' />">헤더확인</a>
<a href="<c:url value='/footer' />">푸터확인</a>
<a href="<c:url value='/maintemp' />">메인화면(작업중)</a>
</body>
</html>