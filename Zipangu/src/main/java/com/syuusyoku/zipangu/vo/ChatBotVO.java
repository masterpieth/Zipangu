package com.syuusyoku.zipangu.vo;

public class ChatBotVO {
	private String msg_num;
	private String chatContent;
	public ChatBotVO() {
		super();
	}
	public ChatBotVO(String msg_num, String chatContent) {
		super();
		this.msg_num = msg_num;
		this.chatContent = chatContent;
	}
	public String getMsg_num() {
		return msg_num;
	}
	public void setMsg_num(String msg_num) {
		this.msg_num = msg_num;
	}
	public String getChatContent() {
		return chatContent;
	}
	public void setChatContent(String chatContent) {
		this.chatContent = chatContent;
	}
	@Override
	public String toString() {
		return "ChatBotVO [msg_num=" + msg_num + ", chatContent=" + chatContent + "]";
	}
	
}
