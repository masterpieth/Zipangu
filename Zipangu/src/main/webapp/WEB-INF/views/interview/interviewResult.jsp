<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모의 면접 결과 보기</title>
</head>
<script type="text/javascript">
function createDownloadLink(blob) {
	var url = URL.createObjectURL(blob);
	var au = document.createElement('audio');
	var li = document.createElement('li');
	li.className = 'lis'; 

	var filename = new Date().toISOString();
	au.controls = true; //오디오 컨트롤 바
	au.src = url;
	li.appendChild(au);
	li.appendChild(document.createTextNode("이 답변으로"))
	recordingsList.appendChild(li);

	//파일저장 및 API 실행
	var upload = document.createElement('button');
		upload.id = 'mouseClick';
		upload.href = "#";
		upload.innerHTML = "제출하기";

		upload.addEventListener("click", function(event) {
			var fd = new FormData();
			fd.append("blob", blob);
</script>
<body>


<div align="center">
	<table border="1">
	<thead>
	   <tr align ="center">
			<td colspan="4">모의면접 결과</td>
	   </tr>
	   <tr align="center">
			<th>날짜</th>
			<th>질문</th>
			<th>답변 성향</th>
			<th>다시 듣기</th>
	   </tr>
   </thead>
		<c:forEach items="${list}" var="item">
			<tr>
				<td>${item.inputdate}</td>
				<td>${item.question_text}</td>
				<td>${item.result}</td>
				<td>${item.voicefilename}</td>
			</tr>
		</c:forEach>
	 </table>
</div>

<form method="POST" enctype="multipart/form-data" id="excelForm">
    <input type="file" name="excelFile"/>
    <input type="hidden" name="userId" value="testUser"/>
</form>

</body>
</html>