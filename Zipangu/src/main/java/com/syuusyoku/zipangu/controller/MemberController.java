package com.syuusyoku.zipangu.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

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
			dao.sendSimpleMessage(member.getEmail(), member.getUserID() + "님 가입을 환영합니다", "Zipangu에서");
			dao.login(member, session);
		}
		return "member/signupResult";
	}

	@RequestMapping(value = "member/login", method = RequestMethod.POST)
	public String login(MemberVO member, HttpSession session) {
		dao.login(member, session);
		return "home";
	}

	@RequestMapping(value = "member/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		dao.logout(session);
		return "home";
	}
}