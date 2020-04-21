<jsp:include page="/WEB-INF/views/include/header.jsp" />
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 현황</title>
<link rel="stylesheet" href="<c:url value='/resources/template_css/bootstrap.min.css' />">
<style>
td {
	text-align: center;
	font-size: 20px;
}

.sunday {
	color: red;
}

.saturday {
	color: gray;
}
</style>
</head>
<body>
<div class="container">
	<table class="table table-bordered">
		<thead>
		<tr>
			<td><button type="button" class="btn" onclick="lastMonth()">&lt;</button></td>
			<td align="center" id="month" colspan="5"></td>
			<td><button type="button" class="btn" onclick="nextMonth()">&gt;</button></td>
		</tr>
		<tr>
			<td align="center" class="sunday">일</td>
			<td align="center">월</td>
			<td align="center">화</td>
			<td align="center">수</td>
			<td align="center">목</td>
			<td align="center">금</td>
			<td align="center" class="saturday">토</td>
		</tr>
		</thead>
		<tbody id="calendar"></tbody>
	</table>
		<button type="button" class="btn btn-success float-right" onclick="updateSchedule()">저장</button>
		<c:if test="${authority gt 1}">
			<div class="modal" id="reserveInfo">
				<div class="modal-dialog modal-dialog-centered">
					<div class="modal-content">
						<div class="modal-header">
							<h4 class="modal-title">예약 현황</h4>
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>
						<div class="modal-body" id="reserveBody"></div>
						<div class="modal-footer" id="reserveFooter"></div>
					</div>
				</div>
			</div>
		</c:if>
</div>
</body>
<script>
var calendarDate, scheduleList, thisMonth, date;

function createCalendar() {
	var year = calendarDate.getFullYear();
	var month = calendarDate.getMonth() + 1;
	var firstDate = new Date(year, month - 1, 1);
	var lastDate = new Date(year, month, 0);
	$('#month').html('<h3>' + year + '년 ' + month + '월</h3>');
	var calendarBody = '';
	var day = 0;
	while (day < firstDate.getDay()) {
		calendarBody += '<td></td>';
		++day;
	}
	calendarBody = day % 7 === 0 ? calendarBody : '<tr>' + calendarBody;
	for (var i = 1; i <= lastDate.getDate(); i++) {
		if (day % 7 === 0) {
			calendarBody += '<tr><td><button type="button" class="btn sunday date" ';
			<c:if test="${authority gt 1}">
				calendarBody += 'data-toggle="modal" data-target="#reserveInfo "'
			</c:if>
			calendarBody += 'onclick="checkDate(this)">' + i + '</button></td>';
		} else if (day % 7 === 6) {
			calendarBody += '<td><button type="button" class="btn saturday date" ';
			<c:if test="${authority gt 1}">
				calendarBody += 'data-toggle="modal" data-target="#reserveInfo "'
			</c:if>
			calendarBody += 'onclick="checkDate(this)">' + i + '</button></td></tr>';
		} else {
			calendarBody += '<td><button type="button" class="btn date" ';
			<c:if test="${authority gt 1}">
				calendarBody += 'data-toggle="modal" data-target="#reserveInfo "'
			</c:if>
			calendarBody += 'onclick="checkDate(this)">' + i + '</button></td>';
		}
		++day;
	}
	while (day % 7 !== 0) {
		calendarBody += '<td></td>';
		if (++day % 7 === 0)
			calendarBody += '</tr>';
	}
	$('#calendar').html(calendarBody);
	var yearMonth = year + (month < 10 ? '0' + month : String(month));
	for (var i = 0; i < scheduleList.length; i++) {
		var reserveDate = scheduleList[i].reserveDate.split('-');
		reserveDate = reserveDate[0] + reserveDate[1];
		if (yearMonth === reserveDate) {
			var index = Number(scheduleList[i].reserveDate.substr(8, 2)) - 1
			$('.date').eq(index).closest('td').css('background-color', 'lightgray');
			if (scheduleList[i].menteeID !== null)
				$('.date').eq(index).css('background-color', 'skyblue');
		}
	}
};

function lastMonth() {
	calendarDate = new Date(calendarDate.getFullYear(), calendarDate.getMonth() - 1, 1);
	var month = calendarDate.getMonth() + 1;
	var lastMonth = Number(calendarDate.getFullYear() + (month < 10 ? '0' + month : String(month)));
	if (thisMonth > lastMonth)
		alert("더 이상 앞으로 갈 수 없습니다.");
	else
		createCalendar();
};

function nextMonth() {
	calendarDate = new Date(calendarDate.getFullYear(), calendarDate.getMonth() + 1, 1);
	var month = calendarDate.getMonth() + 1;
	var nextMonth = Number(calendarDate.getFullYear() + (month < 10 ? '0' + month : String(month)));
	if (nextMonth > thisMonth + 100)
		alert("1년 후 까지만 예약이 가능합니다.");
	else {
		createCalendar();
		<c:if test="${authority gt 1}">
			$('.date').each(function() {
				$(this).attr('data-toggle', 'modal');
				$(this).attr('data-target', '#reserveInfo');
			})
		</c:if>
	}
};

function checkDate(button) {
	var year = calendarDate.getFullYear();
	var month = calendarDate.getMonth() + 1;
	month = month < 10 ? '0' + month : String(month);
	var day = $(button).text();
	day = day < 10 ? '0' + day : day;
	date = year + '-' + month + '-' + day;
	<c:if test="${authority gt 1}">
		var mentorList = '<div class="form-check">';
	</c:if>
	for (var i = 0; i < scheduleList.length; i++) {
		if (date === scheduleList[i].reserveDate) {
			if (scheduleList[i].menteeID !== null) {
				<c:choose>
					<c:when test="${authority gt 1}">
						scheduleList[i].menteeID = null;
						var modalFooter = '<button type="button" class="btn btn-primary" ';
						modalFooter += 'data-dismiss="modal">확인</button>';
						$('#reserveBody').html('예약이 취소되었습니다.');
						$('#reserveFooter').html(modalFooter);
						$(button).css('background-color', 'transparent');
					</c:when>
					<c:otherwise>
						if (confirm("이미 예약된 사람이 있습니다. 일정을 삭제하시겠습니까?")) {
							$(button).closest('td').css('background-color', 'transparent');
							$(button).css('background-color', 'transparent');
							scheduleList.splice(i, 1);
						}
					</c:otherwise>
				</c:choose>
				return;
			} else {
				<c:choose>
					<c:when test="${authority gt 1}">
						if (mentorList.length > 24)
							mentorList += '<br>';
						mentorList += '<label class="form-check-label"><input type="radio" class="form-';
						mentorList += 'check-input" name="mentorID" value="' + scheduleList[i].mentorID;
						mentorList += '">' + scheduleList[i].mentorID + '</label>';
					</c:when>
					<c:otherwise>
						$(button).closest('td').css('background-color', 'transparent');
						scheduleList.splice(i, 1);
						return;
					</c:otherwise>
				</c:choose>
			}
		}
	}
	<c:choose>
		<c:when test="${authority gt 1}">
			var modalFooter = '';
			if (mentorList.length < 25)
				mentorList += '예약 가능한 멘토가 없습니다';
			else {
				modalFooter += '<button type="button" class="btn btn-danger" data-dismiss="modal" ';
				modalFooter += 'onclick="reserve(this)">예약</button>';
			}
			mentorList += '</div>';
			$('#reserveBody').html(mentorList);
			modalFooter += '<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>';
			$('#reserveFooter').html(modalFooter);
		</c:when>
		<c:otherwise>
			var schedule = {};
			schedule.mentorID = '${userID}';
			schedule.menteeID = null;
			schedule.reserveDate = date;
			scheduleList.push(schedule);
			$(button).closest('td').css('background-color', 'lightgray');
		</c:otherwise>
	</c:choose>
};

function reserve(reserve) {
	var button = $('.date').eq(Number(date.substr(8, 2)) - 1);
	var mentorID = $('input[name=mentorID]:checked').val();
	if (typeof mentorID === 'undefined') {
		alert("멘토가 선택되지 않았습니다.");
		$(reserve).removeAttr('data-dismiss');
	} else {
		for (var i = 0; i < scheduleList.length; i++) {
			if (scheduleList[i].reserveDate === date && scheduleList[i].mentorID === mentorID) {
				scheduleList[i].menteeID = '${userID}';
				$(reserve).attr('data-dismiss', 'modal');
				$(button).css('background-color', 'skyblue');
				return;
			}
		}
	}
};

function updateSchedule() {
	$.ajax({
		url : "<c:url value='/schedule/updateSchedule' />",
		type : "post",
		data : {
			scheduleList : JSON.stringify(scheduleList)
		},
		success : function(result) {
			alert(result ? "스케쥴이 변경되었습니다." : "스케쥴 변경에 실패하였습니다.");
		},
		error : function(e) {
			console.log(e);
		}
	});
};

$(function() {
	scheduleList = [];
	var schedule;
	<c:forEach var="schedule" items="${scheduleList}">
		schedule = {};
		schedule.mentorID = '${schedule.mentorID}';
		schedule.menteeID = '${schedule.menteeID}'.length < 1 ? null : '${schedule.menteeID}';
		schedule.reserveDate = '${schedule.reserveDate}';
		scheduleList.push(schedule);
	</c:forEach>
	calendarDate = new Date();
	var month = calendarDate.getMonth() + 1;
	thisMonth = Number(calendarDate.getFullYear() + (month < 10 ? '0' + month : String(month)));
	createCalendar();
});
</script>
</html>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />