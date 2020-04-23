package com.syuusyoku.zipangu.vo;

public class List_MsgVO {
	private String mentor_id;
	private String mentee_id;
	private String msg_num;
	
	public List_MsgVO() {
		super();
	}

	public List_MsgVO(String mentor_id, String mentee_id, String msg_num) {
		this.mentor_id = mentor_id;
		this.mentee_id = mentee_id;
		this.msg_num = msg_num;
	}

	public String getMentor_id() {
		return mentor_id;
	}

	public void setMentor_id(String mentor_id) {
		this.mentor_id = mentor_id;
	}

	public String getMentee_id() {
		return mentee_id;
	}

	public void setMentee_id(String mentee_id) {
		this.mentee_id = mentee_id;
	}

	public String getMsg_num() {
		return msg_num;
	}

	public void setMsg_num(String msg_num) {
		this.msg_num = msg_num;
	}

	@Override
	public String toString() {
		return "List_MsgVO [mentor_id=" + mentor_id + ", mentee_id=" + mentee_id + ", msg_num=" + msg_num + "]";
	}
	
}
