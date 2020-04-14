package com.syuusyoku.zipangu.dao;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.syuusyoku.zipangu.vo.CompanyVO;

@Repository
public class CompanyDAO {

	@Autowired
	SqlSession session;
	
	public boolean insertBookmark(CompanyVO vo, HttpSession httpSession) {
		int result = 0;
		String userID = (String)httpSession.getAttribute("userID");
		vo.setUserID(userID);
		try {
			CompanyMapper mapper = session.getMapper(CompanyMapper.class);
			result = mapper.insertBookmark(vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result > 0;
	}
	public ArrayList<CompanyVO> getBookmarkCount(HttpSession httpSession) {
		String userID = (String)httpSession.getAttribute("userID");
		ArrayList<CompanyVO> result = null;
		try {
			CompanyMapper mapper = session.getMapper(CompanyMapper.class);
			result = mapper.getBookmarkCount(userID);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	public ArrayList<CompanyVO> getBookmarkList(HttpSession httpSession) {
		String userID = (String)httpSession.getAttribute("userID");
		ArrayList<CompanyVO> result = null;
		try {
			CompanyMapper mapper = session.getMapper(CompanyMapper.class);
			result = mapper.getBookmarkList(userID);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
}
