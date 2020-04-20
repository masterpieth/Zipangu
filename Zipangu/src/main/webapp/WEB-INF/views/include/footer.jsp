<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <!--================  start footer Area =================-->
    <footer class="footer-area">
        <div class="footer_top section_gap_top">
            <div class="container">
                <div class="row">
                    <div class="col-lg-3 col-md-6 col-sm-6">
                        <div class="single-footer-widget">
                            <h5 class="footer_title">About Zipangu</h5>
                            <p class="about-text">여기에 장황한 설명이 있는데 굳이 넣어야 하는 걸까요? 여러분의 생각은 어떠신가요? 귀찮네요 ㅎㅎ 그냥 뺄까 싶은데 일단 둡니다</p>
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
                                        <li><a href="#">Main</a></li>
                                        <li><a href="<c:url value='/personality/personalityInsight'/>">Personality</a></li>
                                        <li><a href="<c:url value='/analysis/company'/>">Company</a></li>
                                        <li><a href="<c:url value='/analysis/entrysheet'/>">Entrysheet</a></li>
                                    </ul>
                                </div>
                                <div class="col-5">
                                    <ul class="list">
                                        <li><a href="#">Mentoring</a></li>
                                        <li><a href="#">Interview</a></li>
                                        <li><a href="#">Resume</a></li>
                                        <li><a href="#">Contact</a></li>
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
    </footer>
    <!--================ End footer Area =================-->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="${pageContext.request.contextPath}/resources/template_js/jquery-3.2.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/template_js/popper.js"></script>
    <script src="${pageContext.request.contextPath}/resources/template_js/bootstrap.min.js"></script>
    </body>
</html>
