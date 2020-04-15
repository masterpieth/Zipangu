<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.ArrayList" %>
<html>
<head>
	<title>voice</title>
	<script src="<c:url value="/resources/js/jquery-3.4.1.min.js"/>"></script>
	<script src="<c:url value='/resources/js/recorder.js'/>"></script>
<!--     <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous"> -->
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/style.css' />">
	<jsp:include page="../include/header.jsp"></jsp:include>
</head>

<script>
	var mouseClick = 0;
	var temp;
	var text = "";
	var temp2;
	var text2 = "";
	var stats = "";
	var i;
	
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

			 	document.getElementById("counting").innerHTML = "残り時間 : " + sec + "秒";
			 	sec--;

			 	if (sec < 0) {
			 		clearInterval(leftTime);
			 		document.getElementById("counting").innerHTML = "答えは60秒内にしてください";

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
		document.getElementById("counting").innerHTML = "残り時間 : " + sec + "秒";
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
		li.appendChild(document.createTextNode("この結果を選ぶ"))
		recordingsList.appendChild(li);

		//파일저장
		var upload = document.createElement('button');
			upload.id = 'select';
			upload.href = "#";
			upload.innerHTML = "選ぶ";

			upload.addEventListener("click", function(event) {
				var fd = new FormData();
				fd.append("blob", blob);
				console.log(fd);
				speechToText(blob); 	//STT API 실행
				naturalLanguageUnderstanding(); //NLU API 실행
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
            async: false,
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
                console.log(data)
            }
        })
}

function naturalLanguageUnderstanding(){

    //감정분석 타겟이 되는 전체
	var word = $('#demo').val();
	//공백을 기준으로 문장을 나누어 문장 array를 만듦 -> [悲しいことに今日もここに来ている, なぜだろ] 이렇게
	var string_arr = word.split(' ');
	//ajax내부 관련하여 -> json을 사용할때는 json형태의 데이터를 사용해야 합니다. 이전 코드에는 data에 JSON.stringify가 없었어요.
	//해당 메소드를 쓰지 않은 data는 단순 객체가 되어버리기 때문에 인식이 안됐을 겁니다
	//data를 stringify를 써서 JSON 형식으로 변환해주고, url에 요청을 보냅니다
	//그리고 가이드상에 parameter 설정하는 거랑 조금 다른 부분이 있었습니다
	//이전 코드에는 features : 'sentiment :  {}' 이렇게 되어있었던 것 같은데,
	//가이드를 보면 features라는 객체 안의 sentiment라는 객체 안에 분석 대상이 되는 문장 array를 넣으라고 되어있어요. 객체 안에 객체 안에 객체 뭐 이런식이라 아래와 같이 변경되었습니다
	$.ajax({
		url : 'https://api.kr-seo.natural-language-understanding.watson.cloud.ibm.com/instances/7191d826-cb08-4e42-a043-2b17891cc13c/v1/analyze?version=2019-07-12',
		type : 'post',
		data : JSON.stringify({
			text : word,
			features : {
				'sentiment' : {
					'targets' : string_arr
				}
			},
		}),
		headers: {
           'Authorization': 'Basic YXBpa2V5OlF6b1F2SFV3OGdwRXBYRnVOVldDY3pVbGplbFNvbV8xSUtYTkU0a2dYdXRm', //POSTMAN에서 성공된 코드로 변경
           'Content-Type' : 'application/json;charset=utf-8'
           },
		success : function(data){
			console.log(data);
            temp2 = data;
           	text2 = temp2.sentiment.document.label;

            if (text2="positive") {
                stats = "肯定的";
              } else if (text2 ="negative") {
            	  stats = "否定的";
              } else {
            	  stats = "中立的";
              }
           	
           	document.getElementById("demo2").innerHTML = stats;
		},
		error : function(request, status, error){
			console.log(request.status + '/' + request.responseText + '/' + error);
		}
	});
};

</script>
<body>

<div align="center">

<button class="qBtn" onclick="nextQuestionButton()">模擬面接を開始</button>

<!-- 질문 -->
<h3 id="info">次の質問に答えてください。</h3>
<h1 id="question"></h1>
</div>

<!-- 타이머 -->
<p id="counting" align="center"></p>

<!-- 음성녹음(답변) -->
<div align="center">
	<div id="controls" align="center">
		<button id="recordButton">返事する</button>
		<button id="stopButton" disabled>返事完了</button>
	</div>
</div>

<div align="center">
	<ul id="recordingsList" ></ul>
</div>

<div align="center">
	<textarea id="demo" readonly="readonly" ></textarea><br>
	<textarea id="demo2" readonly="readonly"></textarea>
</div>
</body>
	<jsp:include page="../include/footer.jsp"></jsp:include>
</html>
