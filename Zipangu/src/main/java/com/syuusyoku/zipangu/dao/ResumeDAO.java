package com.syuusyoku.zipangu.dao;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.syuusyoku.zipangu.vo.CareerVO;
import com.syuusyoku.zipangu.vo.QualifiedVO;
import com.syuusyoku.zipangu.vo.ResumeVO;

@Repository
public class ResumeDAO {
	@Autowired
	private SqlSession session;
	@Autowired
	private JavaMailSender mailSender;

	public boolean saveResume(
		MultipartFile picFile, ResumeVO resume, HttpSession session,
		ArrayList<CareerVO> careerList, ArrayList<QualifiedVO> qualifiedList
	) {
		int result = 0;
		try {
			resume.setUserID((String) session.getAttribute("userID"));
			resume.setPicFileName(picFile.getOriginalFilename());
			ResumeMapper mapper = this.session.getMapper(ResumeMapper.class);
			result = mapper.saveResume(resume);
			int resume_num = resume.getResume_num();
			if (result > 0)
				picFile.transferTo(new File("C:/Zipangu/img/picFile/" + resume_num + "_" + resume.getPicFileName()));
			for (CareerVO career: careerList) {
				if (result > 0) {
					career.setResume_num(resume_num);
					result = mapper.saveCareer(career);
				}
			}
			for (QualifiedVO qualified : qualifiedList) {
				if (result > 0) {
					qualified.setResume_num(resume_num);
					result = mapper.saveQualified(qualified);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result > 0;
	}

	public ArrayList<ResumeVO> resumeList(HttpSession session) {
		ArrayList<ResumeVO> resumeList = null;
		try {
			ResumeMapper mapper = this.session.getMapper(ResumeMapper.class);
			resumeList = mapper.resumeList((String) session.getAttribute("userID"));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resumeList;
	}

	public HashMap<String, Object> getResume(int resume_num, HttpSession session) {
		HashMap<String, Object> resume = new HashMap<>();
		try {
			ResumeMapper mapper = this.session.getMapper(ResumeMapper.class);
			HashMap<String, Object> map = new HashMap<>();
			map.put("userID", (String) session.getAttribute("userID"));
			map.put("resume_num", resume_num);
			resume.put("resume", mapper.getResume(map));
			resume.put("careerList", mapper.getCareer(resume_num));
			resume.put("qualifiedList", mapper.getQualified(resume_num));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resume;
	}
}