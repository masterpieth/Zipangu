<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입</title>
<link rel="stylesheet" href="<c:url value='/resources/css/bootstrap.min.css' />">
<script src="<c:url value='/resources/js/jquery-3.4.1.min.js' />"></script>
<script src="<c:url value='/resources/js/popper.min.js' />"></script>
<script src="<c:url value='/resources/js/bootstrap.min.js' />"></script>
<style>
.valid-message {
	width:100%;
	margin-top:.25rem;
	font-size:80%;
}
</style>
</head>
<body>
	<div class="container">
		<h2>Form Validation</h2>
		<p>
			In this example, we use
			<code>.needs-validation</code>
			, which will add the validation effect AFTER the form has been submitting (if there's anything missing).
		</p>
		<p>Try to submit this form before filling out the input fields, to see the effect.</p>
		<form action="<c:url value='/member/signup' />" class="needs-validation" method="post" novalidate>
			<div class="form-group">
				<label for="userID">아이디:</label>
				<input type="text" class="form-control" id="userID" placeholder="사용하실 아이디를 입력하세요." name="userID" required>
				<div class="valid-message" id="userIDMessage">사용하실 아이디를 입력해 주세요.</div>
			</div>
			<div class="form-group">
				<label for="userPwd">비밀번호:</label>
				<input type="password" class="form-control" id="userPwd" placeholder="비밀번호를 입력하세요." name="userPwd" required>
				<div class="valid-message" id="userPwdMessage">비밀번호를 8자리 이상 입력해 주세요.</div>
			</div>
			<div class="form-group">
				<label for="pwdCheck">비밀번호 확인:</label>
				<input type="password" class="form-control" id="pwdCheck" placeholder="비밀번호를 다시 입력하세요." required>
				<div class="valid-message" id="pwdCheckMessage">동일한 비밀번호를 입력해 주세요.</div>
			</div>
			<div class="form-group">
				<label for="eMail">이메일:</label>
				<input type="email" class="form-control" id="eMail" placeholder="이메일을 입력하세요." name="eMail" required>
				<div class="valid-message" id="eMailMessage">이메일을 입력해 주세요.</div>
			</div>
			<div class="form-group">
				<label for="userName">이름:</label>
				<input type="text" class="form-control" id="userName" placeholder="이름을 입력하세요." name="userName" required>
				<div class="valid-message" id="userNameMessage">이름을 입력해 주세요.</div>
			</div>
			<div class="form-group">
				<label for="birth">생년월일:</label>
				<input type="date" min="1970-01-01" max="2002-12-31" class="form-control" id="birth" placeholder="생년월일을 입력하세요." name="birth" required>
				<div class="valid-message" id="birthMessage">생년월일을 입력해 주세요.</div>
			</div>
			<div class="form-group">
				<label for="address">주소:</label>
				<input type="text" class="form-control" id="address" placeholder="주소를 입력하세요." name="address" required>
				<div class="valid-message" id="addressMessage">주소를 입력해 주세요.</div>
			</div>
			<div class="form-group">
				<label for="phone">전화번호:</label>
				<input type="tel" class="form-control" id="phone" placeholder="전화번호를 입력하세요." name="phone" required>
				<div class="valid-message" id="phoneMessage">전화번호를 입력해 주세요.</div>
			</div>
			<div class="form-group">
				<label for="sex">성별:</label>
				<select class="form-control" id="sex" name="sex" required>
					<option></option>
					<option value="male">남성</option>
					<option value="female">여성</option>
				</select>
				<div class="valid-message" id="sexMessage">성별을 골라 주세요.</div>
			</div>
			<button type="submit" class="btn btn-primary" id="signupBtn" onclick="return signup()">가입하기</button>
		</form>
	</div>
</body>
<script>
var checkID, checkPwd, checkEMail, checkUserName, checkBirth, checkAddress, checkPhone, checkSex;
checkID = checkPwd = checkEMail = checkUserName = checkBirth = checkAddress = checkPhone = checkSex = false;

function signup() {
	return checkID && checkPwd && checkEMail && checkUserName && checkBirth && checkAddress && checkPhone && checkSex;
}

$(function() {
	$('#userID').keyup(function() {
		var userID = $('#userID').val();
		if (userID.length > 0) {
			$.ajax({
				url : "<c:url value='/member/checkID' />",
				type : "get",
				data : {
					userID : userID
				},
				success : function(result) {
					if (result) {
						$('#userIDMessage').css('color', '#dc3545');
						$('#userIDMessage').text('사용할 수 없는 아이디입니다.');
						checkID = false;
					} else {
						$('#userIDMessage').css('color', '#28a745');
						$('#userIDMessage').text('사용 가능한 아이디입니다.');
						checkID = true;
					}
				},
				error : function(e) {
					console.log(e);
				}
			});
		} else {
			$('#userIDMessage').css('color', '#dc3545');
			$('#userIDMessage').text('사용하실 아이디를 입력해 주세요.');
			checkID = false;
		}
	});

	$('#userPwd, #pwdCheck').keyup(function() {
		var userPwd = $('#userPwd').val();
		var pwdCheck = $('#pwdCheck').val();

		if (userPwd.length < 8)
			$('#userPwdMessage').css('color', '#dc3545');
		else
			$('#userPwdMessage').css('color', '#28a745');

		if (pwdCheck.length > 0 && userPwd === pwdCheck) {
			$('#pwdCheckMessage').css('color', '#28a745');
			checkPwd = true;
		} else {
			$('#pwdCheckMessage').css('color', '#dc3545');
			checkPwd = false;
		}
	});

	$('#eMail').keyup(function() {
		var eMail = $('#eMail').val();
		var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		if (regExp.test(eMail)) {
			$('#eMailMessage').css('color', '#28a745');
			checkEMail = true;
		} else {
			$('#eMailMessage').css('color', '#dc3545');
			checkEMail = false;
		}
	});

	$('#userName').keyup(function() {
		var userName = $('#userName').val();
		if (userName.length > 0) {
			$('#userNameMessage').css('color', '#28a745');
			checkUserName = true;
		} else {
			$('#userNameMessage').css('color', '#dc3545');
			checkUserName = false;
		}
	});

	$('#birth').on('keyup click', function() {
		var birth = $('#birth').val();
		if (birth.length > 9) {
			$('#birthMessage').css('color', '#28a745');
			checkBirth = true;
		} else {
			$('#birthMessage').css('color', '#dc3545');
			checkBirth = false;
		}
	});

	$('#address').keyup(function() {
		var address = $('#address').val();
		if (address.length > 0) {
			$('#addressMessage').css('color', '#28a745');
			checkAddress = true;
		} else {
			$('#addressMessage').css('color', '#dc3545');
			checkAddress = false;
		}
	});

	$('#phone').keyup(function() {
		var phone = $('#phone').val().replace(/-/g, '');
		if (phone.length > 8 && !isNaN(phone)) {
			$('#phoneMessage').css('color', '#28a745');
			checkPhone = true;
		} else {
			$('#phoneMessage').css('color', '#dc3545');
			checkPhone = false;
		}
	});

	$('#sex').on('keyup click', function() {
		var sex = $('#sex').val();
		if (sex.length > 0) {
			$('#sexMessage').css('color', '#28a745');
			checkSex = true;
		} else {
			$('#sexMessage').css('color', '#dc3545');
			checkSex = false;
		}
	});
});
</script>
</html>