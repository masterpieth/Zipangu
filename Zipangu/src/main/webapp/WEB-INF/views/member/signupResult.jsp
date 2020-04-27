<jsp:include page="/WEB-INF/views/include/header.jsp" />
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Zipangu</title>
<link rel="stylesheet" href="<c:url value='/resources/template_css/bootstrap.min.css' />">
</head>
<body>
<div class="container" style="height:100px;"></div>
<div class="jumbotron jumbotron-fluid">
	<div class="container">
		<c:choose>
			<c:when test="${empty userID}">
				<h1>
					가입에 실패하였습니다.
					<br>
					다시 시도해 주세요.
				</h1>
				<br>
				<p>지속적으로 실패할 경우 관리자에게 문의해 주세요.</p>
			</c:when>
			<c:otherwise>
				<h1>
					${userID}님
					<br>
					가입을 환영합니다.
				</h1>
				<br>
				<p>잠시 후 메인 화면으로 이동합니다.</p>
			</c:otherwise>
		</c:choose>
		<h1></h1>
		<p></p>
	</div>
</div>
<div class="container" style="height:100px;"></div>
</body>
<script>
$(function() {
	if (${empty userID})
		setTimeout(function() { location.href = '<c:url value="/member/signupForm" />' }, 5000);
	else
		setTimeout(function() { location.href = '<c:url value="/" />' }, 5000);
});
</script>
</html>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />