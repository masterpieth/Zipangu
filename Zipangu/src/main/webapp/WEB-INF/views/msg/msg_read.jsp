<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="<c:url value='/resources/js/jquery-3.4.1.js'/>"></script> 
<script>
	$(function(){
		
		$('#btnSend').on('click', function(evt) {
			evt.preventDefault();
		if (socket.readyState !== 1) return;
			  let msg = $('#msg').val();
			  socket.send(msg);
		});

		connectWS();

	})	
</script>
<%@ include file="../footer.jsp"%>	
<title>Insert title here</title>
</head>
<body>
<h2>${sessionScope.userID} : 지금 접속해 있는 사람</h2>
<textarea id="msg"></textarea>
<input type="button" id="btnSend" value="전송">
<br>	
<a href="<c:url value='/'/>"><input type="button" id="exit" value="나가기"></a>
<br>
<div id="writeList"></div>
</body>
</html>