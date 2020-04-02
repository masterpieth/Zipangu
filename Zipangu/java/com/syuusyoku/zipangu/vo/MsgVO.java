package com.syuusyoku.zipangu.vo;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;

import lombok.Data;

@Data
@AllArgsConstructor
public class MsgVO {
	private String userID;
	private String userName;
	private String content;
	private LocalDateTime date;
	public MsgVO() {
		super();
		// TODO Auto-generated constructor stub
	}

}
