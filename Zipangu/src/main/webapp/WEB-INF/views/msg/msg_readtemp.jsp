<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

	<link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:400,600" rel="stylesheet">
	<link rel="stylesheet" href="<c:url value="/resources/css/msg_read.css" />">

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
			
			stompClient.subscribe('/subscribe/chat/'+${requestScope.List_MsgVO.msg_num}, function(message){
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
			stompClient.send("/chat/"+${requestScope.List_MsgVO.msg_num}, {}, JSON.stringify({
				content : str
			}));
				
		}
			
		$("#chatbox").val("");
	}
	
	function disconnect() {
		stompClient.disconnect();
	}
</script>
	
	<title>대화 화면</title>
</head>

<body>
${requestScope.List_MsgVO.msg_num}
<div class="wrapper">
    <div class="container">
    	<div class="left">
            <div class="top">
                <input type="text" placeholder="Search" />
                <a href="javascript:;" class="search"></a>
            </div>
            <ul class="people">
            	<c:forEach items="${who_user_msg_to_list}" var="list">
	                <li class="person" data-chat="person${list.readID}">	
	                     <span class="name">Thomas Bangalter</span>
	                    <span class="time">2:09 PM</span>
	                    <span class="preview">I was wondering...</span>
	                </li>
	            </c:forEach>
                <li class="person" data-chat="person2">
                   <span class="name">Dog Woofson</span>
                    <span class="time">1:44 PM</span>
                    <span class="preview">I've forgotten how it felt before</span>
                </li>
            </ul>
        </div>
        <div class="right">
            <div class="top"><span>To: <span class="name">Dog Woofson</span></span></div>
            <div class="chat" data-chat="person1">
                <div class="conversation-start">
                    <span>Today, 6:48 AM</span>
                </div>
                <div class="bubble you">
                    Hello,
                </div>
                <div class="bubble me">
                    it's me.
                </div>
            </div>
            <div class="chat" data-chat="person2">
                <div class="conversation-start">
                    <span>Today, 5:38 PM</span>
                </div>
                <div class="bubble you">
                    Hello, can you hear me?
                </div>
                <div class="bubble me">
                    ... about who we used to be.
                </div>
                <div id="chatroom"></div>
            </div>
            <div class="write">
                <input type="text" id="chatbox">
                <input type="button" id="send" value="전송">
            </div>
        </div>
    </div>
</div>

	<script src="<c:url value="/resources/js/msg_read.js" />"></script>

</body>
</html>
