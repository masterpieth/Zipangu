<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
	<title>Zipangu</title>
	<script src="<c:url value="/resources/js/jquery-3.4.1.min.js"/>"></script>
	<script src="<c:url value='/resources/js/recorder.js'/>"></script>
	<link type="text/css" rel="stylesheet" href="<c:url value='/resources/css/interview.css'/>">
	<jsp:include page="../include/header.jsp"></jsp:include>
</head>

<meta charset="UTF-8">
<title>모의 면접 결과 보기</title>
<script src="<c:url value="/resources/js/jquery-3.4.1.min.js"/>"></script>
</head>
<body>
    <section class="banner_area">
        <div class="banner_inner overlay d-flex align-items-center">
            <div class="container">
                <div class="banner_content text-center">
                    <div class="page_link">
                        <a href="<c:url value="/"/>">메인페이지
                        </a>
                        <a href="<c:url value="/interview/getinterviewResult"/>">결과조회</a>
                    </div>
                    <h2>모의면접 결과조회</h2>
                </div>
            </div>
        </div>
    </section>
	<c:choose>
		<c:when test="${fn:length(list) == 0}">
			<div align="center" id="nullResult">
				<div class="space"></div>
					<h1>모의 면접 결과가 없습니다.</h1>
					<div class="space"></div>
					<h3>모의 면접 완료 후 다시 이용해 주세요.</h3>
					<button type="button" onclick="location.href='getinterview'" class="btn btn-danger">모의 면접 시작</button>
				<div class="space"></div>
			</div>
		</c:when>
		
		<c:when test="${fn:length(list) > 0}">
			<div class="space"></div>
	<div id="result" >
		<table class="table table-hover">
			<thead>
				<tr align="center">
					<th colspan="4" align="center">
						<h2>모의면접 결과</h2>
					</th>
				</tr>
				<tr id="graph" align="center">
					<th id="graph">날       짜 </th>
					<th id="graph">질       문</th>
					<th id="graph">답변 성향</th>
					<th>다시 듣기</th>
				</tr>
			</thead>
		<tbody align="center">
	        <c:forEach items="${list}" var="item" varStatus="status">
				<c:if test="${status.index % 5 == 0}">
	            	<th colspan="4"></th>
	            		
				</c:if>
	            <tr>
	                <td valign="middle">${item.inputdate}</td>
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
		</c:when>
	</c:choose>
</body>
</html>
<jsp:include page="../include/footer.jsp"></jsp:include>