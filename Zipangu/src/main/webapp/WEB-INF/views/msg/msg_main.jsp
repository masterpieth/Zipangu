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

		connect();
	})
	
	
</script>

<script>		

var socket = null;

function connect() {
	var ws = new WebSocket("ws://localhost:8123/zipangu/msg");
	socket = ws;
	
	ws.onopen = function () {
	    console.log('Info: connection opened.');
	    
	    //서버의 상황에 의해 close가 일어난다면 1초에 한번씩 다시 한번씩 connection을 함
	    //setTimeout( function(){ connect(); }, 1000); // retry connection!!

		//커넥션 후에 메세지를 받을 수 있으니 원칙적으로는 안에 넣는다.
	    ws.onmessage = function (event) {
	        console.log("ReceivedMessage:"+event.data+'\n');
	    };
	    
	};
	
	ws.onclose = function (event) { 
		console.log('Info: connection closed.'); 
	};
	ws.onerror = function (err) { 
		console.log('Error:',err); 
	};
}
</script>
<title>Insert title here</title>
</head>
<body>
<textarea id="msg"></textarea>
<input type="button" id="btnSend" value="전송">
</body>
</html>