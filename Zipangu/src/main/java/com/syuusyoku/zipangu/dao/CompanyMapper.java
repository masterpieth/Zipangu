package com.syuusyoku.zipangu.dao;

import java.util.ArrayList;

import com.syuusyoku.zipangu.vo.CompanyVO;

public interface CompanyMapper {
	public int insertBookmark(CompanyVO vo);
	public int deleteBookmark(CompanyVO vo);
	public ArrayList<CompanyVO> getBookmarkCount(String userID);
	public ArrayList<CompanyVO> getBookmarkList(String userID);
}
