<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.ArrayList" %>
<html>
<head>
	<title>voice</title>
	<script src="<c:url value="/resources/js/jquery-3.4.1.min.js"/>"></script>
	<script src="<c:url value='/resources/js/recorder.js'/>"></script>
<!--     <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous"> -->
<%--     <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/style2.css' />"> --%>
	<jsp:include page="../include/header.jsp"></jsp:include>
</head>

<script>
	var i;
	var mouseClick = 0;
	var filename;
	
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

	recordButton.disabled = true;
	stopButton.disabled = true;
	
	function startRecording() {
			//카운트 다운
			leftTime = setInterval(function() {

		 	document.getElementById("counting").innerHTML = "남은시간 : " + sec + "초";
		 	sec--;

			 	if (sec < 0) {
			 		clearInterval(leftTime);
			 		document.getElementById("counting").innerHTML = "답변은 60초 이내로 해주세요.";

			 		stopRecording();
					recordButton.disabled = false;
					stopButton.disabled = true;
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
		//답변 완료
		recordButton.disabled = false;
		stopButton.disabled = true;
		rec.stop();
		gumStream.getAudioTracks()[0].stop();
		rec.exportWAV(createDownloadLink);

		//남은 시간 리셋
		clearInterval(leftTime);
		sec = 60;
		document.getElementById("counting").innerHTML = "남은시간 : " + sec + "초";
	}

	//답변 완료 선택 시 하단에 결과 표시
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

			upload.setAttribute('class','btn btn-danger e-large');

			upload.addEventListener("click", function(event) {
				var fd = new FormData();
				fd.append("blob", blob);
// 				console.log(fd);

				//답변 파일 저장
				$.ajax({
					url: "/zipangu/interview/voice",
					type:"post",
					async: false,
					data : fd,
					cache: false,
					processData:false,
					contentType: false,
					success: function(data){
						console.log("답변 파일 저장 완료"); //녹음 파일 저장 완료 확인
						$('#voicefilename').val(data+".wav");
						speechToText(blob); 	//STT API 실행
						naturalLanguageUnderstanding(); //NLU API 실행
						insert_interview(); //진행한 인터뷰 저장
						nextQuestionButton();
						$("li").remove(".lis"); //제출 후 녹음 리스트 초기화
						}
				});
			});
				li.appendChild(document.createTextNode(" ")) 
				li.appendChild(upload)
	}
}

	//STT
	function speechToText(blob){
		var temp;
		var text = "";
		
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
		            console.log("STT 완료")
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

	//NLU
	function naturalLanguageUnderstanding(){
		var temp2;
		var text2 = "";
		var stats = "";
		
		var word = $('#demo').val();
		var string_arr = word.split(' ');
		
		$.ajax({
			url : 'https://api.kr-seo.natural-language-understanding.watson.cloud.ibm.com/instances/7191d826-cb08-4e42-a043-2b17891cc13c/v1/analyze?version=2019-07-12',
			type : 'post',
			async: false,
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
				console.log("답변 분석 완료");
	            temp2 = data;
	           	text2 = temp2.sentiment.document.label;
	
	            if (text2==="positive") {
	                stats = "긍정적";
	              } else if (text2 ==="negative") {
	            	  stats = "부정적";
	              } else {
	            	  stats = "중립적";
	              }
	            $('#demo2').val(stats);
			},
			error : function(request, status, error){
				console.log(request.status + '/' + request.responseText + '/' + error);
			}
		});
	};

	$(function (){
		$('#startInterview').on('click',function(){
			$.ajax({
				url : "/zipangu/interview/startInterview",
				type : "post",
				success : function(data){
					console.log("interview_num : "+data);
					console.log("모의면접 준비 완료");
					$('#interview_num').val(data);
					nextQuestionButton();
					recordButton.disabled = false;
					stopButton.disabled = true;
					startInterview.disabled = true;
				},
				error : function(){
					console.log("모의면접 실패");
				}
			});	
		});
	});

	//선택 버튼을 누르면 결과를 DB에 저장
	function insert_interview(){
			$.ajax({
				url : "/zipangu/interview/insertInterview",
				type : "post",
				data :  {
						interview_num : $('#interview_num').val()//인터뷰 번호 1개 고정
						,question_num : $('#question_num').val()//질문 번호
						,voicefilename : $('#voicefilename').val()//녹음 파일 이름
						,result : $('#demo2').val() //감정 분석 결과
						},
				success : function(data){
					console.log("답변 저장 완료"); //저장 완료 시 콘솔 로그 표시
				},
				error : function(e){
					console.log(e);
					console.log("답변 저장 에러");
				}
			});
		};
	
	//질문 표시
	function nextQuestionButton(){
		var arr = ${requestScope.questionList};
		var question_Doc = document.getElementById("question");
		var question_num = document.getElementById("question_num");
		var interviewInfo = document.getElementById("info");
		var interviewComplete = document.getElementById("interviewComplete");
		var startinterviewinfo = document.getElementById("startinterviewinfo");
		var interviewsector = document.getElementById("interviewsector");
		
		if(mouseClick === 0){
			interviewInfo.innerHTML = "[답변하기] 버튼을 누르고 아래 질문에 답변해주세요.";
			startinterviewinfo.style.display = "none";
			question_Doc.innerHTML = "첫번째 : "+arr[mouseClick].question_text;
			$('#question_num').val(arr[mouseClick].question_num);
			console.log("첫번째 질문이 표시 됩니다.");
			console.log(arr[mouseClick].question_num);
			mouseClick++;
		} else if(mouseClick === 1) {
			question_Doc.innerHTML = "두번째 : "+arr[mouseClick].question_text;
			$('#question_num').val(arr[mouseClick].question_num);
			console.log("두번째 질문이 표시 됩니다.");
			console.log(mouseClick+"질문 번호");
			mouseClick++;
		} else if(mouseClick === 2) {
			question_Doc.innerHTML = "세번째 : "+arr[mouseClick].question_text;
			$('#question_num').val(arr[mouseClick].question_num);
			console.log("세번째 질문이 표시 됩니다.");
			console.log(mouseClick+"질문 번호");
			mouseClick++;
		} else if(mouseClick === 3) {
			question_Doc.innerHTML = "네번째 : "+arr[mouseClick].question_text;
			$('#question_num').val(arr[mouseClick].question_num);
			console.log("네번째 질문이 표시 됩니다.");
			console.log(mouseClick+"질문 번호");
			mouseClick++;
		} else if(mouseClick === 4) {
			question_Doc.innerHTML = "마지막 : "+arr[mouseClick].question_text;
			$('#question_num').val(arr[mouseClick].question_num);
			console.log("마지막번째 질문이 표시 됩니다.");
			console.log(mouseClick+"질문 번호");
			mouseClick++;
		} else if(mouseClick === 5) {
			recordButton.disabled = true;
    		stopButton.disabled = true;
    		interviewComplete.style.display = "block";
    		interviewsector.style.display = "none";
		}
	}
</script>
<body>
<div align="center" id="interviewsector">
<h3 id="startinterviewinfo">[모의면접 시작]을 누르시면 시작합니다.</h3>
<button id="startInterview">모의면접 시작</button>
<!-- 질문 -->
<h4 id="info"></h4>
<h1 id="question"></h1>

<!-- 타이머 -->
<p id="counting" align="center"></p>

<!-- 음성녹음(진행 버튼) -->
<div align="center">
	<div id="controls" align="center">
		<button id="recordButton">답변하기</button>
		<button id="stopButton" disabled>답변완료</button>
	</div>
<!-- 음성 녹음(완료 리스트) -->
	<ul id="recordingsList" ></ul>
</div>
</div>
<div id="interviewComplete" style="display: none">
<h1> 모의 면접을 완료 하였습니다. </h1>
<h3> 면접 결과는 [결과보기] 버튼을 선택하시면 확인 하실 수 있습니다. </h3>
<button type="button" onclick="location.href='getinterviewResult'">결과 보기</button>
</div>

<!-- 진행 완료된 값들 저장 -->
<div align="center" style="display:none;">
<h2>----------------(interviewresult 저장되는 값들)----------------</h2>
		진행자 : <input type="text" id="userID" value="${sessionScope.userID}"><br>
		interivew_num : <input type="text" id="interview_num" value=""><br>
		question_num : <input type="text" id="question_num" value=""><br>
		저장되는 파일 이름 : <input type="text" id="voicefilename" value=""><br>
		문장 성향 : <input type="text" id="demo2">
<h2>----------------(STT 결과(미저장))----------------</h2>
		STT 결과 : <textarea id="demo" readonly="readonly"></textarea><br>
</div>

</body>
</html>
	<jsp:include page="../include/footer.jsp"></jsp:include>
