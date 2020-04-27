<jsp:include page="../include/header.jsp"></jsp:include>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>Zipangu</title>
	<script src="<c:url value="/resources/js/jquery-3.4.1.min.js"/>"></script>
	<script src="<c:url value='/resources/js/recorder.js'/>"></script>
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/interview.css' />">
</head>
<body>
    <section class="banner_area">
        <div class="banner_inner overlay d-flex align-items-center">
            <div class="container">
                <div class="banner_content text-center">
                    <div class="page_link">
                        <a href="<c:url value="/"/>">메인페이지
                        </a>
                        <a href="<c:url value="/interview/getintro"/>">면접보기</a>
                    </div>
                    <h2>모의면접</h2>
                </div>
            </div>
        </div>
    </section>
    <div class="container">
        <div class="card-body">
	        <div class="row align-items-center justify-content-center">
	            <h1> 모의 면접에 오신 것을 환영합니다. </h1>
	            <hr>
	            <p class="text-center">
	                모의 면접에서는 직종에 관여하지 않는 역량 질문으로 14개의 질문 중 5개를 무작위로 제시합니다.
	                <br>
	                제시되는 질문에 모두 답변을 제출해야 답변 분석이 가능합니다.
	            </p>
	            <hr>
	            <h4 class="col-auto">다음 주의사항을 확인하시고 진행해 주시기 바랍니다.</h4>
	            <hr>
	            <p class="text-center h7">
	                1. 답변은 일본어로 해주시기 바랍니다.<br><br>
	                2. 답변 시간은 60초이며, 60초가 지나면 답변은 자동으로 종료됩니다.<br><br>
	                3. 답변은 수차례 시도 하실 수 있으며, 답변한 내용은 다시 들을 수 있습니다.<br><br>
	                4. 답변한 내용 중 제출할 수 있는 답변은 1개 입니다.<br>
	            </p>
	            <hr>
	            <p class="text-center h7">
	                답변이 너무 짧거나 인식을 못할 경우 분석이 불가능 합니다.
	            </p>
	        </div>
	        <div class="card-body row align-items-center justify-content-center">
	            <button type="button" onclick="location.href='getinterview'" class="btn btn-danger e-large">모의 면접 시작</button>
	        </div>
        </div>
    </div>
<!-- 	<div align="center"> -->
<!-- 		<div class="space"></div> -->
<!-- 			<h1> 모의 면접에 오신 것을 환영합니다. </h1> -->
<!-- 				<hr> -->
<!-- 			 <h5 class="footer_title"> -->
<!-- 				 모의 면접에서는 직종에 관여하지 않는 역량 질문으로 14개의 질문 중 5개를 무작위로 제시합니다.<br> -->
<!-- 				제시되는 질문에 모두 답변을 제출해야 답변 분석이 가능합니다.</h5> -->
<!-- 			<hr> -->
<!-- 			<p>다음 주의사항을 확인하시고 진행해 주시기 바랍니다.</p> -->
<!-- <div class="parent"> -->
<!-- 	    <div class="child1"> -->
<!-- 	    </div> -->
<!-- 	    <div class="child2"> -->
<!-- 	    <h3> -->
<!-- 	    		1. 답변은 일본어로 해주시기 바랍니다.<br> -->
<!-- 				2. 답변 시간은 60초이며, 60초가 지나면 답변은 자동으로 종료됩니다.<br> -->
<!-- 				3. 답변은 수차례 시도 하실 수 있으며, 답변한 내용은 다시 들을 수 있습니다.<br> -->
<!-- 				4. 답변한 내용 중 제출할 수 있는 답변은 1개 입니다.<br> -->
<!-- 		</h3> -->
<!-- 	    </div>	     -->
<!-- 	    <div class="child3"> -->
<!-- 	    </div> -->
<!-- </div> -->
<!-- </div> -->
<!-- 	<div align="center"> -->
<!-- 		<div class="space"> -->
<!-- 			<p>- 답변이 너무 짧거나 인식을 못할 경우 분석이 불가능 합니다.-</p> -->
<!-- 			<hr> -->
<!-- 		</div> -->
<!-- 			<button type="button" onclick="location.href='getinterview'" class="btn btn-danger">모의 면접 시작</button> -->
<!-- 		<div class="space"></div> -->
<!-- 	</div> -->
</body>
</html>
<jsp:include page="../include/footer.jsp"></jsp:include>