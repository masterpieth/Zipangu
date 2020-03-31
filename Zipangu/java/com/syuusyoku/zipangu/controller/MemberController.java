package com.syuusyoku.zipangu.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.syuusyoku.zipangu.dao.MemberDAO;
import com.syuusyoku.zipangu.vo.MemberVO;

@Controller
public class MemberController {
	@Autowired
	private MemberDAO dao;

	@RequestMapping(value = "member/signupForm", method = RequestMethod.GET)
	public String signupForm() {
		return "member/signupForm";
	}

	@ResponseBody
	@RequestMapping(value = "member/checkID", method = RequestMethod.GET)
	public boolean checkID(String userID) {
		return dao.checkID(userID);
	}

	@RequestMapping(value = "member/signup", method = RequestMethod.POST)
	public String signup(MemberVO member, HttpSession session) {
		if (dao.signup(member)) {
			dao.sendSimpleMessage(member.getEMail(), member.getUserID() + "님 가입을 환영합니다", "Zipangu에서");
			dao.login(member, session);
		}
		return "member/signupResult";
	}
	
	//임시 로그인
	@RequestMapping(value = "member/loginTemp", method = RequestMethod.GET)
	public String loginTemp() {
		return "member/loginTemp";
	}

	//임시 로그인
	@RequestMapping(value = "member/login", method = RequestMethod.POST)
	public String login(MemberVO member, HttpSession session, RedirectAttributes rttr) {
		boolean result = dao.login(member, session);
		rttr.addFlashAttribute("loginResultTemp", result);
		return "redirect:/";
	}
	
	//임시 로그아웃,, dao안만듬
	@RequestMapping(value = "member/logoutTemp", method = RequestMethod.GET)
	public String logoutTemp(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}

}