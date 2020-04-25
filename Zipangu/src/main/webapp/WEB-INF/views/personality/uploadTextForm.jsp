<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="<c:url value='/resources/js/jquery-3.4.1.js'/>"></script>	

<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/template_css/style.css?v=2">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>

<script type="text/javascript">

$(function(){

	//카카오톡, txt 탭
	$(".card > ul").click(function(){
		$(this).toggleClass("active");
		$(".tab-content").toggleClass("active");
    });

    $(".col-sm-3 > ul").click(function(){
        $(this).toggleClass("active");
    })

    
    //이름 적을 때 txt 파일 불러와짐
	$('#kakaoName').on("keyup",function(){
		
		var fileToLoad = document.getElementById("kakaoTxtFile").files[0];
		var fileReader = new FileReader();

		fileReader.onload = function(fileLoadedEvent){
			var textFromFileLoaded = fileLoadedEvent.target.result;
			document.getElementById("kakaoContent").value = textFromFileLoaded;
		};

		fileReader.readAsText(fileToLoad, "UTF-8");
		
	});
});

function exit() {
	var data = {
			"kakaoName": $("#kakaoName").val(),
			"kakaoContent" :  $("#kakaoContent").val()
		};
	var jsonData = JSON.stringify(data);
	
	$.ajax({
		  url: 'sendKakao',
		  type: 'post',
		  data: jsonData,
		  contentType : 'application/json;charaset=utf-8',
		  dataType : "text",
		  success: function(data){
			  console.log("성공");
			  console.log(data);
				var revisedDoc = opener.document.getElementById("revisedContent");
				revisedDoc.value=data;

				close();
		  },
		  error: function(request,status,error){
				console.log("실패");
				console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
	});
}

function exit2() {
	var fileToLoad = document.getElementById("textFile1").files[0];
	var fileReader = new FileReader();

	fileReader.onload = function(fileLoadedEvent){
		var textFromFileLoaded = fileLoadedEvent.target.result;
		document.getElementById("textContent1").value = textFromFileLoaded;
		var revisedDoc = opener.document.getElementById("revisedContent");
		revisedDoc.value=document.getElementById("textContent1").value;
			
	};

	fileReader.readAsText(fileToLoad, "UTF-8");
	
	close();
}
</script>


</head>
<body>
    <div class="container-fluid">
        <div class="card">
            <div class="col-sm-9">
                <div class="card-body">
		            <ul class="nav nav-tabs" role="tablist">
		                <li role="presentation" class="nav-item active">
		                    <a href="#kakaoFile" aria-controls="kakaoFile" role="tab" data-toggle="tab">카카오톡 파일 업로드</a>
		                </li>
		                <li role="presentation" class="nav-item">
		                    <a href="#txtFile" aria-controls="txtFile" role="tab" data-toggle="tab">텍스트 파일 업로드</a>
		                </li>
		            </ul>
		            <div class="tab-content">
		                <div role="tabpanel" class="tab-pane active" id="kakaoFile">
		                    <p style="padding-top: 30px; padding-bottom: 25px;">1.아래의 그림을 참조하여 txt 파일을 업로드 해주세요</p>
		                    <input type="file" id="kakaoTxtFile" required="required">
		                    <img alt="카카오톡txt업로드방법" src="<c:url value='/resources/img/kakaoUpload.JPG'/>" width="500" height="500">
		                        
		                    <p style="padding-top: 30px; padding-bottom: 25px;">2.카카오톡 프로필 상의 나의 이름을 입력해주세요.</p>
		                    <img alt="카카오톡이름작성" src="<c:url value='/resources/img/kakaoUpload2.JPG'/>" width="400" height="200">
		                    <div style="padding-top: 30px;">
		                        	이름 입력 : <input type="text" name="kakaoName" id="kakaoName" required="required">
		                                    <input type="text" name="kakaoContent" id="kakaoContent" hidden="hidden">
		                    </div>
		                    <div align="center" style="padding-top: 30px; padding-bottom: 25px;">
		                        <button type="button" class="genric-btn danger e-large" onclick="exit()">등록하기</button>
		                     </div>
		                </div>
		                <div role="tabpanel" class="tab-pane" id="txtFile">
		                    <p style="padding-top: 30px; padding-bottom: 25px;">1. 내가 쓴 글이 적혀 있는 txt 파일을 업로드 해주세요.</p>
		                    <input type="file" id="textFile1" required="required">
		                    <input type="text" id="textContent1" hidden="hidden">
		                    <br><br>
		                    <p align="center">
		                    <button type="button" class="genric-btn danger e-large" onclick="exit2()">등록하기</button>
		                    </p>
		                </div>
		            </div>
                </div>
             </div>
        </div>
    </div>
</body>
</html>