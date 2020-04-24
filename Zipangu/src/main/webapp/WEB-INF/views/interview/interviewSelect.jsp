<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모의 면접 결과 보기</title>
<script src="<c:url value="/resources/js/jquery-3.4.1.min.js"/>"></script>
<script type="text/javascript">
// var arr = ${requestScope.list_json};

// var audio = new Audio();
// audio.src = "<c:url value='/voice/arr[key].voicefilename'/>";

// $(function(){
	
// 	var html = '';
// 	var voice = document.createElement('button');
	
// 	for(key in arr){
// 		if(key%5==0){
// 			html += '<tr><td colspan="4"></td></tr>';
// 			html += '<td>'+arr[key].inputdate+'</td>';
// 			html += '<td>'+arr[key].question_text+'</td>';
// 			html += '<td>'+arr[key].result+'</td>';
// 			html += '<td>'+arr[key].voicefilename+'</td>';
// 			}else{
// 				html += '<tr>';
// 				html += '<td>'+arr[key].inputdate+'</td>';
// 				html += '<td>'+arr[key].question_text+'</td>';
// 				html += '<td>'+arr[key].result+'</td>';
// 				html += '<td>'+arr[key].voicefilename+'</td>';
// 				html += '</tr>'; 
// 			}
// 	}
// 	$("#dynamicTbody").empty();
// 	$("#dynamicTbody").append(html);


// });
</script>
</head>
<body>
<div align="center">
	<table border="1" id="dynamicTable">
		<thead>
			<tr align="center">
				<th colspan="4">모의면접 결과</th>
			</tr>
			<tr align="center">
				<th>날씨</th>
				<th>질문</th>
				<th>성향</th>
				<th>듣기</th>
			</tr>
		</thead>
	<tbody>
        <c:forEach items="${list_json}" var="item">
            <tr>
                <td>${item.inputdate}</td>
                <td>${item.question_text}</td>
                <td>${item.result}</td>
                <td>${item.voicefilename}</td>
            </tr>
        </c:forEach>
	</tbody>
	</table>
	
    <input type="button" onClick="audio.play();" value="PLAY"/>
    <input type="button" onClick="audio.pause();" value="PAUSE"/>
	<audio src="<c:url value='/voice/20200411213041911.wav'/>" controls="controls"></audio>

</div>
</body>
</html>