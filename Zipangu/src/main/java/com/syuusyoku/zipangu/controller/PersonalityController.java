package com.syuusyoku.zipangu.controller;


import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.syuusyoku.zipangu.dao.PersonalityDAO;
import com.syuusyoku.zipangu.vo.PersonalityVO;


@Controller
public class PersonalityController {
	
	@Autowired
	private PersonalityDAO dao;
	
	@RequestMapping(value = "personality/personalityInsight", method = RequestMethod.GET)
	public String personalityInsight() {
		
		return "personality/personalityInsight";
	}

	@RequestMapping(value = "personality/sendKakao", method = RequestMethod.POST)
	public String sendKakao(@RequestParam String kakaoContent, String kakaoName, RedirectAttributes rttr) {
		
		String text = dao.textList(kakaoContent, kakaoName);
		
		String filePath = "C:/test/testtest.txt";
		
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
		
		List<PersonalityVO> list = new ArrayList<>();
	
		for(int i=0; i<trait.length; i++) {
			PersonalityVO vo = new PersonalityVO();
			
			vo.setUserid("test");
			vo.setTrait(trait[i]);
			vo.setRate(rate[i]);
			list.add(vo);
		} 
	
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("list11", list);
		
		dao.insertPersonality(map);	
	}
	
	
	@RequestMapping(value = "personality/keywordTimeline", method = RequestMethod.GET)
	public String keywordTimeline(Model model) {

		ArrayList<PersonalityVO> list = dao.keywordList();
		model.addAttribute("keywordList", list);
		
		return "personality/keywordTimeline";
	}

}
