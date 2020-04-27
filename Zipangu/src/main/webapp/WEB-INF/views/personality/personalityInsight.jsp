<jsp:include page="../include/header.jsp"></jsp:include>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link type="text/css" rel="stylesheet" href="<c:url value='/resources/css/personalityInsight.css'/>">
<title>Zipangu</title>
<script src="<c:url value='/resources/js/jquery-3.4.1.js'/>"></script>	
<script type="text/javascript">

$(function(){
	
	$('#searchPe').on("click",function(){
	
		var revisedContent = $("#revisedContent").val();
		if(revisedContent.length == 0) {
			alert('텍스트 파일을 업로드해주세요.');
		}
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

				str += '<tr><th>항목</th><th>퍼센트</th></tr>';
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

				var traitAry = new Array();
				var rateAry = new Array();
				var length = $("tr").length;

				for(var i=0; i<length; i++) {
					traitAry[i] = $("tr:eq("+(i+1)+")>td:eq(0)").html();
					rateAry[i] = $("tr:eq("+(i+1)+")>td:eq(1)").html();
				};

				$.ajax({
					type:"post",
					url:"insertPersonality",
					data: {
						'trait' : traitAry,
						'rate' : rateAry
					},
					traditional: true,
					success: function(){
						console.log("성공");
						$.ajax({
							type:"post",
							url:"makeChart",
							success: function(data){
								console.log(data);
								var temp = "";

								for(var i=0; i<10; i++) {
									if(i%5==0) {
										temp += '<div class="flex-wrapper">';
									}	
									temp += '<div class="single-chart" style="font-size: 50%;">';
									temp += '<svg viewBox="0 0 36 36" class="circular-chart orange">';
									temp += '<path class="circle-bg" d="M18 2.0845 a 15.9155 15.9155 0 0 1 0 31.831 a 15.9155 15.9155 0 0 1 0 -31.831"/>';
									temp += '<path class="circle" stroke-dasharray="'+ data[i].rate +', 100" d="M18 2.0845 a 15.9155 15.9155 0 0 1 0 31.831 a 15.9155 15.9155 0 0 1 0 -31.831"/>';
									temp += '<text x="18" y="20.35" class="percentage">'+data[i].trait+' '+ data[i].rate +'%</text>';
								    temp += '</svg>';
							 		temp += '</div>';
							 		if(i%5==4) {
							 			temp += '</div>';
							 		};
								}
							 	$("#showChart").append(temp);
							},error: function(request,status,error){
									console.log("실패");
									console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
							}
						});
						
						var temp="";
						for(var i=0; i<length-1; i++) {
							if(i%10==0) {
								temp += '<table class="table-responsive">';
								temp += '<tr><th style="width: 70%;">항목</th><th style="width: 30%;">퍼센트</th></tr>';
							}
							temp += '<tr><td>'+traitAry[i]+'</td><td>'+Math.round(rateAry[i]*100)+'%</td></tr>';
							if(i%10==9 || i==length-2) {
								temp += '</table>';
								$("#personality_result"+Math.floor(i/10)).append(temp);
								temp="";
							}
						}
						$("#tables_1").removeAttr("hidden");
						$("#ment1").removeAttr("hidden");
					},
					error: function(request,status,error){
						console.log("실패");
						console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					}
				});
			
			},
			error:function(request,status,error){
				console.log("에러");
		        console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		    }
		});
	});
});

function openUploadTextForm() {
	open("<c:url value='/personality/uploadTextForm'/>",
			"_blank",
			"width=600, height=800");	
}
</script>
	<section class="banner_area ">
        <div class="banner_inner overlay d-flex align-items-center">
            <div class="container">
                <div class="banner_content text-center">
                    <div class="page_link">
                        <a href="<c:url value="/"/>">메인페이지s
                        </a>
                        <a href="<c:url value="/personality/personalityInsight"/>">성향 분석</a>
                    </div>
                </div>
                <div class="banner_content text-center">
                    <h2>성향 분석</h2>
                </div>
            </div>
        </div>
    </section>
	<!--================End Home Banner Area =================-->
	<!--================ Start service-2 Area =================-->
	<section class="service-area-2 section_gap">
		<div class="container">
			<div class="row align-items-center justify-content-center">
				<div class="col-lg-6">
					<div class="service-2-left">
						<div class="get-know">
							<p class="df-color">성향분석</p>
							<h1>Zipangu에서는 직접 쓴 텍스트를 통한 성향분석이 가능합니다.</h1>
							<hr>
							<p>위 서비스를 이용하기 위해서는 본인이 작성한 텍스트가 필요합니다. <br>
							나의 경험, 생각 및 반응에 관한 단어가 포함되어 있는 텍스트를 입력 해주세요.
							직접 텍스트 입력외에도 카카오토 대화내용 또는 txt 파일 업로드를 통해 이용이 가능합니다.
							위의 두 방법으로 성향분석을 원하실 경우 아래 '파일 업로드'버튼을 눌러주세요.
							유의미한 결과를 얻기 위해서는 적어도 3,500단어 이상, 이상적으로 6000단어가 필요합니다.
							100단어 정도로도 성향분석은 가능하지만, 분석 결과가 정확하지 않을 수 있는 점 양해 부탁드립니다.</p>			
							<br>
							<div align="center">
							<button class="genric-btn danger e-large" onclick="openUploadTextForm(); return false;">
								파일 업로드
							</button>
							</div>
						</div>
					</div>
				</div>
				<div class="col-lg-6">
					<div class="service-2-right">
						<div class="get-know">
							<p>사용할 텍스트 내용을 확인해 주세요. <br>텍스트를 업로드 하지 않고 아래에 직접 내용을 입력하셔도 됩니다.</p>
							<textarea rows="20" cols="80" id="revisedContent" style="resize: none;"></textarea>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="card-body" style="padding-top: 85px;">
			<div  class="row justify-content-center">
			    <a href="#" class="genric-btn danger e-large" id="searchPe" style="width: 300px; font-size: 15px;">
			    	성향분석
			    </a>
				<table id="insightList" hidden="hidden"></table>
			</div>
		</div>
	</section>
	<br><br>
	<div  class="row justify-content-center align-items-center" id="ment1" hidden="hidden">
		<div class="col-md-7">
	        <h2 class="mb-30 title_color">분석결과</h2>
	        <p>
		        나와 가장 관련 있는 키워드 (10개)
	        </p>
	        <hr>
	    </div>
    </div>
	<br><br>
	<div id="showChart" class="container"></div>
	<br><br><br><br>
<!-- <section class="features_area" id="features_counter"> -->
	<div class="container" id="tables_1" hidden="hidden">
		<div class="row counter_wrapper">
			<!-- single feature -->
			<div class="col-lg-3 col-md-6 col-sm-6">
				<div class="single_feature" id="personality_result0" >
				</div>
			</div>
			<!-- single feature -->
			<div class="col-lg-3 col-md-6 col-sm-6">
				<div class="single_feature" id="personality_result1">
				</div>
			</div>
			<!-- single feature -->
			<div class="col-lg-3 col-md-6 col-sm-6">
				<div class="single_feature" id="personality_result2">
				</div>
			</div>
			<!-- single feature -->
			<div class="col-lg-3 col-md-6 col-sm-6">
				<div class="single_feature" id="personality_result3">
				</div>
			</div>
		</div>
		<div class="row counter_wrapper">	
			<div class="col-lg-3 col-md-6 col-sm-6">
			</div>
			<!-- single feature -->
			<div class="col-lg-3 col-md-6 col-sm-6">
				<div class="single_feature" id="personality_result4">
				</div>
			</div>
			<!-- single feature -->
			<div class="col-lg-3 col-md-6 col-sm-6">
				<div class="single_feature" id="personality_result5">
				</div>
			</div>
			<div class="col-lg-3 col-md-6 col-sm-6">
			</div>
		</div>
		<br><br>
		<div align="center">
			<a href="<c:url value='/personality/keywordTimeline'/>">
				<button class="genric-btn danger e-large">타임라인 작성하러 가기</button>
			</a>
		</div>
	</div>
<br><br><br><br>
<!-- </section> -->
<jsp:include page="../include/footer.jsp"></jsp:include>
