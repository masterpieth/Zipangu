package com.syuusyoku.zipangu.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

public class CompanyVO {

	private int company_num;
	private String userID;
	private String coname;
	private String type;
	private String location;
	private String contact;
	private int count;
	public CompanyVO() {
	}
	public CompanyVO(int company_num, String userID, String coname, String type, String location, String contact,
			int count) {
		super();
		this.company_num = company_num;
		this.userID = userID;
		this.coname = coname;
		this.type = type;
		this.location = location;
		this.contact = contact;
		this.count = count;
	}
	public int getCompany_num() {
		return company_num;
	}
	public void setCompany_num(int company_num) {
		this.company_num = company_num;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getConame() {
		return coname;
	}
	public void setConame(String coname) {
		this.coname = coname;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getContact() {
		return contact;
	}
	public void setContact(String contact) {
		this.contact = contact;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	@Override
	public String toString() {
		return "CompanyVO [company_num=" + company_num + ", userID=" + userID + ", coname=" + coname + ", type=" + type
				+ ", location=" + location + ", contact=" + contact + ", count=" + count + "]";
	}
	
}
