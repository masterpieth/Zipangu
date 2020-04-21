<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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

	var temp = document.getElementById("traits_Selected").value;
	var traitArr = temp.split(",");	
	
	console.log(traitArr);
	
	for(var i in traitArr) {
		$("input[name=keywordSelected][value='"+traitArr[i]+"']").attr("checked",true);
	}
	
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
	<table>
		<tr>
			<th>항목</th><th>퍼센트</th><th>선택</th>
		</tr>
		<c:forEach items="${requestScope.keywordList}" var="keyword">
			<tr>
				<td>${keyword.trait}</td><td>${keyword.rate}</td><td><input type="checkbox" name="keywordSelected" value="${keyword.trait}"></td>
			</tr>
		</c:forEach>
	</table>
	<form action="timelineUpdate" method="post">
		처음 시작한 날짜 : <input type="text" id="start_Date" name="start_Date" data-dd-format="Y/m/d" data-dd-roundtrip="episode" class="episode" value='<fmt:parseDate value="${timelineVO.start_Date}" var="dateFmt" pattern="yyyy-MM-dd"/><fmt:formatDate value="${dateFmt}" pattern="yyyy/MM/dd"/>'>
		<br>끝난 날짜 : <input type="text" id="finish_Date" name="finish_Date" data-dd-format="Y/m/d" data-dd-roundtrip="episode" class="episode" value='<fmt:parseDate value="${timelineVO.finish_Date}" var="dateFmt" pattern="yyyy-MM-dd"/><fmt:formatDate value="${dateFmt}" pattern="yyyy/MM/dd"/>'>
		
		<br>내가 고른 키워드들 : <input type="text" id="traits_Selected" name="traits_Selected" readonly="readonly"  value="${timelineVO.traits_Selected}">
		<br>에피소드 제목 : <input type="text" name="episode_Title" value="${timelineVO.episode_Title}">
		<br>에피소드 내용 : <textarea rows="" cols="" name="episode_Content">${timelineVO.episode_Content}</textarea>
		
		<input type="hidden" name="timeline_Num" value="${timelineVO.timeline_Num}">
		<br><input type="submit" value="에피소드 수정">
	</form>

</body>
</html>