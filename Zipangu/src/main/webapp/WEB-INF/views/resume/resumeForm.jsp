<jsp:include page="/WEB-INF/views/include/header.jsp" />
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
<title>이력서 작성</title>
<link rel="stylesheet" href="/zipangu/resources/template_css/bootstrap.min.css">
<link rel="stylesheet" href="/zipangu/resources/css/resumeForm.css">
</head>
<body>

    <section class="banner_area ">
        <div class="banner_inner overlay d-flex align-items-center">
            <div class="container">
                <div class="banner_content text-center">
                    <div class="page_link">
                        <a href="<c:url value="/"/>">메인페이지
                        </a>
                        <a href="<c:url value="/resume/resumeForm"/>">이력서 작성</a>
                    </div>
                </div>
                <div class="banner_content text-center">
                    <h2>이력서 작성</h2>
                </div>
            </div>
        </div>
    </section>

<div class="sidenav fixed-right">
	<button type="button" class="btn btn-warning btn-lg" onclick="TogetherJS(this); return false;" id="startMentoring">멘토링</button><br><br>
	<button type="button" class="btn btn-secondary btn-lg" id="border">테두리 없애기</button><br><br>
	<button type="button" class="btn btn-info btn-lg" id="language">日本語</button><br><br>
	<button type="button" class="btn btn-primary btn-lg" data-toggle="modal" id="checkResume">이력서 저장</button>
</div>
<form action="<c:url value='/resume/saveResume' />" method="post" enctype="multipart/form-data" id="resumeForm">
	<div class="container" id="resume">
		<img src="<c:url value='/resources/img/resume_kor1.png' />" width="100%" id="resume1">
		<img src="<c:url value='/resources/img/resume_kor2.png' />" width="100%" id="resume2">
		<img id="pic">
		<input type="file" class="form-control-file border" name="picFile" id="picFile">
		<input type="hidden" name="picFileName" value="${resume.picFileName}">
		<input type="hidden" name="resume_num" id="resume_num">
		<input type="text" class="form-control" name="inputYear" id="inputYear">
		<input type="text" class="form-control" name="inputMonth" id="inputMonth">
		<input type="text" class="form-control" id="inputDay">
		<input type="hidden" class="form-control" name="inputDate" id="inputDate">
		<input type="text" class="form-control" name="userName" id="userName" value="${member.userName}">
		<input type="text" class="form-control" name="birthYear" id="birthYear">
		<input type="text" class="form-control" name="birthMonth" id="birthMonth">
		<input type="text" class="form-control" id="birthDay">
		<input type="hidden" class="form-control" name="birth" id="birth" value="${member.birth}">
		<input type="text" class="form-control" name="age" id="age">
		<input type="text" class="form-control" name="sex" id="sex" value="${member.sex}">
		<textarea rows="3" cols="67" name="address" id="address">${member.address}</textarea>
		<input type="text" class="form-control" name="phone" id="phone" value="${member.phone}">
		<textarea rows="2" cols="16" name="email" id="email">${member.email}</textarea>
		<button type="button" class="btn btn-success btn-sm" id="addCareer">+</button>
		<button type="button" class="btn btn-danger btn-sm" id="deleteCareer">-</button>
		<div id="career"></div>
		<input type="hidden" name="careerJSON" id="careerList">
		<button type="button" class="btn btn-success btn-sm" id="addQualified">+</button>
		<button type="button" class="btn btn-danger btn-sm" id="deleteQualified">-</button>
		<div id="qualified"></div>
		<input type="hidden" name="qualifiedJSON" id="qualifiedList">
		<textarea rows="8" cols="87" name="hobbyNSkill" id="hobbyNSkill">${resume.hobbyNSkill}</textarea>
		<textarea rows="10" cols="87" name="introduce" id="introduce">${resume.introduce}</textarea>
	</div>
	<div class="modal" id="inputTitle">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">이력서 제목을 입력해 주세요.</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<div class="modal-body">
					<input class="form-control" type="text" name="title" id="title" value="${resume.title}">
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="saveResume">저장하기</button>
					<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
				</div>
			</div>
		</div>
	</div>
</form>
</body>
<script src="https://togetherjs.com/togetherjs-min.js"></script>
<script>
TogetherJSConfig_hubBase = "https://togetherjs-hub.glitch.me/";

$(function() {
	var today = new Date();
	var year = today.getFullYear();
	var month = today.getMonth() + 1;
	var day = today.getDate();

	var resume_num = '${resume.resume_num}';
	$('#resume_num').val(resume_num);
	var inputDate;
	if (resume_num < 0) {
		$('#inputYear').val(year);
		$('#inputMonth').val(month);
		$('#inputDay').val(day);
	} else {
		inputDate = '${resume.inputDate}'.split('-');
		$('#inputYear').val(inputDate[0]);
		$('#inputMonth').val(Number(inputDate[1]));
		$('#inputDay').val(Number(inputDate[2]));
		if (${resume.picFileName ne null}) {
			var path = '<c:url value="/uploaded/img/picFile/' + resume_num + '_${resume.picFileName}" />';
			$('#pic').attr('src', path);
		}
	}

	var mentorID = '${mentorID}';
	TogetherJSConfig_on_ready = function () {
		$.ajax({
			url : "<c:url value='/resume/shareUrl' />",
			type : "post",
			data : {
				mentorID : mentorID,
				shareUrl : TogetherJS.shareUrl()
			},
			error : function(e) {
				console.log(e);
			}
		});
	};

	$('#inputYear, #inputMonth, #inputDay').change(function() {
		var inputYear = $('#inputYear').val();
		var inputMonth = $('#inputMonth').val();
		inputMonth = month < 10 ? '0' + month : month;
		var inputDay = $('#inputDay').val();
		inputDay = day < 10 ? '0' + day : day;
		inputDate = inputYear + '-' + inputMonth + '-' + inputDay;
		$('#inputDate').val(inputDate);
	});
	$('#inputYear').change();

	var birth = $('#birth').val().split('-');
	$('#birthYear').val(birth[0]);
	$('#birthMonth').val(Number(birth[1]));
	$('#birthDay').val(Number(birth[2]));
	month = month < 10 ? '0' + month : String(month);
	day = day < 10 ? '0' + day : day;
	today = Number(year + month + day);
	var age;
	$('#birthYear, #birthMonth, #birthDay').change(function() {
		var birthYear = $('#birthYear').val();
		var birthMonth = $('#birthMonth').val();
		birthMonth = birthMonth < 10 ? '0' + birthMonth : birthMonth;
		var birthDay = $('#birthDay').val();
		birthDay = birthDay < 10 ? '0' + birthDay : birthDay;
		birth = birthYear + '-' + birthMonth + '-' + birthDay;
		$('#birth').val(birth);
		age = today - Number(birthYear + birthMonth + birthDay);
		age = Math.floor(age / 10000);
		$('#age').val(age);
	});
	$('#birthYear').change();

	$("#picFile").change(function() {
		if (this.files && this.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				$('#pic').attr('src', e.target.result);
			}
			reader.readAsDataURL(this.files[0]);
		}
	});

	var careerCount = 0;
	var careerBottom = 2405;
	$('#addCareer').click(function() {
		if (careerCount > 10)
			alert('더 이상 추가할 수 없습니다.');
		else {
			var careerValue = [];
			$('.career>*').each(function() {
				careerValue.push($(this).val());
			});
			var career = '<span class="career">';
			career += '<input type="text" class="form-control" name="careerStartYear" style=';
			career += '"bottom:' + (careerBottom + 50) + 'px;">';
			career += '<input type="text" class="form-control" name="careerStartMonth" style=';
			career += '"bottom:' + (careerBottom + 50) + 'px;">';
			career += '<input type="text" class="form-control" name="careerEndYear" style=';
			career += '"bottom:' + careerBottom + 'px;">';
			career += '<input type="text" class="form-control" name="careerEndMonth" style=';
			career += '"bottom:' + careerBottom + 'px;">';
			career += '<textarea class="form-control" name="careerContent" rows="3" style=';
			career += '"bottom:' + (careerBottom - 5) + 'px;right:160px;width:670px;"></textarea></span>';
			$('#career').html($('#career').html() + career);
			$('.career>*').each(function(index) {
				$(this).val(careerValue[index]);
				$(this).css('background-color', 'transparent');
				$(this).css('font-size', '20px');
			});
			++careerCount;
			careerBottom -= 100;
			if (careerCount === 8)
				careerBottom -= 217;
		}
	});

	var period;
	var end_period;
	<c:forEach var="career" items="${careerList}">
		start_period = '${career.start_period}'.split('-');
		end_period = '${career.end_period}'.split('-');
		$('#addCareer').click();
		$('input[name="careerStartYear"]:last').val(start_period[0]);
		$('input[name="careerStartMonth"]:last').val(Number(start_period[1]));
		$('input[name="careerEndYear"]:last').val(end_period[0]);
		$('input[name="careerEndMonth"]:last').val(Number(end_period[1]));
		$('textarea[name="careerContent"]:last').val('${career.content}');
	</c:forEach>

	$('#deleteCareer').click(function() {
		if (careerCount < 1)
			alert('삭제할 항목이 없습니다.');
		else {
			$('.career:last').remove();
			--careerCount;
			careerBottom += 100;
			if (careerCount === 8)
				careerBottom += 217;
		}
	});

	var qualifiedCount = 0;
	var qualifiedBottom = 1106;
	$('#addQualified').click(function() {
		if (qualifiedCount > 6) {
			alert('더 이상 추가할 수 없습니다.');
		} else {
			var qualifiedValue = [];
			$('.qualified>*').each(function() {
				qualifiedValue.push($(this).val());
			});
			var qualified = '<span class="qualified">';
			qualified += '<input type="text" class="form-control" name="qualifiedYear" style=';
			qualified += '"bottom:' + qualifiedBottom + 'px;">';
			qualified += '<input type="text" class="form-control" name="qualifiedMonth" style=';
			qualified += '"bottom:' + qualifiedBottom + 'px;">';
			qualified += '<input type="text" class="form-control" name="qualifiedContent" style=';
			qualified += '"bottom:' + qualifiedBottom + 'px;">';
			$('#qualified').html($('#qualified').html() + qualified);
			$('.qualified>*').each(function(index) {
				$(this).val(qualifiedValue[index]);
			});
			++qualifiedCount;
			qualifiedBottom -= 50;
		}
	});

	var period;
	<c:forEach var="qualified" items="${qualifiedList}">
		$('#addQualified').click();
		period = '${qualified.period}'.split('-');
		$('input[name="qualifiedYear"]:last').val(period[0]);
		$('input[name="qualifiedMonth"]:last').val(Number(period[1]));
		$('input[name="qualifiedContent"]:last').val('${qualified.content}');
	</c:forEach>

	$('#deleteQualified').click(function() {
		if (qualifiedCount < 1)
			alert('삭제할 항목이 없습니다.');
		else {
			$('.qualified:last').remove();
			--qualifiedCount;
			qualifiedBottom += 50;
		}
	});

	$('#checkResume').click(function() {
		$('#checkResume').removeAttr('data-target');
		var inputList = $('#resume>input[type="text"], .career>input[type="text"], .qualified>input[type="text"], textarea').get();
		for (var i = 0; i < inputList.length; i++) {
			if ($(inputList[i]).val().length < 1) {
				$(inputList[i]).focus();
				alert("내용을 입력해 주세요.");
				return;
			}
		}
		inputList = $('input[name$="Year"]').get();
		for (var i = 0; i < inputList.length; i++) {
			var inputValue = $(inputList[i]).val();
			if (isNaN(inputValue) || inputValue < 1900 || inputValue > 2099) {
				$(inputList[i]).focus();
				alert("올바른 년도를 입력해 주세요(ex: 1998).");
				return;
			}
		}
		inputList = $('input[name$="Month"]>').get();
		for (var i = 0; i < inputList.length; i++) {
			var inputValue = $(inputList[i]).val();
			if (isNaN(inputValue) || inputValue < 1 || inputValue > 12) {
				$(inputList[i]).focus();
				alert("1~12만 입력가능합니다.");
				return;
			}
		}
		inputList = $('#inputDay #birthDay').get();
		for (var i = 0; i < inputList.length; i++) {
			var checkDay = $(inputList[i]).val();
			var prev = $(inputList[i]).prev();
			var lastDay = new Date($(prev).prev().val(), $(prev).val(), 0).getDate();
			if (isNaN(checkDay) || checkDay < 1 || checkDay > lastDay) {
				$(inputList[i]).focus();
				alert("날짜를 확인해 주세요");
				return;
			}
		}
		$('#checkResume').attr('data-target', '#inputTitle');
	});

	$('#border').click(function() {
		var text = $(this).text();
		if (text === '테두리 보기') {
			$('input, textarea').css('border-color', '#ced4da');
			$(this).text('테두리 없애기');
		} else {
			$('input, textarea').css('border-color', 'transparent');
			$(this).text('테두리 보기');
		}
	});

	$('#language').click(function() {
		var text = $(this).text();
		if (text === '日本語') {
			$(this).text('한국어');
			$('#resume1').attr('src', '<c:url value='/resources/img/resume_jpn1.png' />');
			$('#resume2').attr('src', '<c:url value='/resources/img/resume_jpn2.png' />');
		} else {
			$(this).text('日本語');
			$('#resume1').attr('src', '<c:url value='/resources/img/resume_kor1.png' />');
			$('#resume2').attr('src', '<c:url value='/resources/img/resume_kor2.png' />');
		} 
	});

	$('#saveResume').click(function() {
		if ($('#title').val().length < 1)
			alert('이력서 제목을 입력하세요.');
		else {
			var careerList = [];
			$('.career').each(function() {
				var career = {};
				career.resume_num = resume.num;
				var children = $(this).children();
				var careerMonth = $(children[1]).val();
				careerMonth = careerMonth < 10 ? '0' + careerMonth : careerMonth;
				career.start_period = $(children[0]).val() + '-' + careerMonth + '-01';
				careerMonth = $(children[3]).val();
				careerMonth = careerMonth < 10 ? '0' + careerMonth : careerMonth;
				career.end_period = $(children[2]).val() + '-' + careerMonth + '-01';
				career.content = $(children[4]).val();
				careerList.push(career);
			});
			$('#careerList').val(JSON.stringify(careerList));
			var qualifiedList = [];
			$('.qualified').each(function() {
				var qualified = {};
				qualified.resume_num = resume.num;
				var children = $(this).children();
				var qualifiedMonth = $(children[1]).val();
				qualifiedMonth = qualifiedMonth < 10 ? '0' + qualifiedMonth : qualifiedMonth;
				qualified.period = $(children[0]).val() + '-' + qualifiedMonth + '-01';
				qualified.content = $(children[2]).val();
				qualifiedList.push(qualified);
			});
			$('#qualifiedList').val(JSON.stringify(qualifiedList));
			$('#resumeForm').submit();
		}
	});
});
</script>
<jsp:include page="../include/footer.jsp"></jsp:include>
