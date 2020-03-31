package com.syuusyoku.zipangu.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.syuusyoku.zipangu.dao.MemberDAO;
import com.syuusyoku.zipangu.dao.MsgDAO;
import com.syuusyoku.zipangu.vo.MemberVO;

@Controller
public class MsgController {
	
	@Autowired
	private MsgDAO dao;
	
	@Autowired
	private MemberDAO daoMe;
	
	//멘토 목록 + 멘토 선택하면 대화창(msg/msg_read) 나오게
	@RequestMapping(value = "msg/msg_main", method = RequestMethod.GET)
	public String msg_main(Model model) {
		ArrayList<MemberVO> list = daoMe.mentorList();
		model.addAttribute("mentorList", list);
				
		return "msg/msg_main";
	}
	
	//대화창
	@RequestMapping(value = "msg/msg_read", method = RequestMethod.GET)
	public String msg_read(Model model) {
				
		return "msg/msg_read";
	}
}
