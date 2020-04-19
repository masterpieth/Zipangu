package com.syuusyoku.zipangu.vo;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class MemberVO {
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
		// TODO Auto-generated constructor stub
	}
	
}