package com.syuusyoku.zipangu.dao;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.syuusyoku.zipangu.vo.CareerVO;
import com.syuusyoku.zipangu.vo.MemberVO;
import com.syuusyoku.zipangu.vo.QualifiedVO;
import com.syuusyoku.zipangu.vo.ResumeVO;

@Repository
public class ResumeDAO {
	@Autowired
	private SqlSession session;

	public boolean saveResume(
		MultipartFile picFile, MemberVO member, ResumeVO resume,
		String careerList, String qualifiedList
	) {
		int result = 0;
		try {
			ResumeMapper mapper = session.getMapper(ResumeMapper.class);
			CareerVO[] careerArray = new ObjectMapper().readValue(careerList, CareerVO[].class);
			QualifiedVO[] qualifiedArray = new ObjectMapper().readValue(qualifiedList, QualifiedVO[].class);
			int resume_num = member.getResume_num();
			boolean picFileExist = !picFile.isEmpty();
			if (resume_num < 0) {
				if (picFileExist)
					resume.setPicFileName(picFile.getOriginalFilename());
				result = mapper.saveResume(resume);
				resume_num = resume.getResume_num();
				if (picFileExist)
					picFile.transferTo(new File("C:/Zipangu/img/picFile/" + resume_num + "_" + resume.getPicFileName()));
				member.setResume_num(resume_num);
				result += mapper.saveResumeMember(member);
				for (CareerVO career: careerArray) {
					career.setResume_num(resume_num);
					result += mapper.saveCareer(career);
				}
				for (QualifiedVO qualified : qualifiedArray) {
					qualified.setResume_num(resume_num);
					result += mapper.saveQualified(qualified);
				}
			} else {
				if (resume.getPicFileName() != null)
					new File("C:/Zipangu/img/picFile/" + resume_num + "_" + resume.getPicFileName()).delete();
				if (picFileExist)
					resume.setPicFileName(picFile.getOriginalFilename());
				result = mapper.updateResume(resume);
				if (picFileExist)
					picFile.transferTo(new File("C:/Zipangu/img/picFile/" + resume_num + "_" + resume.getPicFileName()));
				result += mapper.updateResumeMember(member);
				result += mapper.deleteCareer(resume_num);
				for (CareerVO career: careerArray)
					result += mapper.saveCareer(career);
				result += mapper.deleteQualified(resume_num);
				for (QualifiedVO qualified : qualifiedArray)
					result += mapper.saveQualified(qualified);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result > 0;
	}

	public ArrayList<ResumeVO> resumeList(String userID) {
		ArrayList<ResumeVO> resumeList = null;
		try {
			ResumeMapper mapper = session.getMapper(ResumeMapper.class);
			resumeList = mapper.resumeList(userID);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resumeList;
	}

	public HashMap<String, Object> getResume(MemberVO member) {
		HashMap<String, Object> resumeForm = new HashMap<>();
		try {
			int resume_num = member.getResume_num();
			ResumeMapper mapper = session.getMapper(ResumeMapper.class);
			resumeForm.put("resume", mapper.getResume(member));
			resumeForm.put("careerList", mapper.getCareer(resume_num));
			resumeForm.put("qualifiedList", mapper.getQualified(resume_num));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resumeForm;
	}

	public MemberVO getResumeMember(MemberVO member) {
		try {
			ResumeMapper mapper = session.getMapper(ResumeMapper.class);
			member = mapper.getResumeMember(member);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return member;
	}
}