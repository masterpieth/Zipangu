package com.syuusyoku.zipangu.vo;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class List_MsgVO {
	private String mentor_id;
	private String mentee_id;
	private String msg_num;
	public List_MsgVO() {
		super();
		// TODO Auto-generated constructor stub
	} 
}
