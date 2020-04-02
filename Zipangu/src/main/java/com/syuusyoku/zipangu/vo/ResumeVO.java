package com.syuusyoku.zipangu.vo;

import lombok.Data;

@Data
public class ResumeVO {
	private int resume_num;
	private String userID;
	private String hobbyNSkill;
	private String introduce;
	private String picFileName;
	private String title;
	private String inputDate;
	private String correctedDate;
}