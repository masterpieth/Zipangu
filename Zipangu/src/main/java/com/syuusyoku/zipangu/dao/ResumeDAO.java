package com.syuusyoku.zipangu.dao;

import java.io.File;
import java.util.ArrayList;

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
			resume.setUserID(session.getAttribute("userID").toString());
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
			resumeList = mapper.resumeList(session.getAttribute("userID").toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resumeList;
	}

//	public boolean checkID(String userID) {
//		int result = 0;
//		try {
//			MemberMapper mapper = session.getMapper(MemberMapper.class);
//			result = mapper.checkID(userID);
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return result > 0;
//	}
}