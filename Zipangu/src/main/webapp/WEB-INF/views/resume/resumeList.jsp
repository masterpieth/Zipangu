<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이력서 조회</title>
</head>
<body>
<div class="container">
	<h2>조회하실 이력서를 선택하여 주세요.</h2>
	<table class="table table-striped">
		<thead><tr>
			<th></th>
			<th>제목</th>
			<th>작성일</th>
			<th>수정일</th>
		</tr></thead>
		<tbody>
		<c:forEach items="${resumeList}" var="resume">
			<tr><div class="form-check">
				<td><input type="radio" class="form-check-input" value="${resume.resume_num}" id="${resume.resume_num}"></td>
				<label class="form-check-label" for="${resume.resume_num}">
				<td>${resume.title}</td>
				<td>${resume.inputDate}</td>
				<td>${resume.correctedDate}</td>
				</label>
			</div></tr>
		</c:forEach>
		</tbody>
		<tfoot><button type="button" class="btn btn-primary">조회하기</button></tfoot>
	</table>
</div>
</body>
</html>