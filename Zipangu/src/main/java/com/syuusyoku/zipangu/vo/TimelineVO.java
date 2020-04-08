package com.syuusyoku.zipangu.vo;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class TimelineVO {
	private int timeline_Num;
	
	private String userID;
	private String traits_Selected;
	
	private String episode_Title;
	private String episode_Content;
	
	private String start_Date;
	private String finish_Date;
	
	public TimelineVO() {
		super();
		// TODO Auto-generated constructor stub
	}
}
