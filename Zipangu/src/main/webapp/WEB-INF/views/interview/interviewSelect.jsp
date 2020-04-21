<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모의 면접 결과 보기</title>
</head>
<body>


<div align="center">
	<table border="1">
	<thead>
	   <tr align ="center">
			<td colspan="4">모의면접 결과</td>
	   </tr>
	   <tr align="center">
			<th rowspan="6" align="center">날짜</th>
			<th>질문</th>
			<th>답변 성향</th>
			<th>다시 듣기</th>
	   </tr>
   </thead>
   <tbody id="tbody">
		<c:forEach items="${list}" var="item">
			<tr>
				<td>${item.question_num}</td>
				<td>${item.voiceFileName}</td>
				<td>${item.result}</td>
			</tr>
		</c:forEach>
	</tbody>
	 </table>
</div>

</body>
</html>