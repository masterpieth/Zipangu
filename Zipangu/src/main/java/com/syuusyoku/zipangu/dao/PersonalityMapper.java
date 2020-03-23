package com.syuusyoku.zipangu.dao;

import java.util.ArrayList;
import java.util.Map;

import com.syuusyoku.zipangu.vo.PersonalityVO;

public interface PersonalityMapper {
	public void insertPersonality(Map<String,Object> map);
	public ArrayList<PersonalityVO> keywordList(String userid);
}
