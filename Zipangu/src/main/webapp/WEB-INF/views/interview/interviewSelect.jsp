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
function test1() {
// 	var fileToLoad = document.getElementById("textFile1").files[0];
// 	var audio = new Audio(fileToLoad);
// 	audio.controls = true;
// 	audio.play(fileToLoad);
// 	console.log(fileToLoad);
// 	console.log("--------------")

	var arr = ${requestScope.list_json};
	var path = 'C:\\PJT\\';
	var filename = arr[0].voicefilename;
	document.getElementById("path1").innerHTML = path + filename;
	var fileToLoad = document.getElementById("textFile1").files[0];
	var audio = new Audio();
	audio.play(fileToLoad);
    console.log(path + filename);
    console.log("--------------")
    console.log(fileToLoad);
}

</script>
</head>
<body>

   <audio src="file://C:/PJT/2020042316424909.wav" controls="controls" id="textFile1">
   </audio>


<!-- <form id="textFile1" enctype='multipart/form-data'> -->
<!-- <input type="file" id="exlFile" name="exlFile" title="첨부파일" accept="audio/wav"> -->
<!-- </form> -->



<script type="text/javascript">
// function test1() {
// var fileValue = $("#exlFile").val().split("\\");
// var fileName = fileValue[fileValue.length-1]; // 파일명
// console.log(fileName);
// console.log(fileValue);
// var audio = new Audio(fileName);
// audio.controls = true;
// audio.play(fileName);
// }
</script>
<audio src="<c:url value="/uploaded/blob.wav"/>" controls="controls"></audio>
<button onclick="test1()">test</button>
<p id="path1"></p>
</body>
</html>