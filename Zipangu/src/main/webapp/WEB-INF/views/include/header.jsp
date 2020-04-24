<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="<c:url value='/resources/template_img/favicon.png' />" type="image/png">
<!--     Bootstrap CSS -->
<link rel="stylesheet" href="<c:url value='/resources/template_css/bootstrap.min.css' />">
<link rel="stylesheet" href="<c:url value='/resources/template_vendors/linericon/style.css' />">
<link rel="stylesheet" href="<c:url value='/resources/template_css/font-awesome.min.css' />">
<link rel="stylesheet" href="<c:url value='/resources/template_css/magnific-popup.css' />">
<link rel="stylesheet" href="<c:url value='/resources/template_vendors/owl-carousel/owl.carousel.min.css' />">
<link rel="stylesheet" href="<c:url value='/resources/template_vendors/lightbox/simpleLightbox.css' />">
<link rel="stylesheet" href="<c:url value='/resources/template_vendors/nice-select/css/nice-select.css' />">
<link rel="stylesheet" href="<c:url value='/resources/template_vendors/animate-css/animate.css' />">
<!--     main css -->
<link rel="stylesheet" href="<c:url value='/resources/template_css/style.css' />">
<script src="<c:url value='/resources/js/jquery-3.4.1.js'/>"></script> 
<script src="<c:url value='/resources/js/popper.min.js' />"></script>
<script src="<c:url value='/resources/template_js/bootstrap.min.js' />"></script>
<script>
        $(function (){
            $('#msgButton').on('click',function(){
                var hiddenVal = $('input.msg_location').val();
	        	openUploadMessenger(hiddenVal);
            })
        })
        function openUploadMessenger(hiddenVal) {
            open('<c:url value="/msg/msg_start?' + hiddenVal + '"/>',
                    "_blank",
                    "width=1000, height=800");   
        }
    </script>
</head>
<body>
<!--================ Start Header Menu Area =================-->
    <header class="header_area">
        <div class="main_menu">
            <nav class="navbar navbar-expand-lg navbar-light">
                <div class="container">
                    <!-- Brand and toggle get grouped for better mobile display -->
                    <a class="navbar-brand logo_h" href="<c:url value="/"/>"><img src="${pageContext.request.contextPath}/resources/template_img/logo.png" alt=""></a>
                    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
                     aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <!-- Collect the nav links, forms, and other content for toggling -->
                    <div class="collapse navbar-collapse offset" id="navbarSupportedContent">
                        <ul class="nav navbar-nav menu_nav ml-auto">
                            <li class="nav-item active"><a class="nav-link" href="<c:url value="/"/>">메인페이지</a></li>
                            <li class="nav-item submenu dropdown">
                                <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                                 aria-expanded="false">자기분석</a>
                                <ul class="dropdown-menu">
                                    <li class="nav-item"><a class="nav-link" href="<c:url value='/personality/personalityInsight'/>">성향 분석</a></li>
                                    <li class="nav-item"><a class="nav-link" href="<c:url value='/personality/keywordTimeline'/>">성향키워드 타임라인</a></li>
                                    <li class="nav-item"><a class="nav-link" href="<c:url value='/analysis/company'/>">기업 분석</a></li>
                                    <li class="nav-item"><a class="nav-link" href="<c:url value='/analysis/entrysheet'/>">자기소개서 추천</a></li>
                                </ul>
                            </li>
                            <li class="nav-item submenu dropdown">
                                <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                                 aria-expanded="false">이력서</a>
                                <ul class="dropdown-menu">
                                    <li class="nav-item"><a class="nav-link" href="<c:url value='/resume/resumeForm'/>">새 이력서</a></li>
                                    <li class="nav-item"><a class="nav-link" href="<c:url value="/resume/resumeList"/>">이력서 목록</a></li>
                                </ul>
                            </li>
                            <li class="nav-item submenu dropdown">
                                <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                                 aria-expanded="false">멘토링</a>
                                <ul class="dropdown-menu">
                                    <li class="nav-item"><a class="nav-link" href="<c:url value='/schedule/scheduleForm'/>">예약하기</a></li>
                                </ul>
                            </li>
                            <li class="nav-item submenu dropdown">
                                <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                                 aria-expanded="false">모의면접</a>
                                <ul class="dropdown-menu">
                                    <li class="nav-item"><a class="nav-link" href="<c:url value='/interview/getinterview'/>">면접보기</a></li>
                                    <li class="nav-item"><a class="nav-link" href="<c:url value='/interview/getinterviewResult'/>">결과조회</a></li>
                                	<li class="nav-item"><a class="nav-link" href="<c:url value='/interview/interviewSelect'/>">음성 재생 테스트</a></li>
                                </ul>
                            </li>
                            <c:choose>
                                <c:when test="${sessionScope.userID == null}">
                                    <li class="nav-item"><a class="nav-link" href="<c:url value='/member/loginForm'/>">로그인</a></li>
                                </c:when>
                                <c:when test="${sessionScope.userID != null}">
                                    <li class="nav-item"><a class="nav-link" href="about-us.html">마이페이지</a></li>
                                    <li class="nav-item"><a class="nav-link" href="<c:url value='/member/logout'/>">로그아웃</a></li>
                                    <li class="nav-item"><a class="nav-link" href="#">${sessionScope.userID}님 반갑습니다.</a></li>
                                </c:when>
                            </c:choose>
                        </ul>
                        <ul class="nav navbar-nav ml-auto">
                            <div class="social-icons d-flex align-items-center">
                            <section id="msgSection">
                                <c:choose>
                                    <c:when test="${sessionScope.authority=='2'}">
                                        <input type="hidden" class="msg_location" value="mentee_id=${sessionScope.userID}&mentor_id=admin">
                                    </c:when>
                                    <c:when test="${sessionScope.authority=='1'}">
                                        <input type="hidden" class="msg_location" value="mentee_id=admin&mentor_id=${sessionScope.userID}">
                                    </c:when>
                                </c:choose>
                                <button id="msgButton">
                                    <i id="msgFa"class="fa fa-comments-o"></i>
                                    <label id="msgLabel" class="col-form-label" style="font-size: 10px;">메신저/기업검색</label>
                                </button>
                                </a>
                            </section>
                            </div>
                        </ul>
                    </div>
                </div>
            </nav>
        </div>
    </header>
</body>
</html>