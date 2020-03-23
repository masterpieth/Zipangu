package com.syuusyoku.zipangu.vo;

import lombok.Data;

@Data
public class MemberVO {
	private String userID;
	private String userPwd;
	private String eMail;
	private String userName;
	private String birth;
	private String address;
	private String phone;
	private String sex;
	private int authority;
	private String textFileName;
	private String singupDate;
}