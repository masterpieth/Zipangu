package com.syuusyoku.zipangu.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.syuusyoku.zipangu.dao.CompanyDAO;

@Controller
public class EntrysheetController {
	
	@Autowired
	CompanyDAO dao;
	
	@RequestMapping(value="analysis/entrysheet", method = RequestMethod.GET)
	public String entrysheetHelper() {
		return "company/entrysheetHelper";
	}
}
