<jsp:include page="/WEB-INF/views/include/header.jsp" />
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보</title>
<link rel="stylesheet" href="<c:url value='/resources/template_css/bootstrap.min.css' />">
</head>
<body>
<div class="container" style="height:100px;"></div>
<div class="container col-7">
	<table class="table table-bordered">
		<thead>
			<tr>
				<th colspan="2" class="text-center font-weight-bolder">회원 정보</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td class="font-weight-bold bg-light" width="15%">아이디</td>
				<td>${member.userID}</td>
			</tr>
			<tr>
				<td class="font-weight-bold bg-light">비밀번호</td>
				<td>${member.userPwd}</td>
			</tr>
			<tr>
				<td class="font-weight-bold bg-light">이메일</td>
				<td>${member.email}</td>
			</tr>
			<tr>
				<td class="font-weight-bold bg-light">이름</td>
				<td>${member.userName}</td>
			</tr>
			<tr>
				<td class="font-weight-bold bg-light">생년월일</td>
				<td>${member.birth}</td>
			</tr>
			<tr>
				<td class="font-weight-bold bg-light">주소</td>
				<td>${member.address}</td>
			</tr>
			<tr>
				<td class="font-weight-bold bg-light">전화번호</td>
				<td>${member.phone}</td>
			</tr>
			<tr>
				<td class="font-weight-bold bg-light">성별</td>
				<td>${member.sex}</td>
			</tr>
			<tr>
				<td class="font-weight-bold bg-light">역할</td>
				<td>
					<c:choose>
						<c:when test="${member.authority eq 1}">멘토</c:when>
						<c:otherwise>멘티</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr>
				<td class="font-weight-bold bg-light">가입일</td>
				<td>${member.signupDate}</td>
			</tr>
		</tbody>
	</table>
	<div class="float-right">
		<a class="btn btn-info" href="<c:url value='/member/updateForm' />">회원 정보 수정</a>&nbsp;
		<button class="btn btn-secondary" data-toggle="modal" data-target="#withdrawForm">탈퇴</button>
	</div>
	<div class="modal" id="withdrawForm">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">비밀번호를 입력해 주세요.</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<div class="modal-body"><input type="password" class="form-control" id="userPwd"></div>
				<div class="modal-footer">
					<button type="button" class="btn btn-danger" data-dismiss="modal" id="withdraw">탈퇴</button>
					<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="container" style="height:100px;"></div>
</body>
<script>
function withdraw() {
	var userPwd = $('#userPwd').val();
	if (userPwd === '${member.userPwd}' && confirm('모든 정보가 삭제되고 복구가 불가능합니다.\n탈퇴하시겠습니까?')) {
		$.ajax({
			url : "<c:url value='/member/withdraw' />",
			type : "post",
			success : function(result) {
				if (result) {
					alert('탈퇴에 성공하였습니다.\n이용해 주셔서 감사합니다.');
					location.href = "<c:url value='/' />";
				} else
					alert('탈퇴에 실패하였습니다.\n다시 시도해 주세요.');
			},
			error : function(e) {
				console.log(e);
			}
		});
	} else
		alert('비밀번호가 일치하지 않습니다.');
};

$(function () {
	$('#withdraw').click(function() {
		withdraw();
	});
	$('#userPwd').keyup(function(key) {
		if (key.keyCode === 13)
			withdraw();
	});
});
</script>
</html>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />