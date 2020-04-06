<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	멘토 목록
	<table>
	<c:forEach items="${requestScope.mentorList}" var="mentor">
		<tr>
			<th>멘토이름</th><td>${mentor.userName}</td>
			<th>멘토 아이디</th><td>${mentor.userID}</td>
			<td>
				<form action="msg_start" method="get">
					<input type="hidden" value="${sessionScope.userID}" name="mentee_id"> 
					<input type="hidden" value="${mentor.userID}" name="mentor_id">
					
					<input type="submit" value="연락하기">
				</form>
			</td>
		</tr>
	</c:forEach>
	</table>
</body>
</html>