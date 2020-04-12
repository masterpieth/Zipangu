package com.syuusyoku.zipangu.vo;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class ReceiveVO {
	private String userID;
	private String sender_id;
	private String send_time;
	private String read_time;
	private String text;
	public ReceiveVO() {
		super();
	}
}
