package com.syuusyoku.zipangu.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import com.syuusyoku.zipangu.vo.MemberVO;
import com.syuusyoku.zipangu.vo.PersonalityVO;
import com.syuusyoku.zipangu.vo.TimelineVO;

public interface PersonalityMapper {
	public void insertPersonality(Map<String,Object> map);
	public void updatePersonality(Map<String,Object> map);
	public ArrayList<PersonalityVO> keywordList(String userID);
	public int timelineWrite(TimelineVO vo);
	public TimelineVO timelineRead(TimelineVO vo);
	public int timelineUpdate(TimelineVO vo);
	public int timelineDelete(TimelineVO vo);
	public ArrayList<TimelineVO> timelineSearch(HashMap<String,String> map);
	public int withdraw(MemberVO member); //탈퇴로 인한 정보삭제
}