<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 모든 페이지에 들어가는 부분 -->
<script>

	//전역변수로 빼는 이유 : 다른 페이지 어디에서든 소켓으로 메세지를 보낼 수 있어야 하니까
	var socket = null;


	$(document).ready(function(){
		connectWS();
	})
	
	function connectWS() {
		var ws = new WebSocket("ws://localhost:8123/zipangu/msg");	
		socket = ws;
		
		ws.onopen = function () {
		    console.log('Info: connection opened.');
		    
		    //서버의 상황에 의해 close가 일어난다면 1초에 한번씩 다시 한번씩 connection을 함
	//	 	    setTimeout( function(){ connect(); }, 1000); // retry connection!!
	
			//커넥션 후에 메세지를 받을 수 있으니 원칙적으로는 안에 넣는다.
			var str="";
		    ws.onmessage = function (event) {
	// 	        console.log("ReceivedMessage:"+event.data+'\n');
		        str += '<br>';
		       	str += event.data;
		        $("#writeList").html(str);
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
