<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp"></jsp:include>
<head>
<title>이력서 조회</title>
<link rel="stylesheet" href="<c:url value='/resources/template_css/bootstrap.min.css' />">
<%-- <script src="<c:url value='/resources/js/togetherjs-min.js' />"></script> --%>
</head>
<style>
th, td {
	text-align: center;
	font-size: 120%;
}

input[type="radio"] {
	margin: 10px 0 0 -20px;
	vertical-align: middle;
}
</style>
<body>
<div class="container">
	<h2>조회하실 이력서를 선택하여 주세요.</h2>
	<form action="<c:url value="/resume/resumeForm" />" method="get" id="resumeList">
		<table class="table table-striped" border="1">
			<thead><tr>
				<th width="40%">제목</th>
				<th width="30%">작성일</th>
				<th width="30%">수정일</th>
			</tr></thead>
			<tbody id="tbody">
			<c:forEach items="${resumeList}" var="resume">
				<tr>
					<td style="text-align:left;"><div class="form-check">
						<label class="form-check-label" for="${resume.resume_num}">
							<input type="radio" class="form-check-input" name="resume_num" id="${resume.resume_num}" value="${resume.resume_num}">
							${resume.title}
						</label>
					</div></td>
					<td>${resume.inputDate}</td>
					<td>${resume.correctedDate}</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
	</form>
		<button type="button" class="btn btn-primary float-right" data-toggle="modal" data-target="#inputTitle">새 이력서</button>
		<p class="float-right">&nbsp;&nbsp;</p>
		<button type="button" class="btn btn-info float-right" id="updateResume">수정하기</button>
		<div class="modal" id="inputTitle">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title">이력서 제목을 입력해 주세요.</h4>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
					<form action="<c:url value='/resume/resumeForm' />" method="get">
						<div class="modal-body">
								<input class="form-control" type="text" name="title" required>
								<input type="hidden" name="resume_num" value="-1">
						</div>
						<div class="modal-footer">
							<button type="submit" class="btn btn-danger">작성</button>
							<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
						</div>
					</form>
				</div>
			</div>
		</div>
</div>
</body>
<script>
$(function() {
	if (${empty resumeList}) {
		$('#updateResume').css('visibility', 'hidden');
		$('#tbody').html('<tr><td colspan="5"><h4 style="text-align:center;">작성된 이력서가 없습니다.</h4></td></tr>')
	}

	$('#updateResume').click(function() {
		if ($('input[name="resume_num"]').is(':checked'))
			$('#resumeList').submit();
		else
			alert('수정하실 이력서를 선택해 주세요.');
	});
});
</script>
<jsp:include page="../include/footer.jsp"></jsp:include>