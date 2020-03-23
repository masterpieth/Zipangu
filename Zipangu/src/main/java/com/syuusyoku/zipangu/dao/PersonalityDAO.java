package com.syuusyoku.zipangu.dao;

import java.util.ArrayList;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.syuusyoku.zipangu.vo.PersonalityVO;

@Repository
public class PersonalityDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	public String textList(String kakaoContent, String kakaoName){	
		
		Pattern pattern = Pattern.compile("\\["+kakaoName+"] \\[(?:........|.......)] (.*?)\r\n"); 
		Pattern emoticons = Pattern.compile("[^\\x00-\\x7F]");
		Matcher matcher = pattern.matcher(kakaoContent);
		Matcher emoticonsMatcher = emoticons.matcher(kakaoContent);
		kakaoContent = emoticonsMatcher.replaceAll("");

		String text="";
		
		while(matcher.find()) {
			text += matcher.group(1);
		}
		System.out.println(text);
		
		return text;
		
	} 
	
	
	
	public void insertPersonality(Map<String,Object> map) {
		
		try {
			PersonalityMapper mapper = sqlSession.getMapper(PersonalityMapper.class);
			mapper.insertPersonality(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	public ArrayList<PersonalityVO> keywordList() {
		String userid="test";
		ArrayList<PersonalityVO> list = null;
		try {
			PersonalityMapper mapper = sqlSession.getMapper(PersonalityMapper.class);
			list = mapper.keywordList(userid);
		} catch (Exception e) {
			e.printStackTrace();
		} return list;
	}
}
