<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="include/header.jsp"></jsp:include>
	<div class="container">
		<div class="jumbotron" align="center">
		    <div class="card-body col-md-9">
				<h1>허용되지 않은 접근입니다.</h1>
				<hr>
		    </div>
		    <div class="row justify-content-center align-items-center">
		        <p><a href="<c:url value='/member/loginForm' />">로그인</a> 후 이용해 주시기 바랍니다.</p>
		    </div>
		</div>
		<div class="alert alert-info">
		    <div class="text-center">
		        <strong>계정이 없으신가요?</strong>
                <br>
                <br>
                가입하시려면  <a href="<c:url value='/member/signupForm' />" class="alert-link">회원 가입</a>
            </div>
		</div>
	</div>
<jsp:include page="include/footer.jsp"></jsp:include>