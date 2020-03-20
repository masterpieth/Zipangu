<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="resources/js/jquery-3.4.1.js"></script>
<script type="text/javascript">

$(function(){
	
	$('#contentInput').on("keyup",function(){
		
		var fileToLoad = document.getElementById("kakaoFile").files[0];
		var fileReader = new FileReader();

		fileReader.onload = function(fileLoadedEvent){
			var textFromFileLoaded = fileLoadedEvent.target.result;
			document.getElementById("kakaoContent").value = textFromFileLoaded;
		};

		fileReader.readAsText(fileToLoad, "UTF-8");
		
	});



	$('#search').on("click",function(){
		
		var revisedContent = $("#revisedContent").val();
		
		$.ajax({
			url : "https://gateway.aibril-watson.kr/personality-insights/api/v3/profile?version=2017-10-13",
			type : "post",
			headers: {
	        	'Authorization':'Basic ' + btoa("eb27ee1e-673a-4712-b88d-58e3df442b69:SJCDaRyR5O4z"),
	            'Content-Type':'text/plain;charaset=utf-8',
	            'Accept': 'application/json',
	            'Content-Language': 'ko'              
	        },
			data : revisedContent,
			success: function(data){
				console.log(data);
				
				var resultPersonality = data.personality;
				var resultNeeds = data.needs;
				var resultValues = data.values;
				var str = '';

				$.each(resultPersonality,function(j){
					str += '<tr><td>'+resultPersonality[j].name+'</td><td>'+resultPersonality[j].percentile+'</td></tr>';
					str += '<tr><td>'+resultPersonality[j].children[0].name+'</td><td>'+resultPersonality[j].children[0].percentile+'</td></tr>';
					
					$.each(resultPersonality,function(i){
						str += '<tr><td>'+resultPersonality[j].children[i+1].name+'</td><td>'+resultPersonality[j].children[i+1].percentile+'</td></tr>';
					});
					
				});

				$.each(resultNeeds,function(i){
					str += '<tr><td>'+resultNeeds[i].name+'</td><td>'+resultNeeds[i].percentile+'</td></tr>';
				})
				
				$.each(resultValues,function(i){
					str += '<tr><td>'+resultValues[i].name+'</td><td>'+resultValues[i].percentile+'</td></tr>';
				})

				$("#insightList").append(str);
			
			},
			error:function(request,status,error){
				console.log("에러");
		        console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		    }
		});
		
	});
	
});

	
</script>
<title>텍스트 파일을 읽어오는 거</title>
</head>
<body>
	
	<form action="sendKakao" method="post">
		<input type="file" id="kakaoFile" required="required">
		<textarea id="kakaoContent" name="kakaoContent" cols="10" rows="10" hidden="hidden"></textarea>
		<input type="text" name="kakaoName" id="contentInput" required="required">
		<input type="submit" value="파일등록">
		
	</form>
	
	<textarea id="revisedContent" hidden="hidden">
		${requestScope.revisedContent}
	</textarea>	
	
	<input type="button" value="분석" id="search">
	
	<form action="insertPersonality" method="post">
	
		<table id="insightList"></table>
		
	</form>
	
	
</body>
</html>