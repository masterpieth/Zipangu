<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이력서 조회</title>
<link rel="stylesheet" href="<c:url value='/resources/css/bootstrap.min.css' />">
<script src="<c:url value='/resources/js/jquery-3.4.1.min.js' />"></script>
<script src="<c:url value='/resources/js/popper.min.js' />"></script>
<script src="<c:url value='/resources/js/bootstrap.min.js' />"></script>
</head>
<body>
<div class="container">
	<h2>조회하실 이력서를 선택하여 주세요.</h2>
	<table class="table table-striped" border="1">
		<thead><tr>
			<th></th>
			<th>제목</th>
			<th>작성일</th>
			<th>수정일</th>
		</tr></thead>
		<tbody id="tbody">
		<c:forEach items="${resumeList}" var="resume">
			<tr>
				<td><div class="form-check"><input type="radio" class="form-check-input" name="resume_num" value="${resume.resume_num}"></div></td>
				<td><label class="form-check-label" for="${resume.resume_num}">${resume.title}</label></td>
				<td><label class="form-check-label" for="${resume.resume_num}">${resume.inputDate}</label></td>
				<td><label class="form-check-label" for="${resume.resume_num}">${resume.correctedDate}</label></td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<button type="button" class="btn btn-info float-right" id="updateResume">수정하기</button>
	<p class="float-right">&nbsp;&nbsp;</p>
	<button type="button" class="btn btn-primary float-right" id="newResume" onclick="newResume()">새 이력서</button>
</div>
</body>
<script>
function newResume() {
	$(location).attr('href', '<c:url value="/resume/resumeForm?resume_num=-1" />');
};

function updateResume() {
	var resume_num = $('input[name="resume_num"]:checked').val();
	$(location).attr('href', '<c:url value="/resume/resumeForm?resume_num=' + resume_num + '" />');
};
</script>
</html>