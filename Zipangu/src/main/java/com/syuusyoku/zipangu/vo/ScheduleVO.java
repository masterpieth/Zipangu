package com.syuusyoku.zipangu.vo;

public class ScheduleVO {
	private String mentorID;
	private String menteeID;
	private String reserveDate;
	
	public ScheduleVO() {
	}

	public ScheduleVO(String mentorID, String menteeID, String reserveDate) {
		super();
		this.mentorID = mentorID;
		this.menteeID = menteeID;
		this.reserveDate = reserveDate;
	}

	public String getMentorID() {
		return mentorID;
	}

	public void setMentorID(String mentorID) {
		this.mentorID = mentorID;
	}

	public String getMenteeID() {
		return menteeID;
	}

	public void setMenteeID(String menteeID) {
		this.menteeID = menteeID;
	}

	public String getReserveDate() {
		return reserveDate;
	}

	public void setReserveDate(String reserveDate) {
		this.reserveDate = reserveDate;
	}

	@Override
	public String toString() {
		return "ScheduleVO [mentorID=" + mentorID + ", menteeID=" + menteeID + ", reserveDate=" + reserveDate + "]";
	}
	
}