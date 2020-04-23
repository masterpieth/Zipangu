<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="../include/header.jsp"></jsp:include>

<link type="text/css" rel="stylesheet" href="<c:url value='/resources/css/datedropper.css'/>">

<script src="<c:url value='/resources/js/jquery-3.4.1.js'/>"></script> 
<script src="<c:url value='/resources/js/datedropper.pro.min.js '/>"></script> 

<script type="text/javascript">

$(function(){

	$(".episode").dateDropper({
		roundtrip: 'episode'
	});

	var temp = document.getElementById("traits_Selected").value;
	var traitArr = temp.split(",");	
	
	console.log(traitArr);
	
	for(var i in traitArr) {
		$("input[name=keywordSelected][value='"+traitArr[i]+"']").attr("checked",true);
	}
	
	$("input[name=keywordSelected]").on("click",function(){

		var checkbox = $("input[name=keywordSelected]:checked");
		var traitAry = new Array();
		
		checkbox.each(function(i){
			var tr = checkbox.parent().parent().eq(i);
			var td = tr.children();
			
			var trait = td.eq(0).html();
			traitAry[i] = trait;
		})
		
		$('#traits_Selected').val(traitAry);
		
	})
	
})

</script>

<form action="timelineUpdate" method="post">
	<section class="banner_area ">
        <div class="banner_inner overlay d-flex align-items-center">
            <div class="container">
                <div class="banner_content text-center">
                    <h2>타임라인 글 수정</h2>
                </div>
            </div>
        </div>
    </section>
    <!--================End Home Banner Area =================--> 
	<br><br>
	<div class="container">
		<div class="card-body" style="padding-bottom: 0px;">
			<table>
				<tr>
					<th colspan="2">1. 수정하고 싶은 에피소드의 날짜를 입력해주세요.</th>
				</tr>
				<tr>
					<th colspan="2">
					<time>처음 시작한 날짜 : <input type="text" id="start_Date" name="start_Date" data-dd-format="Y/m/d" data-dd-roundtrip="episode" class="episode" required="required" value="<fmt:parseDate value="${timelineVO.start_Date}" var="dateFmt" pattern="yyyy-MM-dd"/><fmt:formatDate value="${dateFmt}" pattern="yyyy-MM-dd"/>">
					~ 끝난 날짜 : <input type="text" id="finish_Date" name="finish_Date" data-dd-format="Y/m/d" data-dd-roundtrip="episode" class="episode" required="required" value="<fmt:parseDate value="${timelineVO.finish_Date}" var="dateFmt" pattern="yyyy-MM-dd"/><fmt:formatDate value="${dateFmt}" pattern="yyyy-MM-dd"/>"></time>
					</th>
				</tr>
				<tr>
					<th colspan="2">2. 수정하고 싶은 에피소드의 키워드를 아래 표에서 선택해주세요.
				</tr>
			</table>
		</div>
	</div>
		<div class="container">
			<div class="card-body" style="border: gray;">
				<div class="row">
					<!-- single feature -->
					<div class="col-lg-3 col-md-6 col-sm-6">
						<div class="single_feature" id="personality_result0">	
							<table>
								<c:forEach items="${requestScope.keywordList}" begin="0" end="9" var="keyword">
									<tr>
										<td>${keyword.trait}</td><td>${Math.round(keyword.rate)} %</td><td><input type="checkbox" name="keywordSelected" value="${keyword.trait}"></td>
									</tr>
								</c:forEach>
							</table>
						</div>
					</div>
					<!-- single feature -->
					<div class="col-lg-3 col-md-6 col-sm-6">
						<div class="single_feature" id="personality_result1">
							<table>
								<c:forEach items="${requestScope.keywordList}" begin="10" end="19" var="keyword">
									<tr>
										<td>${keyword.trait}</td><td>${Math.round(keyword.rate)} %</td><td><input type="checkbox" name="keywordSelected" value="${keyword.trait}"></td>
									</tr>
								</c:forEach>
							</table>
						</div>
					</div>
					<!-- single feature -->
					<div class="col-lg-3 col-md-6 col-sm-6">
						<div class="single_feature" id="personality_result2">
							<table>
								<c:forEach items="${requestScope.keywordList}" begin="20" end="29" var="keyword">
									<tr>
										<td>${keyword.trait}</td><td>${Math.round(keyword.rate)} %</td><td><input type="checkbox" name="keywordSelected" value="${keyword.trait}"></td>
									</tr>
								</c:forEach>
							</table>
						</div>
					</div>
					<!-- single feature -->
					<div class="col-lg-3 col-md-6 col-sm-6">
						<div class="single_feature" id="personality_result3">
							<table>
								<c:forEach items="${requestScope.keywordList}" begin="30" end="39" var="keyword">
									<tr>
										<td>${keyword.trait}</td><td>${Math.round(keyword.rate)} %</td><td><input type="checkbox" name="keywordSelected" value="${keyword.trait}"></td>
									</tr>
								</c:forEach>
							</table>
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
							<table>
								<c:forEach items="${requestScope.keywordList}" begin="40" end="49" var="keyword">
									<tr>	
										<td>${keyword.trait}</td><td>${Math.round(keyword.rate)} %</td><td><input type="checkbox" name="keywordSelected" value="${keyword.trait}"></td>
									</tr>
								</c:forEach>
							</table>
						</div>
					</div>
					<!-- single feature -->
					<div class="col-lg-3 col-md-6 col-sm-6">
						<div class="single_feature" id="personality_result5">
							<table>
								<c:forEach items="${requestScope.keywordList}" begin="50" end="52" var="keyword">
									<tr>
										<td>${keyword.trait}</td><td>${Math.round(keyword.rate)} %</td><td><input type="checkbox" name="keywordSelected" value="${keyword.trait}"></td>
									</tr>
								</c:forEach>
							</table>
						</div>
					</div>
					<div class="col-lg-3 col-md-6 col-sm-6">
					</div>
				</div>
			</div>
		</div>
		<div class="card-body" align="center">
			<table>
				<tr>
					<th>3. 내가 고른 키워드들 :</th><td><input type="text" id="traits_Selected" name="traits_Selected" readonly="readonly"  value="${timelineVO.traits_Selected}" style="width: 100%;"></td>
				</tr>
				<tr>
					<th>4. 에피소드 제목 : </th><td><input type="text" name="episode_Title" value="${timelineVO.episode_Title}" style="width: 100%;" required="required"></td>
				</tr>
				<tr>
					<th>5. 에피소드 내용 : </th><td><textarea rows="10" cols="120" name="episode_Content" required="required" required="required" >${timelineVO.episode_Content}</textarea></td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="submit" class="genric-btn danger e-large" value="에피소드 수정" style="text-align: center;">
						<a href="<c:url value='/personality/keywordTimeline'/>">
							<input type="button" class="genric-btn danger e-large" value="취소">
						</a>
					</td>
				</tr>
			</table>
		</div>		
		<input type="hidden" name="timeline_Num" value="${timelineVO.timeline_Num}">
	</form>

</body>
</html>