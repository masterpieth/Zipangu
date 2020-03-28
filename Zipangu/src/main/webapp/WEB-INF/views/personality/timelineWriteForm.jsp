<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link type="text/css" rel="stylesheet" href="<c:url value='/resources/css/datedropper.css'/>">

<script src="<c:url value='/resources/js/jquery-3.4.1.js'/>"></script> 
<script src="<c:url value='/resources/js/datedropper.pro.min.js '/>"></script> 

<script type="text/javascript">

$(function(){

	$(".episode").dateDropper({
		roundtrip: 'episode'
	});

	$("input[name=keywordSelected]").on("click",function(){

		var checkbox = $("input[name=keywordSelected]:checked");
		var traitAry = new Array();
		
		checkbox.each(function(i){
			var tr = checkbox.parent().parent().eq(i);
			var td = tr.children();
			
			var trait = td.eq(0).html();
			traitAry[i] = trait;
		})
		
		$('#traits_Selected').val(traitAry);
		
	})
	
})

</script>
</head>
<body>

db에 저장된 성향분석 키워드 목록

	<table>
		<tr>
			<th>항목</th><th>퍼센트</th><th>선택</th>
		</tr>
		<c:forEach items="${requestScope.keywordList}" var="keyword">
			<tr>
				<td>${keyword.trait}</td><td>${keyword.rate}</td><td><input type="checkbox" name="keywordSelected"></td>
			</tr>
		</c:forEach>
	</table>
	
	<form action="timelineWrite" method="post">
		처음 시작한 날짜 : <input type="text" id="start_Date" name="start_Date" data-dd-format="Y/m/d" data-dd-roundtrip="episode" class="episode">
		<br>끝난 날짜 : <input type="text" id="finish_Date" name="finish_Date" data-dd-format="Y/m/d" data-dd-roundtrip="episode" class="episode">
		
		<br>내가 고른 키워드들 : <input type="text" id="traits_Selected" name="traits_Selected" readonly="readonly">
		<br>에피소드 제목 : <input type="text" name="episode_Title">
		<br>에피소드 내용 : <textarea rows="" cols="" name="episode_Content"></textarea>
		
		<br><input type="submit" value="에피소드 등록">
		<a href="<c:url value='/personality/keywordTimeline'/>">
		<input type="button" value="취소">
		</a>
	</form>

</body>
</html>