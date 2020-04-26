<jsp:include page="/WEB-INF/views/include/header.jsp" />
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 변경</title>
<link rel="stylesheet" href="<c:url value='/resources/template_css/bootstrap.min.css' />">
</head>
<body>
<div class="container" style="height:100px;"></div>
<div class="container col-7">
	<table class="table table-bordered">
		<thead><tr><th colspan="2" class="text-center font-weight-bolder">회원 정보 수정</th></tr></thead>
		<tbody>
			<tr>
				<td class="font-weight-bold bg-light" width="15%">아이디</td>
				<td><input type="text" class="form-control w-50" value="${member.userID}" disabled></td>
			</tr>
			<tr>
				<td class="font-weight-bold bg-light">이름</td>
				<td><input type="text" class="form-control w-50" id="userName" value="${member.userName}"></td>
			</tr>
			<tr>
				<td class="font-weight-bold bg-light">이메일</td>
				<td><input type="text" class="form-control w-50" id="email" value="${member.email}"></td>
			</tr>
			<tr>
				<td class="font-weight-bold bg-light">주소</td>
				<td><input type="text" class="form-control" id="address" value="${member.address}"></td>
			</tr>
			<tr>
				<td class="font-weight-bold bg-light">전화번호</td>
				<td><input type="text" class="form-control w-25" id="phone" value="${member.phone}"></td>
			</tr>
			<tr>
				<td class="font-weight-bold bg-light">성별</td>
				<td>
					<select class="form-control w-25" id="sex">
						<option value="남성" <c:if test="${member.sex eq '남성'}">selected</c:if>>남성</option>
						<option value="여성" <c:if test="${member.sex eq '여성'}">selected</c:if>>여성</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="font-weight-bold bg-light">역할</td>
				<td>
					<select class="form-control w-25" id="authority">
						<option value="1" <c:if test="${member.authority eq 1}">selected</c:if>>멘토</option>
						<option value="2" <c:if test="${member.authority eq 2}">selected</c:if>>멘티</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="font-weight-bold bg-light">현재 비밀번호</td>
				<td><input type="password" class="form-control" name="userPwd" id="userPwd"></td>
			</tr>
			<tr>
				<td class="font-weight-bold bg-secondary" id="new1">새 비밀번호</td>
				<td><input type="password" class="form-control" name="userPwd" id="newUserPwd" disabled></td>
			</tr>
			<tr>
				<td class="font-weight-bold bg-secondary" id="new2">새 비밀번호 확인</td>
				<td><input type="password" class="form-control" id="newUserPwdCheck" disabled></td>
			</tr>
		</tbody>
	</table>
	<div class="float-right">
		<button type="button" class="btn btn-info" id="changePwd">비밀번호 변경</button>
		<button type="button" class="btn btn-warning" id="update">수정하기</button>
	</div>
</div>
<div class="container" style="height:100px;"></div>
</body>
<script>
$(function() {
	var changePwd = false;
	$('#changePwd').click(function() {
		if (changePwd) {
			$(this).text('비밀번호 변경');
			$(this).attr('class', 'btn btn-info');
			$('#userPwd').attr('name', 'userPwd');
			$('#newUserPwd').val('');
			$('#newUserPwd').attr('disabled', 'disabled');
			$('#new1').attr('class', 'font-weight-bold bg-secondary');
			$('#newUserPwdCheck').val('');
			$('#newUserPwdCheck').attr('disabled', 'disabled');
			$('#new2').attr('class', 'font-weight-bold bg-secondary');
		} else {
			$(this).text('변경 취소하기');
			$(this).attr('class', 'btn btn-danger');
			$('#userPwd').removeAttr('name');
			$('#newUserPwd').removeAttr('disabled');
			$('#new1').attr('class', 'font-weight-bold bg-light');
			$('#newUserPwdCheck').removeAttr('disabled');
			$('#new2').attr('class', 'font-weight-bold bg-light');
		}
		changePwd = !changePwd;
	});

	$('#update').click(function() {
		var userName = $('#userName').val();
		if (userName.length < 1) {
			$('#userName').focus();
			alert('이름을 입력해 주세요.');
			return;
		}
		var email = $('#email').val();
		if (email.length < 1) {
			$('#email').focus();
			alert('이메일을 입력해 주세요.');
			return;
		} else {
			var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
			if (!regExp.test(email)) {
				$('#email').select();
				alert('이메일 주소가 올바르지 않습니다');
				return;
			}
		}
		var address = $('#address').val();
		if (address.length < 1) {
			$('#address').focus();
			alert('주소 입력해 주세요.');
			return;
		}
		var phone = $('#phone').val();
		if (phone.length < 1) {
			$('#phone').focus();
			alert('전화번호를 입력해 주세요.');
		} else {
			var phoneNum = phone.replace(/-/g, '');
			if (phoneNum.length < 10 || isNaN(phoneNum)) {
				$('#phone').select();
				alert('전화번호가 올바르지 않습니다.');
				return;
			}
		}
		if (changePwd) {
			var newUserPwd = $('#newUserPwd').val();
			if (newUserPwd.length < 8) {
				$('#newUserPwd').focus();
				alert('8자리 이상을 입력해 주세요.');
				return;
			} else if (newUserPwd !== $('#newUserPwdCheck').val()) {
				$('#newUserPwdCheck').select();
				alert('비밀번호가 동일하지 않습니다');
				return;	
			}
		}
		var userPwd = $('#userPwd').val();
		if (userPwd.length < 1) {
			$('#userPwd').focus();
			alert('비밀번호를 입력해 주세요.');
			return;
		} else if (userPwd !== '${member.userPwd}') {
			$('#userPwd').select();
			alert('비밀번호가 다릅니다.');
			return;
		}
		$.ajax({
			url : "<c:url value='/member/update' />",
			type : "post",
			data : {
				userPwd : changePwd ? $('#newUserPwd').val() : userPwd,
				userName : userName,
				email : email,
				address : address,
				phone : phone,
				sex : $('#sex option:selected').val(),
				authority : $('#authority option:selected').val()
			},
			success : function(result) {
				if (result) {
					alert('수정되었습니다.');
					location.href = "<c:url value='/member/myPage' />";
				} else
					alert('수정에 실패하였습니다.');
			},
			error : function(e) {
				console.log(e);
			}
		});
	});
});
</script>
</html>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />