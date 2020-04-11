package com.syuusyoku.zipangu.controller;

import java.io.IOException;
import java.util.ArrayList;

import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.syuusyoku.zipangu.dao.InterviewDAO;
import com.syuusyoku.zipangu.vo.QuestionVO;

@Controller
public class InterviewController {
	
//	private static final Logger logger = LoggerFactory.getLogger(InterviewController.class);
	
	@Autowired
	private InterviewDAO dao;
	
	@RequestMapping(value = "interview/getinterview", method = RequestMethod.GET)
	public String getinterview(Model model) {
		ArrayList<QuestionVO> questionList = dao.selectList();
		JSONArray json = new JSONArray(questionList);
		model.addAttribute("questionList", json);
		return "interview/interview";
	}
	
	@ResponseBody
	@RequestMapping(value = "interview/voice", method = RequestMethod.POST)
	public String voice(@RequestParam MultipartFile blob) {
		try {
			byte[] bytes = blob.getBytes();
			System.out.println(bytes.length+"KB");
		} catch (IOException e) {
			e.printStackTrace();
		}
		dao.convert(blob);
		return "data";
	}
	
	@RequestMapping(value = "interview/getinterviewResult", method = RequestMethod.GET)
	public String getinterviewResult() {
		return "interview/interviewResult";
	}
}
