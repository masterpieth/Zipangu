<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link type="text/css" rel="stylesheet" href="<c:url value='/resources/css/datedropper.css'/>">

<script src="<c:url value='/resources/js/jquery-3.4.1.js'/>"></script> 
<script src="<c:url value='/resources/js/datedropper.pro.min.js '/>"></script> 

<script type="text/javascript">

$(function(){

	$.ajax({				
		type:"post",
		url:"makeChart",
		success: function(data){
			console.log("성공");
			console.log(data);
			console.log(data.length);
			var temp="";
			var length = data.length;
			for(var i=0; i<length-1; i++) {
				if(i%10==0) {
					temp += '<table>';
					temp += '<tr><th>항목</th><th>퍼센트</th><th>선택</th></tr>';
				}
				temp += '<tr><td>'+data[i].trait+'</td><td>'+Math.round(data[i].rate*100)+'</td>';
				temp += '<td><div class="primary-checkbox"><input type="checkbox" name="keywordSelected" id="default-checkbox['+i+']"><label for="default-checkbox['+i+']"></label></div></td></tr>';
				if(i%10==9 || i==length-2) {
					temp += '</table>';
					$("#personality_result"+Math.floor(i/10)).append(temp);
					temp="";
				}
			} 
			$(".episode").dateDropper({
				roundtrip: 'episode'
			});

			$("input[name=keywordSelected]").on("click",function(){

				var checkbox = $("input[name=keywordSelected]:checked");
				var traitAry = new Array();
				
				checkbox.each(function(i){
					var tr = checkbox.parent().parent().parent().eq(i);
					var td = tr.children();
					
					var trait = td.eq(0).html();
					traitAry[i] = trait;
				})
				
				$('#traits_Selected').val(traitAry);
				
			})
			
		},

		
		error:function(request,status,error){
			console.log("에러");
	        console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	    }
	});
})

</script>
</head>
<body>
<jsp:include page="../include/header.jsp"></jsp:include>
<form action="timelineWrite" method="post">
	<section class="banner_area ">
        <div class="banner_inner overlay d-flex align-items-center">
            <div class="container">
                <div class="banner_content text-center">
                    <h2>타임라인 글 작성</h2>
                </div>
            </div>
        </div>
    </section>
   	<!--================End Home Banner Area =================--> 
   	<br><br>
	<div class="container">
		<div class="card-body">
			<p>1. 작성하고 싶은 에피소드의 날짜를 입력해주세요.</p>
			<p>처음 시작한 날짜 : <input type="text" id="start_Date" name="start_Date" data-dd-format="Y/m/d" data-dd-roundtrip="episode" class="episode">
				~ 끝난 날짜 : <input type="text" id="finish_Date" name="finish_Date" data-dd-format="Y/m/d" data-dd-roundtrip="episode" class="episode">  
			</p>
			<p>2. 작성하고 싶은 에피소드의 키워드를 아래 표에서 선택해주세요.</p>
			<p>내가 고른 키워드들 : <input type="text" id="traits_Selected" name="traits_Selected" readonly="readonly"><p>
		</div>
		<div class="container" id="tables_1">
			<div class="card-body" style="border: gray;">
				<div class="row">
					<!-- single feature -->
					<div class="col-lg-3 col-md-6 col-sm-6">
						<div class="single_feature" id="personality_result0">
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
				<br>
				<div class="row">
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
			</div>
		</div>
		<div class="card-body">
			<p>에피소드 제목 : <input type="text" name="episode_Title"></p>
			<p>에피소드 내용 : <textarea rows="" cols="" name="episode_Content"></textarea></p>
			<br>
			<p><input type="submit" value="에피소드 등록">
			<a href="<c:url value='/personality/keywordTimeline'/>">
				<input type="button" value="취소">
			</a>
			</p>
		</div>
	</div>
</form>
<jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>