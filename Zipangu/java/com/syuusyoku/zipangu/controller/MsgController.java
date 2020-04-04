package com.syuusyoku.zipangu.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.syuusyoku.zipangu.dao.MemberDAO;
import com.syuusyoku.zipangu.dao.MsgDAO;
import com.syuusyoku.zipangu.vo.List_MsgVO;
import com.syuusyoku.zipangu.vo.MemberVO;

@Controller
public class MsgController {
	
	@Autowired
	private MsgDAO dao;
	
	@Autowired
	private MemberDAO daoMe;
	
	//멘티가 보는 화면
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
	
	//대화창 열기
	@RequestMapping(value = "msg/msg_start", method = RequestMethod.POST)
	public String msg_start(String mentee_id, String mentor_id, RedirectAttributes rttr) {
		List_MsgVO vo = new List_MsgVO();
		vo.setMentee_id(mentee_id);
		vo.setMentor_id(mentor_id);
		
		//mentee_id, mentor_id에 해당하는게 list_msg 테이블에 없으면 insert 해서 새로 만듬
		if(dao.count_list_msg(vo)==0) {
			dao.insert_list_msg(vo);
		}
		
		//select 해서 msg_num에 해당하는 화면으로 이동
		int msg_num = dao.select_list_msg(vo);
		
		rttr.addFlashAttribute("msg_num", msg_num);
		
		return "redirect:/msg/msg_read?msg_num="+msg_num;
	}
	
	//멘토가 보는 화면
	@RequestMapping(value = "msg/msg_tmain", method = RequestMethod.GET)
	public String msg_tmain(Model model, HttpSession session) {
		String userID = (String)session.getAttribute("userID");
		String mentor_id = "";
		ArrayList<List_MsgVO> list = null;
		
		//만약 authority = 1이면
		if(daoMe.memberInfo(userID).getAuthority()==1) {
			mentor_id = userID;
			//멘티리스트가 보이게 함
			list = dao.select_mentee_list(mentor_id);
		}
		
		model.addAttribute("menteeList", list);
				
		return "msg/msg_tmain";
	}
}
