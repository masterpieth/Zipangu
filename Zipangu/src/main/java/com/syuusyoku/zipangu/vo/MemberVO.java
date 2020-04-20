package com.syuusyoku.zipangu.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
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
}