package com.syuusyoku.zipangu.controller;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.syuusyoku.zipangu.dao.ScheduleDAO;

@Controller
public class ScheduleController {
	@Autowired
	private ScheduleDAO dao;

	@RequestMapping(value = "schedule/scheduleForm", method = RequestMethod.GET)
	public String scheduleForm(HttpSession session, Model model) {
		model.addAttribute("scheduleList", dao.scheduleList(session));
		return "schedule/scheduleForm";
	}

	@ResponseBody
	@RequestMapping(value = "schedule/updateSchedule", method = RequestMethod.POST)
	public boolean updateSchedule(HttpSession session, String scheduleList) {
		return dao.updateSchedule(session, scheduleList);
	}
}