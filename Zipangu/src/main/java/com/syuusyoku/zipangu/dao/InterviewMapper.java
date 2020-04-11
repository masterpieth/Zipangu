package com.syuusyoku.zipangu.dao;

import java.util.ArrayList;

import com.syuusyoku.zipangu.vo.QuestionVO;

public interface InterviewMapper {

	public ArrayList<QuestionVO> selectList();
//	public ArrayList<InterviewResultVO> resultList();
}
