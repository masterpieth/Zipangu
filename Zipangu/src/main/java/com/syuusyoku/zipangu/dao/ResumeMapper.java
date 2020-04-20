package com.syuusyoku.zipangu.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.syuusyoku.zipangu.vo.CareerVO;
import com.syuusyoku.zipangu.vo.MemberVO;
import com.syuusyoku.zipangu.vo.QualifiedVO;
import com.syuusyoku.zipangu.vo.ResumeVO;

public interface ResumeMapper {

	int saveResume(ResumeVO resume);

	int saveResumeMember(MemberVO member);

	int saveCareer(CareerVO career);

	int saveQualified(QualifiedVO qualified);

	int updateResume(ResumeVO resume);
	
	int updateResumeMember(MemberVO member);
	
	int deleteCareer(int resume_num);
	
	int deleteQualified(int resume_num);
	
	MemberVO getResumeMember(MemberVO member);

	ArrayList<ResumeVO> resumeList(String userID);

	ResumeVO getResume(MemberVO member);

	ArrayList<CareerVO> getCareer(int resume_num);

	ArrayList<QualifiedVO> getQualified(int resume_num);
}