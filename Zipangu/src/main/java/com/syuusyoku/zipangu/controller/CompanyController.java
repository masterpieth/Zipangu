package com.syuusyoku.zipangu.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.syuusyoku.zipangu.dao.CompanyDAO;
import com.syuusyoku.zipangu.vo.CompanyVO;

@Controller
public class CompanyController {
	
	@Autowired
	CompanyDAO dao;
	
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
		System.out.println(vo);
		Boolean result = dao.insertBookmark(vo, httpSession);
		if(result) return true;
		return false;
	}
}
