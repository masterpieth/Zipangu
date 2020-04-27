<jsp:include page="/WEB-INF/views/include/header.jsp" />
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Zipangu</title>
<link rel="stylesheet" href="<c:url value='/resources/template_css/bootstrap.min.css' />">
<style>
.valid-message {
	width:100%;
	margin-top:.25rem;
	font-size:80%;
}
</style>
<script src="https://togetherjs.com/togetherjs-min.js"></script>
</head>
<body>
<div class="container" style="height:100px;"></div>
<div class="container col-sm-3">
	<h3>Zipangu에 오신 것을 환영합니다.</h3><br>
	<p>회원 가입을 위한 정보를 입력해 주세요.</p>
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
			<label for="email">이메일:</label>
			<input type="email" class="form-control" id="email" placeholder="이메일을 입력하세요." name="email" required>
			<div class="valid-message" id="emailMessage">이메일을 입력해 주세요.</div>
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
		<div class="row">
			<div class="form-group col-6">
				<label for="sex">성별:</label>
				<select class="form-control" id="sex" name="sex" required>
					<option value="">선택</option>
					<option value="남성">남성</option>
					<option value="여성">여성</option>
				</select>
				<div class="valid-message" id="sexMessage">성별을 골라 주세요.</div>
			</div>
			<div class="form-group col-6">
				<label for="sex">역할:</label>
				<select class="form-control" id="authority" name="authority" required>
					<option>선택</option>
					<option value="1">멘토</option>
					<option value="2">멘티</option>
				</select>
				<div class="valid-message" id="sexMessage">당신의 역할을 골라 주세요.</div>
			</div>
		</div>
		<br>
		<div align="center">
		<button type="submit" class="genric-btn danger e-large" id="signupBtn" onclick="return signup()">가입하기</button>
		</div>
	</form>
</div>
<div class="container" style="height:100px;"></div>
</body>
<script>
TogetherJSConfig_hubBase = "https://togetherjs-hub.glitch.me/";
var checkID, checkPwd, checkEmail, checkUserName, checkBirth, checkAddress, checkPhone, checkSex, checkAuthority;
checkID = checkPwd = checkEmail = checkUserName = checkBirth = checkAddress = checkPhone = checkSex = checkAuthority = false;

function signup() {
	return checkID && checkPwd && checkEmail && checkUserName && checkBirth && checkAddress && checkPhone && checkSex && checkAuthority;
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

	$('#email').keyup(function() {
		var email = $('#email').val();
		var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		if (regExp.test(email)) {
			$('#emailMessage').css('color', '#28a745');
			checkEmail = true;
		} else {
			$('#emailMessage').css('color', '#dc3545');
			checkEmail = false;
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

	$('#authority').on('keyup click', function() {
		var authority = $('#authority').val();
		if (authority.length > 0) {
			$('#sexMessage').css('color', '#28a745');
			checkAuthority = true;
		} else {
			$('#sexMessage').css('color', '#dc3545');
			checkAuthority = false;
		}
	});

});
</script>
</html>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />