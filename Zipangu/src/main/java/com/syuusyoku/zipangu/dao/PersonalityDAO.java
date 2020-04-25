package com.syuusyoku.zipangu.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.syuusyoku.zipangu.vo.PersonalityVO;
import com.syuusyoku.zipangu.vo.TimelineVO;

@Repository
public class PersonalityDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	public String textList(String kakaoContent, String kakaoName){	
		
		Pattern pattern = Pattern.compile("\\["+kakaoName+"] \\[(?:........|.......)] (.*?)\\["); 
	      Matcher matcher = pattern.matcher(kakaoContent);

	      String text="";
	      while(matcher.find()) {
	         text += matcher.group(1);
	      }
	      text = text.replaceAll("....년 (?:..|.)월 (?:..|.)일 .요일","");
	      text = text.replaceAll("---------------", "");
	      
	      String regex = "[^\\p{L}\\p{N}\\p{P}\\p{Z}]";
	       Pattern emoticons = Pattern.compile(regex, Pattern.UNICODE_CHARACTER_CLASS);
	       Matcher emoMatcher = emoticons.matcher(text);
	       
	       String result = emoMatcher.replaceAll("");

	      return result;
	     
	} 


	public void insertPersonality(Map<String,Object> map) {
		
		try {
			PersonalityMapper mapper = sqlSession.getMapper(PersonalityMapper.class);
			mapper.insertPersonality(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	public void updatePersonality(Map<String,Object> map) {
		
		try {
			PersonalityMapper mapper = sqlSession.getMapper(PersonalityMapper.class);
			mapper.updatePersonality(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	public ArrayList<PersonalityVO> keywordList(String userID) {
		ArrayList<PersonalityVO> list = null;
		try {
			PersonalityMapper mapper = sqlSession.getMapper(PersonalityMapper.class);
			list = mapper.keywordList(userID);
		} catch (Exception e) {
			e.printStackTrace();
		} return list;
	}
	
	public boolean timelineWrite(TimelineVO vo) {
		int result = 0;
		try {
			PersonalityMapper mapper = sqlSession.getMapper(PersonalityMapper.class);
			result = mapper.timelineWrite(vo);
		} catch (Exception e) {
			e.printStackTrace();
		} if(result==0) return false;
		return true;
	}
	
	public TimelineVO timelineRead(TimelineVO vo) {
		TimelineVO result = null;
		try {
			PersonalityMapper mapper = sqlSession.getMapper(PersonalityMapper.class);
			result = mapper.timelineRead(vo);
		} catch (Exception e) {
			e.printStackTrace();
		} return result;
	}
	
	public boolean timelineUpdate(TimelineVO vo) {
		int result = 0;
		try {
			PersonalityMapper mapper = sqlSession.getMapper(PersonalityMapper.class);
			result = mapper.timelineUpdate(vo);
		} catch (Exception e) {
			e.printStackTrace();
		} if(result==0) return false;
		return true;
	}
	

	public boolean timelineDelete(TimelineVO vo) {
		int result = 0;
		try {
			PersonalityMapper mapper = sqlSession.getMapper(PersonalityMapper.class);
			result = mapper.timelineDelete(vo);
		} catch (Exception e) {
			e.printStackTrace();
		} if(result==0) return false;
		return true;
	}
	
	public ArrayList<TimelineVO> timelineSearch(String searchItem, String searchKeyword, HttpSession session) {
		String userID = (String)session.getAttribute("userID");
		ArrayList<TimelineVO> list = null;
		
		HashMap<String,String> map = new HashMap<>();
		map.put("searchItem", searchItem);
		map.put("searchKeyword", searchKeyword);
		map.put("userID",userID);
		
		try {
			PersonalityMapper mapper = sqlSession.getMapper(PersonalityMapper.class);
			list = mapper.timelineSearch(map);
		} catch (Exception e) {
			e.printStackTrace();
		} return list;
	}
}