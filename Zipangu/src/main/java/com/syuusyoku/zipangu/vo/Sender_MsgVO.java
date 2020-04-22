package com.syuusyoku.zipangu.vo;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;

public class Sender_MsgVO {
	private String msg_num;
	private String userID;
	private String userName;
	private LocalDateTime send_Time;
	private String content;
	public Sender_MsgVO() {
		super();
	}
	public Sender_MsgVO(String msg_num, String userID, String userName, LocalDateTime send_Time, String content) {
		super();
		this.msg_num = msg_num;
		this.userID = userID;
		this.userName = userName;
		this.send_Time = send_Time;
		this.content = content;
	}
	public String getMsg_num() {
		return msg_num;
	}
	public void setMsg_num(String msg_num) {
		this.msg_num = msg_num;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public LocalDateTime getSend_Time() {
		return send_Time;
	}
	public void setSend_Time(LocalDateTime send_Time) {
		this.send_Time = send_Time;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	@Override
	public String toString() {
		return "Sender_MsgVO [msg_num=" + msg_num + ", userID=" + userID + ", userName=" + userName + ", send_Time="
				+ send_Time + ", content=" + content + "]";
	}
	
}
