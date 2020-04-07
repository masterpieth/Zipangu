package com.syuusyoku.zipangu.controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.syuusyoku.zipangu.util.Kuromoji;

@Controller
public class EntrysheetController {

	@Autowired
	private Kuromoji kuromoji;
	
	@RequestMapping(value="analysis/entrysheet", method = RequestMethod.GET)
	public String entrysheetHelper() {
		return "company/entrysheetHelper";
	}
	@ResponseBody
	@RequestMapping(value="analysis/kuromoji", method = RequestMethod.POST)
	public String kuromoji(String str) {
		String surfaceForm = "";
		try {
			surfaceForm = kuromoji.kuromoji(str);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return surfaceForm;
	}
}
