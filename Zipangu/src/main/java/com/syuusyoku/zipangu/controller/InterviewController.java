package com.syuusyoku.zipangu.controller;

import java.io.IOException;
import java.sql.Blob;
import java.util.ArrayList;

import javax.sql.rowset.serial.SerialBlob;

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
	@RequestMapping(value = "interview/test", method = RequestMethod.POST)
	public String test(@RequestParam MultipartFile blob) {
		try {
			byte[] bytes = blob.getBytes();
			System.out.println(bytes.length);
			dao.test(blob);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return "data";
	}
}
