<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>voice</title>
	<script src="<c:url value="/resources/js/jquery-3.4.1.min.js"/>"></script>
	<script src="<c:url value='/resources/js/recorder.js'/>"></script>
<!--     <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous"> -->
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/style2.css' />">
	<jsp:include page="../include/header.jsp"></jsp:include>
</head>

<meta charset="UTF-8">
<title>모의 면접 결과 보기</title>
<script src="<c:url value="/resources/js/jquery-3.4.1.min.js"/>"></script>
</head>
<body>
<div align="center">
	<table border="1">
		<thead>
			<tr align="center">
				<th colspan="4">모의면접 결과</th>
			</tr>
			<tr align="center">
				<th>날씨</th>
				<th>질문</th>
				<th>성향</th>
				<th>듣기</th>
			</tr>
		</thead>
	<tbody>
        <c:forEach items="${list}" var="item" varStatus="status">
			<c:if test="${status.index % 5 == 0}">
            	<th colspan="4"></th>
            	<tr align="center">
        		    <td>${item.inputdate}</td>
	                <td>${item.question_text}</td>
	                <td>${item.result}</td>
	                <td>${item.voicefilename}</td>
                </tr>
			</c:if>
	            <tr align="center">
	                <td>${item.inputdate}</td>
	                <td>${item.question_text}</td>
	                <td>${item.result}</td>
	                <td>${item.voicefilename}</td>
	            </tr>
        </c:forEach>
	</tbody>
	</table>
</div>


</body>
</html>
<jsp:include page="../include/footer.jsp"></jsp:include>