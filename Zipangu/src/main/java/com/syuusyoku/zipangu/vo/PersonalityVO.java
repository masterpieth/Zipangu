package com.syuusyoku.zipangu.vo;

public class PersonalityVO {
	private String userID;
	private String trait;
	private double rate;
	public PersonalityVO() {
		super();
	}
	public PersonalityVO(String userID, String trait, double rate) {
		super();
		this.userID = userID;
		this.trait = trait;
		this.rate = rate;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getTrait() {
		return trait;
	}
	public void setTrait(String trait) {
		this.trait = trait;
	}
	public double getRate() {
		return rate;
	}
	public void setRate(double rate) {
		this.rate = rate;
	}
	@Override
	public String toString() {
		return "PersonalityVO [userID=" + userID + ", trait=" + trait + ", rate=" + rate + "]";
	}
	
}
