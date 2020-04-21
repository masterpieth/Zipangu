package com.syuusyoku.zipangu.dao;

import java.util.ArrayList;

import com.syuusyoku.zipangu.vo.InterviewResultVO;
import com.syuusyoku.zipangu.vo.InterviewVO;
import com.syuusyoku.zipangu.vo.QuestionVO;

public interface InterviewMapper {

	public ArrayList<QuestionVO> selectList();
	public int startInterview(InterviewVO vo);
	public int insertInterview(InterviewResultVO vo);
	public ArrayList<InterviewResultVO> selectInterview(InterviewResultVO vo);
	public ArrayList<InterviewResultVO> resultList();
}
