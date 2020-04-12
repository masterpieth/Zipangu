package com.syuusyoku.zipangu.dao;

import java.util.ArrayList;

import com.syuusyoku.zipangu.vo.CompanyVO;

public interface CompanyMapper {
	public int insertBookmark(CompanyVO vo);
	public ArrayList<CompanyVO> getBookmark(String userID);
}
