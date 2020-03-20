package com.syuusyoku.zipangu.controller;

import java.io.FileWriter;
import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.syuusyoku.zipangu.dao.PersonalityDAO;


@Controller
public class PersonalityController {
	
	@Autowired
	private PersonalityDAO dao;
	
	@RequestMapping(value = "personalityInsight", method = RequestMethod.GET)
	public String personalityInsight() {
		
		return "personalityInsight";
	}

	@RequestMapping(value = "sendKakao", method = RequestMethod.POST)
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
		
		return "redirect:/personalityInsight";
	}

}
