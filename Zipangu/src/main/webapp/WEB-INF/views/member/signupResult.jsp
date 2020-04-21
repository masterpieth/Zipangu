<jsp:include page="/WEB-INF/views/include/header.jsp" />
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입 결과</title>
<link rel="stylesheet" href="<c:url value='/resources/css/bootstrap.min.css' />">
<script src="<c:url value='/resources/js/jquery-3.4.1.min.js' />"></script>
<script src="<c:url value='/resources/js/popper.min.js' />"></script>
<script src="<c:url value='/resources/js/bootstrap.min.js' />"></script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<div class="jumbotron jumbotron-fluid">
		<div class="container">
			<c:choose>
				<c:when test="${sessionScope.userID == null}">
					<h1>가입에 실패하였습니다.<br>다시 시도해 주세요.</h1>
					<p>지속적으로 실패할 경우 관리자에게 문의해 주세요.</p>
				</c:when>
				<c:otherwise>
					<h1>${sessionScope.userID}님<br>가입을 환영합니다.</h1>
					<p>잠시 후 메인 화면으로 이동합니다.</p>
				</c:otherwise>
			</c:choose>
			<h1></h1>
			<p></p>
		</div>
	</div>
</body>
<script>
$(function() {
	if (${sessionScope.userID == null})
		setTimeout(function() { $(location).attr('href', '<c:url value="/member/signupForm" />') }, 5000);
	else
		setTimeout(function() { $(location).attr('href', '<c:url value="/" />') }, 5000);
});
</script>
</html>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />