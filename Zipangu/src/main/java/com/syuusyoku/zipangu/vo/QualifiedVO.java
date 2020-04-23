package com.syuusyoku.zipangu.vo;

public class QualifiedVO {
	private int resume_num;
	private String period;
	private String content;
	
	public QualifiedVO() {
	}

	public QualifiedVO(int resume_num, String period, String content) {
		super();
		this.resume_num = resume_num;
		this.period = period;
		this.content = content;
	}

	public int getResume_num() {
		return resume_num;
	}

	public void setResume_num(int resume_num) {
		this.resume_num = resume_num;
	}

	public String getPeriod() {
		return period;
	}

	public void setPeriod(String period) {
		this.period = period;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	@Override
	public String toString() {
		return "QualifiedVO [resume_num=" + resume_num + ", period=" + period + ", content=" + content + "]";
	}
	
}