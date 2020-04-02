package com.syuusyoku.zipangu.dao;

import java.util.ArrayList;

import org.springframework.web.multipart.MultipartFile;

import com.syuusyoku.zipangu.vo.InterviewResultVO;
import com.syuusyoku.zipangu.vo.QuestionVO;

public interface InterviewMapper {

	public ArrayList<QuestionVO> selectList();
	public int test(MultipartFile blob);
	public ArrayList<InterviewResultVO> resultList();
//	public int uploadVoice(InterviewResultVO vo);
}
