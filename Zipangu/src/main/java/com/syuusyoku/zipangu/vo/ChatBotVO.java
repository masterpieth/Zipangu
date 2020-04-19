package com.syuusyoku.zipangu.vo;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class ChatBotVO {
	private String msg_num;
	private String chatContent;
	public ChatBotVO() {
		super();
		// TODO Auto-generated constructor stub
	}
}
