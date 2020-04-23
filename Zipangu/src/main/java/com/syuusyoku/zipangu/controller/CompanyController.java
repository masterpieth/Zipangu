package com.syuusyoku.zipangu.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
	public String companyTemp() {
		return "company/comAnalysis";
	}
	@ResponseBody
	@RequestMapping(value="analysis/bookmark", method = RequestMethod.POST)
	public boolean bookmark(CompanyVO vo, HttpSession httpSession) {
		Boolean result = dao.insertBookmark(vo, httpSession);
		if(result) return true;
		return false;
	}
	@ResponseBody
	@RequestMapping(value="analysis/getBookmarkCount", method = RequestMethod.POST)
	public ArrayList<CompanyVO> getBookmarkCount(HttpSession httpSession) {
		ArrayList<CompanyVO> bookmarkCount = dao.getBookmarkCount(httpSession);
		return bookmarkCount;
	}
	@ResponseBody
	@RequestMapping(value="analysis/getBookmarkList", method = RequestMethod.POST)
	public ArrayList<CompanyVO> getBookmarkList(HttpSession httpSession) {
		ArrayList<CompanyVO> bookmarkList = dao.getBookmarkList(httpSession);
		return bookmarkList;
	}
	@ResponseBody
	@RequestMapping(value="analysis/kuromoji", method = RequestMethod.POST, produces = "application/text; charset=utf8")
	public String kuromoji(String type) {
		String result = kuromoji.kuromoji(type);
		result = result.trim();
		return result;
	}
	
	@RequestMapping(value="analysis/entrysheet", method = RequestMethod.GET)
	public String entrysheetHelper() {
		return "company/entrysheet";
	}
	
	@RequestMapping(value="analysis/deleteBookmark", method = RequestMethod.GET)
	public String deleteBookmark(CompanyVO vo, HttpSession httpSession, RedirectAttributes rttr) {
		Boolean deleteResult = dao.deleteBookmark(vo, httpSession);
		rttr.addFlashAttribute("deleteResult", deleteResult);
		return "redirect:/analysis/entrysheet";
	}
}
