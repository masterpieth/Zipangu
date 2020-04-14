package com.syuusyoku.zipangu.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.syuusyoku.zipangu.vo.CareerVO;
import com.syuusyoku.zipangu.vo.QualifiedVO;
import com.syuusyoku.zipangu.vo.ResumeVO;

public interface ResumeMapper {

	int saveResume(ResumeVO resume);

	int saveCareer(CareerVO career);

	int saveQualified(QualifiedVO qualified);

	ArrayList<ResumeVO> resumeList(String userID);

	ResumeVO getResume(HashMap<String, Object> map);

	ArrayList<CareerVO> getCareer(int resume_num);

	ArrayList<QualifiedVO> getQualified(int resume_num);
}