<jsp:include page="/WEB-INF/views/include/header.jsp" />
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
	margin: 8px 0 0 -20px;
	vertical-align: middle;
}

.pagination {
	margin: 0 0 0 -20px;
}
</style>
<body>
<div class="container" style="height:100px;"></div>
<div class="container">
	<h2>조회하실 이력서를 선택하여 주세요.</h2>
	<form action="<c:url value="/resume/resumeForm" />" method="get" id="resumeList">
		<table class="table table-striped" border="1">
			<thead><tr>
				<th width="40%">제목</th>
				<th width="30%">작성일</th>
				<th width="30%">수정일</th>
			</tr></thead>
			<tbody id="tbody"></tbody>
			<tfoot>
				<tr><td colspan="3"><ul class="pagination justify-content-center">
					<li class="page-item"><button type="button" class="page-link" onclick="prevPage()">이전</button></li>
					<li class="page-item"><button type="button" class="page-link">1</button></li>
					<li class="page-item active"><button type="button" class="page-link">2</button></li>
					<li class="page-item"><button type="button" class="page-link">3</button></li>
					<li class="page-item"><button type="button" class="page-link" onclick="nextPage()">다음</button></li>
				</ul></td></tr>
			</tfoot>
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
<div class="container" style="height:100px;"></div>
</body>
<script>
var resumeList = [];

function prevPage() {
	var page = Number($('.pagination>.active').text());
	createPagination(page - 1);
};

function nextPage() {
	var page = Number($('.pagination>.active').text());
	createPagination(page + 1);
};

function createPagination(page) {
	var	pagination = '<li class="page-item"><button type="button" class="page-link" onclick="prevPage()"';
	if (page === 1)
		pagination += ' style="visibility:hidden;"'
	pagination += '>이전</button></li>';
	for (var i = page > 1 ? page - 1 : page; i < (resumeList.length - 1) / 5 + 1 && i < page + 2; i++) {
		pagination += '<li class="page-item';
		if (page === i)
			pagination += ' active';
		pagination += '"><button type="button" class="page-link" onclick="createPagination(';
		pagination += i + ')">' + i + '</button></li>';
	}
	pagination += '<li class="page-item"><button type="button" class="page-link" onclick="nextPage()"';
	if (page === resumeList.length / 5)
		pagination += ' style="visibility:hidden;"'
	pagination += '>다음</button></li>';
	$('.pagination').html(pagination);
	createResumeList(page);
};

function createResumeList(page) {
	var resumeListHtml = '';
	for (var i = (page - 1) * 5; i < resumeList.length && i < page * 5; i++) {
		resumeListHtml += '<tr><td style="text-align:left;">';
		resumeListHtml += '<div class="form-check">';
		resumeListHtml += '<label class="form-check-label" for="'; + resumeList[i].resume_num + '">';
		resumeListHtml += '<input type="radio" class="form-check-input" name="resume_num" ';
		resumeListHtml += 'id="' + resumeList[i].resume_num + '" value="' + resumeList[i].resume_num + '">';
		resumeListHtml += resumeList[i].title + '</label></div></td><td>' + resumeList[i].inputDate;
		resumeListHtml += '</td><td>' + resumeList[i].correctedDate + '</td></tr>';
	}
	$('#tbody').html(resumeListHtml);
};

$(function() {
	if (${empty resumeList}) {
		$('#updateResume').css('visibility', 'hidden');
		$('#tbody').html('<tr><td colspan="5" style="text-align:left;"><h4>작성된 이력서가 없습니다.</h4></td></tr>')
	}

	$('#updateResume').click(function() {
		if ($('input[name="resume_num"]').is(':checked'))
			$('#resumeList').submit();
		else
			alert('수정하실 이력서를 선택해 주세요.');
	});

	var resume;
	<c:forEach items="${resumeList}" var="resume">
		resume = {};
		resume.resume_num = '${resume.resume_num}';
		resume.userID = '${resume.userID}';
		resume.title = '${resume.title}';
		resume.inputDate = '${resume.inputDate}';
		resume.correctedDate = '${resume.correctedDate}';
		resumeList.push(resume);
	</c:forEach>
	createResumeList(1);
	createPagination(1);
});
</script>
</html>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />