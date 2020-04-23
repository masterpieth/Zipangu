<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모의 면접 결과 보기</title>
	<script src="<c:url value="/resources/js/jquery-3.4.1.min.js"/>"></script>

<script type="text/javascript">
$(function(){
	var arr = ${requestScope.list_json};
	var html = '';

	for(key in arr){
		if(key%5==0){
			html += '<tr><td colspan="4"></td></tr>';
			html += '<td>'+arr[key].inputdate+'</td>';
			html += '<td>'+arr[key].question_text+'</td>';
			html += '<td>'+arr[key].result+'</td>';
			html += '<td>'+arr[key].voicefilename+'</td>';
			}else{
				html += '<tr>';
				html += '<td>'+arr[key].inputdate+'</td>';
				html += '<td>'+arr[key].question_text+'</td>';
				html += '<td>'+arr[key].result+'</td>';
				html += '<td>'+arr[key].voicefilename+'</td>';
				html += '</tr>'; 
			}
	}
	$("#dynamicTbody").empty();
	$("#dynamicTbody").append(html);
});


// var i;
// var j;
// var text = "";

// for (i = 0; i < arr.length; i++) {
// 		text += arr[i].inputdate;
// 		text += arr[i].question_text;
// 		text += arr[i].voicefilename;
// 		text += arr[i].result;
// 		text += "<br>";
// $('#interview').val(text);
// document.getElementById("interview").innerHTML = text;
// }
	
// console.log(text);
// }

// StringBuilder sb = new StringBuilder(); 
// String arrStr = "";
// sb.append("<div><ul>"); 
// for(int i=0; i <= arr.length; i++){ 

// 	if(i > arr.length)
// arrStr = "";
// else
// arrStr = arr[i-1];
// sb.append("<li>"); 
// sb.append(arrStr); 
// sb.append("</li>"); 
// if(i % 5 == 0) 
// sb.append("</ul></div>") 
// }

// function select_num(){
// 	var arr = ${requestScope.list1};
// 	var interview_num_DOC = document.getElementById("interview_num");
// 	var i = 0;
// 	interview_num_DOC.value = arr[i].interview_num;
// 	console.log(interview_num_DOC.value);
// 	insert_interview();
// };

// function insert_interview(){
// 	var data = $('#interview_num').val();
// 	console.log(data);
// 	$.ajax({
// 		url : "/zipangu/interview/getinterviewResult",
// 		type : "post",
// 		data :  data,
// 		success : function(data){
// 			console.log(data);
// 		},
// 		error : function(e){
// 			console.log(e);
// 			console.log("답변 저장 에러");
// 		}
// 	});
// };

</script>
</head>
<body>

<div>
	<table border="1" id="dynamicTable">
		<thead>
			<tr>
				<th colspan="4">모의면접 결과</th>
			</tr>
			<tr>
				<th>날씨</th>
				<th>질문</th>
				<th>성향</th>
				<th>듣기</th>
			</tr>
		</thead>
	<tbody id="dynamicTbody">
		
	</tbody>
	</table>
</div>


</body>
</html>