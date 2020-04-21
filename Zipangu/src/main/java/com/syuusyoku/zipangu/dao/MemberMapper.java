package com.syuusyoku.zipangu.dao;

import java.util.ArrayList;

import com.syuusyoku.zipangu.vo.MemberVO;

public interface MemberMapper {

	int checkID(String userID);

	int signup(MemberVO member);

	int login(MemberVO member);
	
	public void uploadKakaoText(MemberVO vo);
	
	public ArrayList<MemberVO> mentorList();
	
	MemberVO getMember(String userID);
}