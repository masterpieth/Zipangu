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
	var mouseClick = 0;

window.onload = function(){
	URL = window.URL || window.webkitURL;
	
	
	var sec = 60;	//카운트
	var leftTime = null;
	
	var gumStream;
	var rec;
	var input;

	var AudioContext = window.AudioContext || window.webkitAudioContext;
	var audioContext

	var recordButton = document.getElementById("recordButton");
	var stopButton = document.getElementById("stopButton");

	recordButton.addEventListener("click", startRecording);
	stopButton.addEventListener("click", stopRecording);
	
	
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

	// 	다운로드
	function createDownloadLink(blob) {
		var url = URL.createObjectURL(blob);
		var au = document.createElement('audio');
		var li = document.createElement('li');
		var link = document.createElement('button');

		var filename = new Date().toISOString();
		au.controls = true; //오디오 컨트롤 바
		au.src = url; //
		link.href = url;
		link.download = filename+".wav";
		link.innerHTML = "다운로드";
		li.appendChild(au);
		li.appendChild(document.createTextNode(filename+".wav "))
		li.appendChild(link);
		recordingsList.appendChild(li);

		//컨트롤러로 파일 전달 > 업로드
		var filename = new Date().toISOString();

		var upload = document.createElement('button');
			upload.href = "#";
			upload.innerHTML = "선택하기";
			upload.addEventListener("click", function(event) {
				
				var fd = new FormData();
				fd.append("blob", blob);
				console.log(blob);
				$.ajax({
					url: "/zipangu/interview/test",
					type:"post",
					data : fd,
					cache: false,
					processData:false,
					contentType: false,
					success: function(data){
						console.log(data);
					}
				});
			})
		li.appendChild(document.createTextNode(" ")) //add a space in between 
		li.appendChild(upload) //add the upload link to li
	}
}
	
function nextQuestionButton(){

	var arr = ${requestScope.questionList};
	var question_Doc = document.getElementById("question");

	if(mouseClick === 0){
		question_Doc.innerHTML = arr[mouseClick].question_text;
		mouseClick++;
		console.log(mouseClick);
		console.log(arr[mouseClick].question_text);
	} else if(mouseClick === 1) {
		question_Doc.innerHTML = arr[mouseClick].question_text;
		console.log(mouseClick);
		console.log(arr[mouseClick].question_text);
		mouseClick++;
	} else if(mouseClick === 2) {
		question_Doc.innerHTML = arr[mouseClick].question_text;
		console.log(mouseClick);
		console.log(arr[mouseClick].question_text);
		mouseClick++;
	} else if(mouseClick === 3) {
		question_Doc.innerHTML = arr[mouseClick].question_text;
		console.log(mouseClick);
		console.log(arr[mouseClick].question_text);
		mouseClick++;
	} else if(mouseClick === 4) {
		question_Doc.innerHTML = arr[mouseClick].question_text;
		console.log(mouseClick);
		console.log(arr[mouseClick].question_text);
	}
}

// 	//음성 파일 텍스트 변환
// 	$('#testBtn2').on('click', function(){
// 		var form = $('#testForm')[0];
// 		var data = new FormData(form);
// 		console.log(data);
// 		$.ajax({
//             url : "https://api.kr-seo.speech-to-text.watson.cloud.ibm.com/instances/11a86b43-4a67-4691-bd6c-64c1d352ef3f/v1/recognize",
//             data : data, 
//             enctype: 'multipart/form-data',
//             processData : false,
//             contentType : false,
//             type : "post",
//             headers: {
//                 'Authorization': 'Basic ' + btoa('apikey:GZoCSYVV6T07ZP3_bJuAsEQseDT6J6ZbkMqpymw09fkD'),
//                 'Content-Type' : 'audio/wav'
//             },
//             success: function(data){
//                 console.log(data)
//             },
//             error: function(data){
//             }
//         })
//     })
// }

</script>

<body>

<p align="center"> 다음 질문에 답해주세요</p>

<div id="question"></div>

<button onclick='nextQuestionButton()'>다음 질문</button>

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
