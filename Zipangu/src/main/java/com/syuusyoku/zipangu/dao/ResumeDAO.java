package com.syuusyoku.zipangu.dao;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.syuusyoku.zipangu.vo.CareerVO;
import com.syuusyoku.zipangu.vo.MemberVO;
import com.syuusyoku.zipangu.vo.QualifiedVO;
import com.syuusyoku.zipangu.vo.ResumeVO;

@Repository
public class ResumeDAO {
	private final int countPerPage = 5;
	private final int pagePerGroup = 3;
	@Autowired
	private SqlSession session;

	@Transactional
	public boolean saveResume(
		MultipartFile picFile, MemberVO member, ResumeVO resume,
		String careerJSON, String qualifiedJSON
	) {
		int result = 0;
		Gson gson = new Gson();
		ArrayList<CareerVO> careerList = gson.fromJson(careerJSON, new TypeToken<ArrayList<CareerVO>>(){}.getType());
		ArrayList<QualifiedVO> qualifiedList = gson.fromJson(qualifiedJSON, new TypeToken<ArrayList<QualifiedVO>>(){}.getType());
		try {
			ResumeMapper mapper = session.getMapper(ResumeMapper.class);
			int resume_num = member.getResume_num();
			if (resume_num < 0) {
				if (!picFile.isEmpty()) {
					resume.setPicFileName(picFile.getOriginalFilename());
					result = mapper.saveResume(resume);
					resume_num = resume.getResume_num();
					picFile.transferTo(new File("C:/Zipangu/img/picFile/" + resume_num + "_" + resume.getPicFileName()));
				} else {
					result = mapper.saveResume(resume);
					resume_num = resume.getResume_num();
				}
				member.setResume_num(resume_num);
				result += mapper.saveResumeMember(member);
			} else {
				if (!picFile.isEmpty()) {
					new File("C:/Zipangu/img/picFile/" + resume_num + "_" + resume.getPicFileName()).delete();
					resume.setPicFileName(picFile.getOriginalFilename());
					picFile.transferTo(new File("C:/Zipangu/img/picFile/" + resume_num + "_" + resume.getPicFileName()));
				}
				result = mapper.updateResume(resume);
				result += mapper.updateResumeMember(member);
				result += mapper.deleteCareer(resume_num);
				result += mapper.deleteQualified(resume_num);
			}
			for (CareerVO career: careerList) {
				career.setResume_num(resume_num);
				result += mapper.saveCareer(career);
			}
			for (QualifiedVO qualified : qualifiedList) {
				qualified.setResume_num(resume_num);
				result += mapper.saveQualified(qualified);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result > 0;
	}

	public ArrayList<ResumeVO> resumeList(String userID, PageNavigator navi) {
		ArrayList<ResumeVO> resumeList = null;
		RowBounds rowBounds = new RowBounds(navi.getStartRecord(), navi.getCountPerPage());
		try {
			ResumeMapper mapper = session.getMapper(ResumeMapper.class);
			resumeList = mapper.resumeList(userID, rowBounds);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resumeList;
	}

	public PageNavigator navi(String userID, int page) {
		int resumeCount = 0;
		try {
			ResumeMapper mapper = session.getMapper(ResumeMapper.class);
			resumeCount = mapper.resumeCount(userID);
		} catch (Exception e) {
			e.printStackTrace();
		}
		PageNavigator navi = new PageNavigator(countPerPage, pagePerGroup, page, resumeCount);

		return navi;
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