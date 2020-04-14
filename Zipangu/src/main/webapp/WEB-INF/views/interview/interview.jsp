<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.ArrayList" %>
<html>
<head>
	<title>voice</title>
	<script src="<c:url value="/resources/js/jquery-3.4.1.min.js"/>"></script>
	<script src="<c:url value='/resources/js/recorder.js'/>"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/style.css' />">
<%-- 	<jsp:include page="../include/header.jsp"></jsp:include> --%>
</head>

<script>
	var mouseClick = 0;
	var temp;
	var text = "";
	var i;
	
// window.onload = function(){

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
		sec = 60;
		document.getElementById("counting").innerHTML = "남은시간 : " + sec + "초";
	}

	// 	다운로드
	function createDownloadLink(blob) {
		var url = URL.createObjectURL(blob);
		var au = document.createElement('audio');
		var li = document.createElement('li');
				li.className = 'lis'; //녹음 후 생성되는 리스트에 Class 추가

		var filename = new Date().toISOString();
		au.controls = true; //오디오 컨트롤 바
		au.src = url;
		li.appendChild(au);
		li.appendChild(document.createTextNode("이 녹음 파일로 결과 확인하기"))
		recordingsList.appendChild(li);

		//파일저장
		var upload = document.createElement('button');
			upload.id = 'select';
			upload.href = "#";
			upload.innerHTML = "선택하기";

			upload.addEventListener("click", function(event) {
				var fd = new FormData();
				fd.append("blob", blob);
				console.log(fd);
				speechToText(blob); 	//STT API 실행
				nextQuestionButton();
				 
				$.ajax({
					url: "/zipangu/interview/voice",
					type:"post",
					data : fd,
					cache: false,
					processData:false,
					contentType: false,
					success: function(data){
						console.log("saved complete"); //녹음 파일 저장 완료 확인
						$("li").remove(".lis"); //녹음 리스트 삭제
						}
				});
			});
				li.appendChild(document.createTextNode(" ")) 
				li.appendChild(upload)
	}
}

	//음성 파일 텍스트 변환
function speechToText(blob){
		$.ajax({
            url : "https://api.kr-seo.speech-to-text.watson.cloud.ibm.com/instances/11a86b43-4a67-4691-bd6c-64c1d352ef3f/v1/recognize?model=ja-JP_NarrowbandModel",
            type : "post",
            data : blob, 
            enctype: 'multipart/form-data',
            processData : false,
            contentType : false,
            headers: {
                'Authorization': 'Basic ' + btoa('apikey:GZoCSYVV6T07ZP3_bJuAsEQseDT6J6ZbkMqpymw09fkD'),
                'Content-Type' : 'audio/wav'
            },
            success: function(data){
                console.log(data);
                temp = data;
               	length = temp.results.length;

               	for (i = 0; i < length; i++) {
               	  text += temp.results[i].alternatives[0].transcript + " ";
               	}
               	document.getElementById("demo").innerHTML = text;
            },
            error: function(data){
            }
        })
}

// function testapi(){
// 	var word = "i love you"
	
// 	$.ajax({
// 		url : 'https://api.kr-seo.natural-language-understanding.watson.cloud.ibm.com/instances/7191d826-cb08-4e42-a043-2b17891cc13c/v1/analyze?version=2019-07-12',
// 		type : 'post',
// 		data : {
// 			text : word,
// 			features : 'sentiment : {}',
// 		},
// 		headers: {
// // 			'Authorization': 'Basic' + btoa('apikey:GZoCSYVV6T07ZP3_bJuAsEQseDT6J6ZbkMqpymw09fkD'), //원본
//            'Authorization': 'apikey:GZoCSYVV6T07ZP3_bJuAsEQseDT6J6ZbkMqpymw09fkD', //인증에 에러가 발생되어 테스트용 코드
//            'Content-Type' : 'application/json'
//            },
// 		success : function(data){
// 			console.log(data);
// 		},
// 		error : function(e){
// 		console.log(e);
// 		}
// 	});
// };

</script>
<body>



<div align="center">
<h3>다음 질문에 답해주세요</h3>

<input type="button" onclick="testapi()" value="apitest">

<button onclick="nextQuestionButton()">시작하기</button>

<!-- 질문 -->
<h1 id="question"></h1>
</div>

<!-- 타이머 -->
<p id="counting" align="center"></p>

<!-- 음성녹음(답변) -->
<div align="center">
	<div id="controls" align="center">
		<button id="recordButton">답변 시작</button>
		<button id="stopButton" disabled>답변 완료</button>
	</div>
</div>

<div align="center">
	<ul id="recordingsList" ></ul>
</div>

<div align="center">
	<textarea id="demo" readonly="readonly" ></textarea>
</div>
</body>
</html>
