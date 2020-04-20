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
			
			stompClient.subscribe('/subscribe/chat/${requestScope.List_MsgVO.msg_num}', function(message){
				var data = JSON.parse(message.body);
				var str="";
				if("${sessionScope.userID}"==data.userID) {
					str += '<div class="bubble me">';
					str += data.userName+" 님 -> "+data.content;
					str += '</div>';
				} else if("${sessionScope.userID}"!=data.userID) {
					str += '<div class="bubble you">';
					str += data.userName+" 님 -> "+data.content;
					str += '</div>';
				}
				var mentor = $("#mentor_id").val();
				var mentee = $("#mentee_id").val();
				$(".chat").append(str);
				
				str="";
				//대화 상대가 admin이면 자동으로 답변 나가게..
				if(mentor=='admin'||mentee=='admin') {
					var data = {
							"chatContent": data.content,
							"msg_num" : data.msg_num
						};
					var jsonData = JSON.stringify(data);
					$.ajax({
						url: 'chatBot',
						type: 'post',
						data: jsonData,
						contentType : 'application/json;charaset=utf-8',
						dataType : "text",
						success: function(data){
							console.log(data);
							str += '<div class="bubble you">';
							str += data;
							str += '</div>';
							$(".chat").append(str);
					    },
						error: function(request,status,error){
							console.log("실패");
							console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
							str += '<div class="bubble you">';
							str += '일치하는 검색결과가 없습니다,,';
							str += '</div>';
							$(".chat").append(str);
						}	
					});
				}
							
				console.log("str~~ : "+str);
			});	
			
		});
	}
		
	function sendMessage() {
		var str = $("#chatbox").val();
		str = str.replace(/ /gi, '&nbsp;')
		str = str.replace(/(?:\r\n|\r|\n)/g, '<br />');
		if(str.length > 0){
			stompClient.send("/chat/${requestScope.List_MsgVO.msg_num}", {}, JSON.stringify({
				msg_num : "${requestScope.List_MsgVO.msg_num}",
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
<div class="wrapper">
    <div class="container">
    	<div class="left">
            <div class="top">
                <input type="text" placeholder="Search" />
                <a href="javascript:;" class="search"></a>
            </div>
            <ul class="people">
          		<c:forEach items="${who_user_msg_to_list}" var="list">         	
            		<a href="/zipangu/msg/msg_start?mentee_id=${list.mentee_id}&mentor_id=${list.mentor_id}">
            			<c:if test="${sessionScope.userID==list.mentor_id}">
			                <li class="person" data-chat="person${list.msg_num}">	
			                     <span class="name">${list.mentee_id}</span>
			                </li>
		                </c:if>
		                <c:if test="${sessionScope.userID==list.mentee_id}">
		                	<li class="person" data-chat="person${list.msg_num}">	
			                     <span class="name">${list.mentor_id}</span>
			                </li>			
		                </c:if>
	                </a>
	            </c:forEach>
            </ul>
        </div>
        <div class="right">
	        <div class="chat" data-chat="person${requestScope.List_MsgVO.msg_num}">
	            <div id="chatroom"></div>
	            <input type="hidden" value="${requestScope.List_MsgVO.mentee_id}" name="mentee_id" id="mentee_id">
            	<input type="hidden" value="${requestScope.List_MsgVO.mentor_id}" name="mentor_id" id="mentor_id">		
        	</div>
          	<div class="write">
               	<input type="text" id="chatbox">
               	<input type="button" id="send" value="전송">
           	</div>
	   	</div>
    </div>
</div>
	<script type="text/javascript">
		document.querySelector('.chat[data-chat=person${requestScope.List_MsgVO.msg_num}]').classList.add('active-chat');
		document.querySelector('.person[data-chat=person${requestScope.List_MsgVO.msg_num}]').classList.add('active');
	</script>
	<script src="<c:url value="/resources/js/msg_read.js" />"></script>

</body>
</html>
