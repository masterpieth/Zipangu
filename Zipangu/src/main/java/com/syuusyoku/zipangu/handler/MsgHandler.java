package com.syuusyoku.zipangu.handler;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

//text 외의 것을 보낼 경우 BinaryWebSocketHandler
public class MsgHandler extends TextWebSocketHandler {
	
	List<WebSocketSession> sessions = new ArrayList<>();
	
	//connection이 연결 됐을 때, client가 server 접속 성공했을 때
	@Override	
	public void afterConnectionEstablished(WebSocketSession session) throws Exception{
		System.out.println("afterConnectionEstablished:"+session);
		
		//Array에다 지금 접속되어 있는 session들을 모두 담음
		sessions.add(session);
	}
	
	//socket에 어떤 message를 보냈을 때
	@Override	
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception{
		System.out.println("handleTextMessage:"+session + " : " + message);
		
		//접속되어 있는 모두에게 메세지 날림
		for (WebSocketSession sess: sessions) {
			
			String senderId = session.getId();
			//sess.sendMessage(message);를 조금 가공, senderId는 지금 보낸 사람, session의 아이디
			sess.sendMessage(new TextMessage(senderId + " : " + message));
		}
	}
	
	//connection이 close 되었을 때
	@Override	
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception{
		System.out.println("afterConnectionClosed:"+session + " : " + status);
	}


}
