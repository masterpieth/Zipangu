package com.syuusyoku.zipangu.dao;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.stereotype.Repository;

@Repository
public class PersonalityDAO {

	public String textList(String kakaoContent, String kakaoName){	
		
		Pattern pattern = Pattern.compile("\\["+kakaoName+"] \\[(?:........|.......)] (.*?)\r\n"); 
		Matcher matcher = pattern.matcher(kakaoContent);
		
		String text="";
		
		while(matcher.find()) {
			text += matcher.group(1);
		}
		System.out.println(text);
		
		return text;
		
	} 
}
