package com.syuusyoku.zipangu.vo;

import lombok.Data;

public class ResumeVO {
	private int resume_num;
	private String userID;
	private String hobbyNSkill;
	private String introduce;
	private String picFileName;
	private String title;
	private String inputDate;
	private String correctedDate;
	public ResumeVO() {
		super();
	}
	public ResumeVO(int resume_num, String userID, String hobbyNSkill, String introduce, String picFileName,
			String title, String inputDate, String correctedDate) {
		super();
		this.resume_num = resume_num;
		this.userID = userID;
		this.hobbyNSkill = hobbyNSkill;
		this.introduce = introduce;
		this.picFileName = picFileName;
		this.title = title;
		this.inputDate = inputDate;
		this.correctedDate = correctedDate;
	}
	public int getResume_num() {
		return resume_num;
	}
	public void setResume_num(int resume_num) {
		this.resume_num = resume_num;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getHobbyNSkill() {
		return hobbyNSkill;
	}
	public void setHobbyNSkill(String hobbyNSkill) {
		this.hobbyNSkill = hobbyNSkill;
	}
	public String getIntroduce() {
		return introduce;
	}
	public void setIntroduce(String introduce) {
		this.introduce = introduce;
	}
	public String getPicFileName() {
		return picFileName;
	}
	public void setPicFileName(String picFileName) {
		this.picFileName = picFileName;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getInputDate() {
		return inputDate;
	}
	public void setInputDate(String inputDate) {
		this.inputDate = inputDate;
	}
	public String getCorrectedDate() {
		return correctedDate;
	}
	public void setCorrectedDate(String correctedDate) {
		this.correctedDate = correctedDate;
	}
	@Override
	public String toString() {
		return "ResumeVO [resume_num=" + resume_num + ", userID=" + userID + ", hobbyNSkill=" + hobbyNSkill
				+ ", introduce=" + introduce + ", picFileName=" + picFileName + ", title=" + title + ", inputDate="
				+ inputDate + ", correctedDate=" + correctedDate + "]";
	}
	
}