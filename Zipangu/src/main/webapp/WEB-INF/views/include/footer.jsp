<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html>
<body>
    <!--================  start footer Area =================-->
    <footer class="footer-area">
        <div class="footer_top section_gap_top">
            <div class="container">
                <div class="row">
                    <div class="col-lg-3 col-md-6 col-sm-6">
                        <div class="single-footer-widget">
                            <h5 class="footer_title">About Zipangu</h5>
                            <p class="about-text">
                                일본 취업을 희망하는 한국인들을 대상으로 취업 지원 서비스를 제공하는 Zipangu는,
                                성향 분석을 통한 기업 추천 및 합격 자소서 조회, 이력서 작성부터 면접까지 취업 활동과 관련된 
                                모든 서비스를 제공하는 종합 취업 서비스 플랫폼입니다.
                            </p>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6 col-sm-6">
                     </div>
                     <div class="col-lg-3 col-md-6 col-sm-6">
                     </div>
                    <div class="col-lg-2 col-md-6 col-sm-6">
                        <div class="single-footer-widget">
                            <h5 class="footer_title">Navigation Links</h5>
                            <div class="row">
                                <div class="col-5">
                                    <ul class="list">
                                        <li><a href="<c:url value='/'/>">Main</a></li>
                                        <li><a href="<c:url value='/personality/personalityInsight'/>">Personality</a></li>
                                        <li><a href="<c:url value='/analysis/company'/>">Company</a></li>
                                        <li><a href="<c:url value='/analysis/entrysheet'/>">Entrysheet</a></li>
                                    </ul>
                                </div>
                                <div class="col-5">
                                    <ul class="list">
                                        <li><a href="#" data-toggle="modal" data-target="#inputTitle">Resume</a></li>
                                        <li><a href="<c:url value="/schedule/scheduleForm"/>">Mentoring</a></li>
                                        <li><a href="<c:url value='/interview/getinterview'/>">Interview</a></li>
                                        <c:choose>
                                            <c:when test="${sessionScope.userID == null}">
                                                <li><a href="<c:url value="/member/loginForm"/>">Login</a></li>
                                            </c:when>
                                            <c:when test="${sessionScope.userID != null}">
                                                <li><a href="<c:url value="/member/logout"/>">Logout</a></li>
                                            </c:when>
                                        </c:choose>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="copyright">
            <div class="container">
                <div class="row">
                    <div class="col-lg-6 col-md-12">
                        <p><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with by <a href="https://colorlib.com" target="_blank">Colorlib</a>
<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --></p>
                    </div>
                </div>
            </div>
        </div>
    <div class="modal" id="inputTitle">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">이력서 제목을 입력해 주세요.</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <form action="<c:url value='/resume/resumeForm' />" method="get">
                    <div class="modal-body">
                        <input class="form-control" type="text" name="title" required>
                        <input type="hidden" name="resume_num" value="-1">
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-danger">작성</button>
                        <button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    </footer>
    </body>
</html>
