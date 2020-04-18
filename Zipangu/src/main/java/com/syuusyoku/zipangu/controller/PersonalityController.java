
package com.syuusyoku.zipangu.controller;


import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.syuusyoku.zipangu.dao.MemberDAO;
import com.syuusyoku.zipangu.dao.PersonalityDAO;
import com.syuusyoku.zipangu.vo.PersonalityVO;
import com.syuusyoku.zipangu.vo.TimelineVO;
import com.syuusyoku.zipangu.vo.kakaoVO;



@Controller
public class PersonalityController {
	
	@Autowired
	private PersonalityDAO dao;
	
	@Autowired
	private MemberDAO daoMe;
	
	@RequestMapping(value = "personality/personalityInsight", method = RequestMethod.GET)
	public String personalityInsight(HttpSession session, Model model) {
	
		return "/personality/personalityInsight";
	}
	
	@RequestMapping(value = "personality/uploadTextForm", method = RequestMethod.GET)
	public String uploadTextForm() {
		
		return "/personality/uploadTextForm";
	}

	@RequestMapping(value = "personality/sendKakao", method = RequestMethod.POST,produces ="application/text; charset=utf8")
	@ResponseBody
	public String sendKakao(@RequestBody kakaoVO vo, HttpSession session) {
		
		String userID=(String)session.getAttribute("userID");
		String kakaoContent = vo.getKakaoContent();

		String kakaoName = vo.getKakaoName();

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
		
		textFileName = daoMe.memberInfo(userID).getTextFileName();
		
		String result = "";
		file = null;
		 try{
	   
			 file = new File("C:\\Users\\Administrator\\Desktop\\Zipangu\\Zipangu\\src\\main\\webapp\\resources\\imgUpload\\"+textFileName+".txt");
			 
		     FileReader fr = new FileReader(file);
	         
		     BufferedReader br = new BufferedReader(fr);
	            
		     String line = "";
	         while((line = br.readLine()) != null){
	                result += line;
	         }
	         br.close();
	        }catch (FileNotFoundException e) {
	        	e.printStackTrace();
	        }catch(IOException e){
	        	e.printStackTrace();
	        }
		 
		 return result;

	}
	
	
	
	@RequestMapping(value="personality/insertPersonality", method = RequestMethod.POST)
	@ResponseBody
	public void insertPersonality(String[] trait, Double[] rate, HttpSession session) {
		String userID = (String)session.getAttribute("userID");
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
	
	@RequestMapping(value = "personality/makeChart", method = RequestMethod.POST)
	@ResponseBody
	public ArrayList<PersonalityVO> makeChart(Model model, HttpSession session) {
		
		String userID=(String)session.getAttribute("userID");
		ArrayList<PersonalityVO> list = dao.keywordList(userID); //퍼센트 높은 순..
		
		return list;
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
	public String timelineWriteForm(Model model, HttpSession session) {
		String userID=(String)session.getAttribute("userID");
		ArrayList<PersonalityVO> list = dao.keywordList(userID);
		model.addAttribute("keywordList", list);
		
		return "/personality/timelineWriteForm";
	}
	
	@RequestMapping(value = "personality/timelineWrite", method = RequestMethod.POST)
	public String timelineWrite(TimelineVO vo, RedirectAttributes rttr, HttpSession session) {
		String userID=(String)session.getAttribute("userID");
		vo.setUserID(userID);
		boolean result = dao.timelineWrite(vo);
		rttr.addFlashAttribute("timelineWriteResult", result);
		return "redirect:/personality/keywordTimeline";
	}
	
	@RequestMapping(value = "personality/timelineUpdateForm", method = RequestMethod.GET)
	public String timelineUpdateForm(int timeline_Num, Model model, HttpSession session) {
		String userID=(String)session.getAttribute("userID");
		
		TimelineVO vo = dao.timelineRead(timeline_Num);
		model.addAttribute("timelineVO", vo);
		
		ArrayList<PersonalityVO> list = dao.keywordList(userID);
		model.addAttribute("keywordList", list);
		
		return "/personality/timelineUpdateForm";
	}
	
	@RequestMapping(value = "personality/timelineUpdate", method = RequestMethod.POST)
	public String timelineUpdateForm(TimelineVO vo, RedirectAttributes rttr, HttpSession session) {
		String userID=(String)session.getAttribute("userID");
		vo.setUserID(userID);
		
		boolean result = dao.timelineUpdate(vo);
		rttr.addFlashAttribute("timelineUpdateResult", result);
		
		return "redirect:/personality/keywordTimeline";
	}
	
	@RequestMapping(value = "personality/timelineDelete", method = RequestMethod.GET)
	public String timelineDelete(TimelineVO vo, RedirectAttributes rttr, HttpSession session) {
		String userID=(String)session.getAttribute("userID");
		vo.setUserID(userID);
		
		boolean result = dao.timelineDelete(vo);
		rttr.addFlashAttribute("timelineDeleteResult", result);
		
		return "redirect:/personality/keywordTimeline";
	}
	
}
