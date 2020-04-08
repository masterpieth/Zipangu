package com.syuusyoku.zipangu.controller;


import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.syuusyoku.zipangu.dao.MemberDAO;
import com.syuusyoku.zipangu.dao.PersonalityDAO;
import com.syuusyoku.zipangu.vo.PersonalityVO;
import com.syuusyoku.zipangu.vo.TimelineVO;


@Controller
public class PersonalityController {
	
	@Autowired
	private PersonalityDAO dao;
	
	@Autowired
	private MemberDAO daoMe;
	
	@RequestMapping(value = "personality/personalityInsight", method = RequestMethod.GET)
	public String personalityInsight() {
		
		return "/personality/personalityInsight";
	}

	@RequestMapping(value = "personality/sendKakao", method = RequestMethod.POST)
	public String sendKakao(String kakaoContent, String kakaoName, RedirectAttributes rttr) {
		
		String userID="test";
		
		String text = dao.textList(kakaoContent, kakaoName);
		
		String textFileName = daoMe.memberInfo(userID).getTextFileName();
		
		File file = new File("C:\\Users\\Administrator\\Desktop\\Zipangu\\Zipangu\\src\\main\\webapp\\resources\\imgUpload\\"+textFileName+".txt");
		if(file.exists()) file.delete();
		
		textFileName = UUID.randomUUID().toString();
		daoMe.uploadKakaoText(userID, textFileName);	
		
		String filePath = "C:\\Users\\Administrator\\Desktop\\Zipangu\\Zipangu\\src\\main\\webapp\\resources\\imgUpload\\"+textFileName+".txt";
		try {
			
			FileWriter fileWriter = new FileWriter(filePath);
			
			fileWriter.write(text);
			fileWriter.close();
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		rttr.addFlashAttribute("revisedContent", text);
		
		return "redirect:/personality/personalityInsight";
	}
	
	
	
	@RequestMapping(value="personality/insertPersonality", method = RequestMethod.POST)
	@ResponseBody
	public void insertPersonality(String[] trait, Double[] rate) {
		String userID = "test";
		List<PersonalityVO> list = new ArrayList<>();
	
		for(int i=0; i<trait.length; i++) {
			PersonalityVO vo = new PersonalityVO();
			
			vo.setUserID(userID);
			vo.setTrait(trait[i]);
			vo.setRate(rate[i]);
			list.add(vo);
		} 
	
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("list11", list);
		
		if(dao.keywordList(userID).isEmpty()) {
			dao.insertPersonality(map);	
		} else if(!dao.keywordList(userID).isEmpty()) {
			dao.updatePersonality(map);
		}
		
	}
	
	
	@RequestMapping(value = "personality/keywordTimeline", method = RequestMethod.GET)
	public String keywordTimeline(@RequestParam(value = "searchItem", defaultValue = "byKeyword") String searchItem,
			@RequestParam(value = "searchKeyword", defaultValue = "") String searchKeyword,
			Model model) {
		ArrayList<TimelineVO> list = dao.timelineSearch(searchItem, searchKeyword);

		model.addAttribute("timelineList", list);
		
		return "/personality/keywordTimeline";
	}
	
	@RequestMapping(value = "personality/timelineWriteForm", method = RequestMethod.GET)
	public String timelineWriteForm(Model model) {
		String userID = "test";
		ArrayList<PersonalityVO> list = dao.keywordList(userID);
		model.addAttribute("keywordList", list);
		
		return "/personality/timelineWriteForm";
	}
	
	@RequestMapping(value = "personality/timelineWrite", method = RequestMethod.POST)
	public String timelineWrite(TimelineVO vo, RedirectAttributes rttr) {
		vo.setUserID("test");
		boolean result = dao.timelineWrite(vo);
		rttr.addFlashAttribute("timelineWriteResult", result);
		return "redirect:/personality/keywordTimeline";
	}
	
	@RequestMapping(value = "personality/timelineUpdateForm", method = RequestMethod.GET)
	public String timelineUpdateForm(int timeline_Num, Model model) {
		String userID = "test";
		
		TimelineVO vo = dao.timelineRead(timeline_Num);
		model.addAttribute("timelineVO", vo);
		
		ArrayList<PersonalityVO> list = dao.keywordList(userID);
		model.addAttribute("keywordList", list);
		
		return "/personality/timelineUpdateForm";
	}
	
	@RequestMapping(value = "personality/timelineUpdate", method = RequestMethod.POST)
	public String timelineUpdateForm(TimelineVO vo, RedirectAttributes rttr) {
		vo.setUserID("test");
		
		boolean result = dao.timelineUpdate(vo);
		rttr.addFlashAttribute("timelineUpdateResult", result);
		
		return "redirect:/personality/keywordTimeline";
	}
	
	@RequestMapping(value = "personality/timelineDelete", method = RequestMethod.GET)
	public String timelineDelete(TimelineVO vo, RedirectAttributes rttr) {
		vo.setUserID("test");
		
		boolean result = dao.timelineDelete(vo);
		rttr.addFlashAttribute("timelineDeleteResult", result);
		
		return "redirect:/personality/keywordTimeline";
	}
	
}
