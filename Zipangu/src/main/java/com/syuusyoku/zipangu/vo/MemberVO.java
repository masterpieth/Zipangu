package com.syuusyoku.zipangu.vo;

public class MemberVO {
	private int resume_num;
	private String userID;
	private String userPwd;
	private String email;
	private String userName;
	private String birth;
	private String address;
	private String phone;
	private String sex;
	private int authority;
	private String textFileName;
	private String singupDate;
	
	public MemberVO() {
		super();
	}

	public MemberVO(int resume_num, String userID, String userPwd, String email, String userName, String birth,
			String address, String phone, String sex, int authority, String textFileName, String singupDate) {
		super();
		this.resume_num = resume_num;
		this.userID = userID;
		this.userPwd = userPwd;
		this.email = email;
		this.userName = userName;
		this.birth = birth;
		this.address = address;
		this.phone = phone;
		this.sex = sex;
		this.authority = authority;
		this.textFileName = textFileName;
		this.singupDate = singupDate;
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

	public String getUserPwd() {
		return userPwd;
	}

	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getBirth() {
		return birth;
	}

	public void setBirth(String birth) {
		this.birth = birth;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public int getAuthority() {
		return authority;
	}

	public void setAuthority(int authority) {
		this.authority = authority;
	}

	public String getTextFileName() {
		return textFileName;
	}

	public void setTextFileName(String textFileName) {
		this.textFileName = textFileName;
	}

	public String getSingupDate() {
		return singupDate;
	}

	public void setSingupDate(String singupDate) {
		this.singupDate = singupDate;
	}

	@Override
	public String toString() {
		return "MemberVO [resume_num=" + resume_num + ", userID=" + userID + ", userPwd=" + userPwd + ", email=" + email
				+ ", userName=" + userName + ", birth=" + birth + ", address=" + address + ", phone=" + phone + ", sex="
				+ sex + ", authority=" + authority + ", textFileName=" + textFileName + ", singupDate=" + singupDate
				+ "]";
	}
	
}