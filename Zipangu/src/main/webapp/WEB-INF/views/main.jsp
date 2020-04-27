<jsp:include page="include/header.jsp"></jsp:include>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
<title>Zipangu</title>
</head>
    <!--================ Start Home Banner Area =================-->
    <section class="home_banner_area overlay">
        <div class="banner_inner">
            <div class="container">
                <div class="row fullscreen d-flex align-items-center justify-content-center" style="height: 700px;">
                    <div class="banner_content">
                        <h2>
                            Zipangu<br>
                            여러분의 일본 취업을 도와드립니다!<br>
                        </h2>
                        <p>
                            Zipangu는 일본에서 일하고 싶은 여러분들을 위한 다양한 맞춤형 종합 취업 지원 서비스를 제공합니다. 성향분석 및 기업분석을 통한 자기분석, 멘토링, 모의면접 등<br>
                            Zipangu의 다양한 서비스를 체험해 보세요!       
                        </p>
                        <br>
                        <a class="primary-btn text-uppercase" href="<c:url value="personality/personalityInsight"/>">성향분석 시작하기</a>
                        <br><br>
                        <p>
                        자기 분석 서비스는 성향분석으로부터 시작이 가능합니다. <br>먼저 Zipangu의 성향 분석 서비스를 이용해 보세요!
                        </p>
                    </div>
                </div>
                
            </div>
        </div>
    </section>
    <!--================ End Home Banner Area =================-->
    <!--================ Start service-2 Area =================-->
    <section class="service-area-2" style="padding-top: 50px;">
        <div class="container">
            <div class="row align-items-center justify-content-center">
                <div class="col-lg-6">
                    <div class="service-2-left">
                        <div class="get-know">
                            <h1>전문가에게 받는 이력서 첨삭</h1>
                            <p>1:1 매칭을 통한 전문 첨삭을 통한 확실한 취업 준비</p>
                        </div>
                        <div class="author-lacture">
                            <p>
                                모르겟다.. 홍보멘트가 필요합니다
                            </p>
                            <div class="author-title">
                                <a href="#" data-toggle="modal" data-target="#inputTitle"><button class="primary-btn text-uppercase">이력서 작성 바로가기</button></a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="service-2-right">
                        <div class="row">
                            <div class="col-lg-6 col-md-6 col-sm-6">
                                <div class="left-image">
                                    <div class="s-img"><img class="img-fluid" src="${pageContext.request.contextPath}/resources/template_img/service/service4.jpg" alt=""></div>
                                    <div class="s-img"><img class="img-fluid" src="${pageContext.request.contextPath}/resources/template_img/service/service5.jpg" alt=""></div>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-6">
                                <div class="right-image">
                                        <div class="s-img"><img class="img-fluid" src="${pageContext.request.contextPath}/resources/template_img/service/service6.jpg" alt=""></div>
                                        <div class="s-img"><img class="img-fluid" src="${pageContext.request.contextPath}/resources/template_img/service/service7.jpg" alt=""></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!--================ End service-2 Area =================-->
    
    <!--================ Start service Area =================-->
    <section class="service-area section_gap">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-7">
                    <div class="main_title">
                        <h1>개인 맞춤형 기업 분석</h1>
                        <p>Zipangu만의 취업 지원 서비스</p>
                    </div>
                </div>
            </div>
            <div class="row justify-content-center">
                <!-- single service -->
                <div class="col-lg-4 col-md-4 col-sm-6">
                    <div class="single-service">
                        <div class="service-thumb">
                            <img class="img-fluid" src="${pageContext.request.contextPath}/resources/template_img/service/service1.jpg" style="height: 195px;">
                        </div>
                        <div class="service-details">
                            <h5 style="color: white;">22632개의 기업정보</h5>
                            <p>
                                Zipangu에 등록된 22632개의 기업정보를 토대로 <br> 사용자에게 적합한 기업 목록을 추천합니다. <br>
                                기업분석을 통해 사용자는 다양한 기업 종류에 대한 정보를 얻고 활용할 수 있습니다.
                            </p>
                        </div>
                    </div>
                </div>
                <!-- single service -->
                <div class="col-lg-4 col-md-4 col-sm-6">
                    <div class="single-service">
                        <div class="service-thumb">
                            <img class="img-fluid" src="${pageContext.request.contextPath}/resources/template_img/service/service2.jpg" style="height: 195px;">
                        </div>
                        <div class="service-details">
                            <h5 style="color: white;">개인 맞춤형 기업 추천</h5>
                            <p>
                                업로드된 텍스트를 바탕으로 Zipangu에 등록된 기업 중 사용자에게 가장 적합한 결과를 추천합니다. <br>
                                Zipangu의 기업 분석 기능을 통해 기업 조사 혹은 진로 탐색에 도움을 얻을 수 있습니다.
                            </p>
                        </div>
                    </div>
                </div>
                <!-- single service -->
                <div class="col-lg-4 col-md-4 col-sm-6">
                    <div class="single-service">
                        <div class="service-thumb">
                            <img class="img-fluid" src="${pageContext.request.contextPath}/resources/template_img/service/service3.jpg" style="height: 195px;">
                        </div>
                        <div class="service-details">
                            <h5 style="color: white;">관심기업 분석 통한 자기소개서 추천</h5>
                            <p>
                                기업 분석만으로 끝나지 않고 Zipangu는 최종 합격까지 생각합니다. <br>
                                사용자가 등록한 기업 목록을 기반으로 동일한 업종에의 합격 자기소개서를 제공합니다.<br> 
                                선배들의 자기소개서를 확인하고 관심기업에의 합격 가능성을 올려보세요.
                            </p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row justify-content-center">
                <a href="<c:url value="analysis/company"/>"><button class="primary-btn text-uppercase">기업 분석 바로가기</button></a>
            </div>
        </div>
    </section>
    <!--================ End service Area =================-->
    <!--================ Start CTA Area =================-->
    <div class="cta-area section_gap overlay">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <h1>멘토링~~~~ 예약하기로 가는 div</h1>
                    <p>
                        이력서를 작성하셨나요? 첨삭을 받으셔야죠 호호하ㅏ 하 어서 이 버튼을 눌러라!
                        멘토링~~~~ 예약하기로 가는 div멘토링~~~~ 예약하기로 가는 div
                        멘토링~~~~ 예약하기로 가는 div멘토링~~~~ 예약하기로 가는 div
                        멘토링~~~~ 예약하기로 가는 div멘토링~~~~ 예약하기로 가는 div
                    </p>
                    <a href="<c:url value="schedule/scheduleForm"/>" class="primary-btn">멘토링 예약하기</a>
                </div>
            </div>
        </div>
    </div>
    <!--================ End CTA Area =================-->
    <!--================ Start Blog Area =================-->
    <section class="section_gap blog_area">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-7">
                    <div class="main_title">
                        <h2>모의면접</h2>
                        <p>
                           	면접에서 가장 중요한 핵심은 질문에 대한 답변이며, 답변의 느낌 또한 중요합니다.
                           	긍정적인 단어로 구성하여 질문에 대해 답변을 한다면, '면접관'은 긍정적인 사고를 가지고 있는 가지고 있는 '지원자'라는 인식을 심어줄수 있습니다.
                        </p>
                    </div>
                </div>
            </div>
            <div class="row justify-content-center">
                <!-- single-blog -->
                <div class="col-lg-4 col-md-4 col-sm-6">
                    <div class="single-blog">
                        <div class="blog-thumb">
                            <img class="img-fluid" src="${pageContext.request.contextPath}/resources/template_img/service/service8.jpg" style="width: 350px; height: 220px;">
                        </div>
                        <div class="blog-details">
                            <h5>온라인 역량면접<br></h5>
                            <p>
                            	'온라인 역량면접'에서는 역량에 대한 평가를 하기 위해 면접관들이 자주 질문하는 14개의 질문을 무작위로 출제하여, 지원자의 답변 성향을 분석해 드립니다.
                            </p>
                            <p>
                            	총 5개의 질문에 대해 모두 답변을 해야 분석 결과를 확인하실 수 있습니다. 실제 면접에서 질문에 대해 답변을 안하거나, 넘기실건 아니시죠?
                            </p>
                        </div>
                    </div>
                </div>
                <!-- single-blog -->
                <div class="col-lg-4 col-md-4 col-sm-6">
                    <div class="single-blog">
                        <div class="blog-thumb">
                            <img class="img-fluid" src="${pageContext.request.contextPath}/resources/template_img/service/service10.jpg" style="width: 350px; height: 220px;">
                        </div>
                        <div class="blog-details">
                            <h5>답변 성향 분석<br></h5>
                            <p>
								지원자가 답변한 문장의 성향을 분석합니다.
								지원자의 답변의 성향을 '긍정적 / 중립적 / 부정적' 총 3개의 분석 결과로 제공해 드립니다.
                            </p>
                            <p>-답변이 너무 짧게 하거나, 음성 인식이 되지 않을시엔 '분석 불가'-</p>
                        </div>
                    </div>
                </div>
                <!-- single-blog -->
                <div class="col-lg-4 col-md-4 col-sm-6">
                    <div class="single-blog">
                        <div class="blog-thumb">
                            <img class="img-fluid" src="${pageContext.request.contextPath}/resources/template_img/service/service9.jpg" style="width: 350px; height: 220px;">
                        </div>
                        <div class="blog-details">
                            <h5>분석 결과 조회<br></h5>
                            <p>
                            	출제되는 5개의 질문에 대해 답변을 완료 하시면 분석 결과를 조회하실 수 있습니다.
                            	날짜와 질문, 답변 성향, 다시 듣기를 통해 질문에 대한 답변을 다시 확인하실 수 있습니다.
                            </p>
                        </div>
                    </div>
                </div>
            </div><br>
            <div class="row justify-content-center">
                <a href="<c:url value="interview/getintro"/>"><button class="primary-btn text-uppercase">모의면접 바로가기</button></a>
            </div>
        </div>
    </section>
    <!--================ End Blog Area =================-->
<jsp:include page="include/footer.jsp"></jsp:include>