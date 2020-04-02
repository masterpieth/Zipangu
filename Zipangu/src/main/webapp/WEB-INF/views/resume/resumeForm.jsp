<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이력서 작성</title>
<link rel="stylesheet" href="<c:url value='/resources/css/bootstrap.min.css' />">
<script src="<c:url value='/resources/js/jquery-3.4.1.min.js' />"></script>
<script src="<c:url value='/resources/js/popper.min.js' />"></script>
<script src="<c:url value='/resources/js/bootstrap.min.js' />"></script>
<style>
.container {
	position: relative;
}
.container>form>input, .container>form>textarea, #career>* , #qualified>* {
	position: absolute;
	background: transparent;
	font-size: 20px;
}
textarea {
	resize: none;
}
#writeYear {
	bottom: 3010px;
	right: 635px;
	width: 85px;
}
#writeMonth {
	bottom: 3010px;
	right: 580px;
	width: 65px;
}
#writeDay {
	bottom: 3010px;
	right: 527px;
	width: 65px;
}
#userName {
	bottom: 2910px;
	right: 460px;
	font-size: 30px;
	width: 390px;
}
#birthYear {
	bottom: 2814px;
	right: 865px;
	width: 85px;
}
#birthMonth {
	bottom: 2814px;
	right: 795px;
	width: 65px;
}
#birthDay {
	bottom: 2814px;
	right: 725px;
	width: 65px;
}
#age {
	bottom: 2814px;
	right: 595px;
	width: 65px;
}
#sex {
	bottom: 2814px;
	right: 470px;
	width: 65px;
}
#address {
	bottom: 2600px;
	right: 350px;
}
#phone {
	bottom: 2707px;
	right: 169px;
	width: 170px;
}
#eMail {
	bottom: 2580px;
	right: 170px;
}
#pic {
	position: absolute;
	bottom: 2840px;
	right: 214px;
	width: 180px;
	height: 240px;
}
#picFile {
	bottom: 2805px;
	right: 214px;
	width: 180px;
	font-size: 16px;
}
#addCareer {
	position: absolute;
	bottom: 2503px;
	right: 190px;
}
#deleteCareer {
	position: absolute;
	bottom: 2503px;
	right: 165px;
}
#addQualified {
	position: absolute;
	bottom: 1153px;
	right: 190px;
}
#deleteQualified {
	position: absolute;
	bottom: 1153px;
	right: 165px;
}
#hobbyNSkill {
	position: absolute;
	bottom: 500px;
	right: 160px;
}
#introduce {
	position: absolute;
	bottom: 145px;
	right: 160px;
}
#toServer {
	position: absolute;
	bottom: 70px;
	right: 600px;
}
#toFile {
	position: absolute;
	bottom: 70px;
	right: 400px;
}
</style>
</head>
<body>
	<div class="container" id="resume">
		<img src="<c:url value='/resources/img/resume_kor1.png' />" width="100%">
		<img src="<c:url value='/resources/img/resume_kor2.png' />" width="100%">
		<img id="pic">
		<form action="<c:url value='/resume/saveResume' />" id="resumeForm" method="post" enctype="multipart/form-data">
			<input type="file" class="form-control-file border" id="picFile" name="picFile">
			<input class="form-control" type="text" id="writeYear">
			<input class="form-control" type="text" id="writeMonth">
			<input class="form-control" type="text" id="writeDay">
			<input class="form-control" type="text" id="userName" value="${userName}">
			<input class="form-control" type="text" id="birthYear">
			<input class="form-control" type="text" id="birthMonth">
			<input class="form-control" type="text" id="birthDay">
			<input class="form-control" type="text" id="age">
			<input class="form-control" type="text" id="sex" value="${sex}">
			<textarea rows="3" cols="65" id="address" name="address">${address}</textarea>
			<input class="form-control" type="text" id="phone" value="${phone}">
			<textarea rows="2" cols="16" id="eMail"></textarea>
			<div id="career"></div>
			<button type="button" class="btn btn-success btn-sm" id="addCareer">+</button>
			<button type="button" class="btn btn-danger btn-sm" id="deleteCareer">-</button>
			<div id="qualified"></div>
			<button type="button" class="btn btn-success btn-sm" id="addQualified">+</button>
			<button type="button" class="btn btn-danger btn-sm" id="deleteQualified">-</button>
			<textarea rows="8" cols="87" id="hobbyNSkill" name="hobbyNSkill"></textarea>
			<textarea rows="10" cols="87" id="introduce" name="introduce"></textarea>
			<button type="button" class="btn btn-primary btn-lg" data-toggle="modal" id="toServer">서버에 저장</button>
			<button type="button" class="btn btn-secondary btn-lg" id="toFile">테두리 없애기</button>
			<div class="modal" id="inputTitle">
				<div class="modal-dialog modal-dialog-centered">
					<div class="modal-content">
						<div class="modal-header">
							<h4 class="modal-title">이력서 제목을 입력해 주세요.</h4>
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>
						<div class="modal-body"><input class="form-control" type="text" name="title" value="1"></div>
						<div class="modal-footer">
							<button type="submit" class="btn btn-primary">서버에 저장</button>
							<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
</body>
<script>
	$(function() {
		$('input, textarea').css('border', 'none');

		if (${empty correctedDate}) {
			var today = new Date();
			$('#writeYear').val(today.getFullYear());
			$('#writeMonth').val(today.getMonth() + 1);
			$('#writeDay').val(today.getDate());
		}

		var birth = '2020-04-01'.split('-');
		$('#birthYear').val(birth[0]);
		$('#birthMonth').val(Number(birth[1]));
		$('#birthDay').val(Number(birth[2]));

		var today = new Date();
		var year = String(today.getFullYear());
		var month = String(today.getMonth() + 1);
		if (month < 10)
			month = '0' + month;
		var day = today.getDate();
		if (day < 10)
			day = '0' + day;
		var today = Number(year + month + day);
		var birth = Number('1987-09-23'.replace(/-/g, ''));
		var age = String(today - birth);
		age = age.substr(0, age.length > 6 ? 3 : 2);
		$('#age').val(age); 

		$("#picFile").on('change', function() {
			if (this.files && this.files[0]) {
				var reader = new FileReader();
				reader.onload = function(e) {
					$('#pic').attr('src', e.target.result);
				}
				reader.readAsDataURL(this.files[0]);
			}
		});

		var eMail = 'test@test.com'.split('@');
		$('#eMail').text(eMail[0] + '\n@' + eMail[1]);

		var careerCount = 0;
		var careerBottom = 2405;
		$('#addCareer')
				.click(
						function() {
							if (careerCount > 10)
								alert('더 이상 추가할 수 없습니다.');
							else {
								var careerVal = [];
								$('#career>*').each(function(index, item) {
									careerVal[index] = $(this).val();
								});
								var career = $('#career').html();
								career += '<input class="form-control" type="text" name="careerStartYear" style="bottom:'
										+ (careerBottom + 50)
										+ 'px;right:880px;width:85px">';
								career += '<input class="form-control" type="text" name="careerStartMonth" style="bottom:'
										+ (careerBottom + 50)
										+ 'px;right:810px;width:65px">';
								career += '<input class="form-control" type="text" name="careerEndYear" style="bottom:' + careerBottom + 'px;right:880px;width:85px">';
								career += '<input class="form-control" type="text" name="careerEndMonth" style="bottom:' + careerBottom + 'px;right:810px;width:65px">';
								career += '<textarea class="form-control" rows="3" name="careerContent" style="bottom:' + careerBottom + 'px;right:160px;width:670px"></textarea>';
								$('#career').html(career);
								$('#career>*').each(function(index, item) {
									$(this).val(careerVal[index]);
								});
								++careerCount;
								careerBottom -= 100;
								if (careerCount === 8)
									careerBottom -= 217;
							}
						});

		$('#deleteCareer').click(function() {
			if (careerCount < 1)
				alert('삭제할 항목이 없습니다.');
			else {
				$($('#career>*').get().reverse()).each(function(index, item) {
					if (index < 5)
						$(this).remove();
				});
				--careerCount;
				careerBottom += 100;
				if (careerCount === 8)
					careerBottom += 217;
			}
		});

		var qualifiedCount = 0;
		var qualifiedBottom = 1106;
		$('#addQualified')
				.click(
						function() {
							if (qualifiedCount > 6) {
								alert('더 이상 추가할 수 없습니다.');
							} else {
								var qualifiedVal = [];
								$('#qualified>*').each(function(index, item) {
									qualifiedVal[index] = $(this).val();
								});
								var qualified = $('#qualified').html();
								qualified += '<input class="form-control" type="text" name="qualifiedYear" style="bottom:' + qualifiedBottom + 'px;right:880px;width:85px">';
								qualified += '<input class="form-control" type="text" name="qualifiedMonth" style="bottom:' + qualifiedBottom + 'px;right:810px;width:65px">';
								qualified += '<input class="form-control" type="text" name="qualifiedContent" style="bottom:' + qualifiedBottom + 'px;right:160px;width:670px">';
								$('#qualified').html(qualified);
								$('#qualified>*').each(function(index, item) {
									$(this).val(qualifiedVal[index]);
								});
								++qualifiedCount;
								qualifiedBottom -= 50;
							}
						});

		$('#deleteQualified').click(
				function() {
					if (qualifiedCount < 1)
						alert('삭제할 항목이 없습니다.');
					else {
						$($('#qualified>*').get().reverse()).each(
								function(index, item) {
									if (index < 3)
										$(this).remove();
								});
						--qualifiedCount;
						qualifiedBottom += 50;
					}
				});

		$('#toServer').click(function() {
			$('#toServer').removeAttr('data-target');
			var flag = true;
			$('input, textarea').each(function() {
				if ($(this).val().length < 1) {
					$(this).focus();
					alert("내용을 입력해 주세요.");
					flag = false;
					return false;
				}
			});
			if (flag) {
				$('input[name=careerStartYear], input[name=careerEndYear], input[name=qualifiedYear]').each(function() {
					if (isNaN($(this).val()) || $(this).val() < 1900) {
						$(this).focus();
						alert("올바른 년도를 입력해 주세요(ex: 1998).");
						flag = false;
						return false;
					}
				});
			}
			if (flag) {
				$('input[name=careerStartMonth], input[name=careerEndMonth], input[name=qualifiedMonth]').each(function() {
					if (isNaN($(this).val()) || $(this).val() < 1 || $(this).val() > 12) {
						$(this).focus();
						alert("01~12만 입력가능합니다.");
						flag = false;
						return false;
					} else if ($(this).val() < 10)
						$(this).val('0' + Number($(this).val()));
				});
			}
			if (flag)
				$('#toServer').attr('data-target', '#inputTitle');
		});

		$('#toFile').click(function() {
// 			$('button').css('visibility', 'hidden');
// 			$('#picFile').css('visibility', 'hidden');
		});
	});
</script>
</html>