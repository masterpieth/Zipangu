package com.syuusyoku.zipangu.controller;

import java.util.ArrayList;

import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.syuusyoku.zipangu.dao.InterviewDAO;
import com.syuusyoku.zipangu.vo.QuestionVO;

@Controller
public class InterviewController {
	
	@Autowired
	private InterviewDAO dao;
	
	@RequestMapping(value = "interview/getinterview", method = RequestMethod.GET)
	public String getinterview(Model model) {
		ArrayList<QuestionVO> list = dao.selectList();
		JSONArray json = new JSONArray(list);
		model.addAttribute("list", json);
		return "interview/interview";
	}
	
}
