<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>모의 면접</title>
	<script src="<c:url value="/resources/js/jquery-3.4.1.min.js"/>"></script>
	<script src="<c:url value='/resources/js/recorder.js'/>"></script>
<!--     <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous"> -->
<%--     <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/style2.css' />"> --%>
	<jsp:include page="../include/header.jsp"></jsp:include>
</head>

<meta charset="UTF-8">
<title>모의 면접 결과 보기</title>
<script src="<c:url value="/resources/js/jquery-3.4.1.min.js"/>"></script>
<script type="text/javascript">
// $(function(){
// 	var nullResult = document.getElementById("nullResult");
// 	var result = document.getElementById("result");
//  	var arr = ${list};
//  		console.log(arr);
//  	if(arr == null){
//  		nullResult.style.display = "block";
//  		result.style.display = "none";
// 	 } else {
//  		nullResult.style.display = "none";
//  		result.style.display = "block";
// 	 }
// });
</script>
</head>
<body>
<%-- <c:if test="${list == null }"> --%>
<!-- <div align="center" id="nullResult"> -->
<!-- 	<h1>진행된 모의 면접이 없습니다.</h1> -->
<!-- 	<h3>모의 면접 완료 후 다시 이용해 주세요.</h3> -->
<!-- 	<button type="button" onclick="location.href='getinterview'">모의 면접 시작</button> -->
<!-- </div> -->
<%-- </c:if> --%>
<%-- <c:if test="${list >= 1 }"> --%>
<div align="center" id="result">
	<table border="1">
		<thead>
			<tr align="center">
				<th colspan="4">모의면접 결과</th>
			</tr>
			<tr align="center">
				<th>날       짜</th>
				<th>질       문</th>
				<th>답변 성향</th>
				<th>다시 듣기</th>
			</tr>
		</thead>
	<tbody>
        <c:forEach items="${list}" var="item" varStatus="status">
			<c:if test="${status.index % 5 == 0}">
            	<th colspan="4"></th>
            	<tr align="center">
                </tr>
			</c:if>
            <tr align="center">
                <td>${item.inputdate}</td>
                <td>${item.question_text}</td>
                <td>${item.result}</td>
                <td>
                <audio src="<c:url value='/voice/${item.voicefilename}'/>" controls="controls"></audio>
                </td>
            </tr>
        </c:forEach>
	</tbody>
	</table>
</div>
<%-- </c:if> --%>

</body>
</html>
<jsp:include page="../include/footer.jsp"></jsp:include>