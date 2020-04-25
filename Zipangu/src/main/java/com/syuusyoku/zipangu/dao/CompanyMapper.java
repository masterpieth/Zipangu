package com.syuusyoku.zipangu.dao;

import java.util.ArrayList;

import com.syuusyoku.zipangu.vo.CompanyVO;
import com.syuusyoku.zipangu.vo.MemberVO;

public interface CompanyMapper {
	public int insertBookmark(CompanyVO vo);
	public int deleteBookmark(CompanyVO vo);
	public ArrayList<CompanyVO> getBookmarkCount(String userID);
	public ArrayList<CompanyVO> getBookmarkList(String userID);
	int withdraw(MemberVO member); //탈퇴로 인한 정보 삭제
}