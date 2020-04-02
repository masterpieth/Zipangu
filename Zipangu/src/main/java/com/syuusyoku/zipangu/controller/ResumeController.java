package com.syuusyoku.zipangu.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.syuusyoku.zipangu.dao.ResumeDAO;
import com.syuusyoku.zipangu.vo.CareerVO;
import com.syuusyoku.zipangu.vo.QualifiedVO;
import com.syuusyoku.zipangu.vo.ResumeVO;

@Controller
public class ResumeController {
	@Autowired
	private ResumeDAO dao;

	@RequestMapping(value = "resume/resumeForm", method = RequestMethod.GET)
	public String resumeForm() {
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
		dao.saveResume(picFile, resume, session, careerList, qualifiedList);
		return "resume/resumeForm";
	}
}