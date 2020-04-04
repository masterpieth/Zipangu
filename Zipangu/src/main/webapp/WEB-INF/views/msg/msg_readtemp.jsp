<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="<c:url value='/resources/js/jquery-3.4.1.js'/>"></script> 
<script src="<c:url value="/resources/js/sockjs.js" />"></script>
<script src="<c:url value="/resources/js/stomp.js" />"></script>

<script type="text/javascript">
	$(function(){
		connect();

		$("#send").on("click",function(){
			sendMessage();
		})
		
		document.onkeydown = function ( event ) {
		    if ( event.keyCode == 116 || event.ctrlKey == true && (event.keyCode == 82)) { // f5 && ctrl + r
		        //접속 강제 종료
		        disconnect();
		        // keyevent
		        event.cancelBubble = true; 
		        event.returnValue = false; 
		        setTimeout(function() {window.location.reload();}, 100);
		        return false;
		    }
		}
		
	})
	
	var stompClient = null;
	
	function connect() {
		var socket = new SockJS('/zipangu/endpoint');
		stompClient = Stomp.over(socket);
		stompClient.connect({}, function(frame) {
			
			stompClient.subscribe('/subscribe/chat/'+${requestScope.msg_num}, function(message){
				var data = JSON.parse(message.body);
				$("#chatroom").append(data.userName+" 님 -> "+data.content+"<br />");
			});	
				
		});
	}
		
	function sendMessage() {
		var str = $("#chatbox").val();
		str = str.replace(/ /gi, '&nbsp;')
		str = str.replace(/(?:\r\n|\r|\n)/g, '<br />');
		if(str.length > 0){
			stompClient.send("/chat/"+${requestScope.msg_num}, {}, JSON.stringify({
				content : str
			}));
				
		}
			
		$("#chatbox").val("");
	}
	
	function disconnect() {
		stompClient.disconnect();
	}
</script>

<title>일반 채팅 방</title>
</head>

<body>

	${requestScope.msg_num}
	
	<input type="text" id="chatbox">
	
	<input type="button" id="send" value="전송">
	
	<div id="chatroom"></div>
	
</body>

</html>