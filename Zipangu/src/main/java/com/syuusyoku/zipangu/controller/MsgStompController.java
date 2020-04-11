package com.syuusyoku.zipangu.controller;

import java.time.LocalDateTime;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.stereotype.Controller;

import com.syuusyoku.zipangu.vo.MemberVO;
import com.syuusyoku.zipangu.vo.Sender_MsgVO;

@Controller
public class MsgStompController {
	
	private static final Logger logger = LoggerFactory.getLogger(MsgStompController.class);
	
	
	@MessageMapping("/chat/{msg_num}")				// stompClient.send("/chat", ...)의 첫번째 파라미터와 동일
	@SendTo("/subscribe/chat/{msg_num}")				//	stompClient.subscribe("/subscribe/chat", ...)의 첫번쨰 파라미터와 동일
	public Sender_MsgVO sendChatMessage(@DestinationVariable("msg_num") String msg_num ,Sender_MsgVO message, SimpMessageHeaderAccessor headerAccessor){
		logger.info("채팅 컨트롤러 시작");
		//인터셉터에서 등록해두었던 사용자 정보 가져오기.
		MemberVO vo = (MemberVO)headerAccessor.getSessionAttributes().get("user");
		
		message.setUserID(vo.getUserID());
		message.setUserName(vo.getUserName());
		message.setSend_Time(LocalDateTime.now());
		
		logger.info("채팅 컨트롤러 종료");
		return message;
	}
	
}
