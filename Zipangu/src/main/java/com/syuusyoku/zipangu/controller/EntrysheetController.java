package com.syuusyoku.zipangu.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.syuusyoku.zipangu.dao.CompanyDAO;
import com.syuusyoku.zipangu.vo.CompanyVO;

@Controller
public class EntrysheetController {
	
	@Autowired
	CompanyDAO dao;
	
	@RequestMapping(value="analysis/entrysheet", method = RequestMethod.GET)
	public String entrysheetHelper(HttpSession httpSession, Model model) {
		ArrayList<CompanyVO> bookmarkList = dao.getBookmark(httpSession);
		model.addAttribute("bookmarkList", bookmarkList);
		return "company/entrysheetHelper";
	}
}