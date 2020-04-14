package com.syuusyoku.zipangu.dao;

import com.syuusyoku.zipangu.vo.MemberVO;

public interface MemberMapper {

	int checkID(String userID);

	int signup(MemberVO member);

	MemberVO getMember(MemberVO member);
}