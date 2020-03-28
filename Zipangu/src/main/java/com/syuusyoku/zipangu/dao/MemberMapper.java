package com.syuusyoku.zipangu.dao;

import com.syuusyoku.zipangu.vo.MemberVO;

public interface MemberMapper {

	int checkID(String userID);

	int signup(MemberVO member);

	int login(MemberVO member);
	
	public void uploadKakaoText(MemberVO vo);
	
	public String findTextFileName(String userID);

}