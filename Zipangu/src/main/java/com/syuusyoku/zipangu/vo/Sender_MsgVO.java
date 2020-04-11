package com.syuusyoku.zipangu.vo;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class Sender_MsgVO {
	private String msg_num;
	
	private String userID;
	private String userName;
	
	private LocalDateTime send_Time;
	
	private String content;
	
	public Sender_MsgVO() {
		super();
		// TODO Auto-generated constructor stub
	}
}
