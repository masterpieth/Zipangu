package com.syuusyoku.zipangu.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.syuusyoku.zipangu.dao.MemberDAO;
import com.syuusyoku.zipangu.dao.MsgDAO;
import com.syuusyoku.zipangu.vo.ChatBotVO;
import com.syuusyoku.zipangu.vo.List_MsgVO;

@Controller
public class MsgController {
	
	@Autowired
	private MsgDAO dao;
	
	@Autowired
	private MemberDAO daoMe;
	
	//대화 목록 검색
	@RequestMapping(value = "msg/search_msg_people", method = RequestMethod.GET)
	@ResponseBody
	public ArrayList<List_MsgVO> chatAnswer(String search_people, HttpSession session) {
		String userID = (String)session.getAttribute("userID");
		HashMap<String,String> map = new HashMap<>();
		ArrayList<List_MsgVO> result = null;
		
		//user가 mentee인 경우 mentor의 리스트를 찾음
		if(daoMe.getMember(userID).getAuthority()==1) {
			map.put("mentee_id", search_people);
			map.put("mentor_id", userID);
			result = dao.select_lis_msg_mentor(map);
		}
		if(daoMe.getMember(userID).getAuthority()==2) {
			map.put("mentee_id", userID);
			map.put("mentor_id", search_people);
			result = dao.select_lis_msg_mentor(map);
		}
		return result;
	}
	
	//자동 답변
	@RequestMapping(value = "msg/chatAnswer", method = RequestMethod.POST,produces ="application/text; charset=utf8")
	@ResponseBody
	public String chatAnswer(@RequestBody ChatBotVO vo) {
		String chatContent= vo.getChatContent();
		String result = dao.chatAnswer(chatContent);
		return result;
	}

	//대화창
	@RequestMapping(value = "msg/msg_read", method = RequestMethod.GET)
	public String msg_read(Model model, HttpSession session) {
		//대화 상대 목로 가져오기
		String userID = (String)session.getAttribute("userID");
		ArrayList<List_MsgVO> list = dao.who_user_msg_to(userID);
		model.addAttribute("who_user_msg_to_list", list);
				
		return "msg/msg_read";
	}
	
	//대화창 열기
	@RequestMapping(value = "msg/msg_start", method = RequestMethod.GET)
	public String msg_start(String mentee_id, String mentor_id, HttpSession session, RedirectAttributes rttr) {
		List_MsgVO vo = new List_MsgVO();
		vo.setMentee_id(mentee_id);
		vo.setMentor_id(mentor_id);
		
		//mentee_id, mentor_id에 해당하는게 list_msg 테이블에 없으면 insert 해서 새로 만듬
		if(dao.count_list_msg(vo)==0) {
			String msg_num = (String)UUID.randomUUID().toString();
			vo.setMsg_num(msg_num);
			dao.insert_list_msg(vo);
		}
		
		//대화 상대 목로 가져오기
		String userID = (String)session.getAttribute("userID");
		
		ArrayList<List_MsgVO> list = dao.who_user_msg_to(userID);
		rttr.addFlashAttribute("who_user_msg_to_list", list);
		
		//select 해서 msg_num에 해당하는 화면으로 이동
		List_MsgVO result = dao.select_list_msg(vo);
		rttr.addFlashAttribute("List_MsgVO", result);
	
		return "redirect:/msg/msg_read?msg_num="+result.getMsg_num();
	}
}
