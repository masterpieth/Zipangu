package com.syuusyoku.zipangu.vo;

public class CareerVO {
	private int resume_num;
	private String start_period;
	private String end_period;
	private String content;
	
	public CareerVO() {
		super();
	}

	public CareerVO(int resume_num, String start_period, String end_period, String content) {
		this.resume_num = resume_num;
		this.start_period = start_period;
		this.end_period = end_period;
		this.content = content;
	}

	public int getResume_num() {
		return resume_num;
	}

	public void setResume_num(int resume_num) {
		this.resume_num = resume_num;
	}

	public String getStart_period() {
		return start_period;
	}

	public void setStart_period(String start_period) {
		this.start_period = start_period;
	}

	public String getEnd_period() {
		return end_period;
	}

	public void setEnd_period(String end_period) {
		this.end_period = end_period;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	@Override
	public String toString() {
		return "CareerVO [resume_num=" + resume_num + ", start_period=" + start_period + ", end_period=" + end_period
				+ ", content=" + content + "]";
	}
	
}