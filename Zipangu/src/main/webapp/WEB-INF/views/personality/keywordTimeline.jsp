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
db에 저장된 성향분석 키워드 목록
<table>
<tr>
	<th>항목</th><th>퍼센트</th><th>선택</th>
</tr>
<c:forEach items="${requestScope.keywordList}" var="keyword">
<tr>
	<td>${keyword.trait}</td><td>${keyword.rate}</td><td><input type="checkbox" name="keyword_selected"></td>
</tr>
</c:forEach>

</table>
</body>
</html>