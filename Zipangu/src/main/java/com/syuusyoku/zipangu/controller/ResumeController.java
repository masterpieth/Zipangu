package com.syuusyoku.zipangu.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.syuusyoku.zipangu.dao.MemberDAO;
import com.syuusyoku.zipangu.dao.ResumeDAO;
import com.syuusyoku.zipangu.dao.ScheduleDAO;
import com.syuusyoku.zipangu.vo.MemberVO;
import com.syuusyoku.zipangu.vo.ResumeVO;

@Controller
public class ResumeController {
	@Autowired
	private ResumeDAO dao;
	@Autowired
	private MemberDAO memberDao;
	@Autowired
	private ScheduleDAO scheduleDao;

	@RequestMapping(value = "resume/resumeForm", method = RequestMethod.GET)
	public String resumeForm(ResumeVO resume, HttpSession session, Model model) {
		String userID = (String) session.getAttribute("userID");
		int resume_num = resume.getResume_num();
		if (resume_num < 0) {
			model.addAttribute("resume", resume);
			model.addAttribute("member", memberDao.getMember(userID));
		} else {
			MemberVO member = new MemberVO();
			member.setUserID(userID);
			member.setResume_num(resume_num);
			model.addAttribute("member", dao.getResumeMember(member));
			HashMap<String, Object> resumeForm = dao.getResume(member);
			model.addAttribute("resume", resumeForm.get("resume"));
			model.addAttribute("careerList", resumeForm.get("careerList"));
			model.addAttribute("qualifiedList", resumeForm.get("qualifiedList"));
			model.addAttribute("mentorID", scheduleDao.getMentorID(userID));
		}
		return "resume/resumeForm";
	}

	@RequestMapping(value = "resume/resumeList", method = RequestMethod.GET)
	public String resumeList(HttpSession session, Model model) {
		model.addAttribute("resumeList", dao.resumeList((String) session.getAttribute("userID")));
		return "resume/resumeList";
	}

	@RequestMapping(value = "resume/saveResume", method = RequestMethod.POST)
	public String saveResume(
		MultipartFile picFile, MemberVO member, ResumeVO resume, 
		String careerList, String qualifiedList, HttpSession session
	) {
		resume.setUserID((String) session.getAttribute("userID"));
		dao.saveResume(picFile, member, resume, careerList, qualifiedList);
		return "redirect:/resume/resumeList";
	}

	@ResponseBody
	@RequestMapping(value = "resume/shareUrl", method = RequestMethod.POST)
	public String shareUrl(String mentorID, String shareUrl, HttpSession session) {
		MemberVO member = memberDao.getMember(mentorID);
		String menteeID = (String) session.getAttribute("userID");
		String subject = menteeID + "님이 멘토링을 원하고 있습니다.";
		memberDao.sendSimpleMessage(member.getEmail(), subject, shareUrl);
		return mentorID;
	}
}