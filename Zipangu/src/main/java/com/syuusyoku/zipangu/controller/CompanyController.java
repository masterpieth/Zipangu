package com.syuusyoku.zipangu.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.syuusyoku.zipangu.dao.CompanyDAO;
import com.syuusyoku.zipangu.util.Kuromoji;
import com.syuusyoku.zipangu.vo.CompanyVO;

@Controller
public class CompanyController {
	
	@Autowired
	CompanyDAO dao;
	
	@Autowired
	Kuromoji kuromoji;
	
	@RequestMapping(value="analysis/company", method = RequestMethod.GET)
	public String comAnalysisPage() {
		return "company/comAnalysis";
	}
	@RequestMapping(value="analysis/companyTemp", method = RequestMethod.GET)
	public String companyTemp() {
		return "company/comAnalysisTemp";
	}
	@ResponseBody
	@RequestMapping(value="analysis/bookmark", method = RequestMethod.POST)
	public boolean bookmark(CompanyVO vo, HttpSession httpSession) {
		Boolean result = dao.insertBookmark(vo, httpSession);
		if(result) return true;
		return false;
	}
	@ResponseBody
	@RequestMapping(value="analysis/getBookmarkList", method = RequestMethod.POST)
	public ArrayList<CompanyVO> getBookmarkList(HttpSession httpSession) {
		ArrayList<CompanyVO> bookmarkList = dao.getBookmark(httpSession);
		return bookmarkList;
	}
	@ResponseBody
	@RequestMapping(value="analysis/kuromoji", method = RequestMethod.POST)
	public String kuromoji(String type) {
		String result = kuromoji.kuromoji(type);
		return result;
	}
}
