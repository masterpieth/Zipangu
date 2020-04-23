package com.syuusyoku.zipangu.vo;

import lombok.Data;

@Data
public class InterviewResultVO {

	private int interview_num;
	private String userID;
	private String inputdate;
	private int question_num;
	
	private String voicefilename;
	private String result;
	private String question_text;
}
