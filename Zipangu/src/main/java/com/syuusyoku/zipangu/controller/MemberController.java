package com.syuusyoku.zipangu.controller;

import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.syuusyoku.zipangu.dao.MemberDAO;
import com.syuusyoku.zipangu.dao.MsgDAO;
import com.syuusyoku.zipangu.vo.List_MsgVO;
import com.syuusyoku.zipangu.vo.MemberVO;

@Controller
public class MemberController {
	@Autowired
	private MemberDAO dao;
	
	@Autowired
	private MsgDAO daoMs;

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
			//admin과 대화하는 채팅화면 자동 생성

			List_MsgVO listVO = new List_MsgVO();
			String mentor_id="";
			String mentee_id="";
			
			if(member.getAuthority()==1) {
	            mentor_id += member.getUserID();
	            mentee_id += "admin";
	         }
	         if(member.getAuthority()==2) {
	            mentee_id += member.getUserID();
	            mentor_id += "admin";
	         }
	         
	         
	         listVO.setMentee_id(mentee_id);
	         listVO.setMentor_id(mentor_id);
	         listVO.setMsg_num(UUID.randomUUID().toString());

	         daoMs.insert_list_msg(listVO);
		}
		return "member/signupResult";
	}
	
	@RequestMapping(value = "member/loginForm", method = RequestMethod.GET)
	public String loginForm() {
		return "member/loginForm";
	}
	
	@RequestMapping(value = "/member/login", method = RequestMethod.POST)
	public String login(MemberVO vo, HttpSession session, RedirectAttributes rttr) {
		boolean result = dao.login(vo, session);
		if(result) return "redirect:/";
		rttr.addFlashAttribute("result", result);
		return "redirect:/member/loginForm";
	}
	
	@RequestMapping(value = "/member/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		dao.logout(session);
		return "redirect:/";
	}
}