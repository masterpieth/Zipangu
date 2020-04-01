<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../include/header.jsp"></jsp:include>
    <!--================Home Banner Area =================-->
    <section class="banner_area ">
        <div class="banner_inner overlay d-flex align-items-center">
            <div class="container">
                <div class="banner_content text-center">
                    <div class="page_link">
                        <a href="<c:url value="/"/>">메인페이지</a>
                        <a href="<c:url value="/analysis/company"/>">기업 분석</a>
                    </div>
                    <h2>기업 분석</h2>
                </div>
            </div>
        </div>
    </section>
    <!--================End Home Banner Area =================-->
    <ul class="nav nav-tabs">
        <li class="nav-item">
            <a class="nav-link active" data-toggle="tab" href="#qwe">QWE</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" data-toggle="tab" href="#asd">ASD</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" data-toggle="tab" href="#zxc">ZXC</a>
        </li>
    </ul>
    <div class="tab-content">
        <div class="tab-pane fade show active" id="qwe">
            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc id ornare libero. Vivamus iaculis, justo vel mattis pharetra, nisi ligula varius nisl, sit amet mollis tortor ligula vitae nisi.</p>
        </div>
        <div class="tab-pane fade" id="asd">
            <p>Nunc vitae turpis id nibh sodales commodo et non augue. Proin fringilla ex nunc. Integer tincidunt risus ut facilisis tristique.</p>
        </div>
        <div class="tab-pane fade" id="zxc">
            <p>Curabitur dignissim quis nunc vitae laoreet. Etiam ut mattis leo, vel fermentum tellus. Sed sagittis rhoncus venenatis. Quisque commodo consectetur faucibus. Aenean eget ultricies justo.</p>
        </div>
    </div>
<jsp:include page="../include/footer.jsp"></jsp:include>