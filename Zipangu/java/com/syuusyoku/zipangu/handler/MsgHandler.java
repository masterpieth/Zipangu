package com.syuusyoku.zipangu.handler;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.util.StringUtils;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

//text 외의 것을 보낼 경우 BinaryWebSocketHandler
public class MsgHandler extends TextWebSocketHandler {

	List<WebSocketSession> sessions = new ArrayList<>();
	Map<String, WebSocketSession> userSessions  = new HashMap<>();
	
	//userID 가져옴	HttpSession의
	private String getUserID(WebSocketSession session) {
		 Map<String,Object> map = session.getAttributes();
		  String userID = (String)map.get("userID");
		  return userID;
	}
	
	//authority 가져옴	HttpSession의
	private String getAuthority(WebSocketSession session) {
		 Map<String,Object> map = session.getAttributes();
		  String authority = (String)map.get("authority");
		  return authority;
	}
	
	//userName 가져옴		HttpSession의
	private String getUserName(WebSocketSession session) {
		 Map<String,Object> map = session.getAttributes();
		  String userName = (String)map.get("userName");
		  return userName;
	}
	

	
	//connection이 연결 됐을 때, client가 server 접속 성공했을 때
	@Override	
	public void afterConnectionEstablished(WebSocketSession session) throws Exception{
		System.out.println("afterConnectionEstablished:"+session);
	
		//Array에다 지금 접속되어 있는 session들을 모두 담음
		sessions.add(session);
		String senderId = getUserID(session);
		userSessions.put(senderId, session);
	}
	
	//socket에 message를 보냈을 때
	@Override	
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception{
		System.out.println("handleTextMessage:"+session + " : " + message);
		
		//접속되어 있는 모두에게 메세지 날림
		for (WebSocketSession sess: sessions) {
			String senderId = getUserID(session);
			sess.sendMessage(new TextMessage(senderId + " : " + message.getPayload())); //message.getPayload()
		}
	}

	//connection이 close 되었을 때
	@Override	
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception{
		System.out.println("afterConnectionClosed:"+session + " : " + status);
		sessions.remove(session);
	}


}
