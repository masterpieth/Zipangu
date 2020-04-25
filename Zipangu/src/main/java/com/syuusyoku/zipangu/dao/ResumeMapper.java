package com.syuusyoku.zipangu.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;

import com.syuusyoku.zipangu.vo.CareerVO;
import com.syuusyoku.zipangu.vo.MemberVO;
import com.syuusyoku.zipangu.vo.QualifiedVO;
import com.syuusyoku.zipangu.vo.ResumeVO;

public interface ResumeMapper {

	int saveResume(ResumeVO resume);

	void saveResumeMember(MemberVO member);

	void saveCareer(CareerVO career);

	void saveQualified(QualifiedVO qualified);

	int updateResume(ResumeVO resume);
	
	void updateResumeMember(MemberVO member);
	
	void deleteCareer(int resume_num);
	
	void deleteQualified(int resume_num);
	
	MemberVO getResumeMember(MemberVO member);

	ArrayList<ResumeVO> resumeList(String userID, RowBounds rowBounds);

	int resumeCount(String userID);

	ResumeVO getResume(MemberVO member);

	ArrayList<CareerVO> getCareer(int resume_num);

	ArrayList<QualifiedVO> getQualified(int resume_num);

	int withdraw(MemberVO member);
}