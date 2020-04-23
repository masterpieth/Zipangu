package com.syuusyoku.zipangu.controller;

import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.http.HttpSession;
import org.json.JSONArray;
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
import com.syuusyoku.zipangu.vo.InterviewVO;
import com.syuusyoku.zipangu.vo.QuestionVO;

@Controller
public class InterviewController {
	
	@Autowired
	private InterviewDAO dao;
	
	//모의면접 진입
	@RequestMapping(value = "interview/getinterview", method = RequestMethod.GET)
	public String getinterview(Model model) {
		ArrayList<QuestionVO> questionList = dao.selectList();
		JSONArray json = new JSONArray(questionList);
		model.addAttribute("questionList", json);
		return "interview/interview";
	}
	
	//모의 면접 시작
	@ResponseBody
	@RequestMapping(value = "interview/startInterview", method = RequestMethod.POST)
	public int startInterview(InterviewVO vo, HttpSession session, RedirectAttributes rttr) {
		boolean result = false;
		if(dao.startInterview(vo, session) == 1) result = true;
		rttr.addFlashAttribute("startInterview", result);
		System.out.println(vo.toString()+"startInterview");
		return vo.getInterview_num();
	}
	
	//모의면접 녹음 파일
	@ResponseBody
	@RequestMapping(value = "interview/voice", method = RequestMethod.POST)
	public String voice(@RequestParam MultipartFile blob) {
		try {
			byte[] bytes = blob.getBytes();
			System.out.println(bytes.length+"KB");
		} catch (IOException e) {
			e.printStackTrace();
		}
		String dTime = dao.convert(blob);
		return dTime;
	}

	//각 각 모의 면접 결과 저장
	@ResponseBody
	@RequestMapping(value = "interview/insertInterview", method = RequestMethod.POST)
	public int insertInterview(InterviewResultVO vo) {
		int result = dao.insertInterview(vo);
		System.out.println(vo.toString()+"controller");
		return result;
	}
	
	// 1회차 모의 면접 결과 화면(보류)
//	@RequestMapping(value = "interview/selectInterview", method = RequestMethod.GET)
//	public String selectInterview(InterviewResultVO vo, Model model) {
//		ArrayList<InterviewResultVO> list = dao.selectInterview(vo);
//		model.addAttribute("list", list);
//		return "interview/interviewSelect";
//	}
//	
//	//값 받기
//	@ResponseBody
//	@RequestMapping(value = "interview/interviewSelect", method = RequestMethod.POST)
//	public int resultList2(@RequestParam InterviewResultVO vo) {
//		int result = dao.resultList2(vo);
//		return result;
//	}
//
//	//모의면접 5개를 실행한 결과만 전달
	@RequestMapping(value = "interview/interviewSelect", method = RequestMethod.GET)
	public String home() {
		return "interview/interviewSelect";
	}
//	
	@RequestMapping(value = "interview/getinterviewResult", method = RequestMethod.GET)
	public String resultList(Model model, InterviewResultVO vo) {
		ArrayList<InterviewResultVO> list = dao.resultList(vo); //최종 결과를 받아옴
		JSONArray json = new JSONArray(list);
		model.addAttribute("list_json", json);

		return "interview/interviewResult";
	}

	
}