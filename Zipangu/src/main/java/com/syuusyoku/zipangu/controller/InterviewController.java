package com.syuusyoku.zipangu.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.syuusyoku.zipangu.dao.InterviewDAO;
import com.syuusyoku.zipangu.vo.InterviewResultVO;
import com.syuusyoku.zipangu.vo.QuestionVO;

@Controller
public class InterviewController {
	
	private static final Logger logger = LoggerFactory.getLogger(InterviewController.class);
	
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
	@RequestMapping(value = "interview/test", method = RequestMethod.POST)
	public String test(@RequestParam MultipartFile blob) {
		try {
			byte[] bytes = blob.getBytes();
			System.out.println(bytes.length);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return "data";
	}
	@RequestMapping(value = "interview/getinterviewResult", method = RequestMethod.POST)
	public String insertinterview(InterviewResultVO vo, HttpSession session, MultipartFile uploadFile, RedirectAttributes rttr) {
		boolean result = false;
		if(dao.insertInterview(vo, session, uploadFile) != 0) result = true;
		rttr.addFlashAttribute("insertResult", result);
		return "interview/interviewResult";
	}
}
