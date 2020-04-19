<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<c:if test="${requestScope.result == false}">
	<script>alert("ID 또는 암호가 일치하지 않습니다");</script>
</c:if>
</head>
<body>

<h1>로그인</h1>
<form action="<c:url value='/member/login' />" method="post">
	<table>
		<tr>
			<th>ID</th>
			<td><input type="text" name="userID" required="required"></td>
		</tr>
		<tr>
			<th>암호</th>
			<td><input type="password" id="userPwd" name="userPwd" required="required"></td>
		</tr>
		<tr>
			<th colspan="2">
				<input type="submit" value="로그인" >
			</th>
		</tr>
	</table>
</form>

</body>
</html>
