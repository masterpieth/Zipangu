package com.syuusyoku.zipangu.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.syuusyoku.zipangu.dao.MemberDAO;
import com.syuusyoku.zipangu.dao.ResumeDAO;
import com.syuusyoku.zipangu.vo.CareerVO;
import com.syuusyoku.zipangu.vo.MemberVO;
import com.syuusyoku.zipangu.vo.QualifiedVO;
import com.syuusyoku.zipangu.vo.ResumeVO;

@Controller
public class ResumeController {
	@Autowired
	private ResumeDAO dao;
	@Autowired
	private MemberDAO memberDao;

	@RequestMapping(value = "resume/resumeForm", method = RequestMethod.GET)
	public String resumeForm(int resume_num, HttpSession session, Model model) {
		if (resume_num > -1) {
			HashMap<String, Object> resume = dao.getResume(resume_num, session);
			model.addAttribute("resume", resume.get("resume"));
			model.addAttribute("careerList", resume.get("careerList"));
			model.addAttribute("qualifiedList", resume.get("qualifiedList"));
		}
		MemberVO member = new MemberVO();
		member.setUserID((String) session.getAttribute("userID"));
		member.setUserPwd((String) session.getAttribute("userPwd"));
		model.addAttribute("member", memberDao.getMember(member));
		return "resume/resumeForm";
	}

	@RequestMapping(value = "resume/resumeList", method = RequestMethod.GET)
	public String resumeList(HttpSession session, Model model) {
		model.addAttribute("resumeList", dao.resumeList(session));
		return "resume/resumeList";
	}

	@RequestMapping(value = "resume/saveResume", method = RequestMethod.POST)
	public String saveResume(
		MultipartFile picFile, ResumeVO resume, String[] careerStartYear, String[] careerStartMonth,
		String[] careerEndYear, String[] careerEndMonth, String[] careerContent,
		String[] qualifiedYear, String[] qualifiedMonth, String[] qualifiedContent, HttpSession session
	) {
		ArrayList<CareerVO> careerList = new ArrayList<>();
		for (int i = 0; i < careerContent.length; i++) {
			CareerVO career = new CareerVO();
			career.setStart_period(careerStartYear[i] + "-" + careerStartMonth[i] + "-01");
			career.setEnd_period(careerEndYear[i] + "-" + careerEndMonth[i] + "-01");
			career.setContent(careerContent[i]);
			careerList.add(career);
		}
		ArrayList<QualifiedVO> qualifiedList = new ArrayList<>();
		for (int i = 0; i < qualifiedContent.length; i++) {
			QualifiedVO qualified = new QualifiedVO();
			qualified.setPeriod(qualifiedYear[i] + "-" + qualifiedMonth[i] + "-01");
			qualified.setContent(qualifiedContent[i]);
			qualifiedList.add(qualified);
		}
		if (resume.getResume_num() > -1)
		dao.saveResume(picFile, resume, session, careerList, qualifiedList);
		return "/";
	}
}