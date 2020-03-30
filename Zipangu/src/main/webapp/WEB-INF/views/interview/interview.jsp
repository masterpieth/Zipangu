<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<html>
<head>
	<title>voice</title>
	<script src="<c:url value="/resources/js/jquery-3.4.1.min.js"/>"></script>
	<script src="<c:url value='/resources/js/recorder.js'/>"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<%--     <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/style.css' />"> --%>
</head>

<script>

window.onload = function(){
	URL = window.URL || window.webkitURL;

	var sec = 60;	//카운트
	
	var gumStream;
	var rec;
	var input;

	var AudioContext = window.AudioContext || window.webkitAudioContext;
	var audioContext

	var recordButton = document.getElementById("recordButton");
	var stopButton = document.getElementById("stopButton");

	recordButton.addEventListener("click", startRecording);
	stopButton.addEventListener("click", stopRecording);
	var leftTime = null;
	
	function startRecording() {
			//카운트 다운
			leftTime = setInterval(function() {

			 	document.getElementById("counting").innerHTML = "남은시간 : " + sec + "초";
			 	sec--;

			 	if (sec < 0) {
			 		clearInterval(leftTime);
			 		document.getElementById("counting").innerHTML = "답변은 60초 이내로 짧게 해주세요.";

					stopButton.disabled = true;
					recordButton.disabled = false;
					nextQuestion.disabled = false;
					
					rec.stop();
					
					gumStream.getAudioTracks()[0].stop();

					rec.exportWAV(createDownloadLink);
			}
	}, 1000);

	    var constraints = { audio: true, video:false }

		recordButton.disabled = true;
		stopButton.disabled = false;

		navigator.mediaDevices.getUserMedia(constraints).then(function(stream) {

			audioContext = new AudioContext();

			gumStream = stream;
			
			input = audioContext.createMediaStreamSource(stream);

			rec = new Recorder(input,{numChannels:1})

			rec.record()

		}).catch(function(err) {
	    	recordButton.disabled = false;
	    	stopButton.disabled = true;
	    	nextQuestion.disabled = true;
		});
	}

		
	function stopRecording() {
		stopButton.disabled = true;
		recordButton.disabled = false;
		
		rec.stop();

		gumStream.getAudioTracks()[0].stop();

		rec.exportWAV(createDownloadLink);
		
		clearInterval(leftTime);
		document.getElementById("counting").innerHTML = "남은시간 : " + sec + "초";
	}

	function createDownloadLink(blob) {
		var url = URL.createObjectURL(blob);
		var au = document.createElement('audio');
		var li = document.createElement('li');
		var link = document.createElement('a');

		var filename = new Date().toISOString();

		au.controls = true;
		au.src = url;

		link.href = url;
		link.download = filename+".wav";
		link.innerHTML = "선택 하기";

		li.appendChild(au);
		li.appendChild(document.createTextNode(filename+".wav "))
		li.appendChild(link);
		recordingsList.appendChild(li);
	}
}

// 	질문 1개씩 표시
	var arr = ${requestScope.list};
	document.getElementById("demo").innerHTML = arr[0].question_text;
	console.log(arr[1].question_text);
</script>

<body>
<p id="demo"></p>

<p align="center"> 다음 질문에 답해주세요</p>

<!-- 테스트용 -->
<!-- <div align="center"> -->
<!-- 테스트용 -->
<%-- 	<c:forEach items="${requestScope.list}" var="question" begin="0" end="4"> --%>
<!-- 			<tr> -->
<%-- 				<td>${question.question_num}</td> --%>
<%-- 				<td>${question.question_text}</td> --%>
<!-- 				<br /> -->
<!-- 			</tr> -->
<%-- 	</c:forEach> --%>
<!-- </div> -->

<!-- <button class='button'>다음 질문</button> -->
<%-- <div ${requestScope.list} align="center"> --%>
<%-- <h1 class='question' align="center">${list[0].question_text}</h1> --%>
<!-- </div> -->
<!-- 테스트용 끝 -->

<!-- 타이머 -->
<p id="counting" align="center"></p>

<!-- 음성녹음(답변) -->
	<div id="controls" align="center">
		<button id="recordButton">답변 시작</button>
		<button id="stopButton" disabled>답변 완료</button>
	</div>
		<ol id="recordingsList" ></ol>
</body>
</html>
